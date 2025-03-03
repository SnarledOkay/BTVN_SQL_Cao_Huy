create database QuanLySinhVien ;
use QuanLySinhVien ;

create table lop_hoc(
	id int PRIMARY key AUTO_INCREMENT ,
    ten_lop varchar(50) ,
    khoa_hoc varchar(50)
) ;

create table sinh_vien(
	id int primary key AUTO_INCREMENT ,
    ten VARCHAR(100) ,
	ma_lop int , FOREIGN KEY(ma_lop) REFERENCES lop_hoc(id) ,
    diem FLOAT 
) ;

INSERT INTO lop_hoc (ten_lop, khoa_hoc) VALUES 
('Lớp 10A', 'Khóa 2023-2026'),
('Lớp 10B', 'Khóa 2023-2026'),
('Lớp 11A', 'Khóa 2022-2025'),
('Lớp 11B', 'Khóa 2022-2025'),
('Lớp 12A', 'Khóa 2021-2024');

INSERT INTO sinh_vien (ten, ma_lop, diem) VALUES 
('Nguyễn Văn A', 1, 8.5),
('Trần Thị B', 2, 7.8),
('Lê Văn C', 3, 9.2),
('Phạm Thị D', 4, 6.5),
('Hoàng Văn E', 5, 8.0);

-- Insert 2 students into Lớp 10A (ma_lop = 1)
INSERT INTO sinh_vien (ten, ma_lop, diem) VALUES 
('Đặng Văn F', 1, 7.2),
('Bùi Thị G', 1, 8.9);

-- Insert 3 students into Lớp 11B (ma_lop = 4)
INSERT INTO sinh_vien (ten, ma_lop, diem) VALUES 
('Phan Văn H', 4, 6.8),
('Ngô Thị I', 4, 9.0),
('Vũ Văn J', 4, 7.5);


select * from lop_hoc ;
select * from sinh_vien ;

/*2.  Viết một function trả về tên lớp học dựa trên id của lớp.*/
delimiter $$ 
	CREATE function GetClassName(classID int) returns varchar(50) 
    deterministic 
    begin
		declare tenLop varchar(50) ;
        select lop_hoc.ten_lop into tenLop from lop_hoc where lop_hoc.id = classID ;
        return tenLop ;
	end $$
delimiter ;
	select GetClassName(4) ;
    
/*3.  Viết một function trả về tổng số sinh viên trong một lớp học.*/
delimiter $$
	create function ReturnNumberOfStudents(classID int) returns int
    deterministic 
	begin
		declare classCapacity int ;
        select count(*) into classCapacity from sinh_vien where sinh_vien.ma_lop = classID ;
        RETURN classCapacity ;
    end $$
delimiter ;
	select ReturnNumberOfStudents(1) ;
    
/*4. Viết một function tính điểm trung bình của tất cả sinh viên trong một lớp*/
delimiter $$
	create function Tinh_diem_trung_binh(classID int) returns double
    deterministic
    begin 
		declare averageScore double ;
        select avg(diem) into averageScore from sinh_vien where sinh_vien.ma_lop = classID ;
        RETURN averageScore ;
    end $$
delimiter ;
	select Tinh_diem_trung_binh(2) ;
    
/*5. Viết một function kiểm tra sinh viên có đạt hay không (Điểm trung bình ≥ 5 thì đậu, ngược lại rớt).*/
delimiter $$
	create function Kiem_tra_Sinh_Vien(sinhVienID int) returns varchar(100) 
    deterministic
    begin 
		declare diemSinhVien FLOAT;
        declare ketQua varchar(100) ;
        select sinh_vien.diem into diemSinhVien from sinh_vien where sinh_vien.id = sinhVienID ;
        if(diemSinhVien >= 5) then
			set ketQua = 'Đậu' ;
		else 
			set ketQua = 'Trượt' ;
		end if ;
        return ketQua ;
    end $$
delimiter ;
	select Kiem_tra_Sinh_Vien(3) ;
    
/*6. Viết một function trả về số lượng sinh viên có điểm trên 8 trong một lớp cụ thể.*/
delimiter $$
	create function So_Luong_Student_Tren_8(classID int) returns INT
    deterministic
    begin 
		declare soLuongSinhVien int ;
        select count(*) into soLuongSinhVien from sinh_vien where sinh_vien.ma_lop = classID
        and sinh_vien.diem > 8 ;
        RETURN soLuongSinhVien ;
    end $$
