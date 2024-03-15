SELECT StockItemID,
	StockItemName,
	SupplierID
FROM Warehouse.StockItems;

SELECT SupplierID,
	SupplierName,
	PhoneNumber
FROM Purchasing.Suppliers;

SELECT StockItems.StockItemID,
	StockItems.StockItemName,
	StockItems.SupplierID,
	Suppliers.SupplierName,
	Suppliers.PhoneNumber
FROM Warehouse.StockItems JOIN Purchasing.Suppliers
	ON StockItems.SupplierID = Suppliers.SupplierID;