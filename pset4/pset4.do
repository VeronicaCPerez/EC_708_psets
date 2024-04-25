cd "/Users/veronica/Dropbox/PhD/2024_1/EC_708_Econometrics/EC_708_psets/pset4"

import delimited "bwght.csv", clear

** (a)


// Estimate the probit model
probit smokes motheduc white lfamin

// Perform the Wald test
test motheduc white

** (b)

// Estimate the probit model
probit smokes motheduc white lfaminc

// Calculate partial effect at motheduc = 12, white = 0
margins, dydx(lfaminc) at(motheduc = 12 white = 0)


** (c)

ereturn list 

* -.0251883    .0053396

** (d)

// Instrumental variables probit estimation
ivprobit smokes (lfaminc = fathedu) motheduc white
