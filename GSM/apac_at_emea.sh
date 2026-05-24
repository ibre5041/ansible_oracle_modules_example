
srvctl add database -db APAC_AT_EMEA \
       -oraclehome /oracle/u01/product/23.26.1.0.0 \
       -dbname APAC \
       -instance APAC \
       -spfile '+XDATA/APAC_AT_EMEA/spfileAPAC_AT_EMEA.ora' \
       -startoption 'READ ONLY' \
       -stopoption IMMEDIATE
