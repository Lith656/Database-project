-- Create Database (Renamed)
DROP DATABASE IF EXISTS books;
CREATE DATABASE books;
USE books;

-- Tables
CREATE TABLE publishers (
    publisher_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE authors (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    isbn VARCHAR(20) UNIQUE,
    publisher_id INT,
    FOREIGN KEY (publisher_id) REFERENCES publishers(publisher_id)
);

CREATE TABLE book_authors (
    book_id INT,
    author_id INT,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES books(book_id),
    FOREIGN KEY (author_id) REFERENCES authors(author_id)
);

-- Sample Data
INSERT INTO publishers (name) VALUES
('Penguin Books'),
('Bloomsbury'),
('Doubleday'),
('Scholastic'),
('Berkley');

INSERT INTO authors (name) VALUES
('George Orwell'),
('J.K. Rowling'),
('Stephen King'),
('Suzanne Collins'),
('Emily Henry');

INSERT INTO books (title, isbn, publisher_id) VALUES
('1984', '978-0451524935', 1),
('Harry Potter and the Philosopher''s Stone', '978-0747532743', 2),
('Harry Potter and the Chamber of Secrets', '978-0747538493', 2),
('Harry Potter and the Prisoner of Azkaban', '978-0747542155', 2),
('Harry Potter and the Goblet of Fire', '978-0747551003', 2),
('Harry Potter and the Order of the Phoenix', '978-0747560722', 2),
('Harry Potter and the Half-Blood Prince', '978-0747581086', 2),
('Harry Potter and the Deathly Hallows', '978-0545010221', 2),
('The Shining', '978-0307743657', 3),
('Sunrise on the Reaping', '978-1339015730', 4),
('Funny Story', '978-0593441282', 5);

INSERT INTO book_authors (book_id, author_id) VALUES
(1, 1),
(2, 2),
(3, 2),
(4, 2),
(5, 2),
(6, 2),
(7, 2),
(8, 2),
(9, 3),
(10, 4),
(11, 5);

-- View with book_id
CREATE VIEW book_summary AS
SELECT
    b.book_id,
    b.title,
    p.name AS publisher,
    b.isbn,
    GROUP_CONCAT(a.name SEPARATOR ', ') AS authors
FROM books b
LEFT JOIN publishers p ON b.publisher_id = p.publisher_id
LEFT JOIN book_authors ba ON b.book_id = ba.book_id
LEFT JOIN authors a ON ba.author_id = a.author_id
GROUP BY b.book_id;