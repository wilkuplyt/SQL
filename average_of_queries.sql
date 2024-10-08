-- Query 1: Count the number of students in each group
SELECT group_no, COUNT(*) AS student_count
FROM students
GROUP BY group_no;

-- Expected Output:
-- group_no  | student_count
-- -----------|---------------
-- DMIe1011  | 2
-- DMIe1012  | 1
-- DMIe1013  | 1


-- Query 2: Find the top 3 students with the highest average grades
SELECT s.student_id, s.first_name, s.surname, AVG(g.grade) AS average_grade
FROM students s
JOIN student_grades g ON s.student_id = g.student_id
GROUP BY s.student_id
ORDER BY average_grade DESC
LIMIT 3;

-- Expected Output:
-- student_id | first_name | surname | average_grade
-- ------------|------------|---------|---------------
-- 2          | Mark       | Johnson | 5.00
-- 1          | Alice      | Brown   | 4.25
-- 3          | Luis       | Garcia  | 2.00


-- Query 3: List lecturers who teach modules with no students enrolled
SELECT l.lecturer_id, e.first_name, e.surname, m.module_name
FROM lecturers l
JOIN employees e ON l.lecturer_id = e.employee_id
JOIN modules m ON l.lecturer_id = m.lecturer_id
LEFT JOIN students_modules sm ON m.module_id = sm.module_id
WHERE sm.student_id IS NULL;

-- Expected Output:
-- lecturer_id | first_name | surname | module_name
-- -------------|------------|---------|------------------------
-- 3           | John       | Smith   | Statistics
-- 4           | Sarah      | Williams | Quantum Mechanics


-- Query 4: Find the number of modules taught by each lecturer
SELECT e.first_name, e.surname, COUNT(m.module_id) AS modules_taught
FROM lecturers l
JOIN employees e ON l.lecturer_id = e.employee_id
LEFT JOIN modules m ON l.lecturer_id = m.lecturer_id
GROUP BY e.employee_id;

-- Expected Output:
-- first_name | surname | modules_taught
-- ------------|---------|-----------------
-- Harry       | Jones   | 1
-- Katie       | Davies  | 1
-- John        | Smith   | 1
-- Sarah       | Williams| 1


-- Query 5: List students who have enrolled in more than one module along with their module names
SELECT s.first_name, s.surname, GROUP_CONCAT(m.module_name SEPARATOR ', ') AS modules_enrolled
FROM students s
JOIN students_modules sm ON s.student_id = sm.student_id
JOIN modules m ON sm.module_id = m.module_id
GROUP BY s.student_id
HAVING COUNT(m.module_id) > 1;

-- Expected Output:
-- first_name | surname | modules_enrolled
-- ------------|---------|---------------------
-- Alice       | Brown   | Advanced Databases, History of Computing
