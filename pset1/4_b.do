cd "/Users/veronica/Dropbox/PhD/2024_1/EC_708_Econometrics/EC_708_psets/pset1"

import delimited "data/ps14.csv", clear varnames(1)

ivreg2 y (x=w), ffirst

local f_f_stage  = e(first)[4,1]
local fmtf_f_stage : display %4.3f `f_f_stage'

local CI_minus = e(b)[1,1] - 1.96*sqrt(e(V)[1,1])
local CI_plus = e(b)[1,1] + 1.96*sqrt(e(V)[1,1])

local fmtf_CI_minus : display %4.2f `CI_minus'
local fmtf_CI_plus : display %4.2f `CI_plus'

local CI = "[`fmtf_CI_minus'-`fmtf_CI_plus']"


di "`CI'"

outreg2 using ///
	"/Users/veronica/Dropbox/Apps/Overleaf/EC_708_vcperez/tables/pset1_4b.tex", ///
	tex(fragment) addtext(F First Stage, `fmtf_f_stage', CI 95%, `CI') replace
