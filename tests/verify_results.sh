#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

echo "========================================="
echo "MapReduce Sample Statistics Verification"
echo "========================================="

if [ ! -f "${PROJECT_ROOT}/output_average" ] || [ ! -f "${PROJECT_ROOT}/output_variance" ]; then
    echo "Error: output_average or output_variance not found"
    echo "Please run: make run-all"
    exit 1
fi

AVERAGE=$(cat "${PROJECT_ROOT}/output_average")
VARIANCE=$(cat "${PROJECT_ROOT}/output_variance")


python3 << EOF
import csv
import math
import os

project_root = '${PROJECT_ROOT}'
csv_path = os.path.join(project_root, 'input', 'AB_NYC_2019.csv')

prices = []
line_count = 0
error_count = 0

with open(csv_path, 'r') as f:
    reader = csv.reader(f)
    for row in reader:
        line_count += 1
        try:
            if len(row) > 9 and row[9].strip():
                price = float(row[9])
                prices.append(price)
        except (ValueError, IndexError):
            error_count += 1

if prices:
    n = len(prices)
    mean = sum(prices) / n
    
    variance = sum((x - mean) ** 2 for x in prices) / (n - 1)
    
    print(f'Python verification:')
    print(f'  Total lines in CSV: {line_count}')
    print(f'  Valid price records: {n}')
    print(f'  Average = {mean:.15f}')
    print(f'  Variance = {variance:.15f}')
    print()
    
    avg_mr = float('${AVERAGE}')
    var_mr = float('${VARIANCE}')
    
    print(f'MapReduce results:')
    print(f'  Mean = {avg_mr:.15f}')
    print(f'  Variance = {var_mr:.15f}')
    print()
    
    print(f'Differences:')
    print(f'  Mean diff = {mean - avg_mr:.15f}')
    print(f'  Variance diff = {variance - var_mr:.15f}')
    print(f'  Mean relative error = {abs(mean - avg_mr)/abs(mean)*100:.10f}%')
    print(f'  Variance relative error = {abs(variance - var_mr)/abs(variance)*100:.10f}%')
    print()
    
    
    if abs(mean - avg_mr) < 0.0001 and abs(variance - var_mr) < 0.1:
        print(f'✓ Results match within tolerance!')
    else:
        print(f'✗ Results differ significantly!')
        
else:
    print('No valid price data found')

EOF

echo ""
echo "========================================="