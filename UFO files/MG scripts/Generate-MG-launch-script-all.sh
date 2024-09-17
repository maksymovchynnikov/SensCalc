#!/bin/bash

# Define the file name
output_file="Decays.txt"

# Clear the file content if it already exists
> $output_file

# Function to append commands to the file for a given scenario
write_commands() {
    local scenario=$1
    local mass_param=$2
    local mass_value=$3

    echo "launch $scenario" >> $output_file
    echo "shower=pythia8" >> $output_file
    echo "set nevents 30000" >> $output_file
    echo "set ebeam1 0" >> $output_file
    echo "set ebeam2 0" >> $output_file
    echo "set lpp1 0" >> $output_file
    echo "set lpp2 0" >> $output_file
    echo "set lpp2 0" >> $output_file
    echo "set ptj 0." >> $output_file
    echo "set dynamical_scale_choice 4" >> $output_file
    echo "set $mass_param $mass_value" >> $output_file
    echo "" >> $output_file
}

# Array of Mn values for Decays/HNL-qqv
mn_values_qqv=(0.76 1. 1.2 1.5 1.75 2. 2.5 2.9 3. 3.5 4. 4.5 5.3 6.3 8. 11. 15. 20.)

# Loop over Mn values for Decays/HNL-qqv
for m in "${mn_values_qqv[@]}"; do
    write_commands "Decays/111113_Jets-qqv" "Mn" $m
done

# Array of Mn values for Decays/HNL-qqe
mn_values_qqe=(1.2 1.5 1.75 2. 2.5 2.9 3. 3.5 4. 4.5 5.3 6.3 8. 11. 15. 20.)

# Loop over Mn values for Decays/HNL-qqe
for m in "${mn_values_qqe[@]}"; do
    write_commands "Decays/111113_Jets-qqe" "Mn" $m
done


# Array of Mn values for Decays/HNL-qqmu
mn_values_qqmu=(1.2 1.5 1.75 2. 2.5 2.9 3. 3.5 4. 4.5 5.3 6.3 8. 11. 15. 20.)

# Loop over Mn values for Decays/HNL-qqmu
for m in "${mn_values_qqmu[@]}"; do
    write_commands "Decays/111113_Jets-qqmu" "Mn" $m
done

# Array of Mn values for Decays/HNL-qqtau
mn_values_qqtau=(2.5 2.9 3. 3.5 4. 4.5 5.3 6.3 8. 11. 15. 20.)

# Loop over Mn values for Decays/HNL-qqtau
for m in "${mn_values_qqtau[@]}"; do
    write_commands "Decays/111113_Jets-qqtau" "Mn" $m
done


# Array of M values for Decays/S-cc
m_values=(3.8 4. 4.7 5.1 7. 10.5 10.9 14.)

# Loop over M values for Decays/S-cc
for m in "${m_values[@]}"; do
    write_commands "Decays/111111_Jets-cc" "Ms" $m
done

# Array of M values for Decays/S-bb
m_values=(10.9 14. 20. 25. 30. 37.5 45. 50. 55. 62.49)

# Loop over M values for Decays/S-bb
for m in "${m_values[@]}"; do
    write_commands "Decays/111111_Jets-bb" "Ms" $m
done

# Array of M values for Decays/S-gg
m_values=(2.2 2.5 3. 3.5 3.6 3.8 4. 4.7 5.1)

# Loop over M values for Decays/S-gg
for m in "${m_values[@]}"; do
    write_commands "Decays/111111_Jets-gg" "Ms" $m
done

# Array of M values for Decays/S-ss
m_values=(2.2 2.5 3. 3.5 3.6 3.8 4. 4.7 5.1)

# Loop over M values for Decays/S-ss
for m in "${m_values[@]}"; do
    write_commands "Decays/111111_Jets-ss" "Ms" $m
done

#______________________________________________________________

# Array of M values for Decays/DP-jets-light
m_values=(1.75 2.25 2.75 3.25 3.75 4.25 5.)

# Loop over M values for Decays/DP-jets-light
for m in "${m_values[@]}"; do
    write_commands "Decays/111114_Jets-light" "Mdp" $m
done

# Array of M values for Decays/DP-cc
m_values=(3.75 4.25 5.)

# Loop over M values for Decays/DP-cc
for m in "${m_values[@]}"; do
    write_commands "Decays/111114_Jets-cc" "Mdp" $m
done

# Array of M values for Decays/BL-jets-light
m_values=(1.75 2.25 2.75 3.25 3.75 4.25 5.)

# Loop over M values for Decays/BL-Jets-light
for m in "${m_values[@]}"; do
    write_commands "Decays/111115_Jets-light" "Mbl" $m
done

# Array of M values for Decays/BL-cc
m_values=(3.75 4.25 5.)

# Loop over M values for Decays/BL-cc
for m in "${m_values[@]}"; do
    write_commands "Decays/111115_Jets-cc" "Mbl" $m
done

#_______________________________________________

# Array of M values for Decays/ALP-gg
m_values=(1.8 2.3 2.6 3. 3.6 3.8 4.5 5.1)

# Loop over M values for Decays/ALP-gg
for m in "${m_values[@]}"; do
    write_commands "Decays/111112_Jets-gg" "Ma" $m
done

# Array of M values for Decays/ALP-cc
m_values=(3.8 4.5 5.1)

# Loop over M values for Decays/ALP-cc
for m in "${m_values[@]}"; do
    write_commands "Decays/111112_Jets-cc" "Ma" $m
done

# Array of M values for Decays/ALP-ss
m_values=(1.8 2.3 2.6 3. 3.6 3.8)

# Loop over M values for Decays/ALP-ss
for m in "${m_values[@]}"; do
    write_commands "Decays/111112_Jets-ss" "Ma" $m
done


# Notify the user
echo "Simplified file created: $output_file"
