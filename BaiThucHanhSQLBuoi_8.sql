

-----1. Viết SP spTangLuong dùng để tăng lương lên 10% cho tất cả các nhân viên.
CREATE PROCEDURE spTangLuong
AS
BEGIN
    UPDATE NhanVien
    SET Luong = Luong * 1.1
END;

EXEC spTangLuong;

----2.Thêm vào cột NgayNghiHuu (ngày nghỉ hưu) trong bảng NHANVIEN. Viết SP spNghiHuu dùng để cập nhật ngày nghỉ hưu là ngày hiện tại cộng thêm 100 (ngày) cho những nhân viên nam có tuổi từ 60 trở lên và nữ từ 55 trở lên.
ALTER TABLE NHANVIEN
ADD NgayNghiHuu DATE;

CREATE PROCEDURE spNghiHuu
AS
BEGIN
    UPDATE NHANVIEN
    SET NgayNghiHuu = DATEADD(day, 100, GETDATE())
    WHERE (GioiTinh = 'Nam' AND DATEDIFF(year, NgaySinh, GETDATE()) >= 60)
    OR (GioiTinh = 'Nu' AND DATEDIFF(year, NgaySinh, GETDATE()) >= 55)
END;

EXEC spNghiHuu;

-----3. Tạo SP spXemDeAn cho phép xem các đề án có địa điểm đề án được truyền vào khi gọi thủ tục.
CREATE PROCEDURE spXemDeAn @DiaDiem NVARCHAR(255)
AS
BEGIN
    SELECT * FROM DeAn
    WHERE DiaDiem = @DiaDiem
END;

EXEC spXemDeAn @DiaDiem = N'<địa điểm>';

---4. Tạo SP spCapNhatDeAn cho phép cập nhật lại địa điểm đề án với 2 tham số truyền vào là diadiem_cu, diadiem_moi.
CREATE PROCEDURE spCapNhatDeAn @diadiem_cu NVARCHAR(255), @diadiem_moi NVARCHAR(255)
AS
BEGIN
    UPDATE DeAn
    SET DiaDiem = @diadiem_moi
    WHERE DiaDiem = @diadiem_cu
END;

EXEC spCapNhatDeAn @diadiem_cu = N'<địa điểm cũ>', @diadiem_moi = N'<địa điểm mới>';

---5.Viết SP spThemDeAn để thêm dữ liệu vào bảng DEAN với các tham số vào là các trường của bảng DEAN.

CREATE PROCEDURE spThemDA
   @TENDA NVARCHAR(15),
    @MADA int,
   @DDIEM_DA NVARCHAR(50),
   @MaPhongBan INT
 
AS
BEGIN
   SET NOCOUNT ON;
   INSERT INTO DEAN (TENDA, MADA,DDIEM_DA)
   VALUES (@TENDA,@MADA,@DDIEM_DA);
END;

--6.
-- Trường hợp hợp lệ:
EXEC spThemDeAn 1, 'Đề án A', 'Mô tả cho Đề án A', 1;

-- Trường hợp không hợp lệ: Mã đề án đã tồн tại
EXEC spThemDeAn 1, 'Đề án B', 'Mô tả cho Đề án B', 1;

-- Trường hợp không hợp lệ: Mã phòng ban không tồн tại
EXEC spThemDeAn 2

CREATE PROCEDURE spThemDeAn
    @MaDeAn INT,
    @TenDeAn NVARCHAR(50),
    @MoTa NVARCHAR(255),
    @MaPhongBan INT
AS
BEGIN
    IF EXISTS (SELECT * FROM DEAN WHERE MaDeAn = @MaDeAn)
    BEGIN
        RAISERROR ('Mã đề án đã tồn tại, đề nghị chọn mã đề án khác', 16, 1);
        RETURN;
    END

    IF NOT EXISTS (SELECT * FROM PHONGBAN WHERE MaPhongBan = @MaPhongBan)
    BEGIN
        RAISERROR ('Mã phòng không tồn tại', 16, 1);
        RETURN;
    END

    INSERT INTO DEAN (MaDeAn, TenDeAn, MoTa)
    VALUES (@MaDeAn, @TenDeAn, @MoTa)
END

--7.
CREATE PROCEDURE spXoaDeAn
    @MaDA INT
AS
BEGIN
    IF EXISTS (SELECT * FROM PHANCONG WHERE MaDA = @MaDA)
    BEGIN
        PRINT 'Không thể xóa đề án này vì nó đã được phân công';
        RETURN;
    END

    DELETE FROM DEAN WHERE MaDA = @MaDA;
END
---8.
CREATE PROCEDURE spXoaDA
    @MaDA INT
AS
BEGIN
    IF EXISTS (SELECT * FROM PHANCONG WHERE MaDA = @MaDA)
    BEGIN
        DELETE FROM PHANCONG WHERE MaDA = @MaDA;
    END

    DELETE FROM DEAN WHERE MaDA = @MaDA;
END

---9.
CREATE PROCEDURE spTongGioLamViec
    @MaNV INT,
    @TongGioLamViec INT OUTPUT
AS
BEGIN
    SELECT @TongGioLamViec = SUM(SoGio) FROM PHANCONG WHERE MaNV = @MaNV;
END

----10.
CREATE PROCEDURE spTongTien
    @MaNV INT
AS
BEGIN
    DECLARE @Luong INT;
    DECLARE @LuongDeAn INT;
    DECLARE @TongTien INT;

    SELECT @Luong = Luong FROM NHANVIEN WHERE MaNV = @MaNV;
    SELECT @LuongDeAn = SUM(ThoiGian) * 100000 FROM PHANCONG WHERE MaNV = @MaNV;
    SET @TongTien = @Luong + ISNULL(@LuongDeAn, 0);

    PRINT 'Tổng tiền phải trả cho nhân viên ' + CAST(@MaNV AS NVARCHAR(10)) + ' là ' + CAST(@TongTien AS NVARCHAR(20)) + ' đồng';
END
EXEC spTongTien 333;