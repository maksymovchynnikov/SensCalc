#!/bin/bash

# Base directory
base_dir="Decays"

# Array of patterns
pattern=("HNL-mixing-e" "HNL-mixing-mu" "HNL-mixing-tau" "DP" "B-L" "ALP-gluon" "Scalar")

# Function to display pattern choices and get user selection
get_user_selection() {
    echo "Select the patterns to keep (separate choices by spaces):"
    for i in "${!pattern[@]}"; do
        echo "$i) ${pattern[$i]}"
    done

    read -p "Enter choices: " -a choices
    selected_patterns=()
    for choice in "${choices[@]}"; do
        if [[ "$choice" =~ ^[0-9]+$ ]] && [ "$choice" -ge 0 ] && [ "$choice" -lt "${#pattern[@]}" ]; then
            selected_patterns+=("${pattern[$choice]}")
        else
            echo "Invalid choice: $choice"
        fi
    done
}

# Function to extract the number based on the XXX part of the folder name
extract_number() {
    local folder_name=$1
    case "$folder_name" in
        HNL-mixing-e|HNL-mixing-mu|HNL-mixing-tau)
            echo "111113"
            ;;
        Scalar)
            echo "111111"
            ;;
        ALP-gluon)
            echo "111112"
            ;;
        DP)
            echo "111114"
            ;;
        B-L)
            echo "111115"
            ;;
        *)
            echo "Unknown"
            ;;
    esac
}

# Function to filter .hepmc file
filter_hepmc_file() {
    local input_file=$1
    local output_file=$2
    awk '{
        if ($1 != "P" && $1 != "V") {
            print $0;
        } else if ($1 == "P" && $(NF-4) == 1) {
            print $0;
        }
    }' "$input_file" > "$output_file"
}

# Function to check if folder name contains any pattern
contains_pattern() {
    local folder_name=$1
    for p in "${selected_patterns[@]}"; do
        if [[ "$folder_name" == *"$p"* ]]; then
            return 0
        fi
    done
    return 1
}

# Get user selection for patterns
get_user_selection

# Remove all .hepmc files in the base directory (not in its subfolders)
find "$base_dir" -maxdepth 1 -type f -name "*.hepmc" -exec rm -f {} \;

# Iterate over the XXX_YYY subdirectories
for dir in "$base_dir"/*; do
    if [ -d "$dir" ]; then
        # Extract the XXX part from the folder name
        folder_name=$(basename "$dir" | cut -d '_' -f1)

        # Check if folder name contains any pattern
        if contains_pattern "$folder_name"; then
            # Extract the number based on the XXX part
            number=$(extract_number "$folder_name")

            # Check if the number is known
            if [ "$number" == "Unknown" ]; then
                echo "Unknown folder type for $folder_name"
                continue
            fi

            # Display the current folder and PDG number being processed
            echo "Processing folder: $folder_name. PDG of the decaying particle: $number"

            # Iterate over the run_0i subdirectories
            for run_dir in "$dir/Events"/run_[0-9][0-9]*; do
                if [ -d "$run_dir" ]; then
                    # Extract the index ij from the run_ij folder name
                    run_index=$(basename "$run_dir" | grep -oP 'run_\K\d+')
                    # Construct the correct file path for the banner file
                    file="${run_dir}/run_${run_index}_tag_1_banner.txt"
                    if [ -f "$file" ]; then
                        # Read the number and format it
                        mass_xxx=$(grep -oP "$number \K[\d.]+e[+\-]\d+" "$file" | head -1 | awk '{printf "%.2f", $0}')

                        # Check if mass_xxx is not empty
                        if [ ! -z "$mass_xxx" ]; then
                            # Display the current mass_xxx being processed
                            echo "Found mass: $mass_xxx GeV."

                            # Construct the output file name
                            output_filename="${dir}_${mass_xxx}.hepmc"

                            # Extract and filter the .hepmc file
                            temp_output="${run_dir}/filtered_temp.hepmc"
                            gunzip -c "${run_dir}/tag_1_pythia8_events.hepmc.gz" > "$temp_output"
                            filter_hepmc_file "$temp_output" "$output_filename"
                            rm "$temp_output"
                        fi
                    fi
                fi
            done
        fi
    fi
done
