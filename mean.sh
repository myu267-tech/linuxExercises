#!/bin/bash

# Check number of arguments
if [ $# -lt 1 ] || [ $# -gt 2 ]; then
    echo "usage: ./mean.sh <column> [file.csv]" >&2
    exit 1
fi

column=$1

# Determine input source
if [ $# -eq 2 ]; then
    file="$2"
else
    file="/dev/stdin"
fi
#file=$2
# Process the file
cut -d',' -f"$column" "$file" | tail -n +2 | {
    sum=0
    count=0

    while read value; do
        # Skip empty values
	#sum$=(echo "$sum + $value" | bc -l)
	#count=$((count + 1))
        if [ -n "$value" ]; then
            sum=$(echo "$sum + $value" | bc -l)
            count=$((count + 1))
        fi
    done
    echo "scale=6; $sum / $count" | bc -l

    
}
