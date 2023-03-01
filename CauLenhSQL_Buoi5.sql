-------------------------------18. Cho biết số lượng đề án của công ty
SELECT COUNT(DEAN.MaDA) as 'Tổng đề án'
	FROM DEAN

------------------------------19. Liệt kê danh sách các phòng ban có tham gia chủ trì các đề án
SELECT TenPhg, TenDA
FROM NHANVIEN INNER JOIN PHONGBAN ON NHANVIEN.Phong = PHONGBAN.MaPhg INNER JOIN PHANCONG ON NHANVIEN.MaNV = PHANCONG.MaNV
INNER JOIN DEAN ON DEAN.MaDA = PHANCONG.MaDA
GROUP BY TenPhg, TenDA

------------------------------20. Cho biết số lượng các phòng ban có tham gia chủ trì các đề án
select TenPhg,count(*) as' Số lượng'
	from PHONGBAN,DEAN
	where MaPhg=TenPhg
	group by TenPhg

------------------------------21. Cho biết số lượng đề án do phòng Nghiên Cứu chủ trì
SELECT COUNT(DEAN.MaDA) as 'Số lượng đề án'
	FROM DEAN, PHONGBAN
	WHERE DEAN.MaDA = PHONGBAN.MaPhg AND
		  PHONGBAN.TenPhg = N'Nghiên cứu'

------------------------------22. Cho biết lương trung bình của các nữ nhân viên
SELECT AVG(NHANVIEN.Luong) as'Lương trung bình'
	FROM NHANVIEN
	WHERE NHANVIEN.Phai = N'Nữ'

-----------------------------23. Cho biết số thân nhân của nhân viên Đinh Bá Tiến
SELECT COUNT(THANNHAN.MaNV) as' Nhân thân'
	FROM NHANVIEN, THANNHAN
	WHERE NHANVIEN.MaNV = THANNHAN.MaNV AND
		  NHANVIEN.HoNV = N'Đinh' AND
		  NHANVIEN.TenLot = N'Bá' AND
		  NHANVIEN.TenNV = N'Tiến'

----------------------------24. Liệt kê danh sách 3 nhân viên lớn tuổi nhất, danh sách bao gồm họ tên và năm sinh.
SELECT (HoNV  + ' ' + TenLot + ' ' + TenNV) AS N'Họ Tên', YEAR(NgSinh) AS N'Năm sinh'
FROM NHANVIEN
ORDER BY (2023-YEAR(NgSinh)) ASC

----------------------------25. Với mỗi đề án, liệt kê mã đề án và tổng số giờ làm việc của tất cả các nhân viên tham gia đề án đó.
SELECT DEAN.MaDA, SUM(PHANCONG.ThoiGian) as'Tổng số giờ'
	FROM DEAN, PHANCONG
	WHERE DEAN.MaDA = PHANCONG.MaDA
	GROUP BY DEAN.MaDA

---------------------------26. Với mỗi đề án, liệt kê tên đề án và tổng số giờ làm việc của tất cả các nhân viên tham gia đề án đó.
SELECT DEAN.TenDA, SUM(PHANCONG.ThoiGian) as'Tổng số giờ'
	FROM DEAN, PHANCONG
	WHERE DEAN.MaDA = PHANCONG.MADA
	GROUP BY  DEAN.TenDA

---------------------------27. Với mỗi đề án, cho biết có bao nhiêu nhân viên tham gia đề án đó, thông tin bao gồm tên đề án và số lượng nhân viên.
select TenDA+'' as 'Tên đề án' ,count(*) as 'số lượng nhân viên'
	from NHANVIEN,DEAN
	where TenDA= DEAN.TenDA
	group by DEAN.TenDA
---------------------------28. Với mỗi nhân viên, cho biết họ và tên nhân viên và số lượng thân nhân của nhân viên đó.

