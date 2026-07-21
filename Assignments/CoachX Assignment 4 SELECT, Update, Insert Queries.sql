CREATE DATABASE Uni;

USE Uni;

-- Creating Tables

CREATE TABLE types (
    typeId INT PRIMARY KEY,
    name VARCHAR(50)
);

CREATE TABLE authors (
    authorId INT PRIMARY KEY,
    name VARCHAR(50),
    surname VARCHAR(50)
);

CREATE TABLE students (
    studentId INT PRIMARY KEY,
    name VARCHAR(50),
    surname VARCHAR(50),
    birthdate DATE,
    gender CHAR(1),
    class VARCHAR(10),
    point INT
);

CREATE TABLE books (
    bookId INT PRIMARY KEY,
    name VARCHAR(100),
    pagecount INT,
    point INT,
    authorId INT,
    typeId INT,
    FOREIGN KEY (authorId) REFERENCES authors(authorId),
    FOREIGN KEY (typeId) REFERENCES types(typeId)
);

CREATE TABLE borrows (
    borrowId INT PRIMARY KEY,
    studentId INT,
    bookId INT,
    takenDate DATE,
    broughtDate DATE,
    FOREIGN KEY (studentId) REFERENCES students(studentId),
    FOREIGN KEY (bookId) REFERENCES books(bookId)
);

-- Inserting DATA from PDF

-- Types

INSERT INTO types (typeId, name) VALUES
(1, 'Fiction'),
(2, 'Classic'),
(3, 'Dystopian'),
(4, 'Literature'),
(5, 'Fantasy'),
(6, 'Adventure'),
(7, 'Historical Fiction'),
(8, 'Science Fiction'),
(9, 'Mythology'),
(10, 'Philosophy');

-- Authors

INSERT INTO authors (authorId, name, surname) VALUES
(1, 'F. Scott', 'Fitzgerald'),
(2, 'Harper', 'Lee'),
(3, 'George', 'Orwell'),
(4, 'Jane', 'Austen'),
(5, 'J.D.', 'Salinger'),
(6, 'J.R.R.', 'Tolkien'),
(7, 'Herman', 'Melville'),
(8, 'Leo', 'Tolstoy'),
(9, 'James', 'Joyce'),
(10, 'Homer', '');

-- Students

INSERT INTO students (studentId, name, surname,
birthdate, gender, class, point) VALUES
(1, 'John', 'Doe', '2005-01-15', 'M', '10A', 85),
(2, 'Jane', 'Smith', '2006-03-22', 'F', '10B', 90),
(3, 'Alice', 'Johnson', '2005-07-12', 'F', '10A', 88),
(4, 'Bob', 'Brown', '2006-11-30', 'M', '10C', 76),
(5, 'Charlie', 'Davis', '2005-05-05', 'M', '10B', 92),
(6, 'Diana', 'Miller', '2006-06-25', 'F', '10C', 81),
(7, 'Eve', 'Wilson', '2005-09-18', 'F', '10A', 87),
(8, 'Frank', 'Moore', '2006-12-02', 'M', '10B', 80),
(9, 'Grace', 'Taylor', '2005-04-17', 'F', '10C', 83),
(10, 'Hank', 'Anderson', '2006-10-20', 'M', '10A', 78);

-- Books

INSERT INTO books (bookId, name, pagecount, point, authorId, typeId) VALUES
(1, 'The Great Gatsby', 180, 95, 1, 1),
(2, 'To Kill a Mockingbird', 281, 90, 2, 2),
(3, '1984', 328, 88, 3, 3),
(4, 'Pride and Prejudice', 279, 93, 4, 4),
(5, 'The Catcher in the Rye', 214, 85, 5, 1),
(6, 'The Hobbit', 310, 91, 6, 2),
(7, 'Moby-Dick', 635, 80, 7, 3),
(8, 'War and Peace', 1225, 92, 8, 4),
(9, 'Ulysses', 730, 89, 9, 1),
(10, 'The Odyssey', 541, 87, 10, 2);

-- Borrows

