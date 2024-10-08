-- Query 1: Find the highest grade achieved by each student and the associated module name
SELECT s.first_name, s.surname, m.module_name, g.grade
FROM (
    SELECT student_id, MAX(grade) AS highest_grade
    FROM student_grades
    GROUP BY student_id
) AS max_grades
JOIN student_grades g ON max_grades.student_id = g.student_id AND max_grades.highest_grade = g.grade
JOIN students s ON g.student_id = s.student_id
JOIN modules m ON g.module_id = m.module_id;

-- Expected Output:
-- first_name | surname | module_name           | grade
-- ------------|---------|-----------------------|-------
-- Alice       | Brown   | Advanced Databases    | 4.50
-- Mark        | Johnson | Advanced Databases    | 5.00


-- Query 2: Calculate the percentage of students passing each module (assuming passing is a grade >= 3.0)
SELECT m.module_name, 
       COUNT(CASE WHEN g.grade >= 3.0 THEN 1 END) * 100.0 / COUNT(g.grade) AS passing_percentage
FROM modules m
LEFT JOIN student_grades g ON m.module_id = g.module_id
GROUP BY m.module_id;

-- Expected Output:
-- module_name           | passing_percentage
-- ----------------------|-------------------
-- Advanced Databases    |              100.0
-- History of Computing   |               50.0
-- Statistics            |               0.0
-- Quantum Mechanics      |              NULL (if no grades exist)


-- Query 3: Rank students based on their average grades across all modules
SELECT s.first_name, s.surname, AVG(g.grade) AS average_grade,
       RANK() OVER (ORDER BY AVG(g.grade) DESC) AS rank
FROM students s
JOIN student_grades g ON s.student_id = g.student_id
GROUP BY s.student_id
ORDER BY rank;

-- Expected Output:
-- first_name | surname | average_grade | rank
-- ------------|---------|---------------|-----
-- Mark        | Johnson |           5.0 |  1
-- Alice       | Brown   |           4.25|  2
-- Luis        | Garcia  |           2.00|  3


-- Query 4: List lecturers who have the most students enrolled in their modules
SELECT e.first_name, e.surname, COUNT(sm.student_id) AS total_students
FROM lecturers l
JOIN employees e ON l.lecturer_id = e.employee_id
JOIN modules m ON l.lecturer_id = m.lecturer_id
LEFT JOIN students_modules sm ON m.module_id = sm.module_id
GROUP BY l.lecturer_id
ORDER BY total_students DESC
LIMIT 1;

-- Expected Output:
-- first_name | surname | total_students
-- ------------|---------|----------------
-- Harry       | Jones   |              4


-- Query 5: Find the module with the highest average grade and list the students who scored above that average
SELECT m.module_name, s.first_name, s.surname, g.grade
FROM modules m
JOIN (
    SELECT module_id, AVG(grade) AS avg_grade
    FROM student_grades
    GROUP BY module_id
) AS avg_grades ON m.module_id = avg_grades.module_id
JOIN student_grades g ON m.module_id = g.module_id
JOIN students s ON g.student_id = s.student_id
WHERE g.grade > avg_grades.avg_grade
ORDER BY m.module_name;

-- Expected Output:
-- module_name           | first_name | surname | grade
-- ----------------------|-------------|---------|-------
-- Advanced Databases    | Alice       | Brown   | 4.50
-- History of Computing   | Mark        | Johnson | 5.00
