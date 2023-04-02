--Q1--Show unique birth years from patients and order them by ascending.
select distinct(year(birth_date)) from patients order by year(birth_date);

--Q2--Show unique first names from the patients table which only occurs once in the list.
--For example, if two or more people are named 'John' in the first_name column then don't include their name in the output list.
--If only 1 person is named 'Leo' then include them in the output.
select first_name from patients group by first_name having count(first_name)=1 order by first_name;

--Q3--Show patient_id and first_name from patients where their first_name start and ends with 's' and is at least 6 characters long.
select patient_id,first_name from patients where first_name like "s%s" and len(first_name)>5;

--Q4--Show patient_id, first_name, last_name from patients whos diagnosis is 'Dementia'.
--Primary diagnosis is stored in the admissions table.
select patients.patient_id,patients.first_name,patients.last_name from patients inner join admissions 
on admissions.patient_id=patients.patient_id where admissions.diagnosis="Dementia";

SELECT
  patients.patient_id,
  first_name,
  last_name
FROM patients
  JOIN admissions ON admissions.patient_id = patients.patient_id
WHERE diagnosis = 'Dementia';

--Q5--Display every patient's first_name.
--Order the list by the length of each name and then by alphbetically
select first_name from patients order by len(first_name),first_name;

--Q6--Show the total amount of male patients and the total amount of female patients in the patients table.
--Display the two results in the same row.
SELECT (SELECT count(*) FROM patients WHERE gender='M')as male,(SELECT count(*) FROM patients WHERE gender='F') as female;
--select sonuçları return ediyor. iki ayrı sonucu yatay olarak döndürdü. Burada union ile dikey yapılabilirdi. tablo ismi girdiğimiz
--tüm satıra bu işlmeleri uygular.

--Q7--Show first and last name, allergies from patients which have allergies to either 'Penicillin' or 'Morphine'. 
--Show results ordered ascending by allergies then by first_name then by last_name.
select first_name,last_name,allergies from patients where allergies="Penicillin" or allergies="Morphine" order by allergies,first_name,last_name;

--Q8--Show patient_id, diagnosis from admissions. Find patients admitted multiple times for the same diagnosis.
select patient_id, diagnosis from admissions group by patient_id,diagnosis having count(diagnosis)>1;

--Q9--Show the city and the total number of patients in the city.
--Order from most to least patients and then by city name ascending.
select city,count(*) as num_patients from patients group by city order by count(*) desc,city;

--Q10--Show first name, last name and role of every person that is either patient or doctor.
--The roles are either "Patient" or "Doctor"
select first_name,last_name,"Patient" from patients 
union ALL
select first_name,last_name,"Doctor" from doctors
--union yazılsaydı bir de order yapıyor.

--Q11--Show all allergies ordered by popularity. Remove 'NKA' and NULL values from query.
SELECT allergies,count(allergies) from patients group by allergies having allergies not null order by count(allergies) desc;

--Q12--Show all patient's first_name, last_name, and birth_date who were born in the 1970s decade. Sort the list starting from the earliest birth_date.
select first_name, last_name, birth_date from patients where 1970<=year(birth_date) AND 1980>year(birth_date) order by birth_date;

--Q13--We want to display each patient's full name in a single column. Their last_name in all upper letters must appear first, then first_name in all lower case letters. 
--Separate the last_name and first_name with a comma. Order the list by the first_name in decending order
--EX: SMITH,jane
select concat(upper(last_name),",", lower(first_name)) as full_name from patients order by first_name desc;

--Q14--Show the province_id(s), sum of height; where the total sum of its patient's height is greater than or equal to 7,000.
select province_id,sum(height) As height_sum from patients group by province_id having height_sum >= 7000 

--Q15--Show the difference between the largest weight and smallest weight for patients with the last name 'Maroni'
select (max(weight)-min(weight)) as range_weight from patients where last_name="Maroni";

--Q16--Show all of the days of the month (1-31) and how many admission_dates occurred on that day. Sort by the day with most admissions to least admissions.
select day(admission_date),count(*) from admissions group by day(admission_date) order by count(*) desc;

--Q17--Show all columns for patient_id 542's most recent admission_date.
select * from admissions where patient_id=542 order by admission_date desc limit 1;

--Q18--Show patient_id, attending_doctor_id, and diagnosis for admissions that match one of the two criteria:
--1. patient_id is an odd number and attending_doctor_id is either 1, 5, or 19.
--2. attending_doctor_id contains a 2 and the length of patient_id is 3 characters.
select patient_id,attending_doctor_id,diagnosis from admissions where patient_id%2=1 and attending_doctor_id in(1,5,19)
union all
select patient_id,attending_doctor_id,diagnosis from admissions where attending_doctor_id like "%2%" and len(patient_id)=3;

--Q19--Show first_name, last_name, and the total number of admissions attended for each doctor.
--Every admission has been attended by a doctor.
select doctors.first_name, doctors.last_name, count(admissions.attending_doctor_id) from doctors inner join admissions on admissions.attending_doctor_id=doctors.doctor_id group by admissions.attending_doctor_id;

--Q20--For each doctor, display their id, full name, and the first and last admission date they attended.
select doctors.doctor_id,concat(doctors.first_name," ",doctors.last_name) As full_name,min(admissions.admission_date), mAX(admissions.admission_date)
from doctors inner join admissions on doctors.doctor_id=admissions.attending_doctor_id group by doctors.doctor_id

--Q21--Display the total amount of patients for each province. Order by descending.
select province_names.province_name,count(patients.patient_id) as total_patients from province_names inner join patients on province_names.province_id=patients.province_id group by province_names.province_name order by count(patients.patient_id) desc;

select province_names.province_name,count(patients.patient_id) as total_patients from province_names inner join patients on province_names.province_id=patients.province_id group by province_names.province_name order by total_patients desc;

--Q22--For every admission, display the patient's full name, their admission diagnosis, and their doctor's full name who diagnosed their problem.
select concat(patients.first_name," ",patients.last_name) as patient_full_name, admissions.diagnosis, concat(doctors.first_name, " ", doctors.last_name) as doctor_full_name
from admissions 
inner join patients on admissions.patient_id=patients.patient_id
inner join doctors  on admissions.attending_doctor_id=doctors.doctor_id;

--Q23--Display the number of duplicate patients based on their first_name and last_name.
select first_name,last_name,count(*) as duplicate_number from patients group by first_name,last_name having duplicate_number>1;

--Q24--Display patient's full name,
--height in the units feet rounded to 1 decimal,
--weight in the unit pounds rounded to 0 decimals,
--birth_date,
--gender non abbreviated.

--Convert CM to feet by dividing by 30.48.
--Convert KG to pounds by multiplying by 2.205.
select concat(first_name, " ", last_name) as full_name, round(height/30.48,1), round(weight*2.205,0), birth_date, "Male"
from patients where gender="M"
union all
select concat(first_name, " ", last_name) as full_name, round(height/30.48,1), round(weight*2.205,0), birth_date, "Female"
from patients where gender="F"

select
    concat(first_name, ' ', last_name) AS 'patient_name', 
    ROUND(height / 30.48, 1) as 'height "Feet"', 
    ROUND(weight * 2.205, 0) AS 'weight "Pounds"', birth_date,
CASE
	WHEN gender = 'M' THEN 'MALE' 
  ELSE 'FEMALE' 
END AS 'gender_type'
from patients