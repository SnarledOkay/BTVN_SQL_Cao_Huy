create database LibraryManagement ;
use LibraryManagement ;

create table Authors(
	authorID int primary key auto_increment ,
    authorName varchar(100) not null
) ;

create table Books(
	bookID int primary key auto_increment ,
    title varchar(200) not null ,
    authorID int , foreign key(authorID) references Authors(authorID) ,
    publishedYear year not null
) ;
ALTER TABLE Books AUTO_INCREMENT = 1;

create table Members(
	memberID int primary key auto_increment ,
    memberName varchar(100) not null ,
    joinDate date not null 
) ;

create table Loans(
	loanID int primary key auto_increment ,
    bookID int ,
    foreign key(bookID) references Books(bookID) ,
    memberID int ,
    foreign key(memberID) references Members(memberID) ,
    loanDate date not null ,
    returnDate date
) ;

INSERT INTO Authors (AuthorName) VALUES
('J.K. Rowling'),
('George Orwell'),
('Harper Lee'),
('J.R.R. Tolkien'),
('Jane Austen');

INSERT INTO Books (Title, AuthorID, PublishedYear) VALUES
('Harry Potter and the Philosopher Stone', 1, 1997),
('1984', 2, 1949),
('To Kill a Mockingbird', 3, 1960),
('The Hobbit', 4, 1937),
('Pride and Prejudice', 5, 1928);
DELETE FROM Books WHERE BookID >= 21;

INSERT INTO Members (MemberName, JoinDate) VALUES
('John Doe', '2023-01-15'),
('Jane Smith', '2023-02-20'),
('Alice Johnson', '2023-03-10'),
('Bob Brown', '2023-04-05'),
('Charlie Davis', '2023-05-01');

INSERT INTO Loans (BookID, MemberID, LoanDate, ReturnDate) VALUES
(21, 1, '2024-01-01', '2024-01-10'),
(25, 2, '2024-01-05', '2024-01-15'),
(23, 3, '2024-01-07', NULL),
(24, 3, '2024-02-01', NULL),
(21, 3, '2024-02-10', NULL);

SELECT * FROM Authors;
SELECT * FROM Books;
SELECT * FROM Members;
SELECT * FROM Loans;

select books.bookID 'ID', books.Title, authors.authorName 'Author' , books.publishedYear from books 
left join authors on books.authorID = authors.authorID 
where books.publishedYear < 2010 ;

select members.memberID 'ID', members.memberName 'Name', count(loans.memberID) 'Số Sách đã mượn' from loans
right join members on loans.memberID = members.memberID 
group by members.memberID ;

select members.memberID 'ID', members.memberName 'Name', count(loans.memberID) 'Số Sách đã mượn' from loans
join members on loans.memberID = members.memberID 
group by members.memberID ;

select members.memberID 'ID', members.memberName 'Name', count(loans.memberID) 'Số Sách đã mượn' from loans
join members on loans.memberID = members.memberID 
group by members.memberID having count(loans.memberID) > 2 ;

select min(publishedYear) 'Năm sớm nhất' from books ;

select * from members where members.joinDate between '2020-01-01' and '2022-12-31' ;

select * from authors where authors.authorName like '%a%' ;

select distinct publishedYear from books ;





