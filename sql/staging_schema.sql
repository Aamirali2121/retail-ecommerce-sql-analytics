USE retail_ecommerce;
-- Create  table staging_orders
CREATE TABLE staging_orders (
    order_id VARCHAR(50),
    customer_id VARCHAR(50),
    order_status VARCHAR(20),
    order_purchase_timestamp VARCHAR(30),
    order_approved_at VARCHAR(30),
    order_delivered_carrier_date VARCHAR(30),
    order_delivered_customer_date VARCHAR(30),
    order_estimated_delivery_date VARCHAR(30)
);

-- Create staging table for order_items
CREATE TABLE staging_order_items(
    order_id varchar(50),
    order_item_id varchar(10),
    product_id varchar(50),
    seller_id varchar(50),
    shipping_limit_date varchar(50),
    price varchar(10),
    freight_value varchar(10)
);