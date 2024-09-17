#!/bin/bash

# Define the file name
output_file="Decays-DP.txt"

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

#______________________________________________________________

# Array of M values for Decays/DP-jets-light
m_values=(1.75 2.25 2.75 3.25 3.75 4.25 4.75 5.25)

# Loop over M values for Decays/DP-jets-light
for m in "${m_values[@]}"; do
    write_commands "Decays/DP_Jets-uu" "Mdp" $m
done

# Loop over M values for Decays/DP-jets-light
for m in "${m_values[@]}"; do
    write_commands "Decays/B-L_Jets-uu" "Mbl" $m
done

for m in "${m_values[@]}"; do
    write_commands "Decays/DP_Jets-dd" "Mdp" $m
done

# Loop over M values for Decays/DP-jets-light
for m in "${m_values[@]}"; do
    write_commands "Decays/B-L_Jets-dd" "Mbl" $m
done

for m in "${m_values[@]}"; do
    write_commands "Decays/DP_Jets-ss" "Mdp" $m
done

# Loop over M values for Decays/DP-jets-light
for m in "${m_values[@]}"; do
    write_commands "Decays/B-L_Jets-ss" "Mbl" $m
done

# Array of M values for Decays/DP-cc
m_values=(3.75 4.25 4.75 5.25)

# Loop over M values for Decays/DP-cc
for m in "${m_values[@]}"; do
    write_commands "Decays/DP_Jets-cc" "Mdp" $m
done

for m in "${m_values[@]}"; do
    write_commands "Decays/B-L_Jets-cc" "Mbl" $m
done

# Notify the user
echo "Simplified file created: $output_file"
