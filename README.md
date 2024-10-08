# University Database Schema

This repository contains the detailed schema for a university database designed to manage student, instructor, module, group, and department information. The schema is flexible and can be adapted to meet the specific needs of different universities.

## Schema Overview

The university database consists of several interconnected tables. Below is a detailed description of each table and its attributes:

### 1. Students Table
Stores personal information about students and their registration details.
- **Student_ID** (int, PRIMARY KEY)
- **First_Name** (varchar)
- **Last_Name** (varchar)
- **Date_of_Birth** (date)
- **Address** (varchar)
- **Email** (varchar)
- **Phone_Number** (varchar)
- **Registration_Date** (date)

### 2. Instructors Table
Contains information about instructors and their assigned departments.
- **Instructor_ID** (int, PRIMARY KEY)
- **First_Name** (varchar)
- **Last_Name** (varchar)
- **Academic_Title** (varchar)
- **Email** (varchar)
- **Phone_Number** (varchar)
- **Department_ID** (int, FOREIGN KEY)

### 3. Modules Table
Records information about offered modules, their descriptions, instructors, and credit hours.
- **Module_ID** (int, PRIMARY KEY)
- **Name** (varchar)
- **Description** (text)
- **Instructor_ID** (int, FOREIGN KEY)
- **Credit_Hours** (int)

### 4. Groups Table
Contains information about class groups associated with modules.
- **Group_ID** (int, PRIMARY KEY)
- **Name** (varchar)
- **Module_ID** (int, FOREIGN KEY)
- **Academic_Year** (varchar)

### 5. Staff Table
Records data about university staff, including administrative personnel.
- **Staff_ID** (int, PRIMARY KEY)
- **First_Name** (varchar)
- **Last_Name** (varchar)
- **Position** (varchar)
- **Email** (varchar)
- **Phone_Number** (varchar)

### 6. Departments Table
Contains information about various university departments.
- **Department_ID** (int, PRIMARY KEY)
- **Name** (varchar)
- **Location** (varchar)
- **Phone_Number** (varchar)

### 7. Registrations Table
Used to record students' enrollments in class groups.
- **Registration_ID** (int, PRIMARY KEY)
- **Student_ID** (int, FOREIGN KEY)
- **Group_ID** (int, FOREIGN KEY)
- **Registration_Date** (date)

## Relationships
- **Students** to **Registrations**: One student can have many registrations (1:N relationship).
- **Instructors** to **Modules**: One instructor can teach multiple modules (1:N relationship).
- **Modules** to **Groups**: One module can have many groups (1:N relationship).
- **Groups** to **Registrations**: One group can have many registered students (1:N relationship).
- **Departments** to **Instructors**: One department can have many instructors (1:N relationship).
