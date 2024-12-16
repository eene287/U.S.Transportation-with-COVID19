Pre-processing in Nov. 2024, EE \
I am analyzing the Daily Traffic Volume at the FTS stations in the US on a temporal scale from Jan.1st 2019
 to Dec. 31st 2020 
 
The state wide cumulative traffic volume in 2020 is compared to the corresponding volume in 2018 and 2019, and with the state wide COVID19 policies. \
 The COVID19 state policies were extracted from
 (https://en.wikipedia.org/wiki/U.S._state_and_local_government_responses_to_the_COVID19_pandemic)
 and (https://www.nytimes.com/interactive/2020/us/states-reopen-map-coronavirus.html)   The COVID19 state policies
 were categorical and numerically coded, in time series format. \
  The transportation data are downloaded from the Bureau of Transportation Statistics
 (https://www.fhwa.dot.gov/policyinformation/tables/tmasdata/) in its original database format as it was collected through the FHWA Travel Monitoring Analysis System (TMAS). 
 
 For data modeling purposes, calculated variables were created as follows: \
 stateTraffic    - state cumulative daily traffic, in million vehicles per day \
 priorTraffic    - arithmetic mean of the daily traffic in 2018 and 2019, in million vehicles per day \
  offTraffic      - difference (stateTraffic-priorTraffic), in million vehicles per day \
  prop Traffic    - ratio (stateTraffic/priorTraffic), dimensionless \
  emergencyState  - size after the emergency order in that state, otherwise base \
  lockState       - size if stay home order; 0.5*size if restricted; otherwise base \
  travelOutState  - 0.6* size if out-of-state travel restriction; 0.3* size if limited out-of-state travel restrictions; otherwise base \
  clsRetailState  - 0.8* size if bars and restaurants closed at state level; 0.4* size if limited closings; otherwise base \
  Per plotting purpose, the numerical enconding of the COVID19 policies is state specific \
  size=0.9 of the maximum stateTraffic, in millions of vehicles per day \
  base=0.8 of the minimum statePrior, in millions of vehicles per day 
  
 The TMG (2001) specified fixed width volume data. \
 In this format, each data field has its unique column with fixed width. The hourly count data for each of the 24
 hours in a day takes 24 columns. \
 The tool asks for a zipped volume file (downloaded from the FHWA Office of Highway Policy Information website
 (https://www.fhwa.dot.gov/policyinformation/tables/tmasdata/)  
 The tool then converts it to different formats with a daily record or hourly record forms. 