INSERT INTO borrows (borrowId, studentId, bookId, takenDate, broughtDate) VALUES
(1, 1, 3, '2024-01-10', '2024-01-20'),
(2, 2, 5, '2024-01-12', '2024-01-22'),
(3, 3, 7, '2024-01-15', '2024-01-25'),
(4, 4, 2, '2024-01-18', '2024-01-28'),
(5, 5, 1, '2024-01-20', '2024-01-30'),
(6, 6, 4, '2024-01-22', '2024-02-01'),
(7, 7, 6, '2024-01-24', '2024-02-03'),
(8, 8, 8, '2024-01-26', '2024-02-05'),
(9, 9, 10, '2024-01-28', '2024-02-07'),
(10, 10, 9, '2024-01-30', '2024-02-09');

-- Ex.1 List all the records in the student table
SELECT*FROM students

-- Ex.2 List the name surname and class of the student in the student table
SELECT name, surname, class
FROM students

-- Ex.3 List the gender Female (F) records in the student table
SELECT*
FROM students
WHERE gender = 'F';

-- EX.4 List the names of each class in the way of being seen once in the student table

SELECT DISTINCT class 
FROM students;

-- EX.5 List the students with Female gender and the class 10Math in the student table (taken 10C insted of 10MAth as it does not exist)

SELECT*
FROM students
WHERE gender = 'F' AND class = '10';

-- EX.6 ist the names, surnames and classes of the students in the class 10Math or 10Sci in the student table (Note: Will use 10C and 10B as 10Math and 10Sci not availble in data)

SELECT name, surname, class
FROM students
WHERE class = '10C' OR class = '10B';

-- EX.7 List the students name surname and school number in the student table

SELECT name, surname, studentId
FROM students;

-- Ex.8 List the students name and surname by combining them as name surname in the student tableSELECT name, surname, CONCAT(name,' ', surname) AS FullNameFROM students;
-- Ex.9 List the students with the names starting with “A” letter in the student table
SELECT*
FROM students
WHERE name LIKE 'A%';

-- Ex.10 List the book names and pages count with number of pages between 50 and 200 in the book table
SELECT name, pagecount
FROM books
WHERE pagecount BETWEEN 50 AND 200;

-- Ex.11 List the students with names Emma Sophia and Robert in the student tableSELECT *FROM studentsWHERE name IN ('Emma', 'Sophia', 'Robert','Alice');-- Ex.12 List the students with names starting with A D and K in the student tableSELECT *FROM studentsWHERE name LIKE 'A%'OR name LIKE 'D%'OR name LIKE 'K%';
-- Ex.13 List the names surnames classes and genders of males in 9Math or females in 9His in the student table (Note: Used 10A for 9Math and 10B for 9His)

SELECT name, surname, class, gender
FROM students
WHERE (gender = 'M' AND class = '10A')
OR (gender = 'F' AND class = '10B');

-- Ex.14 List the males whose classes are 10Math or 10Bio (Note: Used 10A for 10Math and 10B for 10Bio)SELECT *FROM studentsWHERE gender = 'M' AND class IN ('10A','10B');-- Ex.15 List the students with birth year 1989 in the student tableSELECT*FROM studentsWHERE YEAR(birthdate) = '1989';-- Ex.16 List the female students with student numbers between 30 and 50
SELECT*
FROM students
WHERE gender = 'F' AND studentId BETWEEN 30 and 50;

-- Ex.17 List the students according to their names
SELECT*
FROM students
ORDER By name ASC;

-- Ex.18 List the students by names for those with same names. List them by their surnames

SELECT *
FROM students
WHERE name IN (
SELECT name 
FROM students
GROUP BY name
HAVING Count(*) > 1)
ORDER By Surname ASC;

-- Ex.19 List the students in 10Math by decreasing school numbers (Note: used 10A for 10MAth)

SELECT*
FROM students
WHERE class = '10A'
ORDER By studentId DESC;

-- Ex.20 List the first 10 records in the student chart

SELECT Top 10*
FROM students;

