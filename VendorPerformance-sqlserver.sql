SELECT 
	purchaseorderheader.PurchaseOrderID,
	purchaseorderheader.Status,
	purchaseorderheader.OrderDate,
	purchaseorderheader.ShipDate,
	purchaseorderheader.Subtotal,
	purchaseorderheader.VendorID,
	purchaseorderheader.Freight,
	vendor.Name AS Vendor,
	vendor.CreditRating,
	purchaseorderdetail.DueDate,
	shipmethod.Name AS ShipMethod,
	shipmethod.ShipBase,
	shipmethod.ShipRate,
	productvendor.AverageLeadTime
FROM Adventureworks2005.dbo.purchaseorderheader AS purchaseorderheader
JOIN Adventureworks2005.dbo.vendor AS vendor
	ON purchaseorderheader.VendorID = vendor.VendorID
JOIN Adventureworks2005.dbo.shipmethod AS shipmethod
	ON purchaseorderheader.ShipMethodID = shipmethod.ShipMethodID
JOIN 
		(SELECT DISTINCT PurchaseOrderID, DueDate
		FROM Adventureworks2005.dbo.purchaseorderdetail) AS purchaseorderdetail
	ON purchaseorderdetail.PurchaseOrderID = purchaseorderheader.PurchaseOrderID
JOIN 
		(SELECT DISTINCT VendorID, AverageLeadTime
		FROM Adventureworks2005.dbo.productvendor) AS productvendor
	ON purchaseorderheader.VendorID = productvendor.VendorID


SELECT 
	purchaseorderheader.PurchaseOrderID,
	purchaseorderheader.OrderDate,
	purchaseorderheader.Subtotal,
	vendor.Name AS Vendor,
	purchaseorderdetail.TotalOrderQty,
	purchaseorderdetail.TotalReceivedQty,
	purchaseorderdetail.TotalRejectedQty	
FROM Adventureworks2005.dbo.purchaseorderheader AS purchaseorderheader
JOIN (SELECT DISTINCT PurchaseOrderID,
					SUM(OrderQty) AS TotalOrderQty,
					SUM(ReceivedQty) AS TotalReceivedQty,
					SUM(RejectedQty) AS TotalRejectedQty
		FROM Adventureworks2005.dbo.purchaseorderdetail
		GROUP BY PurchaseOrderID) AS purchaseorderdetail
ON purchaseorderdetail.PurchaseOrderID = purchaseorderheader.PurchaseOrderID
JOIN Adventureworks2005.dbo.vendor AS vendor
	ON purchaseorderheader.VendorID = vendor.VendorID



SELECT 
	purchaseorderheader.PurchaseOrderID,
	purchaseorderheader.OrderDate,
	vendor.Name AS Vendor,
	vendor.CreditRating,
	vendor.PreferredVendorStatus
FROM Adventureworks2005.dbo.purchaseorderheader AS purchaseorderheader
JOIN Adventureworks2005.dbo.vendor AS vendor
	ON purchaseorderheader.VendorID = vendor.VendorID
