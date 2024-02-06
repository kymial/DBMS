CREATE DATABASE school_db;

CREATE TABLE school_db.Students(
	students_ID INT PRIMARY KEY,
    students_name VARCHAR(100),
    major VARCHAR(100),
    admission_year YEAR
    );

CREATE TABLE school_db.Professors(
	professors_ID INT PRIMARY KEY,
    professors_name VARCHAR(100),
    department VARCHAR(100),
    office VARCHAR(100)
);

CREATE TABLE school_db.Courses(
	courses_ID INT PRIMARY KEY,
    Courses_name  VARCHAR(100),
    professors_ID INT,
    credit INt,
    FOREIGN KEY (professors_ID) REFERENCES school_db.Professors(professors_ID)
    );

CREATE TABLE school_db.Enrollments(
	enrollments_ID INT PRIMARY KEY,
    students_name 