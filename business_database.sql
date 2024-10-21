-- CS4400: Introduction to Database Systems (Fall 2024)
-- Phase II: Create Table & Insert Statements [v0] Monday, September 15, 2024 @ 17:00 EST

-- Team __
-- Lauren Ji (lji41)
-- Khoa Duy Do (kdo60)
-- Thaneesh Babu Krishnasamy (tkrishnasamy3)
-- Aakash Gupta (agupta3118)

-- Directions:
-- Please follow all instructions for Phase II as listed on Canvas.
-- Fill in the team number and names and GT usernames for all members above.
-- Create Table statements must be manually written, not taken from an SQL Dump file.
-- This file must run without error for credit.

/* This is a standard preamble for most of our scripts.  The intent is to establish
a consistent environment for the database behavior. */
set global transaction isolation level serializable;
set global SQL_MODE = 'ANSI,TRADITIONAL';
set names utf8mb4;
set SQL_SAFE_UPDATES = 0;

set @thisDatabase = 'business_supply';
drop database if exists business_supply;
create database if not exists business_supply;
use business_supply;

-- Define the database structures
/* You must enter your tables definitions, along with your primary, unique and foreign key
declarations, and data insertion statements here.  You may sequence them in any order that
works for you.  When executed, your statements must create a functional database that contains
all of the data, and supports as many of the constraints as reasonably possible. */

CREATE TABLE User ( 
	username varchar(40) NOT NULL, 
	address varchar(500) NOT NULL, 
	birthdate date NOT NULL, 
	first_name varchar(100) NOT NULL, 
	last_name varchar(100) NOT NULL, 
	PRIMARY KEY (username) 
);

CREATE TABLE Employee ( 
	taxID varchar(11) NOT NULL,
	username varchar(40) NOT NULL,
	experience int NOT NULL,
	hired date NOT NULL,
	salary float NOT NULL,
	PRIMARY KEY (taxID),
	FOREIGN KEY (username) REFERENCES User(username)
);

CREATE TABLE Owner (
	username varchar(40) NOT NULL,
	PRIMARY KEY (username),
	FOREIGN KEY (username) REFERENCES User(username)
);

CREATE TABLE Location (
	label varchar(100) NOT NULL,
	x_coord int NOT NULL,
	y_coord int NOT NULL,
	space int,
	PRIMARY KEY (label)
);

CREATE TABLE Service (
	id varchar(40) NOT NULL, 
	name varchar(100) NOT NULL, 
	locationLabel varchar(100) NOT NULL,
	PRIMARY KEY (id),
	FOREIGN KEY (locationLabel) REFERENCES Location(label)
	
);

CREATE TABLE Worker ( 
	taxID varchar(11),
	managedServiceID varchar(3),	
	PRIMARY KEY (taxID),
	FOREIGN KEY (taxID) REFERENCES Employee(taxID),
	FOREIGN KEY (managedServiceID) REFERENCES Service(id)
);

CREATE TABLE Driver (
	licenseID int NOT NULL,
	taxID varchar(11) NOT NULL,
	license_type varchar(100) NOT NULL,
	successful_trips int NOT NULL,
	PRIMARY KEY (licenseID),
	FOREIGN KEY (taxID) REFERENCES employee(taxID)
);

CREATE TABLE Van (
	tag int NOT NULL,
	serviceID varchar(40) NOT NULL, 
	fuel float,
	capacity float,
	sales float,
	DLID int,
	location varchar(100),
	PRIMARY KEY (tag, serviceID),
	FOREIGN KEY (serviceID) REFERENCES Service(id),
	FOREIGN KEY (DLID) REFERENCES Driver(licenseID),
	FOREIGN KEY (location) REFERENCES Location(label)
);

CREATE TABLE Business (
	name varchar(100) NOT NULL, 
	spent float NOT NULL,
	rating int NOT NULL,
	locationLabel varchar(100) NOT NULL,
	PRIMARY KEY (name),
	FOREIGN KEY (locationLabel) REFERENCES Location(label)
);

CREATE TABLE Product (
	barcode varchar(40),
	iname varchar(100),
	weight int,
	PRIMARY KEY (barcode)
);

