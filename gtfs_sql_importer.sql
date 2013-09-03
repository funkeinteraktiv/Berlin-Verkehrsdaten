CREATE DATABASE vbb_transitdata;
 
USE vbb_transitdata;

DROP TABLE IF EXISTS agency;
CREATE TABLE agency (
	agency_name VARCHAR(150),
	agency_url VARCHAR(150),
	agency_timezone VARCHAR(75)
);
 
DROP TABLE IF EXISTS calendar;
CREATE TABLE calendar (
	service_id INT(2),
	monday TINYINT(1),
	tuesday TINYINT(1),
	wednesday TINYINT(1),
	thursday TINYINT(1),
	friday TINYINT(1),
	saturday TINYINT(1),
	sunday TINYINT(1),
	start_date DATE,
	end_date DATE,
	PRIMARY KEY(service_id)
);
 
DROP TABLE IF EXISTS routes;
CREATE TABLE routes(
	route_id INT(3),
	route_short_name VARCHAR(25),
	route_long_name VARCHAR(150),
	route_type INT(2),
	PRIMARY KEY(route_id),
	INDEX(route_long_name)
);
 
DROP TABLE IF EXISTS shapes;
CREATE TABLE shapes(
	shape_id INT(5),
	shape_pt_lat DOUBLE,
	shape_pt_lon DOUBLE,
	shape_pt_sequence INT(4)
);

DROP TABLE IF EXISTS stops;
CREATE TABLE stops(
	stop_id BIGINT,
	stop_code CHAR(8),
	stop_name VARCHAR(255) character set utf8,
	stop_desc VARCHAR(255),
	stop_lat DOUBLE,
	stop_lon DOUBLE,
	location_type INT(2),
	PRIMARY KEY(stop_id),
	INDEX(stop_name),
	INDEX(stop_lon),
	INDEX(stop_lat)
);
 
DROP TABLE IF EXISTS stop_times;
CREATE TABLE stop_times(
	trip_id INT(6),
	arrival_time TIME,
	departure_time TIME,
	stop_id BIGINT,
	stop_sequence INT(3),
	INDEX(trip_id),
	INDEX(stop_id)
);
 
DROP TABLE IF EXISTS trips;
CREATE TABLE trips(
	trip_id INT(6),
	service_id INT(1),
	route_id INT(3),
	shape_id INT(5),
	block_id INT(6),
	INDEX(route_id),
	INDEX(trip_id),
	INDEX(service_id)
);
 
LOAD DATA INFILE 'agency.txt' INTO TABLE agency
	FIELDS TERMINATED BY ','
	LINES TERMINATED BY '\n'
	IGNORE 1 LINES
	(agency_name,agency_url,agency_timezone);
 
LOAD DATA INFILE 'calendar.txt' INTO TABLE calendar
	FIELDS TERMINATED BY ','
	LINES TERMINATED BY '\n'
	IGNORE 1 LINES
	(service_id,monday,tuesday,wednesday,thursday,friday,saturday,sunday,start_date,end_date);
 
LOAD DATA INFILE 'routes.txt' INTO TABLE routes
	FIELDS TERMINATED BY ','
	LINES TERMINATED BY '\n'
	IGNORE 1 LINES
	(route_id,route_short_name,route_long_name,route_type);
 
LOAD DATA INFILE 'shapes.txt' INTO TABLE shapes
	FIELDS TERMINATED BY ','
	LINES TERMINATED BY '\n'
	IGNORE 1 LINES
	(shape_id,shape_pt_lat,shape_pt_lon,shape_pt_sequence);
 
LOAD DATA INFILE 'stop_times.txt' INTO TABLE stop_times
	FIELDS TERMINATED BY ','
	LINES TERMINATED BY '\n'
	IGNORE 1 LINES
	(trip_id,arrival_time,departure_time,stop_id,stop_sequence);
 
LOAD DATA INFILE 'stops.txt' INTO TABLE stops
	FIELDS TERMINATED BY ';'
	LINES TERMINATED BY '\n'
	IGNORE 1 LINES
	(stop_id,stop_code,stop_name,stop_desc,stop_lat,stop_lon,location_type);
 
LOAD DATA INFILE 'trips.txt' INTO TABLE trips
	FIELDS TERMINATED BY ','
	LINES TERMINATED BY '\n'
	IGNORE 1 LINES
	(trip_id,service_id,route_id,shape_id,block_id);