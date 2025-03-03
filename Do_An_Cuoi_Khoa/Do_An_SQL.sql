create database DoAnCuoiKhoa ;
use DoAnCuoiKhoa ;

create table products(
	id int primary key AUTO_INCREMENT ,
    productName varchar(100) not null ,
    productType int not null, FOREIGN KEY(productType) REFERENCES category(id) ,
    price decimal(10,2) not null ,
    stock int not null ,
    brand int , FOREIGN KEY(brand) REFERENCES brand(id) ,
    color int , FOREIGN KEY(color) references color(id) ,
    sellerID int , FOREIGN KEY(sellerID) REFERENCES users(id) 
) ;

create table category(
	id int primary key auto_increment ,
    category varchar(100) 
) ;

create table brand(
	id int primary key AUTO_INCREMENT ,
    brand varchar(100) 
);

create table color(
	id int primary key AUTO_INCREMENT,
    color varchar(100) 
) ;

create table users(
	id int primary key AUTO_INCREMENT ,
    username varchar(100) not null ,
    password VARCHAR(100) not null ,
    age int ,
    address varchar(100) not null ,
    contactNumber varchar(15) not null ,
    contactEmail varchar(100) ,
    currentMoney int 
) ;

create table userCart(
	id int primary key AUTO_INCREMENT ,
    userID int , FOREIGN KEY(userID) REFERENCES users(id)
) ;

create table cart_item(
	id int primary key auto_increment ,
	cartID int , FOREIGN KEY(cartID) references userCart(id) ,
    productID int , FOREIGN KEY(productID) REFERENCES products(id) ,
    quantity int ,
    priceAtOrder decimal(10,2)
) ;

create table bills(
	id int primary key AUTO_INCREMENT ,
    userID int , FOREIGN KEY(userID) REFERENCES users(id) ,
    purchaseDate DATETIME not null ,
    totalPrice decimal(10,2) not null 
) ;

create table bill_items(
	id int primary key auto_increment , 
    billID int , foreign KEY(billID) REFERENCES bills(id) ,
    productID int , FOREIGN KEY(productID) REFERENCES products(id) ,
    quantity int ,
    priceAtOrder decimal(10,2) 
) ;

create table review(
	id int primary key AUTO_INCREMENT ,
    productID int , FOREIGN KEY(productID) REFERENCES products(id) ,
    userID int , FOREIGN KEY(userID) REFERENCES users(id) ,
    rating decimal(2,1) ,
    userComment varchar(200) ,
    dateOfReview datetime 
) ;

DROP TABLE IF EXISTS review;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS category;
DROP TABLE IF EXISTS brand;
DROP TABLE IF EXISTS color;
drop table userCart ;
drop table bills ;
drop table bill_items ;
drop table cart_item ;

INSERT INTO category (category) VALUES 
('Electronics'), ('Clothing'), ('Furniture'), ('Books'), ('Sports'),
('Toys'), ('Beauty'), ('Groceries'), ('Automotive'), ('Jewelry');

INSERT INTO brand (brand) VALUES 
('Samsung'), ('Nike'), ('IKEA'), ('Penguin Books'), ('Adidas'),
('Lego'), ('L’Oreal'), ('Nestle'), ('Toyota'), ('Rolex');

INSERT INTO color (color) VALUES 
('Red'), ('Blue'), ('Green'), ('Black'), ('White'),
('Yellow'), ('Pink'), ('Gray'), ('Purple'), ('Brown');

INSERT INTO users (username, password, age, address, contactNumber, contactEmail, currentMoney) VALUES 
('Alice', 'pass123', 25, '123 Main St', '1234567890', 'alice@example.com', 500),
('Bob', 'pass456', 30, '456 Oak St', '0987654321', 'bob@example.com', 1000),
('Charlie', 'pass789', 22, '789 Pine St', '1122334455', 'charlie@example.com', 750),
('David', 'pass000', 35, '101 Maple St', '6677889900', 'david@example.com', 200),
('Emma', 'pass111', 28, '202 Birch St', '2233445566', 'emma@example.com', 850),
('Frank', 'pass222', 40, '303 Cedar St', '3344556677', 'frank@example.com', 1200),
('Grace', 'pass333', 27, '404 Elm St', '4455667788', 'grace@example.com', 650),
('Hannah', 'pass444', 29, '505 Spruce St', '5566778899', 'hannah@example.com', 950),
('Ian', 'pass555', 33, '606 Walnut St', '6677889900', 'ian@example.com', 300),
('Jack', 'pass666', 31, '707 Cherry St', '7788990011', 'jack@example.com', 400);

INSERT INTO products (productName, productType, price, stock, brand, color, sellerID) VALUES 
('Smartphone', 1, 699.99, 50, 1, 4, 1),
('Running Shoes', 2, 99.99, 100, 2, 3, 2),
('Dining Table', 3, 299.99, 20, 3, 8, 3),
('Fiction Book', 4, 15.99, 200, 4, NULL, 4),
('Football', 5, 25.99, 150, 5, 1, 5),
('Toy Car', 6, 19.99, 80, 6, 2, 6),
('Lipstick', 7, 9.99, 300, 7, 5, 7),
('Chocolate Bar', 8, 2.99, 500, 8, NULL, 8),
('Car Battery', 9, 120.00, 40, 9, 7, 9),
('Gold Necklace', 10, 599.99, 10, 10, 10, 10);

