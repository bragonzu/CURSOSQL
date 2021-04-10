-- PRIMER EJERCICIO NIVEL-BASICO-INTERMEDIO
-- SQL (DMC-PERU)
-- Bragonzu

-- USAMOS LA BD ADVENTUREWORK2017

--1.Muestre el Total de Ventas agrupadas por años usando PIVOT (tabla
--[Sales].[SalesOrderDetail])


with venta(anio,total) as
(select DATENAME(year, ModifiedDate) as anio,
sum(OrderQty*UnitPrice) as Total_suma 
from [Sales].[SalesOrderDetail] 
group by salesorderID,DATENAME(year, ModifiedDate))
select * from venta
pivot (sum(total)
for anio in ([2011], [2012], [2013], [2014])) as tv


--2. Muestre el promedio del valor total agrupado por descripción del producto (la 
--descripción se encuentra en [Production].[Product])


SELECT PR.Name AS DESCRIPCION, 
AVG(SS.OrderQty*SS.UnitPrice) AS PROMEDIO_VALOR_TOTAL
FROM Production.Product PR
INNER JOIN [Sales].[SalesOrderDetail] SS ON SS.ProductID=PR.ProductID
GROUP BY PR.Name


--3. Muestre el Total de Ventas agrupados por ID del producto usando PIVOT 
--y XML PATH

DECLARE @query VARCHAR(max)
DECLARE @ID VARCHAR(max)
SELECT @ID = STUFF( (select distinct ', [' + CAST(ProductID AS VARCHAR) + ']'
from [Sales].[SalesOrderDetail] order by ', [' + CAST(ProductID AS VARCHAR) + ']'
FOR XML PATH('') ) , 1, 2, '')
SET @query='SELECT * FROM
( select ProductID as ID,sum(UnitPrice*OrderQty) as valor_total from 
[Sales].[SalesOrderDetail] 
GROUP BY ProductID ) src 
PIVOT
( SUM(valor_total)
FOR ID IN (' + @ID + ')
) rpt '
EXECUTE(@query)


--4. Se solicita crear los siguientes campos a partir de la fecha de venta: 
--Año, mes, día, día de la semana, trimestre y la antigüedad de venta.

SELECT YEAR(QUOTADATE) AS ANIO,
DATENAME(MONTH,QUOTADATE) AS MES,
DATENAME(DAY,QUOTADATE) AS DIA,
DATEPART(WEEKDAY,QUOTADATE) AS DIA_SEM,
DATEPART(QUARTER,QUOTADATE) AS TRIMESTRE,
DATEDIFF(YEAR,QUOTADATE,GETDATE()) AS ANIO_ANTIGUEDAD
FROM Sales.SalesPersonQuotaHistory


--5. Convertir en moneda los campos precio unitario y venta total en formato 
--moneda (asumiendo ventas en dólares)

SELECT
'$ ' + CONVERT(VARCHAR, CONVERT(VARCHAR, CAST(UnitPrice AS MONEY), 1)) AS
PRECIO_UNITARIO,
'$ ' + CONVERT(VARCHAR, CONVERT(VARCHAR, CAST(sum(OrderQty*UnitPrice) AS MONEY),
1)) AS VENTA_TOTAL
FROM [Sales].[SalesOrderDetail] 
GROUP BY UnitPrice--6. Crear un campo que indique si se realizó o no seguimiento del pedido (campo 
--[CarrierTrackingNumber])

-------USANDO IIF
SELECT
IIF(CarrierTrackingNumber IS NULL,'SIN SEGUIM. PEDIDO','CON SEGUIM. PEDIDO') AS
SEGUIMIENTO,
* FROM [Sales].[SalesOrderDetail]

-------USANDO CASE WHEN
SELECT
CASE WHEN CarrierTrackingNumber IS NULL THEN 'SIN SEGUIM. PEDIDO'
ELSE 'CON SEGUIM. PEDIDO' END AS SEGUIMIENTO,
* FROM [Sales].[SalesOrderDetail]


--7. Especifique los productos que fueron vendidos en el año 2012,2013 (Usando 
--INTERSECT). Muestre nombre de producto y cantidad en orden descendente por 
--cantidad.

--SELECT * from [Production].[Product]

--select * from [Sales].[SalesOrderDetail]

select Name as NOMBRE_PROD,
SafetyStockLevel as CANTIDAD_STOCK,
ListPrice as PRECIO_UNITARIO
from [Production].[Product]
where ProductID 
in (select ProductID
from [Production].[Product]
INTERSECT
select ProductID from
[Sales].[SalesOrderDetail]
where DATENAME(Year,ModifiedDate) in ('2012','2013'))
order by CANTIDAD_STOCK desc

--Especifique los productos que no fueron vendidos en el año 2012 y 2013 (Usando 
--EXCEPT). Muéstrelos en orden alfabético
select Name as NOMBRE_PROD,
SafetyStockLevel as CANTIDAD_STOCK,
ListPrice as PRECIO_UNITARIO
from [Production].[Product]
where ProductID 
in (select ProductID
from [Production].[Product]
EXCEPT
select ProductID from
[Sales].[SalesOrderDetail]
where DATENAME(Year,ModifiedDate) in ('2012','2013'))
order by NOMBRE_PROD