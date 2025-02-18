CREATE DATABASE QuanLyQuanCafe
GO

USE QuanLyQuanCafe
GO

-- Food
-- Table
-- FoodCategory
-- Account
-- Bill
-- BillInfo

CREATE TABLE TableFood
(
	id INT IDENTITY PRIMARY KEY,
	name NVARCHAR(100) NOT NULL DEFAULT N'Bàn chưa có tên',
	status NVARCHAR(100) NOT NULL DEFAULT N'Trống'	-- Trống || Có người
)
GO

CREATE TABLE Account
(
	UserName NVARCHAR(100) PRIMARY KEY,	
	DisplayName NVARCHAR(100) NOT NULL DEFAULT N'VINH',
	PassWord NVARCHAR(1000) NOT NULL DEFAULT 0,
	Type INT NOT NULL  DEFAULT 0 -- 1: admin && 0: staff
)
GO

CREATE TABLE FoodCategory
(
	id INT IDENTITY PRIMARY KEY,
	name NVARCHAR(100) NOT NULL DEFAULT N'Chưa đặt tên'
)
GO

CREATE TABLE Food
(
	id INT IDENTITY PRIMARY KEY,
	name NVARCHAR(100) NOT NULL DEFAULT N'Chưa đặt tên',
	idCategory INT NOT NULL,
	price FLOAT NOT NULL DEFAULT 0
	
	FOREIGN KEY (idCategory) REFERENCES dbo.FoodCategory(id)
)
GO

CREATE TABLE Bill
(
	id INT IDENTITY PRIMARY KEY,
	DateCheckIn DATE NOT NULL DEFAULT GETDATE(),
	DateCheckOut DATE,
	idTable INT NOT NULL,
	status INT NOT NULL DEFAULT 0 -- 1: đã thanh toán && 0: chưa thanh toán
	
	FOREIGN KEY (idTable) REFERENCES dbo.TableFood(id)
)
GO

CREATE TABLE BillInfo
(
	id INT IDENTITY PRIMARY KEY,
	idBill INT NOT NULL,
	idFood INT NOT NULL,
	count INT NOT NULL DEFAULT 0
	
	FOREIGN KEY (idBill) REFERENCES dbo.Bill(id),
	FOREIGN KEY (idFood) REFERENCES dbo.Food(id)
)
GO
--chuc nang dang nhap
go
CREATE PROC USP_GetAccountByUserName
@userName nvarchar(100)
AS 
BEGIN
	SELECT * FROM dbo.Account WHERE UserName = @userName
END
GO
select * from dbo.Account where UserName = N'v' AND PassWord = N'1'
go
exec dbo.USP_GetAccountByUserName @userName = N'v' 

INSERT INTO dbo.Account
        ( UserName ,
          DisplayName ,
          PassWord ,
          Type
        )
VALUES  ( N'v' , -- UserName - nvarchar(100)
          N'LeCongVinh' , -- DisplayName - nvarchar(100)
          N'1' , -- PassWord - nvarchar(1000)
          1  -- Type - int
        )
INSERT INTO dbo.Account
        ( UserName ,
          DisplayName ,
          PassWord ,
          Type
        )
VALUES  ( N'T' , -- UserName - nvarchar(100)
          N'Thai' , -- DisplayName - nvarchar(100)
          N'1' , -- PassWord - nvarchar(1000)
          0  -- Type - int
        )
INSERT INTO dbo.Account
        ( UserName ,
          DisplayName ,
          PassWord ,
          Type
        )
VALUES  ( N'q' , -- UserName - nvarchar(100)
          N'GiaQuy' , -- DisplayName - nvarchar(100)
          N'1' , -- PassWord - nvarchar(1000)
          1  -- Type - int
        )
GO

CREATE PROC USP_Login
@userName nvarchar(100), @passWord nvarchar(100)
AS
BEGIN
	SELECT * FROM dbo.Account WHERE UserName = @userName AND PassWord = @passWord
END
GO
EXEC dbo.USP_GetAccountByUserName @userName = N'VINH' -- nvarchar(100)


--tao danh sach ban

DECLARE @i INT = 1

WHILE @i <= 20
BEGIN
	INSERT dbo.TableFood ( name)VALUES  ( N'Bàn ' + CAST(@i AS nvarchar(100)))
	SET @i = @i + 1
END

select * from dbo.Account
SELECT * FROM TableFood
DELETE TableFood
DBCC CHECKIDENT ('TableFood', RESEED, 0);




go
create proc USP_GetTableList
as select * from dbo.TableFood
go
exec dbo.USP_GetTableList


SELECT * FROM TableFood;
DELETE FROM dbo.TableFood;
exec dbo.USP_GetTableList



update dbo.TableFood set status = N'Có người 'where id = 2

UPDATE dbo.TableFood 
SET status = N'Trống';


select * from dbo.BillInfo
delete  from dbo.BillInfo
delete from dbo.Bill
select * from dbo.Bill
select * from dbo.Food
select * from dbo.FoodCategory