INSERT INTO userCart (userID) VALUES 
(1), (2), (3), (4), (5), (6), (7), (8), (9), (10);

INSERT INTO cart_item (cartID, productID, quantity, priceAtOrder) VALUES 
(1, 1, 2, 699.99), (1, 5, 1, 25.99), (2, 2, 3, 99.99), (2, 4, 1, 15.99),
(3, 3, 2, 299.99), (3, 7, 5, 9.99), (4, 6, 2, 19.99), (4, 8, 10, 2.99),
(5, 9, 1, 120.00), (5, 10, 1, 599.99), (6, 1, 1, 699.99), (6, 3, 3, 299.99),
(7, 5, 4, 25.99), (7, 2, 2, 99.99), (8, 6, 5, 19.99), (8, 4, 3, 15.99),
(9, 7, 2, 9.99), (9, 8, 8, 2.99), (10, 10, 2, 599.99), (10, 9, 2, 120.00);

INSERT INTO bills (userID, purchaseDate, totalPrice) VALUES 
(1, '2024-02-10 12:30:00', 725.98), (2, '2024-02-11 14:45:00', 315.96), 
(3, '2024-02-12 16:20:00', 659.97), (4, '2024-02-13 10:15:00', 239.80), 
(5, '2024-02-14 18:05:00', 719.99), (6, '2024-02-15 09:30:00', 1299.97), 
(1, '2024-02-16 11:00:00', 599.99), (7, '2024-02-17 20:45:00', 251.96), 
(8, '2024-02-18 22:10:00', 289.95), (9, '2024-02-19 07:30:00', 1199.98);

INSERT INTO bill_items (billID, productID, quantity, priceAtOrder) VALUES 
(1, 1, 2, 699.99), (1, 5, 1, 25.99), (2, 2, 3, 99.99), (2, 4, 1, 15.99),
(3, 3, 2, 299.99), (3, 7, 5, 9.99), (4, 6, 2, 19.99), (4, 8, 10, 2.99),
(5, 9, 1, 120.00), (5, 10, 1, 599.99), (6, 1, 1, 699.99), (6, 3, 3, 299.99),
(7, 5, 4, 25.99), (7, 2, 2, 99.99), (8, 6, 5, 19.99), (8, 4, 3, 15.99),
(9, 7, 2, 9.99), (9, 8, 8, 2.99), (10, 10, 2, 599.99), (10, 9, 2, 120.00);

INSERT INTO review (productID, userID, rating, userComment, dateOfReview) VALUES 
(1, 1, 4.5, 'Great smartphone!', '2024-02-20 15:30:00'),
(2, 2, 4.0, 'Comfortable running shoes', '2024-02-21 16:45:00'),
(3, 3, 3.5, 'Decent quality', '2024-02-22 10:10:00'),
(4, 4, 5.0, 'Loved the book!', '2024-02-23 14:20:00'),
(5, 5, 3.0, 'Average football', '2024-02-24 09:55:00'),
(6, 6, 4.2, 'Kids enjoyed it', '2024-02-25 11:40:00'),
(7, 7, 2.8, 'Not as expected', '2024-02-26 12:15:00'),
(8, 8, 4.8, 'Delicious chocolate!', '2024-02-27 13:05:00'),
(9, 9, 3.9, 'Works fine', '2024-02-28 17:25:00'),
(10, 10, 5.0, 'Beautiful necklace', '2024-02-29 18:50:00');

INSERT INTO review (productID, userID, rating, userComment, dateOfReview) VALUES
(3, 1, 4.5, 'Great product, worth the price!', '2025-02-10 14:30:00'),
(5, 2, 3.0, 'Decent quality, but expected better.', '2025-02-11 09:15:00'),
(7, 3, 5.0, 'Absolutely love it! Highly recommend.', '2025-02-12 18:45:00'),
(2, 1, 4.0, 'Nice design, but delivery was slow.', '2025-02-13 12:00:00'),
(8, 4, 2.5, 'Not as described, disappointed.', '2025-02-14 16:20:00'),
(6, 5, 4.8, 'Exceeded my expectations, very satisfied.', '2025-02-15 20:10:00'),
(3, 2, 3.5, 'Good, but could be improved.', '2025-02-16 10:30:00'),
(1, 3, 5.0, 'Perfect! Will buy again.', '2025-02-17 15:40:00'),
(9, 1, 4.2, 'Nice quality, but a bit expensive.', '2025-02-18 11:25:00'),
(10, 4, 2.0, 'Product arrived damaged.', '2025-02-19 17:55:00'),
(5, 5, 4.7, 'Really liked it, great value.', '2025-02-20 13:10:00'),
(7, 2, 3.2, 'Not bad, but not great either.', '2025-02-21 14:45:00'),
(2, 3, 4.9, 'Fantastic quality, would buy again.', '2025-02-22 19:20:00'),
(6, 1, 4.3, 'Comfortable and stylish.', '2025-02-23 08:40:00'),
(8, 2, 3.8, 'Average product, nothing special.', '2025-02-24 16:30:00');

