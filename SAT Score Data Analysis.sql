/* Description:
This dataset is related to SAT scores. SAT is an exam used in USA to provide admission. SAT contains
of three subjects - writing, verbal, and math. This dataset has following columns:
• School: The school in which student studied
• Teacher: Name of the teacher who taught the student
• Student_id: The id for each student(a unique identifier)
• Sat_writing: marks scored in writing
• Sat_verbal: marks scored in verbal
• Sat_maths: marks scored in math
• Hrs_studied: hours spent in studying
• Id: unique identifier for the dataset.*/


use Tutorial;
select * from sat_scores;

/*Question-1: Write a query to add column - avg_sat_writing. Each row in this column 
should include average marks in the writing section of the student per school. */
select *,  round(avg(Sat_writing) over (partition by School order by school)) as avg_sat_writing from sat_scores;

/*Question-2: In the above question, add an additional column - count_per_school.
 Each row of this column should include number of students per school*/
select *, count(Student_id) over (partition by School order by school) as count_per_school from sat_scores;

select School ,count(Student_id)  as count_per_school from sat_scores group by School order by school;

select * from sat_scores t1
inner join (select School ,count(Student_id)  as count_per_school from sat_scores group by School) t2
on t1.School=t2.school;

/*Question-3: In the above question, add two additional columns - max_per_teacher and min_per_teacher.
 Each row of this column should include maximum and minimum marks in maths per teacher respectively*/
select *, max(Sat_maths) over (partition by School,Teacher order by '') as max_per_teacher,
min(Sat_maths) over (partition by school,Teacher order by '') as min_per_teacher
from sat_scores;

 /*Question-4: For the dataset, write a query to add the two columns cum_hrs_studied and total_hrs_studied.
 Each row in cum_hrs_studied should display the cumulative sum of hours studied per school.
 Each row in the total_hrs_studied will display total hours studied perschool.
 Order the data in the ascending order of student id */
select *, sum(Hrs_studied) over (partition by School order by Student_id) as cum_hrs_studied,
min(Hrs_studied) over (partition by school  order by Student_id rows between unbounded preceding and unbounded following ) 
as total_hrs_studied
from sat_scores;
 
 
 /*Question-5: For the dataset, write a query to add column sub_hrs_studied and total_hrs_studied.
 Each row in sub_hrs_studied should display the sum of hrs_studied for a row above, a row below,
 and current row per school. Order the data in the ascending order of student id */
select *, sum(Hrs_studied) over (partition by School order by Student_id rows between 1 preceding and 1 following) as sub_hrs_studied,
min(Hrs_studied) over (partition by school  order by Student_id rows between unbounded preceding and unbounded following ) 
as total_hrs_studied
from sat_scores;

/*Question-6: Write a query to rank the students per school on the basis of scores in verbal.
 Use both rank and dense_rank function. Students with the highest marks should get rank 1.
 **Note: see if there is difference in ranking provided by both the functions.*/
select *, rank()  over (partition by School order by Sat_verbal desc) as rnk,
dense_rank() over (partition by school order by Sat_verbal desc) as dense_rnk
from sat_scores;
 
 
 /*Question-7: Write a query to rank the students per school on the basis of scores in writing.
 Use both rank and dense_rank function. Student with the highest marks should get rank 1.
 **Note: see if there is difference in ranking provided by both the functions for teacher ='Teacher_A'*/
select *, rank()  over (partition by School order by Sat_writing desc) as rnk,
dense_rank() over (partition by school order by Sat_writing desc) as dense_rnk
from sat_scores where Teacher = 'Teacher_A';
 
 -- Question-8: Write a query to find the top 5 students per teacher who spent maximum hours studying.
 select * from(
select *, dense_rank() over (partition by Teacher order by Hrs_studied desc ) as dense_rnk
from sat_scores ) t1 
where dense_rnk<=5;

-- Question-9: Write a query to find the worst 5 students per school who got minimum marks in sat_math
select * from(
select *, dense_rank() over (partition by Teacher order by Sat_maths ) as dense_rnk
from sat_scores ) t1 
where dense_rnk<=5;

-- Question-10: Write a query to divide the dataset into quartile on the basis of marks in sat_verbal.
select *, ntile(4) over (partition by '' order by sat_verbal ) as quartile
from sat_scores;


/*Question-11: For ‘School_K’ school, write a query to arrange the students in the 
ascending order of hours  studied. Also, add a column to find the difference
 in hours studied from the student above(in the row).  Exclude the cases 
 where hrs_studied is null.     Lead*/
select *, Hrs_studied - lead (Hrs_studied,1) over (partition by Teacher order by Hrs_studied ) as diff_marks
from sat_scores
where School='School_K';
 
 
/*Question-12: 
For ‘Washington HS’ school, write a query to arrange the students in the 
descending order of  sat_math. Also, add a column to find the difference 
in sat_math from the student below(in the row). Answer-12:   Lag*/
select *, Sat_maths - lag (Sat_maths,1) over (partition by Teacher order by Hrs_studied ) as diff_marks
from sat_scores
where School='School_K';

select *,  avg(Sat_writing) over (partition by School order by Sat_writing ) as diff_avg
from sat_scores;

/*Question-13: 
Write a query to return 4 columns - student_id, school, sat_writing, difference
 in sat_writing and  average marks scored in sat_writing in the school. */
select student_id, school, sat_writing,sat_writing - avg(Sat_writing) over (partition by School order by Sat_writing ) as diff_avg
from sat_scores;
 
 
/*Question-14: 
Write a query to return 4 columns - student_id, teacher, sat_verbal, difference in 
sat_verbal and  minimum marks scored in sat_verbal per teacher. */
select student_id, teacher, sat_verbal,sat_verbal - min(sat_verbal) over (partition by School order by sat_verbal ) as diff_avg
from sat_scores;
 
 
