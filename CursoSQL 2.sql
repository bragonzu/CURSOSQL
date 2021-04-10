-- PRIMER EJERCICIO NIVEL-BASICO-INTERMEDIO
-- SQL (DMC-PERU)
-- Bragonzu

-- USAMOS LA BD HR 

--1.Muestre por regi�n la cantidad de empleados asignados
--tabla job_history


WITH CANT_HIST AS(
SELECT employee_id,COUNT(*) AS CANT
FROM job_history
GROUP BY employee_id)
SELECT E.* FROM CANT_HIST C
INNER JOIN employees E ON E.employee_id=C.employee_id
WHERE C.CANT=( 
SELECT MAX(CANT) AS MAXI 
FROM (SELECT COUNT(*) AS CANT
FROM job_history
GROUP BY employee_id)
AS C)