CREATE TABLE Contain (
	serviceID varchar(40) NOT NULL,
	tag int NOT NULL,
	productBarcode varchar(100) NOT NULL,
	price int,
	quantity int,
	PRIMARY KEY (serviceID, tag, productBarcode),
	FOREIGN KEY (tag, serviceID) REFERENCES Van(tag, serviceID), 
	FOREIGN KEY (productBarcode) REFERENCES Product(barcode)
);

CREATE TABLE Work_for (
	worker VARCHAR(11) NOT NULL,	
    service VARCHAR(3) NOT NULL,
    PRIMARY KEY (worker, service),
    FOREIGN KEY (worker) REFERENCES Worker(taxID),
    FOREIGN KEY (service) REFERENCES Service(id)
);

CREATE TABLE Fund (
	owner varchar(100) NOT NULL,
	business varchar(100) NOT NULL,
    invested float,
    date date,
	PRIMARY KEY (owner, business),
	FOREIGN KEY (owner) REFERENCES Owner(username),
	FOREIGN KEY (business) REFERENCES Business(name)
);


INSERT INTO User (username, address, birthdate, first_name, last_name) VALUES ('agarcia7', '710 Living Water Drive', '1966-10-29', 'Alejandro', 'Garcia');
INSERT INTO User (username, address, birthdate, first_name, last_name) VALUES ('awilson5', '220 Peachtree Street', '1963-11-11', 'Aaron', 'Wilson');
INSERT INTO User (username, address, birthdate, first_name, last_name) VALUES ('bsummers4', '5105 Dragon Star Circle', '1976-02-09', 'Brie', 'Summers');
INSERT INTO User (username, address, birthdate, first_name, last_name) VALUES ('cjordan5', '77 Infinite Stars Road', '1966-06-05', 'Clark', 'Jordan');
INSERT INTO User (username, address, birthdate, first_name, last_name) VALUES ('ckann5', '64 Knights Square Trail', '1972-09-01', 'Carrot', 'Kann');
INSERT INTO User (username, address, birthdate, first_name, last_name) VALUES ('csoares8', '706 Living Stone Way', '1965-09-03', 'Claire', 'Soares');
INSERT INTO User (username, address, birthdate, first_name, last_name) VALUES ('echarles19', '22 Peachtree Street', '1974-05-06', 'Ella', 'Charles');
INSERT INTO User (username, address, birthdate, first_name, last_name) VALUES ('eross10', '22 Peachtree Street', '1975-04-02', 'Erica', 'Ross');
INSERT INTO User (username, address, birthdate, first_name, last_name) VALUES ('fprefontaine6', '10 Hitch Hikers Lane', '1961-01-28', 'Ford', 'Prefontaine');
INSERT INTO User (username, address, birthdate, first_name, last_name) VALUES ('hstark16', '53 Tanker Top Lane', '1971-10-27', 'Harmon', 'Stark');
INSERT INTO User (username, address, birthdate, first_name, last_name) VALUES ('jstone5', '101 Five Finger Way', '1961-01-06', 'Jared', 'Stone');
INSERT INTO User (username, address, birthdate, first_name, last_name) VALUES ('lrodriguez5', '360 Corkscrew Circle', '1975-04-02', 'Lina', 'Rodriguez');
INSERT INTO User (username, address, birthdate, first_name, last_name) VALUES ('mrobot1', '10 Autonomy Trace', '1988-11-02', 'Mister', 'Robot');
INSERT INTO User (username, address, birthdate, first_name, last_name) VALUES ('mrobot2', '10 Clone Me Circle', '1988-11-02', 'Mister', 'Robot');
INSERT INTO User (username, address, birthdate, first_name, last_name) VALUES ('rlopez6', '8 Queens Route', '1999-09-03', 'Radish', 'Lopez');
INSERT INTO User (username, address, birthdate, first_name, last_name) VALUES ('sprince6', '22 Peachtree Street', '1968-06-15', 'Sarah', 'Prince');
INSERT INTO User (username, address, birthdate, first_name, last_name) VALUES ('tmccall5', '360 Corkscrew Circle', '1973-03-19', 'Trey', 'McCall');

