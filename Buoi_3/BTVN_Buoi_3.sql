create table Student(
	student_id int primary key ,
    student_name varchar(50) ,
    student_age int
) ;

create table Courses(
	course_id int primary key ,
    course_name varchar(50) ,
    course_description varchar(100)
) ;

create table Enrollments(
	enrollment_id int primary key auto_increment ,
    student_id int ,
    course_id int ,
    foreign key(student_id) references student(student_id) ,
    foreign key(course_id) references courses(course_id)
) ;

select * from courses ;
select * from student ;
select * from enrollments ;

insert into Student(student_id,student_name,student_age) values
(1,'Nguyễn Văn A',18) , 
(2, 'Nguyễn Văn B', 25) , 
(3, 'Nguyễn Văn C',15) , 
(4, 'Nguyễn Cao A', 20) ,
(5, 'Phạm Gia H', 17) ;

insert into courses(course_id,course_name,course_description) values
(1,'Kinh tế', 'Học cách lừa đảo') ,
(2, 'Tội phạm', 'Học cách đột nhập') ,
(3, 'Lịch sử', 'Học lịch sử chiến tranh') , 
(4, 'Văn hóa', 'Giới thiệu về văn hóa VN') ,
(5, 'Thể thao', 'Học pickleball') ;

insert into enrollments(enrollment_id,student_id,course_id) values
(1,2,4) ,
(2, 3,3) , 
(3,1,5) , 
(4,4, 1) ,
(5,5, 3) ,
(6,4,2) ;

/* Lấy danh sách tất cả sinh viên và thông tin khóa học mà họ đã đăng ký */
select student.student_name,courses.course_name,courses.course_description from student
join enrollments on student.student_id = enrollments.enrollment_id
join courses on enrollments.course_id = courses.course_id ;

/*Lấy tên của tất cả các khóa học mà một sinh viên cụ thể đã đăng ký (sử dụng tham số student_id)*/
select courses.course_name from courses 
join enrollments on courses.course_id = enrollments.course_id 
where enrollments.student_id = 5 ; 

/*Lấy danh sách tất cả sinh viên và số lượng khóa học mà họ đã đăng ký*/
select student.student_name , sum(enrollments.course_id) as 'Số khóa đã đăng ký' from student
left join enrollments on student.student_id = enrollments.student_id
group by student.student_id ;

/*Lấy tất cả các khóa học mà chưa có sinh viên nào đăng ký.*/
select courses.course_name from courses
left join enrollments on courses.course_id = enrollments.course_id 
where enrollments.enrollment_id is null ;

/*Lấy tất cả sinh viên và thông tin khóa học mà họ đã đăng ký, sắp xếp theo tên sinh viên và tên khóa học*/
select student.student_name,courses.course_name, courses.course_description from student
join enrollments on student.student_id = enrollments.student_id 
join courses on courses.course_id = enrollments.course_id 
order by student.student_name,courses.course_name;

/*Lấy tất cả các sinh viên và thông tin của họ, cùng với tên khóa học mà họ đăng ký (nếu có).*/
select student.student_name,student.student_age,courses.course_name from student
left join enrollments on student.student_id = enrollments.student_id
left join courses on courses.course_id = enrollments.course_id ;

/*Lấy danh sách tất cả sinh viên và thông tin của họ, cùng với tên khóa học mà họ đăng ký (nếu có).
Sắp xếp theo tên sinh viên và tuổi từ cao xuống thấp*/
select student.student_name,student.student_age,courses.course_name from student
left join enrollments on student.student_id = enrollments.student_id 
left join courses on courses.course_id = enrollments.course_id
order by student.student_age, student.student_name DESC ;

/*Lấy tất cả các khóa học và số lượng sinh viên đã đăng ký vào mỗi khóa học*/
select courses.course_name , count(enrollments.student_id) as 'Số lượng sinh viên đâng ký' from courses
left join enrollments on courses.course_id = enrollments.course_id
group by courses.course_id ;








