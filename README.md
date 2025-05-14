Mall Management System

A complete Database Management System designed in MySQL to manage malls, shops, products, employees, customers, and sales.

Project Description

This project implements a Mall Management System schema in MySQL. It supports:

Malls: Store mall information and locations.

Shops: Manage shops within each mall, their categories, and lease details.

Lease Tracking: Record lease start/end dates and rent amounts.

Shop Employees: Assign and manage employees per shop.

Product Inventory: Track products (SKU, price, stock) sold by shops.

Customer & Sales: Record customer profiles, sales transactions, and sale items.

All relationships are enforced with appropriate primary keys, foreign keys, unique constraints, and checks for data integrity.

Repository Contents

mall_management_schema.sql — MySQL schema file with all CREATE TABLE statements and constraints.

mall_erd.png — PNG diagram of the Entity-Relationship Diagram.

ERD.md — Mermaid source for the ERD.

README.md — Project overview and setup instructions.

How to Setup & Run

Clone the repository:

git clone https://github.com/<username>/mall-management-system.git
cd mall-management-system

Import schema into MySQL:

mysql -u <user> -p <database_name> < mall_management_schema.sql

Verify tables:

SHOW TABLES;
DESCRIBE Shops;

ERD



Pushing to GitHub

Initialize a new Git repository and commit all files:

git init
git add .
git commit -m "Add Mall Management System schema and ERD"

Create a remote repo on GitHub (e.g., mall-management-system).

Push to GitHub:

git remote add origin https://github.com/<username>/mall-management-system.git
git branch -M main
git push -u origin main
![8e812561-13c0-4f6c-b4ff-a85a6147e5e3](https://github.com/user-attachments/assets/05725333-1c27-432d-9a53-59a4872d0ad4)

Author

collins joshua

This README was generated to accompany the Mall Management System SQL schema and ERD.