-- Ex.21 List the first 10 records name surname and date of birth information in the student table

SELECT Top 10 name, surname, birthdate 
FROM students;

-- Ex.22 List the book with the most page number
SELECT TOP 1*
FROM books
ORDER By pagecount DESC;

-- Ex.23 List the youngest student in the student table

SELECT TOP 1*
FROM students
ORDER By birthdate DESC;

-- Ex.24 List the oldest student in the 10Math class (Note: Used 10A for 10Math)SELECT TOP 1*FROM studentsWHERE class = '10A'ORDER By birthdate ASC;-- Ex.25 List the books with the second letter NSELECT *FROM booksWHERE name LIKE '_N%';
-- Ex.26 List the students by grouping according to their classes

SELECT class, count(*) as StudentCount
FROM students
GROUP By class;

-- Ex.27 List the students to be different in each questioning randomly

SELECT * 
FROM students 
ORDER BY NEWID(); 

-- Ex.28 Pick a random student from student table
SELECT Top 1*
FROM students
ORDER By NEWID();

-- Ex.29 Bring some random student’s name , surname and number from class 10Math (Used 10A for 10Math)

SELECT Top 1 name, surname, studentId
FROM students
WHERE class = '10A'
ORDER BY NEWID();

-- Ex.30 Add the writer named Smith Allen to the authors table

INSERT INTO authors (authorId, name, surname) VALUES
(11, 'Smith', 'Allen');

-- Ex.31 Add the genre of biography to the genre table
INSERT INTO types (typeId, name) VALUES
(11, 'Biography')

-- Ex.32 Add 10Math Class male named Thomas Nelson , 9Bio class female named Sally Allen and 11His Class female named Linda Sandra in one question
-- Note used 10A for 10Math, 10B for 9Bio, 10C for 11His

INSERT INTO students (studentId, name, surname, birthdate, gender, class, point) VALUES
(11, 'Thomas', 'Nelson', '2005-03-16', 'M', '10A', 75),
(12, 'Sallly', 'Allen', '2005-12-25', 'F', '10B', 84),
(13, 'Linda', 'Sandra', '2006-02-19', 'F', '10C', 89);


-- Ex.33 Add a random student in the students chart to the writers chart as an authors 

INSERT INTO authors (authorId, name, surname)
SELECT Top 1 studentId, name, surname
FROM students
WHERE studentId > 11
ORDER BY NEWID();

-- Ex.34 Add students with student numbers between 10 and 30 as authors
INSERT INTO authors (authorId, name, surname)
SELECT studentId, name, surname
FROM students
WHERE studentId BETWEEN 10 AND 30;

-- Ex.35 Add the writer named Cindy Brown and make him write his writer number (Note: The last increased rate in automatic enhancing is hold in @@IDENTITY factor)

INSERT INTO authors (name, surname) 
VALUES ('Cindy', 'Brown');
SELECT @@IDENTITY AS NewAuthorID;

-- Ex.36 Change the class of the student whose school number is 3 from 10Bio to 10His (Used 10A for 10Bio and 10B for 10His)

UPDATE students 
SET class = '10B'
WHERE studentId = '3';

-- Ex.37 Transfer all the students in 9Math Class to 10Math Class (Used 10A for 9Math and 10B for 10B)
UPDATE students
SET class = '10B'
WHERE class = '10A';

-- Ex.38 Increase all of the students’ score by 5 points

UPDATE students
SET point = point + 5;

-- Ex.39 Delete the author #25

DELETE authors
WHERE authorId = 25;

-- Ex.40 List the students whose birth dates are null

SELECT *
FROM students
WHERE birthdate is NULL;

-- Ex.41 List the name ,surname and the dates of received books of the student

SELECT*FROM students
SELECT*FROM books
SELECT*FROM borrows

SELECT B.borrowId, S.name, S.surname, B1.name, B.broughtDate, B.takenDate
FROM borrows B
JOIN students S ON S.studentId = B.studentId
JOIN books B1 ON B1.bookId = B.bookId;












