create database LuuTruThongTin ;
use LuuTruThongTin ;

create table students(
	student_id int primary key ,
    first_name varchar(50) ,
    last_name varchar(50) ,
    date_of_birth date ,
    class varchar(50) 
) ;

create table student_scores(
	student_id int , foreign key(student_id) references students(student_id) ,
    subject_id int ,
    score decimal(5,2) ,
    primary key(student_id,subject_id) 
) ;

create table employees(
	employee_id int primary key ,
    name varchar(100) ,
    position varchar(50) ,
    salary decimal(10,2) 
) ;

create table accounts(
	account_id int primary key ,
    account_name varchar(100) ,
    balance decimal(10,2) 
) ;

INSERT INTO students (student_id, first_name, last_name, date_of_birth, class) VALUES
(1, 'Nguyen', 'Anh', '2000-05-15', 'Lop 10A'),
(2, 'Le', 'Mai', '1999-08-22', 'Lop 10B'),
(3, 'Tran', 'Hoa', '2001-03-12', 'Lop 10A'),
(4, 'Pham', 'Duy', '2000-11-25', 'Lop 10C'),
(5, 'Nguyen', 'Minh', '1998-12-05', 'Lop 10B');

INSERT INTO student_scores (student_id, subject_id, score) VALUES
(1, 101, 9.0),  -- Sinh viên 1, Môn học 101, Điểm 9.0
(1, 102, 8.0),  -- Sinh viên 1, Môn học 102, Điểm 8.0
(2, 101, 6.5),  -- Sinh viên 2, Môn học 101, Điểm 6.5
(2, 103, 7.8),  -- Sinh viên 2, Môn học 103, Điểm 7.8
(3, 102, 8.7),  -- Sinh viên 3, Môn học 102, Điểm 8.7
(3, 103, 9.2),  -- Sinh viên 3, Môn học 103, Điểm 9.2
(4, 101, 5.0),  -- Sinh viên 4, Môn học 101, Điểm 5.0
(4, 103, 6.0),  -- Sinh viên 4, Môn học 103, Điểm 6.0
(5, 102, 7.5);  -- Sinh viên 5, Môn học 102, Điểm 7.5

INSERT INTO employees (employee_id, name, position, salary)
VALUES
(1, 'Nguyen Thi Mai', 'Manager', 15000.00),
(2, 'Le Thi Lan', 'Developer', 12000.00),
(3, 'Tran Minh Tu', 'Designer', 11000.00),
(4, 'Pham Hoang Duy', 'Developer', 13000.00),
(5, 'Nguyen Thanh Hai', 'Tester', 10000.00);

INSERT INTO accounts (account_id, account_name, balance) VALUES
(1, 'Nguyen Thi Mai', 2500.00),
(2, 'Le Thi Lan', 1500.00),
(3, 'Tran Minh Tu', 5000.00),
(4, 'Pham Hoang Duy', 1200.00),
(5, 'Nguyen Thanh Hai', 10000.00);

select * from students ;
select * from student_scores ;
select * from employees ;
select * from accounts ;

/* 1.	Tạo một stored procedure để lấy thông tin sinh viên theo student_id. */
DELIMITER $$ 
	create procedure GetStudentId(in studentID int)
    begin
		select * from students st where st.student_id = studentID ;
	end $$
delimiter ;
	call GetStudentId(1) ;
    call GetStudentId(2) ;
    
/*2.	Viết một stored procedure để cập nhật điểm của sinh viên trong bảng student_scores.*/
delimiter $$
	create procedure UpdateStudentScore(in studentID int, in newScore decimal(5,2))
    begin
		update student_scores set score = newScore where student_scores.student_id = studentID ;
	end $$ 
delimiter ;
	call UpdateStudentScore(1,8.4) ;
    
/*3.	Tạo stored procedure để xóa một sinh viên khỏi bảng students theo student_id.*/
delimiter $$
	create procedure DeleteStudent(in studentID int)
    begin
		delete from student_scores where student_id = studentID ;
        delete from students where student_id = studentID ;
	end $$ 
delimiter ;

drop procedure DeleteStudent ;
call DeleteStudent(3) ;

/*4.Tạo stored procedure để tính tổng điểm của tất cả sinh viên trong bảng student_scores.*/
delimiter $$
	create procedure CalculateSumOfScore(out total Decimal(5,2))
    begin
		select sum(score) into total from student_scores ;
	end $$
delimiter ;
drop procedure CalculateSumOfScore ;

	call CalculateSumOfScore(@total) ;
    select @total ;

