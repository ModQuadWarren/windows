SELECT OrderLineID,
	Quantity,
	UnitPrice,
	TaxRate,
	Quantity * UnitPrice AS ExtendedPrice,
	Quantity * UnitPrice * (TaxRate/100) AS TaxDue,
	Format (
		(Quantity*UnitPrice) + (Quantity*UnitPrice*(TaxRate/100))
		, 'C')
		AS TotalPrice
FROM Sales.OrderLines;