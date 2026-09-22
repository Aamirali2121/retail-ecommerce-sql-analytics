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

-- Creating staging table for products:
CREATE TABLE staging_products (
    product_id VARCHAR(50),
    product_category_name VARCHAR(50),
    product_name_lenght VARCHAR(3),
    product_description_lenght VARCHAR(3),
    product_photos_qty VARCHAR(3),
    product_weight_g VARCHAR(3),
    product_length_cm VARCHAR(3),
    product_height_cm VARCHAR(3),
    product_width_cm VARCHAR(3)
);