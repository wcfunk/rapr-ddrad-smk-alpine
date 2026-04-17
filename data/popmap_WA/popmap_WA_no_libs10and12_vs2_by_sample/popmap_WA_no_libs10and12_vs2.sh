#!/bin/bash

# Check if the input file is provided
if [ -z "$1" ]; then
  echo "Usage: $0 input.tsv"
  exit 1
fi

input_file=$1

# Check if the input file exists
if [ ! -f "$input_file" ]; then
  echo "File $input_file not found!"
  exit 1
fi

# Read the input file line by line
while IFS=$'\t' read -r col1 col2 col3; do
  # Create a new file named based on the value of the first column
  output_file="popmap_WA_no_libs10and12_vs2_${col1}.tsv"
  echo -e "${col1}\t${col2}\t${col3}" > "$output_file"
done < "$input_file"

echo "Script execution completed."
