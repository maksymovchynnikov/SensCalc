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

# Array of M values for Decays/S-bb
m_values=(1.25 1.5 1.75 2. 2.5 3. 3.5 4. 4.5 5.3 5.8 6.3 8. 10. 12. 15. 20.)

# Loop over M values for Decays/S-bb
for m in "${m_values[@]}"; do
    write_commands "Decays/HNL-mixing-e_Jets-uuv" "Mn" $m
done

for m in "${m_values[@]}"; do
    write_commands "Decays/HNL-mixing-e_Jets-ddv" "Mn" $m
done

for m in "${m_values[@]}"; do
    write_commands "Decays/HNL-mixing-e_Jets-ssv" "Mn" $m
done

m_values=(4. 4.5 5.3 5.8 6.3 8. 10. 12. 15. 20.)

for m in "${m_values[@]}"; do
    write_commands "Decays/HNL-mixing-e_Jets-ccv" "Mn" $m
done

# Loop over M values for HNL -> qq'e
m_values=(1.25 1.5 1.75 2. 2.5 3. 3.5 4. 4.5 5.3 5.8 6.3 8. 10. 12. 15. 20.)
for m in "${m_values[@]}"; do
    write_commands "Decays/HNL-mixing-e_Jets-ude" "Mn" $m
done

for m in "${m_values[@]}"; do
    write_commands "Decays/HNL-mixing-e_Jets-udebar" "Mn" $m
done

m_values=(2.5 3. 3.5 4. 4.5 5.3 5.8 6.3 8. 10. 12. 15. 20.)

for m in "${m_values[@]}"; do
    write_commands "Decays/HNL-mixing-e_Jets-cse" "Mn" $m
done

for m in "${m_values[@]}"; do
    write_commands "Decays/HNL-mixing-e_Jets-csebar" "Mn" $m
done

# Loop over M values for HNL -> qq'mu
m_values=(1.25 1.5 1.75 2. 2.5 3. 3.5 4. 4.5 5.3 5.8 6.3 8. 10. 12. 15. 20.)
for m in "${m_values[@]}"; do
    write_commands "Decays/HNL-mixing-mu_Jets-udmu" "Mn" $m
done

for m in "${m_values[@]}"; do
    write_commands "Decays/HNL-mixing-mu_Jets-udmubar" "Mn" $m
done

m_values=(2.5 3. 3.5 4. 4.5 5.3 5.8 6.3 8. 10. 12. 15. 20.)

for m in "${m_values[@]}"; do
    write_commands "Decays/HNL-mixing-mu_Jets-csmu" "Mn" $m
done

for m in "${m_values[@]}"; do
    write_commands "Decays/HNL-mixing-mu_Jets-csmubar" "Mn" $m
done

# Loop over M values for HNL -> qq'tau
m_values=(2.5 3. 3.5 4. 4.5 5.3 5.8 6.3 8. 10. 12. 15. 20.)
for m in "${m_values[@]}"; do
    write_commands "Decays/HNL-mixing-tau_Jets-udtau" "Mn" $m
done

for m in "${m_values[@]}"; do
    write_commands "Decays/HNL-mixing-tau_Jets-udtaubar" "Mn" $m
done

m_values=(4.5 5.3 5.8 6.3 8. 10. 12. 15. 20.)

for m in "${m_values[@]}"; do
    write_commands "Decays/HNL-mixing-tau_Jets-cstau" "Mn" $m
done

for m in "${m_values[@]}"; do
    write_commands "Decays/HNL-mixing-tau_Jets-cstaubar" "Mn" $m
done

# Notify the user
echo "Simplified file created: $output_file"