INSERT INTO Employee (taxID, username, experience, hired, salary) VALUES ('999-99-9999', 'agarcia7', 24, '2019-03-17', 41000);
INSERT INTO Employee (taxID, username, experience, hired, salary) VALUES ('111-11-1111', 'awilson5', 9, '2020-03-15', 46000);
INSERT INTO Employee (taxID, username, experience, hired, salary) VALUES ('000-00-0000', 'bsummers4', 17, '2018-12-06', 35000);
INSERT INTO Employee (taxID, username, experience, hired, salary) VALUES ('640-81-2357', 'ckann5', 27, '2019-08-03', 46000);
INSERT INTO Employee (taxID, username, experience, hired, salary) VALUES ('888-88-8888', 'csoares8', 26, '2019-02-25', 57000);
INSERT INTO Employee (taxID, username, experience, hired, salary) VALUES ('777-77-7777', 'echarles19', 3, '2021-01-02', 27000);
INSERT INTO Employee (taxID, username, experience, hired, salary) VALUES ('444-44-4444', 'eross10', 10, '2020-04-17', 61000);
INSERT INTO Employee (taxID, username, experience, hired, salary) VALUES ('121-21-2121', 'fprefontaine6', 5, '2020-04-19', 20000);
INSERT INTO Employee (taxID, username, experience, hired, salary) VALUES ('555-55-5555', 'hstark16', 20, '2018-07-23', 59000);
INSERT INTO Employee (taxID, username, experience, hired, salary) VALUES ('222-22-2222', 'lrodriguez5', 20, '2019-04-15', 58000);
INSERT INTO Employee (taxID, username, experience, hired, salary) VALUES ('101-01-0101', 'mrobot1', 8, '2015-05-27', 38000);
INSERT INTO Employee (taxID, username, experience, hired, salary) VALUES ('010-10-1010', 'mrobot2', 8, '2015-05-27', 38000);
INSERT INTO Employee (taxID, username, experience, hired, salary) VALUES ('123-58-1321', 'rlopez6', 51, '2017-02-05', 64000);
INSERT INTO Employee (taxID, username, experience, hired, salary) VALUES ('333-33-3333', 'tmccall5', 29, '2018-10-17', 33000);

INSERT INTO Owner (username) VALUES ('cjordan5');
INSERT INTO Owner (username) VALUES ('jstone5');
INSERT INTO Owner (username) VALUES ('sprince6');

INSERT INTO Location (label, x_coord, y_coord, space) VALUES ('southside', 1, -16, 5);
INSERT INTO Location (label, x_coord, y_coord, space) VALUES ('buckhead', 7, 10, 8);
INSERT INTO Location (label, x_coord, y_coord, space) VALUES ('airport', 5, -6, 15);
INSERT INTO Location (label, x_coord, y_coord, space) VALUES ('plaza', -4, -3, 10);
INSERT INTO Location (label, x_coord, y_coord, space) VALUES ('avalon', 2, 15, 12);
INSERT INTO Location (label, x_coord, y_coord, space) VALUES ('highpoint', 11, 3, 4);
INSERT INTO Location (label, x_coord, y_coord, space) VALUES ('downtown', -4, -3, 10);
INSERT INTO Location (label, x_coord, y_coord, space) VALUES ('springs', 7, 10, 8);
INSERT INTO Location (label, x_coord, y_coord, space) VALUES ('mercedes', -8, 5, NULL);
INSERT INTO Location (label, x_coord, y_coord, space) VALUES ('highlands', 2, 1, 7);
INSERT INTO Location (label, x_coord, y_coord, space) VALUES ('midtown', 2, 1, 7);

INSERT INTO Service (id, name, locationLabel) VALUES ('mbm', 'Metro Business Movers', 'southside');
INSERT INTO Service (id, name, locationLabel) VALUES ('lcc', 'Local Commerce Couriers', 'plaza');
INSERT INTO Service (id, name, locationLabel) VALUES ('pbl', 'Pro Business Logistics', 'avalon');

