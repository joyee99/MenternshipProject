-- First we will check some Numerical columns to find some general info about them which can help to understand why the particular Metrics is important.

-- 1. Term :
select "Term" from "SBAnational";

select max("Term") as "Highest_Term" from "SBAnational";

select count("Term") as "countOfTerm_more_than_500mnths" from "SBAnational" where "Term">=500;

select min("Term") as "Lowest_Term" from "SBAnational";

select min("Term") as "Lowest_Term" from "SBAnational" where "Term" != 0;

select count("Term") from "SBAnational" where "Term" = (select min("Term") from "SBAnational" where "Term" != 0 );

select avg("Term") from "SBAnational";


-- 2. NoEmp:
select "NoEmp" from "SBAnational";

select max("NoEmp") as "Highest_NumberOfEmp" from "SBAnational";

select count("NoEmp") as "countOfHighestEMp" from "SBAnational" 
where "NoEmp"=(select max("NoEmp") as "Highest_NumberOfEmp" from "SBAnational");

select min("NoEmp") as "Lowest_NumberOfEmp" from "SBAnational";
select min("NoEmp") as "NonZeroEmp" from "SBAnational" where "NoEmp" != 0;

select count("NoEmp") from "SBAnational" 
where "NoEmp" = (select min("NoEmp") from "SBAnational" where "NoEmp" != 0 );

select avg("NoEmp") from "SBAnational";



-- 3. DisbursementGross
select "DisbursementGross" from "SBAnational";

select max("DisbursementGross") as "Highest_DisbursementGross" from "SBAnational";

select min("DisbursementGross") as "Lowest_Term" from "SBAnational" where ("DisbursementGross"::numeric) != 0;

select count("DisbursementGross") as "count_of_lowestDisbursementGross" from "SBAnational" 
where ("DisbursementGross"::numeric) = (select min("Term") 
from "SBAnational" where ("DisbursementGross"::numeric) != 0);

select avg(("DisbursementGross"::numeric)) from "SBAnational";



-- 4. BalanceGross
select "BalanceGross" from "SBAnational" order by "BalanceGross" DESC;

select max("BalanceGross") as "Highest_BalanceGross" from "SBAnational";

select min("BalanceGross") as "Lowest_BalanceGross" from "SBAnational" where ("BalanceGross"::numeric) != 0;

select count("BalanceGross"::numeric) as "count_of_lowestBalanceGross" from "SBAnational" 
where ("BalanceGross"::numeric) = (select min("BalanceGross"::numeric) 
from "SBAnational" where ("BalanceGross"::numeric) != 0);

select avg(("BalanceGross"::numeric)) from "SBAnational";


-- 5. ChgOffPrinGr
select "ChgOffPrinGr" from "SBAnational" order by "ChgOffPrinGr" DESC;

select "Name","ChgOffPrinGr" from "SBAnational" where 
"ChgOffPrinGr" = (select max("ChgOffPrinGr") from "SBAnational");

select min("ChgOffPrinGr") as "Lowest_ChgOffPrinGr" from "SBAnational" where ("ChgOffPrinGr"::numeric) != 0;

select count("ChgOffPrinGr"::numeric) as "count_of_lowestChgOffPrinGr" from "SBAnational" 
where ("ChgOffPrinGr"::numeric) = (select min("ChgOffPrinGr"::numeric) 
from "SBAnational" where ("ChgOffPrinGr"::numeric) != 0);

select avg(("ChgOffPrinGr"::numeric)) from "SBAnational";



-- 6. GrAppv
select "GrAppv" from "SBAnational" order by "GrAppv" DESC;

select max("GrAppv") as "Highest_GrAppv" from "SBAnational";

select count("GrAppv"::numeric) as "count_of_highestGrAppv" from "SBAnational" 
where ("GrAppv"::numeric) = (select max("GrAppv"::numeric) 
from "SBAnational");

select min("GrAppv") as "Lowest_GrAppv" from "SBAnational" where ("GrAppv"::numeric) != 0;

