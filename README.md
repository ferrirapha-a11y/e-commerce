# E-commerce Database Project

## Project Description

This project was developed as part of a database modeling challenge focused on creating a logical database schema for an e-commerce system using MySQL.

The main objective was to replicate and refine an EER (Enhanced Entity Relationship) model, implementing primary keys, foreign keys, constraints, and relationship mappings between entities.

The project also includes data insertion scripts and complex SQL queries for data analysis and testing.

---

# Business Rules Implemented

## Clients (PF and PJ)

A client can be:

* PF (Individual Person)
* PJ (Company)

A client cannot be both at the same time.

This rule was implemented using:

* `clients`
* `client_pf`
* `client_pj`

---

## Payments

An order can contain multiple payment methods, such as:

* Credit Card
* Pix
* Bank Slip

This relationship was implemented through the `payment` table.

---

## Delivery System

The delivery system includes:

* Delivery status
* Tracking code

Implemented using the `delivery` table.

---

# Database Structure

The project contains the following main entities:

* Clients
* Individual Clients (PF)
* Company Clients (PJ)
* Products
* Orders
* Payments
* Deliveries
* Suppliers
* Sellers
* Product Storage
* Relationship tables

---

# Technologies Used

* MySQL
* SQL
* MySQL Workbench

---

# Concepts Applied

* Entity Relationship Modeling (ER)
* Primary Keys
* Foreign Keys
* Constraints
* One-to-One Relationships
* One-to-Many Relationships
* Many-to-Many Relationships
* Associative Tables
* SQL Queries
* Data Normalization

---

# SQL Features Demonstrated

The project includes SQL queries using:

* SELECT
* WHERE
* ORDER BY
* HAVING
* JOIN
* Derived Attributes
* Aggregation Functions

---

# Example Queries

Some examples implemented in the project:

* Number of orders made by each client
* Products and suppliers relationship
* Products and storage locations
* Sellers that are also suppliers
* Product total values in orders