INSERT INTO Worker (taxID, managedServiceID) VALUES ('640-81-2357', 'mbm');
INSERT INTO Worker (taxID, managedServiceID) VALUES ('777-77-7777', 'pbl');
INSERT INTO Worker (taxID, managedServiceID) VALUES ('444-44-4444', 'lcc');
INSERT INTO Worker (taxID, managedServiceID) VALUES ('555-55-5555', 'mbm');
INSERT INTO Worker (taxID, managedServiceID) VALUES ('333-33-3333', 'mbm');
INSERT INTO Worker (taxID, managedServiceID) VALUES ('010-10-1010', 'pbl');

INSERT INTO Driver (licenseID, taxID, license_type, successful_trips) VALUES (610623, '999-99-9999', 'CDL', 38);
INSERT INTO Driver (licenseID, taxID, license_type, successful_trips) VALUES (314159, '111-11-1111', 'commercial', 41);
INSERT INTO Driver (licenseID, taxID, license_type, successful_trips) VALUES (411911, '000-00-0000', 'private', 35);
INSERT INTO Driver (licenseID, taxID, license_type, successful_trips) VALUES (343563, '888-88-8888', 'commercial', 7);
INSERT INTO Driver (licenseID, taxID, license_type, successful_trips) VALUES (657483, '121-21-2121', 'private', 2);
INSERT INTO Driver (licenseID, taxID, license_type, successful_trips) VALUES (287182, '222-22-2222', 'CDL', 67);
INSERT INTO Driver (licenseID, taxID, license_type, successful_trips) VALUES (101010, '101-01-0101', 'CDL', 18);
INSERT INTO Driver (licenseID, taxID, license_type, successful_trips) VALUES (235711, '123-58-1321', 'private', 58);

INSERT INTO Van (tag, serviceID, fuel, capacity, sales, DLID, location) VALUES (1, 'mbm', 100, 6, 0, 657483, 'southside');
INSERT INTO Van (tag, serviceID, fuel, capacity, sales, DLID, location) VALUES (5, 'mbm', 27, 7, 100, 657483, 'buckhead'); 
INSERT INTO Van (tag, serviceID, fuel, capacity, sales, DLID, location) VALUES (8, 'mbm', 100, 8, 0, 411911, 'southside');
INSERT INTO Van (tag, serviceID, fuel, capacity, sales, DLID, location) VALUES (11, 'mbm', 25, 10, 0, NULL, 'buckhead');
INSERT INTO Van (tag, serviceID, fuel, capacity, sales, DLID, location) VALUES (16, 'mbm', 17, 5, 40, 657483, 'buckhead'); 
INSERT INTO Van (tag, serviceID, fuel, capacity, sales, DLID, location) VALUES (1, 'lcc', 100, 9, 0, 314159, 'airport');
INSERT INTO Van (tag, serviceID, fuel, capacity, sales, DLID, location) VALUES (2, 'lcc', 75, 7, 0, NULL, 'airport');
INSERT INTO Van (tag, serviceID, fuel, capacity, sales, DLID, location) VALUES (3, 'pbl', 100, 5, 50, 610623, 'avalon'); 
INSERT INTO Van (tag, serviceID, fuel, capacity, sales, DLID, location) VALUES (7, 'pbl', 53, 5, 100, 610623, 'avalon');
INSERT INTO Van (tag, serviceID, fuel, capacity, sales, DLID, location) VALUES (8, 'pbl', 100, 6, 0, 610623, 'highpoint'); 
INSERT INTO Van (tag, serviceID, fuel, capacity, sales, DLID, location) VALUES (11, 'pbl', 90, 6, 0, NULL, 'highpoint');

