DROP DATABASE IF EXISTS university;
CREATE DATABASE university;
USE university;

CREATE TABLE employees (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    surname VARCHAR(50),
    first_name VARCHAR(50),
    gender ENUM('Male', 'Female'),
    birth_date DATE,
    position VARCHAR(50)
);

INSERT INTO employees (surname, first_name, gender, birth_date, position) VALUES
('Kowalski', 'Jan', 'Male', '1980-01-15', 'Professor'),
('Nowak', 'Anna', 'Female', '1985-05-20', 'Lecturer'),
('Zielinski', 'Marek', 'Male', '1990-03-30', 'Lecturer'),
('Wojcik', 'Katarzyna', 'Female', '1992-07-18', 'Doctor'),
('Szymanski', 'Piotr', 'Male', '1988-11-10', 'Doctor');

CREATE TABLE lecturers (
    lecturer_id INT AUTO_INCREMENT PRIMARY KEY,
    department VARCHAR(50),
    acad_position VARCHAR(50),
    FOREIGN KEY (lecturer_id) REFERENCES employees(employee_id)
);

INSERT INTO lecturers (lecturer_id, department, acad_position) VALUES
(1, 'Computer Science', 'Professor'),
(2, 'Mathematics', 'Lecturer'),
(3, 'Physics', 'Lecturer');

CREATE TABLE modules (
    module_id INT AUTO_INCREMENT PRIMARY KEY,
    module_name VARCHAR(50),
    department VARCHAR(50),
    lecturer_id INT,
    FOREIGN KEY (lecturer_id) REFERENCES lecturers(lecturer_id)
);

INSERT INTO modules (module_name, department, lecturer_id) VALUES
('Database Systems', 'Computer Science', 1),
('Calculus', 'Mathematics', 2),
('Quantum Mechanics', 'Physics', 3);

CREATE TABLE students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    group_no INT,
    surname VARCHAR(50),
    first_name VARCHAR(50),
    gender ENUM('Male', 'Female'),
    birth_date DATE
);

INSERT INTO students (group_no, surname, first_name, gender, birth_date) VALUES
(1, 'Kowal', 'Michał', 'Male', '2000-02-12'),
(1, 'Wiśniewska', 'Julia', 'Female', '2001-03-04'),
(2, 'Dąbrowski', 'Jakub', 'Male', '1999-09-21'),
(2, 'Nowicka', 'Zofia', 'Female', '2002-12-25');

CREATE TABLE student_grades (
    grade_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    module_id INT,
    grade FLOAT,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (module_id) REFERENCES modules(module_id)
);

INSERT INTO student_grades (student_id, module_id, grade) VALUES
(1, 1, 4.5),
(1, 2, 3.0),
(2, 1, 5.0),
(3, 3, 3.5),
(4, 2, 2.0);

CREATE TABLE groups (
    group_no INT PRIMARY KEY
);

INSERT INTO groups (group_no) VALUES
(1),
(2),
(3);

CREATE TABLE students_modules (
    student_id INT,
    module_id INT,
    PRIMARY KEY (student_id, module_id),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (module_id) REFERENCES modules(module_id)
);

INSERT INTO students_modules (student_id, module_id) VALUES
(1, 1),
(1, 2),
(2, 1),
(3, 3),
(4, 2);
