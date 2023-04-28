-- 1. First we will see which Occupations have applied for loan in bigger population.
-- 2. which occupations are taken loan in large amount and their MIS_Status is PIF.
-- 3. which occupations are taken loan in large amount and their MIS_Status is CHGOFF.
-- involved columns = (NAICS, DisbursementGross, MIS_Status)
select SUBSTRING(("NAICS"::varchar),1,2), count("NAICS") 
from "SBAnational" 
GROUP by SUBSTRING(("NAICS"::varchar),1,2) 
order by count("NAICS") DESC;


select "Name", SUBSTRING(("NAICS"::varchar),1,2), "DisbursementGross", "MIS_Status", dense_rank()
over (PARTITION BY SUBSTRING(("NAICS"::varchar),1,2) order by "DisbursementGross" DESC) 
from "SBAnational" where "NAICS" != 0;

select SUBSTRING(("NAICS"::varchar),1,2), count("MIS_Status") from "SBAnational" 
where "MIS_Status" = 'P I F' group by SUBSTRING(("NAICS"::varchar),1,2);

select SUBSTRING(("NAICS"::varchar),1,2), count("MIS_Status") from "SBAnational" 
where "MIS_Status" = 'CHGOFF' group by SUBSTRING(("NAICS"::varchar),1,2);

select "Name", SUBSTRING(("NAICS"::varchar),1,2), "DisbursementGross", "MIS_Status", dense_rank()
over (PARTITION BY SUBSTRING(("NAICS"::varchar),1,2) order by "DisbursementGross" DESC) 
from "SBAnational" where "NAICS" != 0 and "MIS_Status" = 'CHGOFF';


-- 4. show Name, NAICS, DisbursementGross, Term, MIS_Status and Term where all are chgoff.
-- 5. show Name, NAICS, DisbursementGross, Term, MIS_Status and Term where all are pif.

select "Name", "DisbursementGross", "Term", substring(("NAICS"::varchar),1,2), "MIS_Status", dense_rank()
over (partition by SUBSTRING(("NAICS"::varchar),1,2) order by "Term" DESC) 
from "SBAnational" where "NAICS" = 0 and "MIS_Status" = 'P I F';

select "Name", "DisbursementGross", "Term", substring(("NAICS"::varchar),1,2), "MIS_Status", dense_rank()
over (partition by SUBSTRING(("NAICS"::varchar),1,2) order by "Term" DESC) 
from "SBAnational" where "NAICS" = 0 and "MIS_Status" = 'CHGOFF';

select "Name", "DisbursementGross", "Term", substring(("NAICS"::varchar),1,2), "MIS_Status", dense_rank()
over (partition by SUBSTRING(("NAICS"::varchar),1,2) order by "Term" DESC) 
from "SBAnational" where "NAICS" != 0 and "MIS_Status" = 'P I F';

select "Name", "DisbursementGross", "Term", substring(("NAICS"::varchar),1,2), "MIS_Status", dense_rank()
over (partition by SUBSTRING(("NAICS"::varchar),1,2) order by "Term" DESC) 
from "SBAnational" where "NAICS" != 0 and "MIS_Status" = 'CHGOFF';



-- 6. show Name, NAICS, DisbursementGross, NewExist, MIS_Status and Term where all are chgoff.
-- 7. show Name, NAICS, DisbursementGross, NewExist, MIS_Status and Term where all are pif.


select "Name", "DisbursementGross", "NewExist", substring(("NAICS"::varchar),1,2), "MIS_Status", dense_rank()
over (partition by SUBSTRING(("NAICS"::varchar),1,2) order by "DisbursementGross" DESC) 
from "SBAnational" where "NAICS" != 0 and "NewExist" = 1;

select "Name", "DisbursementGross", "NewExist", substring(("NAICS"::varchar),1,2), "MIS_Status", dense_rank()
over (partition by SUBSTRING(("NAICS"::varchar),1,2) order by "DisbursementGross" DESC) 
from "SBAnational" where "NAICS" != 0 and "NewExist" = 2;

select count("MIS_Status") from "SBAnational" 
where "NewExist" = 1 and "MIS_Status" = 'P I F';

select count("MIS_Status") from "SBAnational" 
where "NewExist" = 2 and "MIS_Status" = 'P I F';


