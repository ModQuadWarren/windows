-- Limit results with TOP --
SELECT TaxRate, Name
FROM Sales.SalesTaxRate;

-- select top x results;
SELECT TOP (3) TaxRate, Name -- Paratheses optional --
FROM Sales.SalesTaxRate
ORDER BY TaxRate;

-- OR --
SELECT TOP 50 PERCENT TaxRate, Name
FROM Sales.SalesTaxRate
ORDER BY TaxRate;

-- Return rows, including ones that may have the same value
SELECT TOP 50 WITH TIES TaxRate, Name
FROM Sales.SalesTaxRate
ORDER BY TaxRate;

-- Order by tax rate (Descending)
SELECT TOP 3 TaxRate, Name
FROM Sales.SalesTaxRate
ORDER BY TaxRate DESC;

-- Order by tax rate (Ascending)
SELECT TOP 3 TaxRate, Name
FROM Sales.SalesTaxRate
ORDER BY TaxRate ASC;

-- remove duplicates rows with DISTINCT --
-- List all cities
Select City
FROM Person.Address

-- remove duplicate rows (caution: this could remove records with the same name in diferent states)
SELECT DISTINCT City
FROM Person.Address
ORDER BY City;

-- to address this add more DISTINCT filters. results will quey all rows in the SELECT statement
SELECT DISTINCT City, StateProvinceID
FROM Person.Address
ORDER BY City;

/* Comparison operators (Standard)
=	Equal to
<>	Not equal to
>	Greater than
<	Less than
>=	Greater than or equal to
<=	Less than or equal to

Non-Standard Operators
!=	Not equal to
!<	Not less than
!>	Not greater than*/

-- base query
SELECT Name, TaxRate
FROM Sales.SalesTaxRate;

-- show specific (numerical) rows
SELECT Name, TaxRate
FROM Sales.SalesTaxRate
WHERE TaxRate = 7.25;

-- change the comparison operator examples
SELECT Name, TaxRate
FROM Sales.SalesTaxRate
WHERE TaxRate >= 7.25;

-- range
SELECT Name, TaxRate
FROM Sales.SalesTaxRate
WHERE (TaxRate >= 7) AND (TaxRate <= 10);

-- NULL values
