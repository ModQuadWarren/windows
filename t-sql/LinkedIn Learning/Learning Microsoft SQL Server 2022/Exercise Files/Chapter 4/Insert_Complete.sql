SELECT *
FROM dbo.Products;

INSERT INTO dbo.Products
	(ProductID, ProductCategory, ProductName, RetailPrice,
	ManufactureCost, QuantityInStock)
VALUES ('EB502', 'EBooks', 'Building Your First Robot', 24.95,
	9.48, 380);