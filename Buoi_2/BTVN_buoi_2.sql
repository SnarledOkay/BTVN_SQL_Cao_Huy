create database BTVNBuoi2 ;
use BTVNBuoi2 ;
set sql_safe_updates = 0 ;

create table products(
	id int primary key auto_increment ,
    TenSanPham varchar(255) not null ,
    category varchar(100) not null ,
    price decimal(10,2) not null ,
    stock int not null
) ;

select * from products ;

insert into products(TenSanPham,category,price,stock) values
('Coffee', 'Beverage', 150000 , 30) ,
('Rolex', 'Phụ kiện', 20000000 , 20) ,
('Xe điện', 'Phương tiện', 13500000 , 150) ,
('Đồ hộp', 'Thức Ăn', 35000 , 200) ,
('Coca-cola','Beverage', 10000 , 400) ;

update products set price = price * 1.2 where id=2 ;
update products set stock = 0 where id = 3 ;

delete from products where stock = 0 ;

select products.TenSanPham , products.price from products where products.price = (select min(price) from products) ;

select products.TenSanPham , products.price from products where products.price = (select max(price) from products) ;

select sum(stock) 'Tổng sản phẩm' , avg(price) 'Giá trung bình' from products ;

select products.TenSanPham'Sản Phảm' , products.price 'Giá' from products 
where products.price > 100 order by products.price desc ;

select products.TenSanPham'Sản Phảm' , products.price 'Giá' from products 
order by products.price desc/*asc*/ ;

select products.TenSanPham'Sản Phảm' , products.price 'Giá' from products 
where products.price > (select avg(price) from products) ;

