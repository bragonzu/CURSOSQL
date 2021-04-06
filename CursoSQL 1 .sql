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

--8.Muestre los clientes que tienen la regi�n en blanco (NULA).SELECT * 
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

--11.Muestre el conteo de empleados agrupados por el cargo.SELECT Title, COUNT(*) AS cantidadFROM EmployeesGROUP BY TitleORDER BY 2 desc--12. Muestre los clientes y el total de compras efectuadas.SELECT C.ContactName, COUNT(*) AS TOTALFROM Customers C INNER  JOIN Orders O ON O.CustomerID=C.CustomerIDGROUP BY C.ContactNameORDER BY TOTAL DESC--13.Muestre los 5 clientes que m�s compraron.SELECT TOP 5 C.ContactName, COUNT(*) AS TOTALFROM Customers C INNER  JOIN Orders O ON O.CustomerID=C.CustomerIDGROUP BY C.ContactNameORDER BY TOTAL DESC--14.Muestre los proveedores y la cantidad de productos que se han vendidoSELECT C.CompanyName AS PROVEEDORES,count(quantity) AS CANTIDADFROM [Order Details] as ODINNER JOIN Products P on P.productid=OD.productidINNER JOIN Suppliers C on C.Supplierid=P.SupplieridGROUP BY  C.CompanyNameORDER BY 2 DESC--15.Muestre la cantidad de pedidos y la suma de valorizados (precio por cantidad)
--agrupados por a�o. Ord�nelo por a�o.SELECT DATENAME(YEAR,O.ORDERDATE) AS ANIO,COUNT(QUANTITY) AS CANT_PEDIDOS,SUM(OD.UNITPRICE*OD.QUANTITY) AS SUMA_VALORFROM [ORDER DETAILS]  ODINNER JOIN Orders O on O.OrderID=OD.OrderIDGROUP BY DATENAME(YEAR,O.ORDERDATE)ORDER BY ANIO DESC