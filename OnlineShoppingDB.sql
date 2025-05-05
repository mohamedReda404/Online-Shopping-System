
-- إنشاء قاعدة البيانات
CREATE DATABASE OnlineShoppingDB;
GO

USE OnlineShoppingDB;
GO

-- جدول المستخدمين (تسجيل حساب وتسجيل دخول)
CREATE TABLE Users (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Username NVARCHAR(100) NOT NULL,
    Email NVARCHAR(150) NOT NULL UNIQUE,
    PasswordHash NVARCHAR(255) NOT NULL,
    Role NVARCHAR(50) NOT NULL DEFAULT 'Customer', -- أو 'Admin'
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE()
);
GO

-- جدول المنتجات
CREATE TABLE Products (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(200) NOT NULL,
    Description NVARCHAR(MAX),
    Price DECIMAL(10, 2) NOT NULL,
    Category NVARCHAR(100),
    ImageUrl NVARCHAR(500),
    ImageData VARBINARY(MAX) -- لتخزين الصورة كبيانات ثنائية
);
GO

-- جدول الطلبات
CREATE TABLE Orders (
    Id INT PRIMARY KEY IDENTITY(1,1),
    UserId INT NOT NULL,
    OrderDate DATETIME NOT NULL DEFAULT GETDATE(),
    Status NVARCHAR(50) NOT NULL DEFAULT 'Pending',
    FOREIGN KEY (UserId) REFERENCES Users(Id)
);
GO

-- جدول عناصر الطلب (علاقة بين الطلبات والمنتجات)
CREATE TABLE OrderItems (
    Id INT PRIMARY KEY IDENTITY(1,1),
    OrderId INT NOT NULL,
    ProductId INT NOT NULL,
    Quantity INT NOT NULL,
    FOREIGN KEY (OrderId) REFERENCES Orders(Id),
    FOREIGN KEY (ProductId) REFERENCES Products(Id)
);
GO