delimiter ;
	drop function So_luong_student_tren_8 ;
	select So_Luong_Student_Tren_8(1) ;
    
/*12.  Viết một stored procedure để lấy danh sách sinh viên trong một lớp cụ thể.*/
delimiter $$ 
	create procedure LayDanhSachNhanVien(in classID int)
    begin
		select sinh_vien.id 'ID', sinh_vien.ten 'Name', ten_lop from sinh_vien
        join lop_hoc on sinh_vien.ma_lop 
        where lop_hoc.id= classID ; 
    end $$
delimiter ;
	drop procedure LayDanhSachNhanVien ;
	call LayDanhSachNhanVien(1) ;
    
/*13.  Viết một stored procedure để cập nhật điểm của một sinh viên dựa trên ID.*/
delimiter $$ 
	create procedure UpdateDiemSinhVien(in studentID int,in newScore float)
    begin
		UPDATE sinh_vien set diem = newScore where sinh_vien.id = studentID ;
    end $$
delimiter ;
	select * from sinh_vien ;
	call updatediemsinhvien(2,8.4) ;
    
/*14. Tạo một View hiển thị danh sách sinh viên cùng tên lớp học.*/
create view DanhSachSinhVien as
select sinh_vien.id 'ID', sinh_vien.ten 'Tên', ten_lop 'Lớp học' from sinh_vien
join lop_hoc on sinh_vien.ma_lop = lop_hoc.id ;

/*15.  Tạo một View hiển thị danh sách sinh viên có điểm >= 5.*/
create view SinhVienDiemTren5 as 
select sinh_vien.id 'ID', sinh_vien.ten 'Name', ten_lop 'Class', diem 'Score' from sinh_vien 
join lop_hoc on sinh_vien.ma_lop = lop_hoc.id 
where diem >= 5 ;

/*16. Lấy danh sách sinh viên có tên chứa chữ "n".*/
select sinh_vien.id 'ID', sinh_vien.ten 'Name', ten_lop 'Class', diem 'Score' from sinh_vien 
join lop_hoc on sinh_vien.ma_lop = lop_hoc.id 
where diem >= 5 ;

/*7.  Viết một trigger tự động cập nhật điểm của sinh viên thành 0 nếu điểm nhập vào nhỏ hơn 0.*/
DELIMITER $$
	CREATE TRIGGER trg_check_diem BEFORE INSERT ON sinh_vien FOR EACH ROW
		BEGIN
			IF NEW.diem < 0 THEN
				SET NEW.diem = 0;
			END IF;
		END $$

$$

	CREATE TABLE log_diem (
    id INT AUTO_INCREMENT PRIMARY KEY,
    sinh_vien_id INT,
    old_diem FLOAT,
    new_diem FLOAT,
    change_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TRIGGER trg_log_diem_update
BEFORE UPDATE ON sinh_vien
FOR EACH ROW
BEGIN
    INSERT INTO log_diem (sinh_vien_id, old_diem, new_diem)
    VALUES (OLD.id, OLD.diem, NEW.diem);
END;

$$

CREATE TRIGGER trg_prevent_delete_lop
BEFORE DELETE ON lop_hoc
FOR EACH ROW
BEGIN
    IF (SELECT COUNT(*) FROM sinh_vien WHERE ma_lop = OLD.id) > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot delete class with students';
    END IF;
END;

$$

CREATE TRIGGER trg_default_diem
BEFORE INSERT ON sinh_vien
FOR EACH ROW
BEGIN
    IF NEW.diem IS NULL THEN
        SET NEW.diem = 10;
    END IF;
END;

$$

CREATE TABLE avg_diem_lop (
    ma_lop INT PRIMARY KEY,
    avg_diem FLOAT
);

CREATE TRIGGER trg_update_avg_diem
AFTER INSERT OR UPDATE ON sinh_vien
FOR EACH ROW
BEGIN
    INSERT INTO avg_diem_lop (ma_lop, avg_diem)
    VALUES (NEW.ma_lop, (SELECT AVG(diem) FROM sinh_vien WHERE ma_lop = NEW.ma_lop))
    ON DUPLICATE KEY UPDATE avg_diem = (SELECT AVG(diem) FROM sinh_vien WHERE ma_lop = NEW.ma_lop);
END;

$$
DELIMITER ;


