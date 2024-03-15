SELECT * 
FROM Sales.SpecialDeals;

UPDATE Sales.SpecialDeals
SET EndDate = '12/31/2023',
	DealDescription = '10% off 2023 for Wingtip'
WHERE SpecialDealID = 1;