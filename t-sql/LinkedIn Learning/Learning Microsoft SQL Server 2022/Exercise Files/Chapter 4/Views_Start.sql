-- Review WideWorldImporters order data

SELECT Orders.CustomerID,
	Customers.CustomerName,
	Orders.OrderID,
	OrderLines.OrderLineID,
	OrderLines.StockItemID,
	OrderLines.Description,
	OrderLines.Quantity,
	OrderLines.UnitPrice,
	OrderLines.Quantity * OrderLines.UnitPrice AS ExtendedPrice
FROM Sales.Orders JOIN Sales.OrderLines
	ON Orders.OrderID = OrderLines.OrderID
	JOIN Sales.Customers
	ON Orders.CustomerID = Customers.CustomerID