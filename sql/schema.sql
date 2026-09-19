-- Create databse retail_ecommerce

CREATE DATABASE retail_ecommerce;

-- USE retail_ecommerce;

USE retail_ecommerce;

-- Create table customers
create table customers(
	customer_id varchar(50) primary key,
    customer_unique_id varchar(50),
    customer_zip_code_prefix int,
    customer_city varchar(50),
    customer_state varchar(2)
    );

-- Create orders table
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

-- Create table order_items:
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

-- Create table products
create table products(
			customer_id varchar(50) primary key,
            customer_unique_id varchar(50),
            customer_zip_code_prefix int,
            customer_city varchar(100),
            customer_state varchar(2)
            );