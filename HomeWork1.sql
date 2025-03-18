-- Departments tablosunun oluşturulması ve veri eklenmesi
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50) NOT NULL
);

INSERT INTO Departments (DepartmentID, DepartmentName) VALUES
(1, 'IT'),
(2, 'HR'),
(3, 'Finance');

-- Employees tablosunun oluşturulması ve veri eklenmesi
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Age INT,
    DepartmentID INT,
    Salary DECIMAL(10,2),
    JoinDate DATE,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

INSERT INTO Employees (EmployeeID, FirstName, LastName, Age, DepartmentID, Salary, JoinDate) VALUES
(1, 'John', 'Doe', 30, 1, 55000, '2020-01-15'),
(2, 'Jane', 'Smith', 45, 2, 65000, '2018-07-20'),
(3, 'Sam', 'Brown', 28, 1, 52000, '2021-04-25'),
(4, 'Lisa', 'White', 35, 3, 70000, '2019-03-18'),
(5, 'Mark', 'Black', 50, 1, 75000, '2015-11-05'),
(6, 'Lucy', 'Green', 40, 2, 60000, '2017-10-10');


--3. Görevler--
--Aşağıda belirtilen SQL sorgularını yazın ve her biri için kısa açıklamalar ekleyin.

------------------------------------------------------------------------------------------------------------

--a. Belirli Kolonları Seçme
--Çalışanların sadece FirstName, LastName ve Salary bilgilerini getiren bir SQL sorgusu yazınız.

SELECT firstname, lastname, salary
FROM employees

SELECT FirstName, LastName, Salary
FROM employees

--Açıklama - Bu sorgu çalıştığında PostgreSQL otomatik olarak
--firstname, lastname, ve salary kolon adlarını küçük harflerle kabul eder 
--ve sorguyu doğru şekilde çalıştırır.
------------------------------------------------------------------------------------------------------------

--b. DISTINCT Komutu ile Tekrarları Önleme
--Çalışanların çalıştıkları departmanları benzersiz olarak listeleyen bir SQL sorgusu yazınız.

SELECT DISTINCT DepartmentID
FROM Employees;

--Açıklama: Bu sorgu, DISTINCT komutunu kullanarak, 
--çalışanların çalıştıkları departmanların benzersiz (tekrar etmeyen) ID'lerini getirir.
--Yani her departman sadece bir kez listelenir.

------------------------------------------------------------------------------------------------------------

--c. Belirli Bir Departmana Ait Çalışanları Listeleme
--Sadece IT departmanında çalışanların bilgilerini getiren bir SQL sorgusu yazınız.

SELECT *
FROM Employees
WHERE DepartmentID = 1;

SELECT *
FROM Employees
WHERE DepartmentID = 2;

SELECT *
FROM Employees
WHERE DepartmentID = 3;

--Açıklama: 
--İlk sorgu, WHERE komutunu kullanarak sadece IT departmanında çalışan çalışanları getirir.
--Burada DepartmentID = 1 ile IT departmanının ID'sine göre filtreleme yapılır.
--İkinci sorgu, WHERE komutunu kullanarak sadece HR departmanında çalışan çalışanları getirir.
--Burada DepartmentID = 2 ile HR departmanının ID'sine göre filtreleme yapılır.
--Üçüncü sorgu, WHERE komutunu kullanarak sadece Finance departmanında çalışan çalışanları getirir.
--Burada DepartmentID = 3 ile Finance departmanının ID'sine göre filtreleme yapılır.

------------------------------------------------------------------------------------------------------------

--d. Maaşa Göre Sıralama
--Çalışanları maaşlarına göre büyükten küçüğe sıralayan bir SQL sorgusu yazınız.

SELECT FirstName, LastName, Salary
FROM Employees
ORDER BY Salary DESC;

--Açıklama: Bu sorgu, ORDER BY komutunu kullanarak çalışanları maaşlarına göre büyükten küçüğe sıralar.
--DESC anahtar kelimesi, sıralamanın azalan düzende yapılmasını sağlar.

------------------------------------------------------------------------------------------------------------

--e. Kolonları Birleştirme (Concatenation)
--Çalışanların FirstName ve LastName alanlarını birleştirerek, tam adlarını içeren yeni bir kolon oluşturan bir SQL sorgusu yazınız.

SELECT FirstName || ' ' || LastName AS FullName
FROM Employees;

--Açıklama: Bu sorgu, || operatörü ile FirstName ve LastName kolonlarını birleştirir ve bir boşlukla ayırır. Sonuçta her çalışanın tam adı (FullName) oluşturulur. 
--AS FullName ile bu birleşimi FullName olarak adlandırıyoruz.

------------------------------------------------------------------------------------------------------------
