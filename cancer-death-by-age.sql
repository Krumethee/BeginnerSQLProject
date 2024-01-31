select * from Project..cancer_deaths_by_age
order by 3,4

--select data that we are going to be using 

select country, year, age_70up, age_50to69, age_15to49, 
age_5to14, age_under5
from Project..cancer_deaths_by_age
order by 1,2

-- Looking at age70+ vs age50-69
-- Show likelihood of dying if you contract cancer in your country
select country, year, age_70up, age_50to69, 
(age_50to69/age_70up)*100 as Deathpercentage
from Project..cancer_deaths_by_age
where country like '%Thailand%'
order by 1,2

-- Looking at age15-49 vs age5-14 
select country, year, age_15to49, age_5to14, 
(age_15to49/age_5to14)*100 as Deathpercentage  
from Project..cancer_deaths_by_age
where country like '%Thailand%'
order by 1,2

-- Looking at age5-14 vs age under5
select country, year, age_15to49, age_5to14, 
(age_5to14/age_under5)*100 as Deathpercentage  
from Project..cancer_deaths_by_age
where country like '%Thailand%'
order by 1,2

-- Looking at countries with highest deaths from cancer

select country, year, 
max(age_70up) as Highestcancerdeath70up,
max(age_50to69) as Highestcancerdeath50_69, 
max(age_15to49) as Highestcancerdeath15_49, 
max(age_5to14) as Highestcancerdeath5_14, 
max(age_under5) as Highestcancerdeath_under5
from Project..cancer_deaths_by_age
where country like '%Thailand%'
group by country, [year] 
order by 1,2 desc

-- Looking at countries with highest rate compared to cancer-deaths
-- age70+ and age50-69

select country, year, 
max(age_70up) as max_age_70up, 
max(age_50to69) as max_age_to50to69,
max(age_70up) / nullif(max(age_50to69), 0) * 100 
as percentage_population_deaths
from Project..cancer_deaths_by_age
group by country, [year]
order by percentage_population_deaths desc --japan no.1

-- Looking at countries with highest rate compared to cancer-deaths
-- age50-69 and age15-49

select country, year, 
max(age_50to69) as max_age_50to69, 
max(age_15to49) as max_age_15to49,
max(age_50to69) / nullif(max(age_15to49), 0) * 100 
as percentage_population_deaths
from Project..cancer_deaths_by_age
group by country, [year]
order by percentage_population_deaths desc --finland no.1

-- Looking at countries with highest rate compared to cancer-deaths
-- age15-49 and age5-14

select country, year, 
max(age_15to49) as max_age_15to49, 
max(age_5to14) as max_age_5to14,
max(age_15to49) / nullif(max(age_5to14), 0) * 100 
as percentage_population_deaths
from Project..cancer_deaths_by_age
group by country, [year]
order by percentage_population_deaths desc --united arab emirates no.1

-- Looking at countries with highest rate compared to cancer-deaths
-- age5-14 and age_under5

select country, year,
max(age_5to14) as max_age_5to14, 
max(age_under5) as max_age_under5,
max(age_5to14) / nullif(max(age_under5), 0) * 100 
as percentage_population_deaths
from Project..cancer_deaths_by_age
group by country, [year]
order by percentage_population_deaths desc --south afica no.1

-- Showing Countries with  highest death count per population

 select country, 
max(cast(age_70up as int)) as TotalDeathCount70up,
max(cast(age_50to69 as int)) as TotalDeathCount50_69, 
max(cast(age_15to49 as int)) as TotalDeathCount15_49, 
max(cast(age_5to14 as int)) as TotalDeathCount5_14, 
max(cast(age_under5 as int)) as TotalDeathCount_under5
from Project..cancer_deaths_by_age
group by country
order by 
TotalDeathCount70up, 
TotalDeathCount50_69, 
TotalDeathCount15_49, 
TotalDeathCount5_14, 
TotalDeathCount_under5 desc

-- Showing Year Contries with highest death in 2019

select country, 
max(iif(year = 2019, age_70up, NULL)) as highest_age_70up_2019,
max(iif(year = 2019, age_50to69, NULL)) as highest_age_50to69_2019,
max(iif(year = 2019, age_15to49, NULL)) as highest_age_15to49_2019,
max(iif(year = 2019, age_5to14, NULL)) as highest_age_5to14_2019,
max(iif(year = 2019, age_under5, NULL)) as highest_age_under5_2019
from Project..cancer_deaths_by_age
group by country 

-- Showing Year Contries with highest death in 1990

select country, 
max(iif(year = 1990, age_70up, NULL)) as highest_age_70up_1990,
max(iif(year = 1990, age_50to69, NULL)) as highest_age_50to69_1990,
max(iif(year = 1990, age_15to49, NULL)) as highest_age_15to49_1990,
max(iif(year = 1990, age_5to14, NULL)) as highest_age_5to14_1990,
max(iif(year = 1990, age_under5, NULL)) as highest_age_under5_1990
from Project..cancer_deaths_by_age
group by country 

-- Global Numbers deaths

select country, year, 
sum(age_70up) as Highestcancerdeath70up,
sum(age_50to69) as Highestcancerdeath50_69, 
sum(age_15to49) as Highestcancerdeath15_49, 
sum(age_5to14) as Highestcancerdeath5_14, 
sum(age_under5) as Highestcancerdeath_under5
from Project..cancer_deaths_by_age
where country like '%world%'
group by country, [year] 
order by 1,2 desc