/*5.	Tạo stored procedure để tìm kiếm sinh viên theo tên (họ hoặc tên).*/
delimiter $$ 
	create procedure SearchStudentByName(in StudentName varchar(50), out targetStudentID int)
    begin
		select students.student_id into targetStudentId 
        from students
        where students.first_name = StudentName or students.last_name = StudentName ;
        
        if targetStudentID is not null then
			select @targetStudentID ;
		else
			-- signal sqlstate(45000) set Message_text('Không tồn tại sinh viên có tên ' + StudentName ) ;
            select ('Không tồn tại') ;
		end if ;
	end $$
delimiter ;
	drop procedure SearchStudentByName ;
    call SearchStudentByName('An',@studentID) ;
    select @studentID ;
    
/*6.	Tạo một stored procedure để lấy danh sách các nhân viên có lương cao hơn một mức nhất định.*/
delimiter $$
	create procedure TimNhanVienTheoLuong(in minSalary decimal(10,2))
    begin
		select * from employees where salary > minSalary order by salary asc ;
	end $$
delimiter ;
	call TimNhanVienTheoLuong(12000) ;
    
/*7.	Tạo một stored procedure để tính điểm trung bình của sinh viên trong một lớp học cụ thể (class).*/
delimiter $$
	create procedure TinhDiemTrungBinh(in class varchar(50), out averageScore decimal(10,2))
    begin
		select avg(score) into averageScore from students
        join student_scores on students.student_id = student_scores.student_id
        where students.class = class ;
	end $$
delimiter ;
	drop procedure TinhDiemTrungBinh ;
	call TinhDiemTrungBinh('Lop 10A',@averageScore) ;
    select @averageScore ;
    
/*7.1. Lấy ra tên lớp và điểm trung bình*/
delimiter $$
	create procedure TinhDiemTrungBinhVaClass(in class varchar(50))
    begin
		select avg(score) , students.class from students
        join student_scores on students.student_id = student_scores.student_id
        group by students.class having students.class = class ;
	end $$
delimiter ;
	call TinhDiemTrungBinhVaClass('Lop 10A');
    
/*8.	Viết một stored procedure để cập nhật thông tin nhân viên 
trong bảng employees (ví dụ: tên, vị trí, lương).*/
delimiter $$
	create procedure UpdateEmployeeInfo(in employeeID int , in newName varchar(100), in newPost varchar(50), in newSalary decimal(10,2))
    begin
		update employees set 
			name = coalesce(newName,name) ,
            position = coalesce(newPost,position) ,
            salary = coalesce(newSalary,salary)
		where employee_id = employeeID ;
    end $$
delimiter ;
	drop procedure UpdateEmployeeInfo ;
	call UpdateEmployeeInfo(3,'Nguyen Cao Huy', null,15020.03) ;
    select * from employees ;
    
/*9.	Tạo stored procedure để tính tổng số dư của tất cả tài khoản trong bảng accounts.*/
delimiter $$
	create procedure SumOfAllBalance(out totalBalance int)
    begin
		select sum(balance) into totalBalance from accounts ;
    end $$
delimiter ;
	call SumOfAllBalance(@totalBalance) ;
    select @totalBalance ;
    
/*10.	Tạo stored procedure để tính số lượng sinh viên trong mỗi lớp.*/
delimiter $$
	create procedure TotalStudentEachClass()
    begin
		select students.class 'Lớp học', count(students.class) 'Số sinh viên' from students 
        group by students.class;
    end $$
delimiter ;
	drop procedure TotalStudentEachClass ;
	call TotalStudentEachClass() ;
    
/*11.	Tạo một stored procedure để hiển thị danh sách các nhân viên có chức vụ Manager.*/
delimiter $$
	create procedure ViewAllManager()
    begin 
		select * from employees where employees.position = 'Manager' ;
    end $$
delimiter ;
	call ViewAllManager() ;
    
/*12.	Tạo stored procedure để tìm các tài khoản ngân hàng có số dư dưới mức quy định.*/
delimiter $$
	create procedure ViewAccountsWithLessMoneyThanLimit(in minimumMoney decimal(10,2))
    begin
		select * from accounts where accounts.balance < minimumMoney ;
    end $$ 
delimiter ;
	call ViewAccountsWithLessMoneyThanLimit(12000.01) ;
    
/*13.	Viết stored procedure để chuyển tiền
 giữa hai tài khoản ngân hàng, sử dụng giao dịch (transaction) và kiểm tra số dư.*/
 delimiter $$
	create procedure transferMoney(in from_account int, in to_account int , in amount decimal(10,2))
    begin
		declare from_balance decimal(10,2) ;
        select balance into from_balance from accounts where account_id = from_account ;
        if(from_balance < amount) then
			signal sqlstate '45000' set message_text = 'Số dư không đủ' ;
		else
			update accounts set balance = from_balance - amount where account_id = from_account ;
            update accounts set balance = balance + amount where account_id = to_account ;
		end if ;
    end $$ 
 delimiter ;
	call transferMoney(2,5,500) ;
    select * from accounts ;
    
