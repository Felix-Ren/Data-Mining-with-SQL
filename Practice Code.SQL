SELECT ret2.customer_country as customer_country, ret2.supplier_country as supplier_country, COUNT(ret2.order_id) as order_ct
FROM
	(SELECT s.Country as supplier_country, s.SupplierName as supplier_name, od.OrderID as order_id, ret1.CustomerName as customer_name, ret1.Country as customer_country
	FROM Suppliers s 
	JOIN Products p 
		on s.SupplierID = p.SupplierID
	JOIN OrderDetails od
		on p.ProductID = od.ProductID
	JOIN (SELECT o.OrderID, c.CustomerName, c.Country 
		  FROM Customers c
		  JOIN Orders o
				on c.CustomerID = o.CustomerID) ret1
		on ret1.OrderID = od.OrderID
	WHERE customer_country = "USA") ret2
GROUP BY supplier_country
ORDER BY order_ct DESC, supplier_country