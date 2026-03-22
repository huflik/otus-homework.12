#!/bin/sh
BINARY_HOME=./bin
INPUT_HOME=./input
INPUT=${INPUT_HOME}/AB_NYC_2019.csv

cat ${INPUT} | ${BINARY_HOME}/mapper_variance "$(cat output_average)" | ${BINARY_HOME}/reducer_variance > output_variance
cat output_variance