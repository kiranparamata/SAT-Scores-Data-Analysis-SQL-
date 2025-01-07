 Tutorial.sat_scores
Description:
This dataset is related to SAT scores. SAT is an exam used in USA to provide admission. SAT contains
of three subjects - writing, verbal, and math. This dataset has following columns:
• School: The school in which student studied
• Teacher: Name of the teacher who taught the student
• Student_id: The id for each student(a unique identifier)
• Sat_writing: marks scored in writing
• Sat_verbal: marks scored in verbal
• Sat_maths: marks scored in math
• Hrs_studied: hours spent in studying
• Id: unique identifier for the dataset


Question-1: Write a query to add column - avg_sat_writing. Each row in this column should include average marks in the writing section of the student per school. 

Question-2: In the above question, add an additional column - count_per_school. Each row of this column should include number of students per school 

Question-3: In the above question, add two additional columns - max_per_teacher and min_per_teacher. Each row of this column should include maximum and minimum marks in maths per teacher respectively

Question-4: For the dataset, write a query to add the two columns cum_hrs_studied and total_hrs_studied. Each row in cum_hrs_studied should display the cumulative sum of hours studied per school. Each row in the total_hrs_studied will display total hours studied perschool. Order the data in the ascending order of student id 

Question-5: For the dataset, write a query to add column sub_hrs_studied and total_hrs_studied. Each row in sub_hrs_studied should display the sum of hrs_studied for a row above, a row below, and current row per school. Order the data in the ascending order of student id 

Question-6: Write a query to rank the students per school on the basis of scores in verbal. Use both rank and dense_rank function. Students with the highest marks should get rank 1.
 **Note: see if there is difference in ranking provided by both the functions.

Question-7: Write a query to rank the students per school on the basis of scores in writing. Use both rank and dense_rank function. Student with the highest marks should get rank 1.
 **Note: see if there is difference in ranking provided by both the functions for teacher = ‘Spellman’

Question-8: Write a query to find the top 5 students per teacher who spent maximum hours studying.

Question-9: Write a query to find the worst 5 students per school who got minimum marks in sat_math

Question-10: Write a query to divide the dataset into quartile on the basis of marks in sat_verbal.


Question-11: 
For ‘Petersville HS’ school, write a query to arrange the students in the ascending order of hours  studied. Also, add a column to find the difference in hours studied from the student above(in the row).  Exclude the cases where hrs_studied is null. 
Question-12: 
For ‘Washington HS’ school, write a query to arrange the students in the descending order of  sat_math. Also, add a column to find the difference in sat_math from the student below(in the row). Answer-12: 
Question-13: 
Write a query to return 4 columns - student_id, school, sat_writing, difference in sat_writing and  average marks scored in sat_writing in the school. 
Question-14: 
Write a query to return 4 columns - student_id, teacher, sat_verbal, difference in sat_verbal and  minimum marks scored in sat_verbal per teacher. 





CREATE TABLE Tutorial.sat_scores (
    Id INT PRIMARY KEY,
    School VARCHAR(255),
    Teacher VARCHAR(255),
    Student_id INT UNIQUE,
    Sat_writing INT,
    Sat_verbal INT,
    Sat_maths INT,
    Hrs_studied INT
);

INSERT INTO Tutorial.sat_scores (Id, School, Teacher, Student_id, Sat_writing, Sat_verbal, Sat_maths, Hrs_studied)
SELECT
    n+1 AS Id,
    CONCAT('School_', CHAR(65 + FLOOR(RAND() * 26))) AS School,
    CONCAT('Teacher_', CHAR(65 + FLOOR(RAND() * 3))) AS Teacher,
    1000 + n AS Student_id,
    FLOOR(RAND() * 400) + 400 AS Sat_writing,
    FLOOR(RAND() * 400) + 400 AS Sat_verbal,
    FLOOR(RAND() * 400) + 400 AS Sat_maths,
    FLOOR(RAND() * 60) + 20 AS Hrs_studied
FROM (
    SELECT ones.n + tens.n * 10 + hundreds.n * 100 + thousands.n * 1000 AS n
    FROM (SELECT 0 AS n UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) AS ones
    CROSS JOIN (SELECT 0 AS n UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) AS tens
    CROSS JOIN (SELECT 0 AS n UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) AS hundreds
    CROSS JOIN (SELECT 0 AS n UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) AS thousands
) AS numbers
LIMIT 1500;

