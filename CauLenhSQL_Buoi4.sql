--------------------------------------BÀI THỰC HÀNH SQL SERVER – BUỔI 04

-------------------1.Liệt kê danh sách tất cả các nhân viên
select * from NHANVIEN

-------------------2. Tìm các nhân viên làm việc ở phòng số 5
select MaNV, HoNV, TenLot, TenNV, NgSinh, Diachi, Phai, Luong, Phong
from NHANVIEN
where Phong=5

-------------------3. Liệt kê họ tên và phòng làm việc các nhân viên có mức lương trên 6.000.000 đồng
select HoNV, Tenlot, TenNV, Luong, Phong
from NHANVIEN
where Luong > 6000000

-------------------4. Tìm các nhân viên có mức lương trên 6.500.000 ở phòng 1 hoặc các nhân viên có mức
lương trên 5.000.000 ở phòng 4
select MaNV, Tenlot, TenNV, Luong, Phong
from NHANVIEN
where Phong = 1 AND Luong >6500000 OR
	  Luong > 5000000 AND Phong =4

-------------------------5. Cho biết họ tên đầy đủ của các nhân viên ở TP Quảng Ngãi
select MANV, HONV, TENLOT, TENNV
from NHANVIEN , Diachi_phong
where NHANVIEN.Phong = diachi_phong.maphg and diachi_phong.DIAchi = 'QUANG NGAI'
select *from NHANVIEN

---------------------6. Cho biết họ tên đầy đủ của các nhân viên có họ bắt đầu bằng ký tự &#39;N&#39;
select HoNV+''+TenLot+''+TenNV+'' as' họ và tên nhân viên'
from NHANVIEN
where NHANVIEN.HoNV like N'N%'

----------------------7. Cho biết ngày sinh và địa chỉ của nhân viên Cao Thanh Huyền
SELECT NHANVIEN.NGSINH, NHANVIEN.DiaCHI
FROM NHANVIEN
WHERE NHANVIEN.HONV = N'Cao' AND
		  NHANVIEN.TENLOT = N'Thanh' AND
		  NHANVIEN.TENNV = N'Huyền'

---------------------8. Cho biết các nhân viên có năm sinh trong khoảng 1955 đến 1975
select *FROM NHANVIEN
WHERE Year(NGSINH) BETWEEN 1955 AND 1975;

---------------------9. Cho biết các nhân viên và năm sinh của nhân viên
Select HONV + ' ' +TENLOT+ ' ' +TENNV as 'Họ Và Tên' , YEAR(NGSINH) as 'Năm Sinh của sinh viên: '
from NHANVIEN

---------------------10. Cho biết họ tên và tuổi của tất cả các nhân viên
select HONV+ ' ' +TENLOT+ ' ' +TENNV as 'Họ và tên', (2023 - YEAR(NGSINH)) as 'Tuổi nhân viên' from NHANVIEN

---------------------11. Tìm tên những người trưởng phòng của từng phòng ban
select HONV+ ' ' +TENLOT+ ' ' +TENNV as 'Họ và tên Trưởng Phòng' from PHONGBAN,NHANVIEN
where PHONGBAN.TRPHG = NHANVIEN.MANV

---------------------12. Tìm tên và địa chỉ của tất cả các nhân viên của phòng &quot;Điều hành&quot;.
select HONV+ ' ' +TENLOT+ ' ' +TENNV as 'Họ và tên', DCHI from NHANVIEN inner join PHONGBAN on NHANVIEN.PHG = PHONGBAN.MAPHG
where PHONGBAN.MAPHG = 4

---------------------13. Với mỗi đề án ở Tp Quảng Ngãi, cho biết tên đề án, tên phòng ban, họ tên và ngày nhận chức của trưởng phòng của phòng ban chủ trì đề án đó.
select TENDA, TENPHG, HONV+ ' ' +TENLOT+ ' ' +TENNV as 'Họ và tên', NG_NHANCHUC 
from NHANVIEN inner join PHONGBAN 
ON NHANVIEN.PHG = PHONGBAN.MAPHG 
inner join DEAN ON DEAN.PHONG = PHONGBAN.MAPHG
where PHONGBAN.TRPHG = NHANVIEN.MANV and DCHI like '%Tp Quảng Ngãi'

---------------------14. Tìm tên những nữ nhân viên và tên người thân của họ
select HONV+ ' ' +TENLOT+ ' ' +TENNV as 'Họ và tên', TENTN as 'Tên người thân' 
from NHANVIEN inner join THANNHAN ON NHANVIEN.MANV = THANNHAN.MA_NVIEN
where NHANVIEN.PHAI = N'Nữ'

---------------------15. Với mỗi nhân viên, cho biết họ tên của nhân viên, họ tên trưởng phòng của phòng ban mà nhân viên đó đang làm việc.

select NV.HONV + ' ' + NV.TENLOT + ' ' + NV.TENNV as 'Họ và tên nhân viên', QL.HONV+ ' ' + QL.TENLOT + ' ' + QL.TENNV as 'Họ và tên quản lí'
	from NHANVIEN NV,NHANVIEN QL
	where NV.MA_NQL = QL.MANV

---------------------16. Tên những nhân viên phòng Nghiên cứu có tham gia vào đề án Xây dựng nhà máy chế biến thủy sản
select HONV+ ' ' + TENLOT + ' ' + TENNV as 'Họ và tên' 
from NHANVIEN inner join DEAN ON NHANVIEN.PHG = DEAN.PHONG
where DEAN.TENDA= 'Xây dựng nhà máy chế biến thủy sản'

---------------------17. Cho biết tên các đề án mà nhân viên Trần Thanh Tâm đã tham gia.
select TENDA as 'Tên đề án'
from NHANVIEN inner join DEAN ON NHANVIEN.PHG = DEAN.PHONG
where NHANVIEN.HONV = N'Trần' and NHANVIEN.TENLOT = N'Thanh' and NHANVIEN.TENNV = N'Tâm'