WITH CTE AS (
    SELECT id, name, idCategory, price,
           ROW_NUMBER() OVER (PARTITION BY name, idCategory, price ORDER BY id) AS row_num
    FROM dbo.Food
)
DELETE FROM dbo.Food WHERE id IN (
    SELECT id FROM CTE WHERE row_num > 1
);
SET IDENTITY_INSERT dbo.Food OFF;
DELETE FROM dbo.Food;
DBCC CHECKIDENT ('dbo.Food', RESEED, 0);
SELECT * FROM dbo.Food;




--thêm loại đồ uống

INSERT dbo.FoodCategory
        ( name )
VALUES  ( N'Caffe'  -- name - nvarchar(100)
          )
INSERT dbo.FoodCategory
        ( name )
VALUES  ( N'Trà' )
INSERT dbo.FoodCategory
        ( name )
VALUES  ( N'Nước ép' )
INSERT dbo.FoodCategory
        ( name )
VALUES  ( N'Nước đóng chai' )
INSERT dbo.FoodCategory
        ( name )
VALUES  ( N'Bánh' )

-- thêm danh sách Cà phê
INSERT dbo.Food
        ( name, idCategory, price )
VALUES  ( N'Cà phê đen', -- name - nvarchar(100)
          1, -- idCategory - int
          25000)
INSERT dbo.Food
        ( name, idCategory, price )
VALUES  ( N'Cà phê sữa', 1, 25000)
INSERT dbo.Food
        ( name, idCategory, price )
VALUES  ( N'Cappuccino', 1, 25000)
INSERT dbo.Food
        ( name, idCategory, price )
VALUES  ( N'Latte', 1, 25000)


--thêm danh sách trà

INSERT dbo.Food
        ( name, idCategory, price )
VALUES  ( N'Trà sữa matcha', 2, 25000)

INSERT dbo.Food
        ( name, idCategory, price )
VALUES  ( N'Trà sữa oolong', 2, 25000)

INSERT dbo.Food
        ( name, idCategory, price )
VALUES  ( N'trà sữa khoai môn kem trứng', 2, 30000)

INSERT dbo.Food
        ( name, idCategory, price )
VALUES  ( N'Trà đào cam sả', 2, 25000)



--thêm danh sách nước ép

INSERT dbo.Food
        ( name, idCategory, price )
VALUES  ( N'Nước ép dưa hấu', 3, 20000)

INSERT dbo.Food
        ( name, idCategory, price )
VALUES  ( N'Nước ép cam', 3, 20000)

INSERT dbo.Food
        ( name, idCategory, price )
VALUES  ( N'Nước ép ổi', 3, 20000)

INSERT dbo.Food
        ( name, idCategory, price )
VALUES  ( N'Nước ép xoài', 3, 20000)



-- thêm danh sách nước đóng chai

INSERT dbo.Food
        ( name, idCategory, price )
VALUES  ( N'Coca', 4, 12000)

INSERT dbo.Food
        ( name, idCategory, price )
VALUES  ( N'Pespi', 4, 12000)



--danh sach banh

INSERT dbo.Food
        ( name, idCategory, price )
VALUES  ( N'Bánh cokkie', 5, 18000)

INSERT dbo.Food
        ( name, idCategory, price )
VALUES  ( N'Bánh quy', 5, 18000)


--them bill
INSERT	dbo.Bill
        ( DateCheckIn ,
          DateCheckOut ,
          idTable ,
          status
        )

VALUES  ( GETDATE() , -- DateCheckIn - date
          NULL , -- DateCheckOut - date
          2 , -- idTable - int
          0  -- status - int
        )
        
INSERT	dbo.Bill
        ( DateCheckIn ,
          DateCheckOut ,
          idTable ,
          status
        )
VALUES  ( GETDATE() , -- DateCheckIn - date
          NULL , -- DateCheckOut - date
          3, -- idTable - int
          0  -- status - int
        )
INSERT	dbo.Bill
        ( DateCheckIn ,
          DateCheckOut ,
          idTable ,
          status
        )
VALUES  ( GETDATE() , -- DateCheckIn - date
          GETDATE() , -- DateCheckOut - date
          4 , -- idTable - int
          1  -- status - int
        )



-- thêm bill info
INSERT	dbo.BillInfo
        ( idBill, idFood, count )
VALUES  ( 1, -- idBill - int
          1, -- idFood - int
          1  -- count - int
          )
INSERT	dbo.BillInfo
        ( idBill, idFood, count )
VALUES  ( 1, -- idBill - int
          3, -- idFood - int
          1  -- count - int
          )
INSERT	dbo.BillInfo
        ( idBill, idFood, count )
VALUES  ( 1, -- idBill - int
          5, -- idFood - int
          1  -- count - int
          )
INSERT	dbo.BillInfo
        ( idBill, idFood, count )
VALUES  ( 1, -- idBill - int
          6, -- idFood - int
          1  -- count - int
          )

