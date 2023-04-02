--Show first name, last name, and gender of patients who's gender is 'M'
SELECT first_name,last_name,gender FROM patients where gender="M";--1.soru

--Show first name and last name of patients who does not have allergies. (null)
SELECT first_name,last_name FROM patients where allergies IS NULL;--2.soru

--Show first name of patients that start with the letter 'C'
SELECT first_name FROM patients where first_name like "C%";--3.soru

--Show first name and last name of patients that weight within the range of 100 to 120 (inclusive)
SELECT first_name,last_name FROM patients where weight<=120 and weight>=100;--4.soru

--Update the patients table for the allergies column. If the patient's allergies is null then replace it with 'NKA'
update patients set allergies = "NKA" where allergies IS NULL;--5.soru

--Show first name and last name concatinated into one column to show their full name.
SELECT CONCAT(first_name," ",last_name) FROM patients;--6.soru

--Show first name, last name, and the full province name of each patient.
--Example: 'Ontario' instead of 'ON'
SELECT patients.first_name,patients.last_name,province_names.province_name FROM patients--7.soru
INNER JOIN province_names ON patients.province_id=province_names.province_id;--7.soru

--Show how many patients have a birth_date with 2010 as the birth year.
select count(birth_date) from patients where birth_date like "2010%";--8.soru
SELECT COUNT(*) from patients WHERE YEAR(birth_date) = 2010;--8.soru
select count(birth_date) From patients where year(birth_date)=2010;--8.soru

--Show the first_name, last_name, and height of the patient with the greatest height.
SELECT first_name,last_name,max(height) FROM patients;--9.soru
select first_name,last_name,height from patients where height=(select max(height)from patients);

--Show all columns for patients who have one of the following patient_ids:1,45,534,879,1000
SELECT * FROM patients where patient_id in(1,45,534,879,1000);--10.soru

--Show the total number of admissions
select count(patient_id) from admissions;--11.soru

--Show all the columns from admissions where the patient was admitted and discharged on the same day.
select * from admissions where admission_date=discharge_date;--12.soru

--Show the patient id and the total number of admissions for patient_id 579.
select patient_id,count(patient_id) from admissions where patient_id=579;--13.soru

--Based on the cities that our patients live in, show unique cities that are in province_id 'NS'?
select city from patients where province_id="NS" group by city;--14.soru

--Write a query to find the first_name, last name, and birth date of patients who has height greater than 160 and weight greater than 70
select first_name, last_name, birth_date from patients where height>160 and weight>70;--15.srou

--Write a query to find list of patients first_name, last_name, and allergies from city 'Hamilton' where allergies is not null
select first_name, last_name, allergies from patients where city="Hamilton" and allergies IS Not Null;--16.soru

--Based on cities where our patient lives in, write a query to display the list of unique city starting with a vowel (a, e, i, o, u). 
--Show the result order in ascending by city.
select city from patients where (CITY LIKE 'a%' 
    OR CITY LIKE 'e%' 
    OR CITY LIKE 'i%' 
    OR CITY LIKE 'o%'
    OR CITY LIKE 'u%'
) group by city order by city;--17.soru

select distinct city --17.soru onun çözümü distinct kullanılmış unique yapmak için ben group by kullanmışım bunun regex ile yazılan komutu da olmalı--like için hep cityi yazdık dikkat et--
from patients
where
  city like 'a%'
  or city like 'e%'
  or city like 'i%'
  or city like 'o%'
  or city like 'u%'
order by city;--17.soru

select distinct city from patiens where city ~ "^[aeiou]" order by city;--17.soru regexp çözümü ancak burada çalışmadı