INSERT INTO Business (name, spent, rating, locationLabel) VALUES ('Aircraft Electrical Svc', 10, 5, 'airport');
INSERT INTO Business (name, spent, rating, locationLabel) VALUES ('Homestead Insurance', 30, 5, 'downtown');
INSERT INTO Business (name, spent, rating, locationLabel) VALUES ('Jones and Associates', 0, 3, 'springs');
INSERT INTO Business (name, spent, rating, locationLabel) VALUES ('Prime Solutions', 30, 4, 'buckhead');
INSERT INTO Business (name, spent, rating, locationLabel) VALUES ('Innovative Ventures', 0, 4, 'avalon');
INSERT INTO Business (name, spent, rating, locationLabel) VALUES ('Blue Horizon Enterprises', 10, 4, 'mercedes');
INSERT INTO Business (name, spent, rating, locationLabel) VALUES ('Peak Performance Group', 20, 5, 'highlands');
INSERT INTO Business (name, spent, rating, locationLabel) VALUES ('Summit Strategies', 0, 2, 'southside');
INSERT INTO Business (name, spent, rating, locationLabel) VALUES ('Elevate Consulting', 30, 5, 'midtown');
INSERT INTO Business (name, spent, rating, locationLabel) VALUES ('Pinnacle Partners', 10, 4, 'plaza');

INSERT INTO Product (barcode, iname, weight) VALUES ('gc_4C6B9R', 'glass cleaner', 4);
INSERT INTO Product (barcode, iname, weight) VALUES ('pn_2D7Z6C', 'pens', 5);
INSERT INTO Product (barcode, iname, weight) VALUES ('sd_6J5S8H', 'screwdrivers', 4);
INSERT INTO Product (barcode, iname, weight) VALUES ('pt_16WEF6', 'paper towels', 6);
INSERT INTO Product (barcode, iname, weight) VALUES ('st_2D4E6L', 'shipping tape', 3);
INSERT INTO Product (barcode, iname, weight) VALUES ('hm_5E7L23M', 'hammer', 3);

INSERT INTO Contain (serviceID, tag, productBarcode, price, quantity) VALUES ('pbl', 3, 'pn_2D7Z6C', 28, 2);
INSERT INTO Contain (serviceID, tag, productBarcode, price, quantity) VALUES ('mbm', 5, 'pn_2D7Z6C', 30, 1);
INSERT INTO Contain (serviceID, tag, productBarcode, price, quantity) VALUES ('lcc', 1, 'pt_16WEF6', 20, 5);
INSERT INTO Contain (serviceID, tag, productBarcode, price, quantity) VALUES ('mbm', 8, 'pt_16WEF6', 18, 4);
INSERT INTO Contain (serviceID, tag, productBarcode, price, quantity) VALUES ('lcc', 1, 'st_2D4E6L', 23, 3);
INSERT INTO Contain (serviceID, tag, productBarcode, price, quantity) VALUES ('mbm', 11, 'st_2D4E6L', 19, 3);
INSERT INTO Contain (serviceID, tag, productBarcode, price, quantity) VALUES ('mbm', 1, 'st_2D4E6L', 27, 6);
INSERT INTO Contain (serviceID, tag, productBarcode, price, quantity) VALUES ('lcc', 2, 'hm_5E7L23M', 14, 7);
INSERT INTO Contain (serviceID, tag, productBarcode, price, quantity) VALUES ('pbl', 3, 'hm_5E7L23M', 15, 2);
INSERT INTO Contain (serviceID, tag, productBarcode, price, quantity) VALUES ('mbm', 5, 'hm_5E7L23M', 17, 4);

INSERT INTO Work_for (worker, service) VALUES ('640-81-2357', 'mbm');
INSERT INTO Work_for (worker, service) VALUES ('777-77-7777', 'pbl');
INSERT INTO Work_for (worker, service) VALUES ('444-44-4444', 'lcc');
INSERT INTO Work_for (worker, service) VALUES ('555-55-5555', 'mbm');
INSERT INTO Work_for (worker, service) VALUES ('333-33-3333', 'mbm');
INSERT INTO Work_for (worker, service) VALUES ('010-10-1010', 'pbl');

INSERT INTO Fund (owner, business) VALUES ('jstone5', 'Jones and Associates');
INSERT INTO Fund (owner, business) VALUES ('jstone5', 'Peak Performance Group');
INSERT INTO Fund (owner, business) VALUES ('jstone5', 'Elevate Consulting');
INSERT INTO Fund (owner, business) VALUES ('sprince6', 'Blue Horizon Enterprises');
