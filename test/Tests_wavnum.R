# This is a script to save verification tests for function wavnum in the DWS R package
source("R/DWS.R")



####################################################
## Verification of Function wavnum
####################################################
# Case 1 (Deep water):
wavnum(h = 400.0, g = 9.8065, sigma = 3.14159265)
# [1] 1.006435
# Match hand calculation, refer to "Verification of Function wavnum.docx"


# Case 2 (Intermediate water):
wavnum(h = 40.0, g = 9.8065, sigma = 0.62831853)
# [1] 0.04293825
# Match hand calculation, refer to "Verification of Function wavnum.docx"


# Case 3 (Shallow water):
wavnum(h = 2.0, g = 9.8065, sigma = 0.2513274)
# [1] 0.05687239
# Match hand calculation, refer to "Verification of Function wavnum.docx"
