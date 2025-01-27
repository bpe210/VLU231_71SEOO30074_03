CREATE DATABASE QLDKHP
GO
USE QLDKHP
GO

CREATE TABLE Khoa (
	Ma VARCHAR(20) PRIMARY KEY,
	Ten NVARCHAR(50),
	Sdt VARCHAR(16),
	DiadiemVp NVARCHAR(100)
)
CREATE TABLE NguoiDung (
	Ma VARCHAR(20),
	Loai INT CHECK (Loai BETWEEN 0 AND 2),
	TenTk VARCHAR(50) UNIQUE CHECK (TenTk NOT LIKE '% %' AND LEN(TenTk) > 4),
	MatKhau VARCHAR(50) CHECK (MatKhau NOT LIKE '% %' 
								AND LEN(MatKhau) > 7 
								AND MatKhau LIKE '%[0-9]%' 
								AND MatKhau LIKE '%[!@#$%^&*()]%'),
	HoTen NVARCHAR(50),
	NgaySinh DATE,
	QueQuan NVARCHAR(50),
	GioiTinh BIT,
	DiaChi NVARCHAR(100),
	PRIMARY KEY(Ma, Loai)
)
CREATE TABLE Admin (
	Ma VARCHAR(20) PRIMARY KEY,
	Loai AS 0 PERSISTED,
	FOREIGN KEY (Ma, Loai) REFERENCES NguoiDung(Ma, Loai)
)
CREATE TABLE GiangVien (
	Ma VARCHAR(20) PRIMARY KEY,
	Loai AS 1 PERSISTED,
	MaKhoa VARCHAR(20) NOT NULL FOREIGN KEY REFERENCES Khoa(Ma),
	FOREIGN KEY (Ma, Loai) REFERENCES NguoiDung(Ma, Loai)
)
CREATE TABLE SinhVien (
	Ma VARCHAR(20) PRIMARY KEY,
	Loai AS 2 PERSISTED,
	MaKhoa VARCHAR(20) NOT NULL FOREIGN KEY REFERENCES Khoa(Ma),
	FOREIGN KEY (Ma, Loai) REFERENCES NguoiDung(Ma, Loai)
)
CREATE TABLE MonHoc (
	Ma VARCHAR(20) PRIMARY KEY,
	MaKhoa VARCHAR(20) NOT NULL FOREIGN KEY REFERENCES Khoa(Ma),
	MaTienQuyet VARCHAR(20) UNIQUE FOREIGN KEY REFERENCES MonHoc(Ma),
	Ten NVARCHAR(50),
	SoTc TINYINT,
	CHECK (MaTienQuyet != Ma)
)
CREATE TABLE LopHp (
	Ma VARCHAR(20) PRIMARY KEY,
	MaMonHoc VARCHAR(20) NOT NULL FOREIGN KEY REFERENCES MonHoc(Ma),
)
CREATE TABLE GiangvienHp (
	MaGiangVien VARCHAR(20) FOREIGN KEY REFERENCES GiangVien(Ma),
	MaHp VARCHAR(20) FOREIGN KEY REFERENCES LopHp(Ma),
	PRIMARY KEY (MaGiangVien, MaHp)
)
CREATE TABLE SinhvienHp (
	MaSinhVien VARCHAR(20) FOREIGN KEY REFERENCES SinhVien(Ma),
	MaHp VARCHAR(20) FOREIGN KEY REFERENCES LopHp(Ma),
	PRIMARY KEY (MaSinhVien, MaHp)
)
CREATE TABLE Diem (
	MaSinhVien VARCHAR(20) FOREIGN KEY REFERENCES SinhVien(Ma),
	MaHp VARCHAR(20) FOREIGN KEY REFERENCES LopHp(Ma),
	DiemTrongLop DECIMAL(4, 2) CHECK (DiemTrongLop BETWEEN 0 AND 10),
	DiemGiuaKy DECIMAL(4, 2) CHECK (DiemGiuaKy BETWEEN 0 AND 10),
	DiemCuoiKy DECIMAL(4, 2) CHECK (DiemCuoiKy BETWEEN 0 AND 10),
	PRIMARY KEY(MaSinhVien, MaHp)
)
USE master