create proc USP_InsertBill
@idTable int
as
begin
INSERT	dbo.Bill
        ( DateCheckIn ,
          DateCheckOut ,
          idTable ,
          status
        )

VALUES  ( GETDATE() , -- DateCheckIn - date
          NULL , -- DateCheckOut - date
          @idTable , -- idTable - int
          0  -- status - int
        )
end
go

create PROC USP_InsertBill
@idTable INT
AS
BEGIN
	INSERT dbo.Bill 
	        ( DateCheckIn ,
	          DateCheckOut ,
	          idTable ,
	          status,
			  discount
	        )
	VALUES  ( GETDATE() , -- DateCheckIn - date
	          NULL , -- DateCheckOut - date
	          @idTable , -- idTable - int
	          0 , -- status - int
			  0
	        )
END
GO

CREATE PROC USP_InsertBillInfo
@idBill INT, @idFood INT, @count INT
AS
BEGIN

	DECLARE @isExitsBillInfo INT
	DECLARE @foodCount INT = 1
	
	SELECT @isExitsBillInfo = id, @foodCount = b.count 
	FROM dbo.BillInfo AS b 
	WHERE idBill = @idBill AND idFood = @idFood

	IF (@isExitsBillInfo > 0)
	BEGIN
		DECLARE @newCount INT = @foodCount + @count
		IF (@newCount > 0)
			UPDATE dbo.BillInfo	SET count = @foodCount + @count WHERE idFood = @idFood
		ELSE
			DELETE dbo.BillInfo WHERE idBill = @idBill AND idFood = @idFood
	END
	ELSE
	BEGIN
		INSERT	dbo.BillInfo
        ( idBill, idFood, count )
		VALUES  ( @idBill, -- idBill - int
          @idFood, -- idFood - int
          @count  -- count - int
          )
	END
END
GO

DELETE dbo.BillInfo

DELETE dbo.Bill

CREATE TRIGGER UTG_UpdateBillInfo
ON dbo.BillInfo FOR INSERT, UPDATE
AS
BEGIN
	DECLARE @idBill INT
	
	SELECT @idBill = idBill FROM Inserted
	
	DECLARE @idTable INT
	
	SELECT @idTable = idTable FROM dbo.Bill WHERE id = @idBill AND status = 0
	
	UPDATE dbo.TableFood SET status = N'Có người' WHERE id = @idTable
END
GO

CREATE TRIGGER UTG_UpdateBill
ON dbo.Bill FOR UPDATE
AS
BEGIN
	DECLARE @idBill INT
	
	SELECT @idBill = id FROM Inserted	
	
	DECLARE @idTable INT
	
	SELECT @idTable = idTable FROM dbo.Bill WHERE id = @idBill
	
	DECLARE @count int = 0
	
	SELECT @count = COUNT(*) FROM dbo.Bill WHERE idTable = @idTable AND status = 0
	
	IF (@count = 0)
		UPDATE dbo.TableFood SET status = N'Trống' WHERE id = @idTable
END
GO



SELECT MAX (id) FROM dbo.Bill





 select * from dbo.Bill
 select * from dbo.BillInfo
DELETE FROM dbo.Bill;
DBCC CHECKIDENT ('dbo.Bill', RESEED, 0);

DELETE FROM dbo.BillInfo;
DBCC CHECKIDENT ('dbo.BillInfo', RESEED, 0);




go


select DISTINCT f.name , bi.count, f.price , f.price*bi.count as totalPrice from dbo.Billinfo as bi,dbo.Food as f,dbo.bill as b 
where bi.idBill = b.id and bi.idFood = f.id and b.status = 0 and b.idTable = 4
UPDATE dbo.TableFood SET STATUS = N'Có người' WHERE id = 2

SELECT * FROM dbo.Bill WHERE idTable = 4

select * from Bill
select * from BillInfo
select * from dbo.TableFood
select * from dbo.FoodCategory

SELECT DISTINCT name, idCategory, price FROM dbo.Food;

select * from Food

SELECT DISTINCt MIN(id) AS id, name FROM dbo.FoodCategory GROUP BY name;




SELECT DISTINCT * FROM FoodCategory

select DISTINCT * from dbo.Food




SELECT DISTINCT * FROM TableFood;


SELECT id, name, status, COUNT(*) AS duplicate_count
FROM TableFood
GROUP BY id, name, status
HAVING COUNT(*) > 1;

WITH CTE AS (
    SELECT id, name, status, 
           ROW_NUMBER() OVER (PARTITION BY id, name ORDER BY id) AS row_num
    FROM TableFood
)
DELETE FROM TableFood WHERE id IN (
    SELECT id FROM CTE WHERE row_num > 1
);

INSERT INTO TableFood (id, name, status)
SELECT DISTINCT id, name, status FROM TableFood;



ALTER TABLE dbo.Bill
ADD discount int
declare @Discount float;
declare @id int;
UPDATE Bill SET [discount] = @Discount WHERE id = @id


select * from dbo.Bill

