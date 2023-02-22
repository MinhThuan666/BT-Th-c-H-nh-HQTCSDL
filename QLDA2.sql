CREATE TABLE NHANVIEN 
(
	MaNV varchar(9) PRIMARY KEY,  
	HoNV NVARCHAR(15)NOT NULL, 
	TenLot NVARCHAR(30)NOT NULL, 
	TenNV NVARCHAR(30)NOT NULL,
	NgSinh SMALLDATETIME NOT NULL,	
	DiaChi NVARCHAR(150)NOT NULL,
	Phai NVARCHAR(3)NOT NULL,
	Luong NUMERIC(18,0)NOT NULL,
	Phong VARCHAR(2)NOT NULL
)
GO 
CREATE TABLE PHANCONG
(
	MaNV varchar(9),
	MaDA varchar(2),
	ThoiGian numeric(18,0) not null
	primary key (MaNV,MaDA)
)
GO
CREATE TABLE THANNHAN
(
	MaNV varchar(9),
	TenTN varchar(9),
	NgSinh smalldatetime not null,
	Phai varchar(3)not null,
	QuanHe varchar(15) not null
	primary key(MaNV,TenTN)
)
GO
CREATE TABLE DEAN
(
	MaDA varchar(2) primary key,
	TenDA nvarchar(50)not null,
	DDiemDA varchar(20) not null
)
GO
 CREATE TABLE PHONGBAN
 (
	MaPhg varchar (2) primary key,
	TenPhg nvarchar(20) not null
 )



 -----4
 ----chỉnh sửa kiểu dữ liệu
 ALTER TABLE PHONGBAN	
ALTER COLUMN TenPhg NVARCHAR(30)

----chỉnh sửa kiểu dữ liệu
 ALTER TABLE DEAN
ALTER COLUMN DDiemDA NVARCHAR(20)

-----chỉnh sửa kiểu dữ liệu
ALTER TABLE THANNHAN	
ALTER COLUMN TenTN NVARCHAR(20)

ALTER TABLE THANNHAN	
ALTER COLUMN Phai NVARCHAR(3)

ALTER TABLE THANNHAN	
ALTER COLUMN QuanHe NVARCHAR(15)

-----thêm cột SoDienThoai
ALTER TABLE NHANVIEN
ADD SoDienThoai varchar(15)

-----xóa cột SoDienThoai
ALTER TABLE NHANVIEN
DROP COLUMN SoDienThoai

------5. Sử dụng câu lệnh SQL để nhập liệu vào các bảng như sau-----
INSERT INTO THANNHAN
	(MaNV, TenTN, NgSinh, Phai, QuanHe)
values
	('123', 'Châu', '30/10/2005', 'Nữ', 'Con gái'),
	('123', 'Duy', '25/10/2001', 'Nam', 'Con trai'),
	('123', 'Phương', '30/10/1985', 'Nữ', 'vợ chồng'),
	('234', 'Thanh', '05/04/1980', 'Nữ', 'Con gái'),
	('345', 'Dương', '30/10/1956', 'Nam', 'vợ chồng'),
	('345', 'Khang', '25/10/1982', 'Nam', 'Con trai'),
	('456', 'Hùng', '01/01/1987', 'Nam', 'Con trai'),
	('901', 'Thương', '05/04/1989', 'Nữ', 'Vợ chồng');

INSERT INTO PHANCONG
	(MaNV, MaDA, ThoiGian)
values
	('123','1','33'),
	('123','2','8'),
	('345','10','10'),
	('345','20','10'),
	('345','3','10'),
	('456','1','20'),
	('456','2','20'),
	('678','3','40'),
	('789','10','35'),
	('789','20','30'),
	('789','30','5');


INSERT INTO DEAN
	(MaDA,TenDA,DDiemDA)
values
	('1','Nâng cao chất lượng muối','Sa Huỳnh'),
	('10','Xây dụng nhà máy chế biến thủy sản','Dung Quắt'),
	('2','Phát triển hạ tầng mạng','Tp Quảng ngãi'),
	('20','Truyền tải cáp quang','Tp Quảng ngãi'),
	('3','Tin học hóa trường học','Ba Tơ'),
	('30','Đào tạo nhân lục','Tịnh Phong');


INSERT INTO PHONGBAN
	(MaPhg,TenPhg)
values 
	('1','Quản lý'),
	('4','Điều Hành'),
	('5','Nghiên cứu');

INSERT INTO NHANVIEN
    (MaNV, HoNV, TenLot,TenNV, NgSinh, DiaChi,Phai,Luong,Phong)
VALUES
    ('123', 'Đinh', 'Bá', 'Tiến', '1982-2-27', 'Mộ Đức','Nam','','4'),
	('234', 'Nguyễn', 'Thanh', 'Tùng', '1956-8-12', 'Sơn Tịnh','','Nam','5'),
	('345', 'Bùi', 'Thúy', 'Vũ', '', 'Tư Nghĩa','Nữ','','4'),
	('567', 'Nguyễn', 'Mạnh', 'Hùng', '1985-3-25', 'Sơn Tịnh','Nam','','5'),
	('678', 'Trần ', 'Hồng', 'Quang', '', 'Bình Sơn','Nam','','5');




