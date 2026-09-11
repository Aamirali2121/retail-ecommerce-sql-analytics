/*========================
PROJECT: RETAIL ECOMMERCE SALES ANALYTICS
Author: Aamirali Contractor
Database: retail_ecommerce

Description:
Relatioal database for analyzing customers, products,
 orders, payments, and returns for an online retailer.
 ========================*/

 -- Create the database
 CREATE DATABASE IF NOT EXISTS retail_ecommerce;

-- Use the database
 USE retail_ecommerce;

-- Create the customers table
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(150),
    phone VARCHAR(20),
    city VARCHAR(50),
    signup_date DATE
);

-- Create the products table
CREATE TABLE products (
    product_id int AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) not null,
    brand VARCHAR(50),
    category VARCHAR(50),
    cost_price DECIMAL(10, 2),
    selling_price DECIMAL(10, 2)
);

-- Create the orders table
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATE NOT NULL,
    status VARCHAR(20),
    shipping_city VARCHAR(50),

    FOREIGN KEY (customer_id)
     REFERENCES customers(customer_id)
);

-- Create the order_items table
CREATE TABLE(
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    selling_price DECIMAL(10,2) NOT NULL,
    discount_percent DECIMAL(5,2),

    FOREIGN KEY (order_id) 
    REFERENCES orders(order_id),

    FOREIGN KEY (product_id)
    REFERENCES products(product_id)
);