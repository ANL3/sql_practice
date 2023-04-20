--Q1--Show all of the patients grouped into weight groups.
--Show the total amount of patients in each weight group.
--Order the list by the weight group decending.
--For example, if they weight 100 to 109 they are placed in the 100 weight group, 110-119 = 110 weight group, etc.

SELECT COUNT(*) , FLOOR(weight/10.0)*10 AS weight_hist
FROM patients
GROUP BY weight_hist
order by weight_hist desc

--Q2--Show patient_id, weight, height, isObese from the patients table.
--Display isObese as a boolean 0 or 1.
--Obese is defined as weight(kg)/(height(m)2) >= 30.
--weight is in units kg.
--height is in units cm.

Select patient_id,weight,height,"0" As isObese
from patients
where (weight*10000)/(height*height) < 30.0
union
Select patient_id,weight,height,"1" As isObese
from patients
where (weight*10000)/(height*height) >= 30.0

SELECT patient_id, weight, height, 
  (CASE 
      WHEN weight/(POWER(height/100.0,2)) >= 30 THEN
          1
      ELSE
          0
      END) AS isObese
FROM patients;

--Q3--Show patient_id, first_name, last_name, and attending doctor's specialty.
--Show only the patients who has a diagnosis as 'Epilepsy' and the doctor's first name is 'Lisa'
--Check patients, admissions, and doctors tables for required information.

select patients.patient_id,patients.first_name,patients.last_name,doctors.specialty
from admissions 
join patients on patients.patient_id=admissions.patient_id
join doctors on admissions.attending_doctor_id=doctors.doctor_id
where admissions.diagnosis='Epilepsy' and doctors.first_name='Lisa'

--Q4--All patients who have gone through admissions, can see their medical documents on our site. Those patients are given a temporary password after their first admission. Show the patient_id and temp_password.
--The password must be the following, in order:
--1. patient_id
--2. the numerical length of patient's last_name
--3. year of patient's birth_date

select distinct(patients.patient_id),concat(patients.patient_id,len(patients.last_name),year(patients.birth_date)) As temp_password
FROM patients join admissions on patients.patient_id=admissions.patient_id;

--Q5--Each admission costs $50 for patients without insurance, and $10 for patients with insurance. 
--All patients with an even patient_id have insurance.
--Give each patient a 'Yes' if they have insurance, and a 'No' if they don't have insurance. 
--Add up the admission_total cost for each has_insurance group.

select "YES",count(*)*10 from admissions where patient_id%2=0
union
select "NO",count(*)*50 from admissions where patient_id%2=1;

SELECT 
CASE WHEN patient_id % 2 = 0 Then 
    'Yes'
ELSE 
    'No' 
END as has_insurance,
SUM(CASE WHEN patient_id % 2 = 0 Then 
    10
ELSE 
    50 
END) as cost_after_insurance
FROM admissions 
GROUP BY has_insurance;

--Q6--Show the provinces that has more patients identified as 'M' than 'F'. 
--Must only show full province_name

select province_names.province_name from province_names 
join patients on province_names.province_id=patients.province_id
group by province_names.province_name
having sum(case when patients.gender="M" then 1 else 0 end)  > sum(case when patients.gender="F" then 1 else 0 end) 

--Q7--We are looking for a specific patient. Pull all columns for the patient who matches the following criteria:
--First_name contains an 'r' after the first two letters.
--Identifies their gender as 'F'
--Born in February, May, or December
--Their weight would be between 60kg and 80kg
--Their patient_id is an odd number
--They are from the city 'Kingston'

select * from patients where first_name like "__r%" 
and gender="F" 
and 60<=weight<=80
AND patient_id%2=1
And city="Kingston"
AND MONTH(birth_date) IN (2, 5, 12)

--Q8--Show the percent of patients that have 'M' as their gender. 
--Round the answer to the nearest hundreth number and in percent form.
select concat(round(Sum(case when gender="M" then 1 else 0 end )*100.0/count(*),2),"%") as male_perc from patients

SELECT CONCAT(
    ROUND(
      (
        SELECT COUNT(*)
        FROM patients
        WHERE gender = 'M'
      ) / CAST(COUNT(*) as float),
      4
    ) * 100,
    '%'
  ) as percent_of_male_patients
FROM patients;

