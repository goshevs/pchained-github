* Examples of Plumpton with -mi impute chained-
* Developers: Simo Goshev, Zitong Liu
*
*
*
*
*
********************************************************************************
*** Examples of running Plumpton with mi impute chained
********************************************************************************

clear
set more off


simdata 500 3
pchained s1_i (y2, include(mean(s1_i)) omit(x1 i.x2)) (y3 i.yx x1 i.yz, include(y2 mean(s1_i)) noimputed), ///
	          i(id) t(time) scalecov(x1 i.x2 x3 y1) mio(add(1) chaindots rseed(123456)) ///
			  mod(s1_i = "pmm, knn(3)" y2 = "poisson" y3 = "regress, nocons")

*** TODO:
*** y3 could be in the include for y2
*** y2 could be in the include for y3
*** y2 and y3 could be used for the scale items!

exit


*******************
***  One scale  ***

*** Categorical items
simdata 500 3
pchained s1_i, i(id) t(time) cov(x1 i.x2 x3 y) mio(add(1) chaindots rseed(123456))

*** Treat items as continuous
simdata 200 3
pchained s1_i, i(id) t(time) cont(s1_i) cov(x1 i.x2 x3 y) mio(add(1) chaindots rseed(123456))

*** Items continuous by design (imputation model defined by user)
simdata 200 3
pchained s4_i, i(id) t(time) cov(x1 i.x2 x3 y) mio(add(1) chaindots rseed(123456)) mod(s4_i = "pmm, knn(3)")


*******************
*** Two scales  ***

*** Categorical items
simdata 200 3
pchained s1_i s3_i, i(id) t(time) cov(x1 i.x2 x3 y) score("sum") mio(add(1) chaindots rseed(123456))


*** Treat some scales as continuous
simdata 500 3
pchained s1_i s2_i, i(id) t(time) cont(s2_i) cov(x1 i.x2 x3 y) mio(add(1) chaindots rseed(123456))

*** Some scales/items continuous by design (imputation models defined by user)
simdata 200 3
pchained s2_i s4_i, i(id) t(time) cov(x1 i.x2 x3 y) mio(add(1) chaindots rseed(123456)) mod(s2_i = "ologit" s4_i = "pmm, knn(3)")


********************
*** Three scales ***

*** Categorical items
simdata 200 3
pchained s1_i s2_i s3_i, i(id) t(time) cov(x1 i.x2 x3 y) score(mean) mio(add(1) chaindots rseed(123456))


*** Treat some scales as continuous
simdata 200 3
pchained s1_i s2_i s3_i, i(id) t(time) cont(s2_i) cov(x1 i.x2 x3 y) score(mean) mio(add(1) chaindots rseed(123456))


*** Some scales/items continuous by design
simdata 200 3
pchained s1_i s3_i s4_i, i(id) t(time) cov(x1 i.x2 x3 y) score(mean) mio(add(1) chaindots)


*** Mixed, s4_i by design is cont, s2_i user defined as cont
simdata 200 3
pchained s1_i s2_i s4_i, i(id) t(time) cont(s2_i) cov(x1 i.x2 x3 y) score(mean) mio(add(1) chaindots rseed(123456))


********************
***   By group   ***

simdata 1000 3
pchained s1_i s4_i, i(id) t(time) cov(x1 i.x2 x3 y) score(sum) mio(add(1) chaindots by(group) rseed(123456))


*************************
***  Sampling Weight  ***

simdata 500 3
pchained s1_i s4_i [pw=weight], i(id) t(time) cov(x1 i.x2 x3 y) score(sum) mio(add(1) chaindots rseed(123456))


*** Generate aggregates off of imputed vars
*mi xeq: egen s1_sum = rowtotal(s1*)
*mi xeq: egen s1_mean = rowmean(s1*)