/*14.	Tạo một stored procedure để tính điểm trung bình của một sinh viên cho tất cả các môn học.*/
delimiter $$
	create procedure GetAverageScore(in studentID int,out avgScore decimal(5,2))
    begin
		declare checkStudentExists int ;
        select count(*) into checkStudentExists from student_scores where student_scores.student_id = studentID ;
        if(checkStudentExists = 0) then
			signal sqlstate '45000' set message_text = 'Không tồn tại sinh viên' ;
		else
			select avg(score) from student_scores where student_scores.student_id = studentID ;
		end if ;
    end $$ 
delimiter ;
	drop procedure GetAverageScore ;
	call GetAverageScore(3,@avgScore) ;
    select @avgScore ;
    
/*15.	Viết một stored procedure để tạo tài khoản mới trong bảng accounts và đảm bảo số dư không âm.*/
delimiter $$
	create procedure CreateNewAccount(in accountID int, in accountName varchar(100), in balance decimal(10,2))
    begin
		if(balance <= 0) then
			signal sqlstate '45000' set message_text = 'Tài khoản không thể có số dư âm' ;
		else
			insert into accounts (account_id,account_name,balance) values (accountID,accountName,balance) ;
		end if ;
    end $$ 
delimiter ;
	drop procedure createnewaccount ;
	call CreateNewAccount(7,'Nguyen Van A', 2000000) ;
    select * from accounts ;
    
/*16.	Tạo một stored procedure để tính lương mới cho tất cả nhân viên trong bảng employees có chức vụ Manager, tăng 10%.*/
delimiter $$
	create procedure UpdateNewManagerSalary()
    begin
		update employees set salary = salary * 1.1 where employees.position = 'Manager' ;
    end $$ 
delimiter ;
	call UpdateNewManagerSalary() ;
    select * from employees ;
    
/*17.	Viết stored procedure để thay đổi tên sinh viên trong bảng students sau khi kiểm tra lớp của sinh viên.*/
delimiter $$
	create procedure UpdateNewManagerSalary(in studentID int , in class varchar(50), in newName varchar(100))
    begin
		declare checkClassExists int ;
        select count(*) into checkClassExists from student_scores where student_scores.class = class ;
        if(checkClassExists = 0) 
    end $$
delimiter ;

/*18.	Tạo stored procedure để xóa tài khoản ngân hàng có số dư dưới 500, sau đó thông báo nếu tài khoản bị xóa.*/
delimiter $$
	create procedure DeleteAccountWithBalanceUnder500()
    begin
		declare numberOfDeletedAccount int ;
        select count(*) into numberOfDeletedAccount from accounts where accounts.balance < 5000 ;
        if(numberOfDeletedAccount = 0) then
			select 'Không tài khoản nào bị xóa' ;
		ELSE
			delete from accounts where accounts.balance < 5000 ;
            select concat(numberOfDeletedAccounts , ' tài khoản đã bị xóa') as message ;
		end if ;
    end $$
delimiter ;
	drop procedure DeleteAccountWithBalanceUnder500 ;
	call DeleteAccountWithBalanceUnder500() ;
    select * from accounts; 
    
/*19. Viết stored procedure để tính tổng số điểm của sinh viên theo từng môn học trong bảng student_scores.*/
delimiter $$
	create procedure GetStudentTotalScore(in studentID int)
    begin
		select student_scores.subject_id 'Môn học' , sum(score) 'Tổng điểm' from student_scores
        join students 
        on student_scores.student_id = students.student_id ;
    end $$
delimiter ;
drop procedure GetStudenttotalscore ;
	call GetStudentTotalScore(1) ;
    
/*20.	Tạo stored procedure để lấy thông tin sinh viên và 
số điểm trung bình của họ trong một lớp học cụ thể, chỉ lấy sinh viên có điểm trung bình trên 6.0.*/
delimiter $$
	create procedure GetInfoForStudents(in class varchar(50))
    begin
		select students.last_name , students.first_name , avg(student_scores.score)
        from students join student_scores 
        on students.student_id = student_scores.student_id 
        group by students.last_name, students.first_name 
        having avg(student_scores.score) > 6 ;
    end $$
delimiter ;
	drop procedure GetInfoForStudents ;
	call GetInfoForStudents('Lop 101') ;
    select * from student_scores ;
    
/*21. Lấy tên học sinh, điểm học sinh , và 
tên môn học : 101 -> 'Vật Lý' ; 102 -> 'Hóa học' ; 103 -> 'Toán học' còn lại null */
delimiter $$
	create procedure GetInfoForStudents(in class varchar(50))
    begin
		select students.last_name , students.first_name , avg(student_scores.score)
        from students join student_scores 
        on students.student_id = student_scores.student_id 
        group by students.last_name, students.first_name 
        having avg(student_scores.score) > 6 ;
    end $$
delimiter ;


