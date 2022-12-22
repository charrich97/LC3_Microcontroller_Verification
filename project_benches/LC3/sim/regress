#!/bin/bash
##########################################################
#Run Random SEED Tests
##########################################################
make clean
make convert_testplan
make build
make optimize
export  TEST_NAME=all_valid_instructions_test
make regress
make merge_coverage
export  TEST_NAME=branch_test
make regress
make merge_coverage
export  TEST_NAME=additional_operands_test
make regress
make merge_coverage
##export  TEST_NAME=register_test
##make regress
##make merge_coverage
export  TEST_NAME=random_test
make regress 
make merge_coverage
make report_coverage
make view_coverage_results