select count("GrAppv"::numeric) as "count_of_lowestGrAppv" from "SBAnational" 
where ("GrAppv"::numeric) = (select min("GrAppv"::numeric) 
from "SBAnational" where ("GrAppv"::numeric) != 0);

select avg(("GrAppv"::numeric)) from "SBAnational";


-- Now we will check some data which comes under categorical.

-- 1. NewExist
select "NewExist" from "SBAnational";
select "NewExist",count("NewExist") from "SBAnational" group by "NewExist";

-- 2. UrbanRural
select "UrbanRural" from "SBAnational";
select "UrbanRural",count("UrbanRural") from "SBAnational" group by "UrbanRural";

-- 3. LowDoc
select "LowDoc" from "SBAnational";
select "LowDoc",count("LowDoc") from "SBAnational" group by "LowDoc";


-- 3. MIS_Status
select "MIS_Status" from "SBAnational";
select "MIS_Status",count("MIS_Status") from "SBAnational" group by "MIS_Status";


-- 4. NAICS
select "NAICS" from "SBAnational";

select count(("NAICS"::VARCHAR)) from "SBAnational" where ("NAICS"::VARCHAR) like '11%'
union
select count(("NAICS"::VARCHAR)) from "SBAnational" where ("NAICS"::VARCHAR) like '21%'
union
select count(("NAICS"::VARCHAR)) from "SBAnational" where ("NAICS"::VARCHAR) like '22%'
union
select count(("NAICS"::VARCHAR)) from "SBAnational" where ("NAICS"::VARCHAR) like '23%'
union
select count(("NAICS"::VARCHAR)) from "SBAnational" where ("NAICS"::VARCHAR) like '42%'
union
select count(("NAICS"::VARCHAR)) from "SBAnational" where ("NAICS"::VARCHAR) like '31%' or ("NAICS"::varchar) like '33%'
union
select count(("NAICS"::VARCHAR)) from "SBAnational" where ("NAICS"::VARCHAR) like '45%' or ("NAICS"::varchar) like '44%'
union
select count(("NAICS"::VARCHAR)) from "SBAnational" where ("NAICS"::VARCHAR) like '48%' or ("NAICS"::varchar) like '49%'
union
select count(("NAICS"::VARCHAR)) from "SBAnational" where ("NAICS"::VARCHAR) like '51%'
union
select count(("NAICS"::VARCHAR)) from "SBAnational" where ("NAICS"::VARCHAR) like '52%'
union
select count(("NAICS"::VARCHAR)) from "SBAnational" where ("NAICS"::VARCHAR) like '53%'
union
select count(("NAICS"::VARCHAR)) from "SBAnational" where ("NAICS"::VARCHAR) like '54%'
union
select count(("NAICS"::VARCHAR)) from "SBAnational" where ("NAICS"::VARCHAR) like '55%'
union
select count(("NAICS"::VARCHAR)) from "SBAnational" where ("NAICS"::VARCHAR) like '56%'
union
select count(("NAICS"::VARCHAR)) from "SBAnational" where ("NAICS"::VARCHAR) like '61%'
union
select count(("NAICS"::VARCHAR)) from "SBAnational" where ("NAICS"::VARCHAR) like '62%'
union
select count(("NAICS"::VARCHAR)) from "SBAnational" where ("NAICS"::VARCHAR) like '71%'
union
select count(("NAICS"::VARCHAR)) from "SBAnational" where ("NAICS"::VARCHAR) like '72%'
union
select count(("NAICS"::VARCHAR)) from "SBAnational" where ("NAICS"::VARCHAR) like '81%'
union
select count(("NAICS"::VARCHAR)) from "SBAnational" where ("NAICS"::VARCHAR) like '92%';


-- 5. States
select count("LoanNr_ChkDgt"),"State" from "SBAnational" group by "State" order by count("LoanNr_ChkDgt") Desc;




