SELECT (NHANVIEN.HoNV + ' ' + NHANVIEN.TenLot + ' ' + NHANVIEN.TenNV) AS 'Họ tên nhân viên', COUNT(THANNHAN.MaNV) AS 'Số lượng thân nhân'
	FROM NHANVIEN, THANNHAN
	WHERE NHANVIEN.MaNV = THANNHAN.MaNV
	GROUP BY (NHANVIEN.HoNV + ' ' + NHANVIEN.TenLot + ' ' + NHANVIEN.TenNV)
--------------------------29. Với mỗi nhân viên, cho biết họ tên của nhân viên và số lượng đề án mà nhân viên đó đã tham gia.

SELECT (NHANVIEN.HoNV + ' ' + NHANVIEN.TenLot + ' ' + NHANVIEN.TenNV) AS 'Họ tên nhân viên', COUNT(PHANCONG.MaNV) AS'Số lượng đề án tham gia'
	FROM NHANVIEN, DEAN, PHANCONG
	WHERE NHANVIEN.MaNV = PHANCONG.MaNV AND
		  DEAN.MaDA = PHANCONG.MaDA
	GROUP BY (NHANVIEN.HoNV + ' ' + NHANVIEN.TenLot + ' ' + NHANVIEN.TenNV)

--------------------------30. Với mỗi phòng ban, liệt kê tên phòng ban và lương trung bình của những nhân viên làm việc cho phòng ban đó.
SELECT PHONGBAN.MaPhg, PHONGBAN.TenPhg, AVG(NHANVIEN.Luong) AS 'Lương trung bình'
	FROM NHANVIEN, PHONGBAN
	WHERE NHANVIEN.Phong = PHONGBAN.MaPhg
	GROUP BY PHONGBAN.MaPhg, PHONGBAN.TenPhg

--------------------------31. Với các phòng ban có mức lương trung bình trên 5.200.000, liệt kê tên phòng ban và số lượng nhân viên của phòng ban đó.
	SELECT PHONGBAN.TenPhg, COUNT(NHANVIEN.MaNV) AS N'Số lượng nhân viên'
	FROM NHANVIEN, PHONGBAN
	WHERE NHANVIEN.Phong = PHONGBAN.MaPhg
	GROUP BY PHONGBAN.TenPhg
	HAVING AVG(NHANVIEN.Luong)>5200000

-------------------------32. Với mỗi phòng ban, cho biết tên phòng ban và số lượng đề án mà phòng ban đó chủ trì
select TENPHG,count(DEAN.TenDA) as 'Số lượng đề án'
	from PHONGBAN,DEAN
	where MaPhg= MaDA
	group by TENPHG

-------------------------33. Với mỗi phòng ban, cho biết tên phòng ban, họ tên người trưởng phòng và số lượng đề án mà phòng ban đó chủ trì
SELECT PHONGBAN.TENPHG, (NHANVIEN.HoNV + ' ' + NHANVIEN.TenLot + ' ' + NHANVIEN.TenNV) AS 'Họ tên trưởng phòng', COUNT(DEAN.DDiemDA) AS 'Số lượng đề án'
	FROM NHANVIEN, PHONGBAN, DEAN
	WHERE NHANVIEN.MaNV = PHONGBAN.TenPhg AND
		  PHONGBAN.MaPhg = DEAN.DDiemDA
	GROUP BY PHONGBAN.TenPhg, (NHANVIEN.HoNV + ' ' + NHANVIEN.TenLot + ' ' + NHANVIEN.TenNV)

-------------------------34. Với mỗi đề án, cho biết tên đề án và số lượng nhân viên tham gia đề án
SELECT (NHANVIEN.HoNV + ' ' + NHANVIEN.TenLot + ' ' + NHANVIEN.TenNV) AS 'Họ tên nhân viên', COUNT(PHANCONG.MaNV) AS'Số lượng đề án tham gia'
	FROM NHANVIEN, DEAN, PHANCONG
	WHERE NHANVIEN.MaNV = PHANCONG.MaNV AND
		  DEAN.MaDA = PHANCONG.MaDA
	GROUP BY (NHANVIEN.HoNV + ' ' + NHANVIEN.TenLot + ' ' + NHANVIEN.TenNV)