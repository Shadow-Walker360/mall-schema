\-- Mall Management System Database Schema
\-- Use case: Manage malls, shops, products, employees, customers, and sales in a shopping mall
\-- SQL Dialect: MySQL

\-- =============================================
\-- Drop existing tables if they exist (to reset schema)
\-- =============================================
DROP TABLE IF EXISTS SaleItems;
DROP TABLE IF EXISTS Sales;
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS ShopEmployees;
DROP TABLE IF EXISTS Leases;
DROP TABLE IF EXISTS Shops;
DROP TABLE IF EXISTS Malls;
DROP TABLE IF EXISTS Customers;

\-- =============================================
\-- 1. MALLS Table
\-- Stores information about each mall location
\-- =============================================
CREATE TABLE Malls (
mall\_id INT AUTO\_INCREMENT PRIMARY KEY,         -- unique ID for each mall
name VARCHAR(100) NOT NULL,                     -- name of the mall
location VARCHAR(200) NOT NULL,                 -- physical address or description
opening\_date DATE,                              -- date when the mall opened
UNIQUE KEY uq\_mall\_name (name, location)        -- ensure no duplicate mall entries
) ENGINE=InnoDB;

\-- =============================================
\-- 2. SHOPS Table
\-- Stores individual shops within malls
\-- =============================================
CREATE TABLE Shops (
shop\_id INT AUTO\_INCREMENT PRIMARY KEY,         -- unique ID for each shop
mall\_id INT NOT NULL,                           -- foreign key referencing Malls
name VARCHAR(100) NOT NULL,                     -- shop name
category VARCHAR(50),                           -- e.g., Retail, Food, Services
open\_date DATE,                                 -- date shop started operating
UNIQUE KEY uq\_shop\_per\_mall (mall\_id, name),    -- no two shops with same name in one mall
FOREIGN KEY (mall\_id)                           -- link each shop to its mall
REFERENCES Malls(mall\_id)
ON DELETE CASCADE                          -- delete shops if mall is removed
ON UPDATE CASCADE                          -- propagate mall\_id changes
) ENGINE=InnoDB;

\-- =============================================
\-- 3. LEASES Table
\-- Tracks lease agreements for each shop
\-- =============================================
CREATE TABLE Leases (
lease\_id INT AUTO\_INCREMENT PRIMARY KEY,        -- unique ID for each lease
shop\_id INT NOT NULL,                           -- foreign key referencing Shops
start\_date DATE NOT NULL,                       -- lease start date
end\_date DATE NOT NULL,                         -- lease end date
rent\_amount DECIMAL(10,2) NOT NULL,             -- agreed monthly rent
CONSTRAINT chk\_lease\_dates                      -- ensure valid date range
CHECK (end\_date >= start\_date),
FOREIGN KEY (shop\_id)
REFERENCES Shops(shop\_id)
ON DELETE CASCADE                          -- delete leases if shop is removed
ON UPDATE CASCADE
) ENGINE=InnoDB;

\-- =============================================
\-- 4. ShopEmployees Table
\-- Employees working at specific shops
\-- =============================================
CREATE TABLE ShopEmployees (
employee\_id INT AUTO\_INCREMENT PRIMARY KEY,     -- unique ID for each employee
shop\_id INT NOT NULL,                           -- foreign key to Shops
first\_name VARCHAR(50) NOT NULL,                -- employee first name
last\_name VARCHAR(50) NOT NULL,                 -- employee last name
hire\_date DATE NOT NULL,                        -- date hired
role VARCHAR(50),                               -- job title or role
UNIQUE KEY uq\_employee\_shop (shop\_id, first\_name, last\_name),
FOREIGN KEY (shop\_id)
REFERENCES Shops(shop\_id)
ON DELETE CASCADE                          -- remove employees if shop is removed
ON UPDATE CASCADE
) ENGINE=InnoDB;

\-- =============================================
\-- 5. Products Table
\-- Items offered for sale by shops
\-- =============================================
CREATE TABLE Products (
product\_id INT AUTO\_INCREMENT PRIMARY KEY,      -- unique ID for each product
shop\_id INT NOT NULL,                           -- foreign key to Shops
name VARCHAR(150) NOT NULL,                     -- product name or description
sku VARCHAR(50) NOT NULL UNIQUE,                -- stock keeping unit for inventory
price DECIMAL(10,2) NOT NULL,                   -- unit price
stock INT NOT NULL DEFAULT 0,                   -- current inventory level
CONSTRAINT chk\_stock\_nonnegative                -- ensure no negative inventory
CHECK (stock >= 0),
FOREIGN KEY (shop\_id)
REFERENCES Shops(shop\_id)
ON DELETE CASCADE                          -- remove products if shop is removed
ON UPDATE CASCADE
) ENGINE=InnoDB;

\-- =============================================
\-- 6. Customers Table
\-- Registered shoppers and clients
\-- =============================================
CREATE TABLE Customers (
customer\_id INT AUTO\_INCREMENT PRIMARY KEY,     -- unique ID for each customer
first\_name VARCHAR(50) NOT NULL,                -- customer first name
last\_name VARCHAR(50) NOT NULL,                 -- customer last name
email VARCHAR(100) NOT NULL UNIQUE,             -- contact email
phone VARCHAR(20),                              -- contact number
join\_date DATE NOT NULL DEFAULT CURRENT\_DATE    -- date of registration
) ENGINE=InnoDB;

\-- =============================================
\-- 7. Sales Table
\-- Records each purchase transaction
\-- =============================================
CREATE TABLE Sales (
sale\_id INT AUTO\_INCREMENT PRIMARY KEY,         -- unique ID for each sale
customer\_id INT NOT NULL,                       -- foreign key to Customers
sale\_date DATETIME NOT NULL DEFAULT CURRENT\_TIMESTAMP,  -- date/time of sale
total\_amount DECIMAL(12,2) NOT NULL,            -- total sale value
FOREIGN KEY (customer\_id)
REFERENCES Customers(customer\_id)
ON DELETE RESTRICT                          -- prevent deletion of customer with sales
ON UPDATE CASCADE
) ENGINE=InnoDB;

\-- =============================================
\-- 8. SaleItems Table
\-- Junction table linking sales to products
\-- =============================================
CREATE TABLE SaleItems (
sale\_id INT NOT NULL,                           -- part of composite PK and FK to Sales
product\_id INT NOT NULL,                        -- part of composite PK and FK to Products
quantity INT NOT NULL,                          -- number of units sold
unit\_price DECIMAL(10,2) NOT NULL,              -- price at time of sale
PRIMARY KEY (sale\_id, product\_id),              -- composite key ensures uniqueness
CONSTRAINT chk\_quantity\_positive                -- ensure at least one item sold
CHECK (quantity > 0),
FOREIGN KEY (sale\_id)
REFERENCES Sales(sale\_id)
ON DELETE CASCADE                          -- remove sale items if sale is deleted
ON UPDATE CASCADE,
FOREIGN KEY (product\_id)
REFERENCES Products(product\_id)
ON DELETE RESTRICT                          -- prevent deletion of product that was sold
ON UPDATE CASCADE
) ENGINE=InnoDB;

\-- =============================================
\-- Indexes for Performance Optimization
\-- =============================================
CREATE INDEX idx\_sales\_customer ON Sales(customer\_id, sale\_date);
CREATE INDEX idx\_products\_shop ON Products(shop\_id);

\-- End of Mall Management System Schema
