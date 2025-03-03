create database btvnBuoi1 ;
use btvnBuoi1 ;

create table person(
	id int primary key AUTO_INCREMENT ,
    fullname varchar(200) ,
    job varchar(50) ,
    birthday date ,
    salary decimal(10,2) ,
    address varchar(200) 
) ;

INSERT INTO person (fullname, job, birthday, salary, address) VALUES
('Nguyen Van A', 'Software Engineer', '1990-05-15', 1500.00, '123 Le Loi, Hanoi'),
('Tran Thi B', 'Data Analyst', '1992-08-21', 1350.50, '45 Tran Hung Dao, Hanoi'),
('Le Van C', 'Teacher', '1985-11-30', 1000.00, '78 Nguyen Trai, Ho Chi Minh City'),
('Pham Thi D', 'Nurse', '1993-07-12', 1200.75, '23 Hai Ba Trung, Da Nang'),
('Hoang Van E', 'Marketing Manager', '1988-02-28', 1800.25, '56 Bach Dang, Hue'),
('Vo Thi F', 'Graphic Designer', '1995-09-05', 1250.00, '89 Dien Bien Phu, Hai Phong'),
('Dang Van G', 'Accountant', '1986-04-18', 1400.00, '12 Ton Duc Thang, Can Tho'),
('Bui Thi H', 'Doctor', '1983-12-25', 2200.00, '34 Vo Thi Sau, Da Nang'),
('Pham Van I', 'Construction Worker', '1990-06-10', 950.00, '67 Ly Tu Trong, Hanoi'),
('Nguyen Thi K', 'HR Specialist', '1994-03-09', 1300.50, '101 Nguyen Hue, Ho Chi Minh City');
