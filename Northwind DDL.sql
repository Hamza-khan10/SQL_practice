CREATE DATABASE Northwind;
GO

USE Northwind;
GO

-- Channels
CREATE TABLE channels (
    id INT IDENTITY(1,1) PRIMARY KEY,
    channel_name VARCHAR(100) NOT NULL
);

-- Channels
INSERT INTO channels (channel_name) VALUES
('Online Ads'),
('Social Media'),
('Word of Mouth'),
('Email Campaign');

-- Categories
CREATE TABLE categories (
    category_id INT IDENTITY(1,1) PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL,
    description VARCHAR(255)
);

-- Categories
INSERT INTO categories (category_name, description) VALUES
('Beverages', 'Soft drinks, coffees, teas, beers, and ales'),
('Condiments', 'Sweet and savory sauces, relishes, spreads, and seasonings'),
('Confections', 'Desserts, candies, and sweet breads');


-- Products
CREATE TABLE products (
    product_id INT IDENTITY(1,1) PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category_id INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    discontinued BIT NOT NULL DEFAULT 0,
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

-- Products
INSERT INTO products (product_name, category_id, unit_price, discontinued) VALUES
('Chai Tea', 1, 18.00, 0),
('Chang Beer', 1, 19.00, 0),
('Aniseed Syrup', 2, 10.00, 0),
('Chef Anton''s Cajun Seasoning', 2, 22.00, 0),
('Grandma''s Boysenberry Spread', 2, 25.00, 0),
('Chocolate Biscuits', 3, 12.50, 0),
('Fruit Jelly', 3, 15.00, 0);

-- Customers
CREATE TABLE customers (
    customer_id INT IDENTITY(1,1) PRIMARY KEY,
    email VARCHAR(100) NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    address VARCHAR(200),
    city VARCHAR(100),
    region VARCHAR(100),
    postal_code VARCHAR(20),
    country VARCHAR(100),
    phone VARCHAR(50),
    registration_date DATE NOT NULL,
    channel_id INT,
    first_order_id INT NULL,
    first_order_date DATE NULL,
    last_order_id INT NULL,
    last_order_date DATE NULL,
    FOREIGN KEY (channel_id) REFERENCES channels(id)
);

-- Customers
INSERT INTO customers (email, full_name, address, city, region, postal_code, country, phone, registration_date, channel_id)
VALUES
('john.doe@example.com', 'John Doe', '123 Main St', 'London', 'London', 'SW1A 1AA', 'UK', '+44-123456789', '2023-01-15', 1),
('jane.smith@example.com', 'Jane Smith', '45 High St', 'New York', 'NY', '10001', 'USA', '+1-555-1234', '2023-02-20', 2),
('ali.khan@example.com', 'Ali Khan', '78 Market Rd', 'Karachi', NULL, '74000', 'Pakistan', '+92-3001234567', '2023-03-10', 3),
('maria.garcia@example.com', 'Maria Garcia', '56 Calle Mayor', 'Madrid', 'Madrid', '28001', 'Spain', '+34-600123456', '2023-04-05', 4);


-- Orders
CREATE TABLE orders (
    order_id INT IDENTITY(1,1) PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,
    ship_name VARCHAR(100),
    ship_address VARCHAR(200),
    ship_city VARCHAR(100),
    ship_region VARCHAR(100),
    ship_postalcode VARCHAR(20),
    ship_country VARCHAR(100),
    shipped_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Orders
INSERT INTO orders (customer_id, order_date, total_amount, ship_name, ship_address, ship_city, ship_region, ship_postalcode, ship_country, shipped_date)
VALUES
(1, '2023-05-01', 50.00, 'John Doe', '123 Main St', 'London', 'London', 'SW1A 1AA', 'UK', '2023-05-03'),
(2, '2023-05-10', 85.00, 'Jane Smith', '45 High St', 'New York', 'NY', '10001', 'USA', '2023-05-12'),
(2, '2023-06-15', 30.00, 'Jane Smith', '45 High St', 'New York', 'NY', '10001', 'USA', '2023-06-17'),
(3, '2023-07-01', 40.00, 'Ali Khan', '78 Market Rd', 'Karachi', NULL, '74000', 'Pakistan', '2023-07-03');

-- Order Items
CREATE TABLE order_items (
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL,
    discount DECIMAL(4,2) NOT NULL DEFAULT 0,
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Order Items
INSERT INTO order_items (order_id, product_id, unit_price, quantity, discount) VALUES
(1, 1, 18.00, 2, 0.00),  -- John buys 2 Chai Tea
(1, 6, 12.50, 1, 0.00),  -- John buys 1 Chocolate Biscuits
(2, 2, 19.00, 3, 0.05),  -- Jane buys 3 Chang Beer with discount
(2, 3, 10.00, 2, 0.00),  -- Jane buys 2 Aniseed Syrup
(3, 4, 22.00, 1, 0.00),  -- Jane buys 1 Cajun Seasoning
(4, 5, 25.00, 1, 0.10),  -- Ali buys 1 Boysenberry Spread with 10% discount
(4, 7, 15.00, 2, 0.00);  -- Ali buys 2 Fruit Jelly
