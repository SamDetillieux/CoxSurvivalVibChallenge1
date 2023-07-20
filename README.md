# CoxSurvivalVibChallenge1

R script used for hazard analysis along with the 2 data sets.

TrueControl is the data set containing a non innoculated control group with one mortality assigned arbitrarily to avoid the infinite survival error.
TrueRemoved is the same data set but with the true control gorup removed for the purposes of comparing only the treatment groups to eachother.

Legend:

Treatment - 1/C=Resistant, 2/B=Susceptable, 3/A=control

Genetics - 1=Resistant, 2=Susceptable 3=TrueControl

Dose - 1=None, 2=Vibrio

TE - Time Elapsed, day of mortality 1-6, TE of 6 are survivors

Binary - 0=Alive, 1=Dead
