
-- 1. Kiểu dữ liệu tự định nghĩa
EXEC sp_addtype 'Mota', 'NVARCHAR(40)'
EXEC sp_addtype 'IDKH', 'CHAR(10)', 'NOT NULL'
EXEC sp_addtype 'DT', 'CHAR(12)'

-- 2. Tạo table
CREATE TABLE SanPham 
(
MaSP CHAR(6) primary key NOT NULL ,
TenSP VARCHAR(20),
NgayNhap Date,
DVT CHAR(10),
SoLuongTon INT,
DonGiaNhap money,
)
CREATE TABLE HoaDon 
(
MaHD CHAR(10) primary key NOT NULL ,
NgayLap Date,
NgayGiao Date,
MaKH IDKH,
DienGiai Mota,
)
CREATE TABLE KhachHang 
(
MaKH IDKH primary key ,
TenKH NVARCHAR(30),
DiaCHi NVARCHAR(40),
DienThoai DT,
)
CREATE TABLE ChiTietHD 
(
MaHD CHAR(10)  foreign key references HoaDon(MaHD)  NOT NULL,
MaSP CHAR(6) foreign key references SanPham(Masp) NOT NULL,
SoLuong INT
PRIMARY KEY (MaHD, MaSP)
)

-- 3. Trong Table HoaDon, sửa cột DienGiai thành nvarchar(100).
ALTER TABLE HoaDon
ALTER COLUMN DienGiai NVARCHAR(100)

-- 4. Thêm vào bảng SanPham cột TyLeHoaHong float
ALTER TABLE SanPham
ADD TyLeHoaHong float

-- 5. Xóa cột NgayNhap trong bảng SanPham
ALTER TABLE SanPham
DROP COLUMN NgayNhap

---6.Tạo các ràng buộc khóa chính và khóa ngoại cho các bảng trên

ALTER TABLE SanPham
ADD primary key (MaSP);

ALTER TABLE HoaDon
ADD primary key (MaHD) ;

ALTER TABLE KhachHang
ADD primary key (MaKH);

ALTER TABLE ChiTietHD
ADD primary key (MaHD), foreign key(MaSP).

---7. Thêm vào bảng HoaDon các ràng buộc sau.
------NgayGiao >= NgayLap---------
ALTER TABLE HoaDon
ADD CONSTRAINT check_Ngaygiao CHECK (Ngaygiao >= Ngaylap);
------MaHD gồm 6 ký tự, 2 ký tự đầu là chữ, các ký tự còn lại là số-----
ALTER TABLE HoaDon
ADD CONSTRAINT check_MaHD CHECK(MaHD like '[A-Z][A-Z][0-9][0-9][0-9][0-9]');
------Giá trị mặc định ban đầu cho cột NgayLap luôn luôn là ngày hiện hành-----
ALTER TABLE HoaDon
ADD CONSTRAINT df_Ngaylap DEFAULT GETDATE() FOR Ngaylap;

---8.
--Cau 1:
EXEC sp_addtype 'Mota', 'NVARCHAR(40)'
EXEC sp_addtype 'IDKH', 'CHAR(10)', 'NOT NULL'
EXEC sp_addtype 'DT', 'CHAR(12)'

--Cau 2:
CREATE TABLE SanPham (
	Masp char(6) primary key not null,
	Tensp varchar(20),
	NgayNhap date,
	DVT char(10),
	SoluongTon int,
	DongiaNhap money
)

CREATE TABLE KhachHang(
	MaKH IDKH primary key not null,
	TenKH nvarchar(30),
	Diachi nvarchar(40),
	Dienthoai DT
)

CREATE TABLE HoaDon(
	MaHD char(10) primary key not null,
	Ngaylap date,
	Ngaygiao date,
	MaKH IDKH foreign key references KhachHang(MaKH),
	Diengiai Mota
)

CREATE TABLE ChiTietHD(
	MaHD char(10) foreign key references HoaDon(MaHD) not null,
	Masp char(6) foreign key references SanPham(Masp) not null,
	Soluong int
	primary key(MaHD, Masp)
)

--Cau 3:
ALTER TABLE HoaDon
ALTER COLUMN DienGiai nvarchar(100)

--Cau 4:
ALTER TABLE SanPham
ADD TyLeHoaHong FLOAT

--Cau 5:
ALTER TABLE SanPham
DROP COLUMN NgayNhap

--Cau 6:

--Cau 7:
------NgayGiao >= NgayLap---------
ALTER TABLE HoaDon
ADD CONSTRAINT check_Ngaygiao CHECK (Ngaygiao >= Ngaylap);
------MaHD gồm 6 ký tự, 2 ký tự đầu là chữ, các ký tự còn lại là số-----
ALTER TABLE HoaDon
ADD CONSTRAINT check_MaHD CHECK(MaHD like '[A-Z][A-Z][0-9][0-9][0-9][0-9]');
------Giá trị mặc định ban đầu cho cột NgayLap luôn luôn là ngày hiện hành-----
ALTER TABLE HoaDon
ADD CONSTRAINT df_Ngaylap DEFAULT GETDATE() FOR Ngaylap;

--8.Thêm vào bảng Sản phẩm các ràng buộc sau
------SoLuongTon chỉ nhập từ 0 đến 500----
ALTER TABLE SanPham
ADD CONSTRAINT check_SoluongTon CHECK (SoluongTon BETWEEN 0 AND 500)
------DonGiaNhap lớn hơn 0------
ALTER TABLE SanPham
ADD CONSTRAINT check_DongiaNhap CHECK (DongiaNhap > 0)
------Giá trị mặc định cho NgayNhap là ngày hiện hành-----
ALTER TABLE SanPham
ADD CONSTRAINT df_NgayNhap DEFAULT GETDATE() FOR NgayNhap;
------DVT chỉ nhập vào các giá trị ‘KG’, ‘Thùng’, ‘Hộp’, ‘Cái’----
ALTER TABLE SanPham
ADD CONSTRAINT df_DVT CHECK (DVT = N'KG' or DVT = N'Thùng' or DVT = N'Hộp' or DVT = N'Cái')