INSERT INTO bills (userID, purchaseDate, totalPrice) VALUES
(1, '2025-02-10 14:30:00', 120.50),
(2, '2025-02-11 09:15:00', 75.99),
(3, '2025-02-12 18:45:00', 210.30),
(4, '2025-02-13 12:00:00', 95.40),
(5, '2025-02-14 16:20:00', 180.99),
(2, '2025-02-15 20:10:00', 145.80),
(3, '2025-02-16 10:30:00', 220.60),
(1, '2025-02-17 15:40:00', 60.30),
(4, '2025-02-18 11:25:00', 130.50),
(5, '2025-02-19 17:55:00', 175.75);

INSERT INTO bill_items (billID, productID, quantity, priceAtOrder) VALUES
(1, 11, 2, 25.25),(1, 12, 1, 70.00),(2, 13, 1, 75.99),(3, 14, 3, 50.10),(3, 15, 2, 55.00),
(3, 16, 1, 45.20),(4, 17, 1, 95.40),(5, 18, 2, 89.50),(5, 19, 1, 91.49),(6, 20, 1, 145.80),
(6, 11, 3, 30.00),(6, 12, 2, 42.00),(7, 13, 2, 90.30),(7, 14, 1, 55.50),(7, 15, 1, 74.80),
(8, 16, 1, 60.30),(8, 17, 2, 25.10),(8, 18, 3, 28.00),(9, 19, 2, 65.25),(9, 20, 1, 70.00),
(9, 11, 1, 30.25),(10, 12, 2, 48.00),(10, 13, 1, 55.50),(10, 14, 3, 24.50),(10, 15, 1, 52.75),
(10, 16, 2, 28.00),(10, 17, 1, 50.00),(10, 18, 1, 45.00),(10, 19, 2, 42.50),(10, 20, 1, 65.00);



SELECT * FROM review;
SELECT * FROM products;
SELECT * FROM users;
SELECT * FROM category;
SELECT * FROM brand;
SELECT * FROM color;
select * from userCart ;
select * from bills ;
select * from bill_items ;
select * from cart_item ;

/*Lấy ra category , brand , name của tất cả sp*/
select products.productName 'Product' , brand.brand 'Brand' , category.Category 'Category' from products 
join brand on products.brand = brand.id 
join category on products.productType = category.id ;

/*Lấy ra SP có lượt đánh giá cao nhất*/
select products.id 'ID' , products.productName 'Product' , avg(review.rating) from products
join review on products.id = review.productID 
group by products.id 
order by avg(review.rating) desc limit 1 ;

/*Viết function lấy ra người dùng với tổng tiền của hóa đơn (input id user)*/ 
delimiter $$
	create FUNCTION GetTotalMoneySpent(userID int) returns int
    deterministic
    begin 
		declare total_spent decimal(10,2) ;
        declare user_exists int ;
		select count(*) into user_exists from users where userID = id ;
        if(user_exists = 0) then
			return 'User does not exist' ;
		else
			select sum(bills.totalPrice) into total_spent from bills where bills.userID = userID ;
			return total_spent ;
		end if ;
    end $$
delimiter ;
	drop function GetTotalMoneySpent ;
	select GetTotalMoneySpent(35) ;

/*Viết stored procedure để lấy ra số lượng sản phẩm trong 1 hóa đơn (input id hóa đơn)*/
delimiter $$
		create procedure GetNumberOfProductsInBills(in billID int, out numberOfProducts int)
		begin
			declare bill_exists int ;
			select count(*) into bill_exists from bills where id = billID ;
			if(bill_exists = 0) then
				select 'Bill does not exist' ;
			else
				select sum(bill_items.quantity) into numberOfProducts from bill_items
				join bills on bill_items.billID = bills.id 
                where bills.id = billID ;
			end if ;
		end $$
delimiter ;
	drop procedure GetNumberOfProductsInBills ;
    call GetNumberOfProductsInBills(1,@numberOfProducts) ;
    select @numberOfProducts ;
	
/*Stored procedure để lấy ra tất cả sản phẩm có màu A (input id màu)*/
delimiter $$
	create procedure GetProductWithColor(in colorID int)
    begin
		declare color_exists int ;
        select count(*) into color_exists from color where id = colorID ;
        if(color_exists=0) then
			select 'Color does not exist' ;
		else
			select products.id 'ID' , products.productName 'Product' , category.category 'Category' , brand.brand 'Brand' , color.color 'Color' ,
			products.stock 'Stock' , products.price 'Price' from products
			join category on category.id = products.productType 
			join brand on products.brand = brand.id
			join color on products.color = color.id 
			where products.color = colorID ;
		end if ;
    end $$
delimiter ;
	drop procedure GetProductWithColor ;
	call GetProductWithColor(3) ;






