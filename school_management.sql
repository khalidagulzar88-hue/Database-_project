CREATE DATABASE school_management_db;
CREATE TABLE class (
    class_id SERIAL PRIMARY KEY,
    class_name VARCHAR(100) NOT NULL,
    class_date DATE NOT NULL,
    room VARCHAR(100)
);
CREATE TABLE registration (
    registration_id SERIAL PRIMARY KEY,
    student_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    class_id INT REFERENCES class(class_id) ON DELETE CASCADE
);
CREATE TABLE fee (
    fee_id SERIAL PRIMARY KEY,
    fee_type VARCHAR(50) NOT NULL,
    amount NUMERIC(10,2) NOT NULL,
    registration_id INT REFERENCES registration(registration_id)
    ON DELETE CASCADE
);
INSERT INTO class (class_name, class_date, room)
VALUES
('Computer Science', '2026-03-15', 'Room 101'),
('Database Systems', '2026-04-10', 'Room 202');

INSERT INTO registration (student_name, email, class_id)
VALUES
('Ali Khan', 'ali@gmail.com', 1),
('Sara Ahmed', 'sara@gmail.com', 1),
('Bilal Raza', 'bilal@gmail.com', 2);

INSERT INTO fee (fee_type, amount, registration_id)
VALUES
('Admission Fee', 2000.00, 1),
('Tuition Fee', 5000.00, 2),
('Admission Fee', 2500.00, 3);

SELECT * FROM class;
SELECT c.class_name, r.student_name
FROM class c
JOIN registration r
ON c.class_id = r.class_id;

SELECT r.student_name, f.fee_type, f.amount
FROM registration r
JOIN fee f
ON r.registration_id = f.registration_id;

SELECT c.class_name, SUM(f.amount) AS total_fee
FROM class c
JOIN registration r
ON c.class_id = r.class_id
JOIN fee f
ON r.registration_id = f.registration_id
GROUP BY c.class_name;

INSERT INTO class (class_name, class_date, room)
SELECT
    'Class ' || gs,
    CURRENT_DATE + (gs % 365),
    'Room ' || (gs % 100)
FROM generate_series(1,100000) AS gs;

INSERT INTO registration (student_name, email, class_id)
SELECT
    'Student ' || gs,
    'student' || gs || '@gmail.com',
    (RANDOM() * 99999 + 1)::INT
FROM generate_series(1,500000) AS gs;

SELECT
    c.class_name,
    COUNT(r.registration_id) AS total_students
FROM class c
JOIN registration r
ON c.class_id = r.class_id
GROUP BY c.class_name;

SELECT
    c.class_name,
    COUNT(r.registration_id) AS total_students
FROM class c
JOIN registration r
ON c.class_id = r.class_id
GROUP BY c.class_name
HAVING COUNT(r.registration_id) > 20;

SELECT
    c.class_name,
    COUNT(r.registration_id) AS total_students
FROM class c
LEFT JOIN registration r
ON c.class_id = r.class_id
GROUP BY c.class_name;

SELECT
    room,
    COUNT(*) AS total_classes
FROM class
GROUP BY room;

SELECT
    c.class_name,
    COUNT(r.registration_id) AS total_students
FROM class c
JOIN registration r
ON c.class_id = r.class_id
GROUP BY c.class_name;

SELECT
    c.class_name,
    COUNT(r.registration_id) AS total_students
FROM class c
JOIN registration r
ON c.class_id = r.class_id
GROUP BY c.class_name
ORDER BY total_students DESC;

SELECT
    c.class_name,
    COUNT(r.registration_id) AS total_students
FROM class c
JOIN registration r
ON c.class_id = r.class_id
GROUP BY c.class_name
HAVING COUNT(r.registration_id) > 15;


SELECT
    c.class_name,
    COUNT(r.registration_id) AS total_students
FROM class c
LEFT JOIN registration r
ON c.class_id = r.class_id
GROUP BY c.class_name
ORDER BY total_students ASC;



EXPLAIN ANALYZE
SELECT
    c.class_name,
    COUNT(r.registration_id) AS total_students
FROM class c
JOIN registration r
ON c.class_id = r.class_id
GROUP BY c.class_name;