-- 8. check the MIS_Status on basis of Urban and Rural area. with other important factors.
select "Name", "DisbursementGross", substring(("NAICS"::varchar),1,2) as Occupation, "UrbanRural", "MIS_Status",
dense_rank() over (partition by substring(("NAICS"::varchar),1,2) order by "DisbursementGross") from "SBAnational"
where "NAICS" = 0;

select "Name", "DisbursementGross", substring(("NAICS"::varchar),1,2) as Occupation, "UrbanRural", "MIS_Status",
dense_rank() over (partition by substring(("NAICS"::varchar),1,2) order by "DisbursementGross") from "SBAnational"
where "NAICS" != 0;

select "UrbanRural", count("MIS_Status") from "SBAnational" where "MIS_Status" = 'P I F' group by "UrbanRural";

select "UrbanRural", count("MIS_Status") from "SBAnational" where "MIS_Status" = 'CHGOFF' group by "UrbanRural";


-- 9. check the MIS_Status on basis of DisbursementDate and ChgOffDate with other important factors.
select "Name", "DisbursementGross", substring(("NAICS"::varchar),1,2) as Occupation, "ChgOffDate", "MIS_Status",
dense_rank() over (partition by substring(("NAICS"::varchar),1,2) order by "DisbursementGross" desc) 
from "SBAnational" where "NAICS" != 0 and "ChgOffDate" is not null;

select "Name", "DisbursementGross", substring(("NAICS"::varchar),1,2) as Occupation, 
("ChgOffDate"-"DisbursementDate")/365 as years, "MIS_Status",
dense_rank() over (partition by substring(("NAICS"::varchar),1,2) order by "DisbursementGross" desc) 
from "SBAnational" where "NAICS" != 0 and "ChgOffDate" is not null;

select substring(("NAICS"::varchar),1,2) as Occupation, count(substring(("NAICS"::varchar),1,2))
from "SBAnational" where "ChgOffDate" is not null 
group by substring(("NAICS"::varchar),1,2) order by count(substring(("NAICS"::varchar),1,2)) DESC;


-- 10. PIF & CHGOFF as per BalanceGross.
select "Name", "DisbursementGross", substring(("NAICS"::varchar),1,2) as Occupation, 
"BalanceGross", "MIS_Status",
dense_rank() over (partition by substring(("NAICS"::varchar),1,2) order by "DisbursementGross" desc) 
from "SBAnational" where "NAICS" != 0 and ("BalanceGross"::numeric) != 0;

select count(("BalanceGross"::numeric)) from "SBAnational" where ("BalanceGross"::numeric) != 0;

-- 11. MIS_Status on basis of loss amount.
select "Name", "DisbursementGross", substring(("NAICS"::varchar),1,2) as Occupation, 
"ChgOffPrinGr", "MIS_Status",
dense_rank() over (partition by substring(("NAICS"::varchar),1,2) order by "ChgOffPrinGr" desc) 
from "SBAnational" where "NAICS" != 0;

select count("ChgOffPrinGr") from "SBAnational" where "MIS_Status" = 'CHGOFF'; 

select count("ChgOffPrinGr") from "SBAnational" where "MIS_Status" = 'P I F'; 


-- 12. Defaulters and non-defaulters on basis of State.
select "State", count("MIS_Status") from "SBAnational" 
where "MIS_Status" = 'P I F' group by "State" 
order by count("MIS_Status") DESC;

select "State", count("MIS_Status") from "SBAnational" 
where "MIS_Status" = 'CHGOFF' group by "State"
order by count("MIS_Status") DESC;

select "Name", "DisbursementGross", substring(("NAICS"::varchar),1,2) as Occupation, 
"State", "MIS_Status",
dense_rank() over (partition by "State" order by "DisbursementGross" desc) 
from "SBAnational" where "NAICS" != 0;


-- Final Query to add a column and identify should we give the loan to a person or not.
ALTER TABLE "SBAnational" ADD COLUMN "Decision" VARCHAR(50);

UPDATE "SBAnational" SET "Decision"=
CASE 
   WHEN "MIS_Status" = 'P I F' THEN 'Approved'
   WHEN "MIS_Status" = 'CHGOFF' THEN 'Denied'
   ELSE 'Pending'
END;

Select "MIS_Status", "Decision" from "SBAnational"






