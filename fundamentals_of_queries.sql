-- Query 1: List all students along with their group numbers
SELECT student_id, surname, first_name, group_no
FROM students;

-- Expected Output:
-- student_id | surname | first_name | group_no
-- ------------|---------|-------------|---------
--      1     | Brown   | Alice       | DMIe1011
--      2     | Johnson | Mark        | DMIe1011
--      3     | Garcia  | Luis        | DMIe1012
--      4     | Smith   | Emily       | DMIe1013


-- Query 2: Get the average grade for each module
SELECT m.module_name, AVG(g.grade) AS average_grade
FROM modules m
JOIN student_grades g ON m.module_id = g.module_id
GROUP BY m.module_name;

-- Expected Output:
-- module_name           | average_grade
-- ----------------------|---------------
-- Advanced Databases    |     4.25
-- History of Computing   |     3.75
-- Statistics            |     2.00
-- Quantum Mechanics      |     NULL (if no grades exist)


-- Query 3: Retrieve all lecturers with their respective departments
SELECT e.first_name, e.surname, l.department, l.acad_position
FROM lecturers l
JOIN employees e ON l.lecturer_id = e.employee_id;

-- Expected Output:
-- first_name | surname | department                   | acad_position
-- ------------|---------|------------------------------|--------------
-- Harry       | Jones   | Department of Informatics     | Lecturer
-- Katie       | Davies   | Department of History         | Lecturer
-- John        | Smith    | Department of Mathematics     | Doctor
-- Sarah       | Williams | Department of Physics         | Associate Professor


-- Query 4: Find all students who have received a grade above 4.0 in any module
SELECT s.first_name, s.surname, g.grade
FROM students s
JOIN student_grades g ON s.student_id = g.student_id
WHERE g.grade > 4.0;

-- Expected Output:
-- first_name | surname | grade
-- ------------|---------|-------
-- Alice       | Brown   | 4.50
-- Mark        | Johnson | 5.00


-- Insert new lecturer
INSERT INTO lecturers (lecturer_id, department, acad_position) VALUES
(5, 'Department of Chemistry', 'Professor');

-- Note: Ensure that the lecturer_id is unique and doesn't conflict with existing entries

-- Query 5: List all students along with the modules they are enrolled in
SELECT s.first_name, s.surname, m.module_name
FROM students s
JOIN students_modules sm ON s.student_id = sm.student_id
JOIN modules m ON sm.module_id = m.module_id;

-- Expected Output:
-- first_name | surname | module_name
-- ------------|---------|-------------------
-- Alice       | Brown   | Advanced Databases
-- Alice       | Brown   | History of Computing
-- Mark        | Johnson | Advanced Databases
-- Luis        | Garcia  | Statistics
-- Emily       | Smith   | Quantum Mechanics
