-- PRIMER EJERCICIO NIVEL-BASICO-INTERMEDIO
-- SQL (DMC-PERU)
-- Bragonzu

-- USAMOS LA BD HR 

--1.Muestre por región la cantidad de empleados asignadosSELECT R.REGION_NAME AS REGION,COUNT(*) AS CANT_EMPLEADOSFROM employees EINNER JOIN departments D ON D.department_id=E.department_idINNER JOIN locations L ON L.location_id=D.location_idINNER JOIN countries C ON C.country_id=L.country_idINNER JOIN regions R ON R.region_id=C.region_idGROUP BY  R.REGION_NAME--2.Muestre la cantidad de empleados por departamentoSELECT D.department_name AS DEPARTAMENTO,COUNT(*) AS CANT_EMPLEADOSFROM employees EINNER JOIN departments D ON D.department_id=E.department_idGROUP BY D.department_name--3.Muestre los departamentos que no tienen asignados empleadosSELECT department_name AS DEPARTAMENTOFROM departmentsWHERE department_id NOT IN (SELECT E.department_id FROM employees EINNER JOIN departments D ON D.department_id=E.department_id)--4. Muestre los 5 empleados con mayor antigüedad en la empresaSELECT TOP 5 first_name AS EMPLEADO,DATEDIFF(YYYY,hire_date,GETDATE()) AS TIEMPOFROM employeesORDER BY 2 DESC--5. Muestre los datos de los empleados que tiene la mayor cantidad de registros en la 
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


