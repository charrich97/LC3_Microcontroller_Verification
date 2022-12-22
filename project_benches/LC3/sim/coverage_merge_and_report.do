# coverage attribute -name TESTNAME -value test_name
# coverage save test_name.$Sv_Seed.ucdb
xml2ucdb -format Excel ./LC3_Testplan.xml ./LC3_Testplan.ucdb
#add testbrowser ./*.ucdb
vcover merge -stats=none -strip 0 -totals LC3_Testplan_Merged.ucdb ./*.ucdb 
add testbrowser ./*.ucdb
coverage open ./LC3_Testplan_Merged.ucdb
vcover report -detail -html -output covhtmlreport -assert -directive -cvg -code bcefst -threshL 50 -threshH 90 ./LC3_Testplan_Merged.ucdb
vsim -viewcov LC3_Testplan_Merged.ucdb