-- PRIMER EJERCICIO NIVEL-BASICO-INTERMEDIO
-- SQL (DMC-PERU)
-- Bragonzu

-- USAMOS LA BD NORTWIND 

--1. Muestre los registros de la tabla de empleados

SELECT * FROM Employees

--2. Muestre los nombres y apellidos de los empleados.
SELECT FirstName,LastName FROM Employees

--3. Muestre los nombres de las ciudades que aparecen en la tabla de empleados. (No 
-- mostrar 2 veces un mismo nombre de ciudad).

SELECT distinct(City) FROM Employees

--4.Muestre los nombres de productos y precios unitarios de la tabla de productos.
SELECT ProductName as Producto,UnitPrice as Precio_unitario FROM Products

--5.Muestre de la tabla de empleados que viven en USA
SELECT * FROM Employees
WHERE Country ='USA'

--6. Muestre los clientes: listar nombre de la empresa de todos los clientes que viven en
--las ciudades London, Br�cke, Cowes.

SELECT ContactName AS CLIENTE
FROM CUSTOMERS
WHERE City In ('London','Br�cke', 'Cowes')

--7.Muestre las cuidades con su cantidad de clientes
SELECT CITY,COUNT(CustomerID) AS CANT
FROM Customers
GROUP BY CITY
ORDER BY CANT

--8.Muestre los clientes que tienen la regi�n en blanco (NULA).
FROM Customers
WHERE REGION IS NULL

--9.Muestre los 5 productos con mayor precio unitario.
SELECT TOP 5 * 
FROM PRODUCTS
ORDER BY UnitPrice DESC

--10.Muestre los 5 productos con menor precio unitario
SELECT TOP 5 * 
FROM PRODUCTS
ORDER BY UnitPrice ASC

--11.Muestre el conteo de empleados agrupados por el cargo.
--agrupados por a�o. Ord�nelo por a�o.