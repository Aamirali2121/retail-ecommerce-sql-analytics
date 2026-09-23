create database retail_ecommerce;

use retail_ecommerce;

create table customers(
			customer_id varchar(50) primary key,
            customer_unique_id varchar(50),
            customer_zip_code_prefix int,
            customer_city varchar(100),
            customer_state varchar(2)
            );
drop table products;
SET GLOBAL local_infile = 1;

SHOW GLOBAL VARIABLES LIKE 'local_infile';
LOAD DATA LOCAL INFILE 'C:/Users/aamir/OneDrive/Desktop/Projects/retail-ecommerce-sql-analytics/data/olist_orders_dataset.csv'
INTO TABLE orders
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
  order_id,
  customer_id,
  order_status,
  order_purchase_timestamp,
  order_approved_at,
  order_delivered_carrier_date,
  order_delivered_customer_date,
  order_estimated_delivery_date
);


SET GLOBAL local_infile = 1;
SHOW GLOBAL VARIABLES LIKE 'local_infile';

use retail_ecommerce;

drop table orders;

create table staging_orders(
order_id varchar(50),
customer_id varchar(50),
order_status varchar(30),
order_purchase_timestamp varchar(30),
order_approved_at varchar(30),
order_delivered_carrier_date varchar(30),
order_delivered_customer_date varchar(30),
order_estimated_delivery_date varchar(30)
);

CREATE TABLE orders (
    order_id VARCHAR(50) PRIMARY KEY,
    customer_id VARCHAR(50) NOT NULL,
    order_status VARCHAR(20) NOT NULL,
    order_purchase_timestamp DATETIME NOT NULL,
    order_approved_at DATETIME,
    order_delivered_carrier_date DATETIME,
    order_delivered_customer_date DATETIME,
    order_estimated_delivery_date DATETIME,

    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
);

select* from staging_orders;

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

SELECT COUNT(*) AS production_rows
FROM orders;

CREATE TABLE staging_order_items(
    order_id varchar(50),
    order_item_id varchar(10),
    product_id varchar(50),
    seller_id varchar(50),
    shipping_limit_date varchar(50),
    price varchar(10),
    freight_value varchar(10)
);

LOAD DATA LOCAL INFILE 'C:/Users/aamir/OneDrive/Desktop/Projects/retail-ecommerce-sql-analytics/data/olist_order_items_dataset.csv'
INTO TABLE staging_orders
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

CREATE TABLE order_items(
    order_id varchar(50) NOT NULL,
    order_item_id int not null,
    product_id varchar(50) not null,
    seller_id varchar(50) not null,
    shipping_limit_date datetime,
    price decimal(10,2),
    freight_value decimal(10,2),

    PRIMARY KEY (order_id, order_item_id),

    foreign key(order_id)
    references orders(order_id),

    foreign key(product_id)
    references products(product_id)
);
select count(*) from order_items;

CREATE TABLE products (
    product_id VARCHAR(50) PRIMARY KEY,
    product_category_name VARCHAR(50),
    product_name_lenght INT,
    product_description_lenght INT,
    product_photos_qty INT,
    product_weight_g INT,
    product_length_cm INT,
    product_height_cm INT,
    product_width_cm INT
);

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

insert into products(
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
select 
    product_id,
    nullif(product_category_name,''),
    cast(nullif(product_name_lenght, '') as signed),
    cast(nullif(product_description_lenght, '') as signed),
    cast(nullif(product_photos_qty,'') as signed),
    cast(nullif(product_weight_g,'') as signed),
    cast(nullif(product_length_cm,'') as signed),
    cast(nullif(product_height_cm,'') as signed),
    cast(nullif(product_width_cm,'') as signed)
FROM staging_products;

select * from products;

CREATE TABLE order_items(
    order_id varchar(50) NOT NULL,
    order_item_id int not null,
    product_id varchar(50) not null,
    seller_id varchar(50) not null,
    shipping_limit_date datetime not null,
    price decimal(10,2) not null,
    freight_value decimal(10,2) not null,

    PRIMARY KEY (order_id, order_item_id),

    foreign key(order_id)
    references orders(order_id),

    foreign key(product_id)
    references products(product_id)
);

select count(*) from order_items;

insert into order_items(
	order_id,
	order_item_id,
	product_id,
	seller_id,
	shipping_limit_date,
	price,
	freight_value
)
select 
	order_id,
	cast(order_item_id as signed),
	product_id,
	seller_id,
	str_to_date(shipping_limit_date, '%Y-%m-%d %H:%i:%s'),
	cast(price as decimal(10,2)),
	cast(freight_value as decimal(10,2))
    FROM staging_order_items;
    
select count(*) from order_items;