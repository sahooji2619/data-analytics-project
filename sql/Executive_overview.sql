use iet ;
SELECT * FROM iet.datasheet1 as abc;

create view no_of_products as
select count(Product_ID) AS no_of_Products FROM iet.datasheet1 ;

create view inventory_value as
select sum(i.closing_stock*p.Unit_Price) AS inventory_value
FROM iet.inventory_table i
JOIN iet.datasheet1 p 
ON i.product_id = p.product_id;

create view stockout_days as
SELECT count(stockout_flag) AS Stockout_days FROM iet.inventory_table where stockout_flag=1;

create view supplier_delay_percentage as
SELECT 100*SUM(CASE when delivery_date > expected_delivery_date then 1 else 0 end) / count(order_id) AS Supplier_delay from iet.orders_table;

create view revenue_loss as 
SELECT 
    SUM(p.Unit_Price * i.stockout_flag) AS Revenue_loss
FROM iet.inventory_table i
JOIN iet.datasheet1 as p
    ON i.product_id = p.Product_id;

create view avg_lead_time as
SELECT 
    AVG(DATEDIFF(
        STR_TO_DATE(delivery_date, '%Y-%m-%d'),
        STR_TO_DATE(order_date, '%Y-%m-%d')
    )) AS avg_lead_time
FROM iet.orders_table;
