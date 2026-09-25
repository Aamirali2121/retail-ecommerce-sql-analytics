USE retail_ecommerce;

-- =====================================================
-- ETL: Orders
-- Source      : staging_orders
-- Destination : orders
-- =====================================================

-- Pre-Load QA
SELECT COUNT(*) AS staging_rows FROM staging_orders;
SELECT COUNT(*) AS production_rows FROM orders;

-- Transform & Load
INSERT INTO orders (
    order_id,
    customer_id,
    order_status,
    order_purchase_timestamp,
    order_approved_at,
    order_delivered_carrier_date,
    order_delivered_customer_date,
    order_estimated_delivery_date
)
SELECT
    order_id,
    customer_id,
    order_status,
    STR_TO_DATE(NULLIF(order_purchase_timestamp,''), '%Y-%m-%d %H:%i:%s'),
    STR_TO_DATE(NULLIF(order_approved_at,''), '%Y-%m-%d %H:%i:%s'),
    STR_TO_DATE(NULLIF(order_delivered_carrier_date,''), '%Y-%m-%d %H:%i:%s'),
    STR_TO_DATE(NULLIF(order_delivered_customer_date,''), '%Y-%m-%d %H:%i:%s'),
    STR_TO_DATE(NULLIF(order_estimated_delivery_date,''), '%Y-%m-%d %H:%i:%s')
FROM staging_orders;

-- Validation
SELECT COUNT(*) AS production_rows FROM orders;


-- =====================================================
-- ETL: Products
-- Source      : staging_products
-- Destination : products
-- =====================================================

-- Pre-Load QA
SELECT COUNT(*) AS staging_rows FROM staging_products;
SELECT COUNT(*) AS production_rows FROM products;

-- Transform & Load
INSERT INTO products (
    product_id,
    product_category_name,
    product_name_lenght,
    product_description_lenght,
    product_photos_qty,
    product_weight_g,
    product_length_cm,
    product_height_cm,
    product_width_cm
)
SELECT
    product_id,
    NULLIF(product_category_name,''),
    CAST(NULLIF(product_name_lenght,'') AS SIGNED),
    CAST(NULLIF(product_description_lenght,'') AS SIGNED),
    CAST(NULLIF(product_photos_qty,'') AS SIGNED),
    CAST(NULLIF(product_weight_g,'') AS SIGNED),
    CAST(NULLIF(product_length_cm,'') AS SIGNED),
    CAST(NULLIF(product_height_cm,'') AS SIGNED),
    CAST(NULLIF(product_width_cm,'') AS SIGNED)
FROM staging_products;

-- Validation
SELECT COUNT(*) AS production_rows FROM products;


-- =====================================================
-- ETL: Order Items
-- Source      : staging_order_items
-- Destination : order_items
-- =====================================================

-- Pre-Load QA
SELECT COUNT(*) AS staging_rows FROM staging_order_items;
SELECT COUNT(*) AS production_rows FROM order_items;

-- Transform & Load
INSERT INTO order_items (
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
    CAST(order_item_id AS SIGNED),
    product_id,
    seller_id,
    STR_TO_DATE(shipping_limit_date, '%Y-%m-%d %H:%i:%s'),
    CAST(price AS DECIMAL(10,2)),
    CAST(freight_value AS DECIMAL(10,2))
FROM staging_order_items;

-- Validation
SELECT COUNT(*) AS production_rows FROM order_items;


-- =====================================================
-- ETL: Payments
-- Source      : staging_payments
-- Destination : payments
-- =====================================================

-- Pre-Load QA
SELECT COUNT(*) AS staging_rows FROM staging_payments;
SELECT COUNT(*) AS production_rows FROM payments;

-- Transform & Load
INSERT INTO payments (
    order_id,
    payment_sequential,
    payment_type,
    payment_installments,
    payment_value
)
SELECT
    order_id,
    CAST(payment_sequential AS SIGNED),
    payment_type,
    CAST(payment_installments AS SIGNED),
    CAST(payment_value AS DECIMAL(10,2))
FROM staging_payments;

-- Validation
    SELECT COUNT(*) AS production_rows FROM payments;


-- =====================================================
-- ETL: Reviews
-- Source      : staging_reviews
-- Destination : reviews
-- =====================================================

--  Pre-Load QA
SELECT COUNT(*) AS staging_rows FROM staging_reviews;
SELECT COUNT(*) AS production_rows FROM reviews;

-- Transform & Load
INSERT INTO reviews (
    review_id,
    order_id,
    review_score,
    review_comment_title,
    review_comment_message,
    review_creation_date,
    review_answer_timestamp
)
SELECT
    review_id,
    order_id,
    CAST(review_score AS SIGNED),
    NULLIF(review_comment_title,''),
    NULLIF(review_comment_message,''),
    STR_TO_DATE(review_creation_date, '%Y-%m-%d %H:%i:%s'),
    STR_TO_DATE(review_answer_timestamp, '%Y-%m-%d %H:%i:%s')
FROM staging_reviews;

-- Validation
SELECT COUNT(*) AS production_rows FROM reviews;

-- ======================================================
-- ETL: Sellers
-- Source: staging_sellers
-- Destination: sellers
-- ======================================================

-- Pre-Load QA
SELECT COUNT(*) AS staging_rows FROM staging_sellers;
SELECT COUNT(*) AS production_rows FROM sellers;

-- Transform & Load
insert into sellers(
    seller_id,
    seller_zip_code_prefix,
    seller_city,
    seller_state
)
select
    seller_id,
    cast(seller_zip_code_prefix as signed),
    seller_city,
    seller_state
from staging_sellers;

-- Validation
SELECT COUNT(*) AS production_rows from sellers;