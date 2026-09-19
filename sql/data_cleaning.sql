-- ==========================
-- DATA QUALITY AUDIT
-- ==========================
-- QA Check 1
SELECT COUNT(*) FROM staging_orders;

-- QA Check 2
SELECT COUNT(*) FROM orders;

-- QA Check 3
SELECT COUNT(*) FROM customers;
USE retail_ecommerce;

-- =====================================================
-- ETL: Orders
-- Source      : staging_orders
-- Destination : orders
-- Purpose     : Convert VARCHAR timestamps to DATETIME
-- =====================================================

insert into orders(
    order_id,
    customer_id,
    order_status,
    order_purchase_timestamp,
    order_approved_at,
    order_delivered_carrier_date,
    order_delivered_customer_date,
    order_estimated_delivery_date)
select
	order_id,
    customer_id,
    order_status,
    str_to_date(nullif(order_purchase_timestamp,''),
    '%Y-%m-%d %H:%i:%s'),
    str_to_date(nullif(order_approved_at,''),
    '%Y-%m-%d %H:%i:%s'),
	str_to_date(nullif(order_delivered_carrier_date,''),
    '%Y-%m-%d %H:%i:%s'),
    str_to_date(nullif(order_delivered_customer_date,''),
    '%Y-%m-%d %H:%i:%s'),
    str_to_date(nullif(order_estimated_delivery_date,''),
    '%Y-%m-%d %H:%i:%s')
From staging_orders;

-- Validation: Check the number of rows after the ETL porcess
select count(*) as production_rows 
from orders;


-- =====================================================
-- ETL: Order Items
-- Source      : staging_order_items
-- Destination : order_items
-- Purpose    : Convert VARCHAR to DECIMAL
-- =====================================================

-- QA
SELECT COUNT(*) FROM staging_order_items;
SELECT COUNT(*) FROM order_items;

INSERT INTO order_items(
        order_id,
    order_item_id,
    product_id,
    seller_id,
    shipping_limit_date,
    price,
    freight_value
)
SELECT 
    order_id,
    cast(order_item_id as signed),
    product_id,
    seller_id,
    str_to_date(nullif(shipping_limit_date,''),'%Y-%m-%d %H:%i:%s'),
    CAST(price AS DECIMAL(10,2)),
    CAST(freight_value AS DECIMAL(10,2))
FROM staging_order_items;



-- Validation
SELECT COUNT(*) FROM order_items;