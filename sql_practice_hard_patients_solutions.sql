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

