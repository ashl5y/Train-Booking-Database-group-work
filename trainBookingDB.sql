CREATE DATABASE trainBookingDB;

USE trainbookingDB;

CREATE TABLE schedule (
    id INT PRIMARY KEY,
    name VARCHAR(100)
);

INSERT INTO schedule (id, name)
VALUES
(1, 'Morning schedule'),
(2, 'Afternoon schedule'),
(3, 'Night schedule');

CREATE TABLE train_journey (
    id INT PRIMARY KEY, 
    schedule_id INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    FOREIGN KEY (schedule_id) REFERENCES schedule(id)
);

INSERT INTO train_journey (id, schedule_id, name)
VALUES
(1, 1, 'Nairobi to Mtito Andei'),
(2, 2, 'Nairobi to Voi'),
(3, 1, 'Nairobi to Mombasa'),
(4, 3, 'Athi River to Voi'),
(5, 2, 'Emali to Mombasa'),
(6, 3, 'Voi to Mombasa');

CREATE TABLE train_station (
    id INT PRIMARY KEY,
    station_name VARCHAR(200)
);

INSERT INTO train_station (id, station_name)
VALUES
(1, 'Nairobi Terminus'),
(2, 'Athi River Station'),
(3, 'Emali Station'),
(4, 'Mtito Andei Station'),
(5, 'Voi Station'),
(6, 'Mombasa Terminus');

CREATE TABLE journey_station (
    journey_id INT NOT NULL,
    station_id INT NOT NULL,
    stop_order INT NOT NULL,
    departure_time TIMESTAMP NOT NULL,
    PRIMARY KEY (journey_id, station_id),
    FOREIGN KEY (journey_id) REFERENCES train_journey(id),
    FOREIGN KEY (station_id) REFERENCES train_station(id)
);

INSERT INTO journey_station (journey_id, station_id, stop_order, departure_time)
VALUES
(1, 1, 3, '2025-04-12 08:00:00'),
(2, 1, 4, '2025-04-12 15:00:00'),
(3, 1, 5, '2025-04-12 08:00:00'),
(4, 2, 4, '2025-04-12 22:40:00'),
(5, 3, 5, '2025-04-12 16:27:00'),
(6, 5, 5,  '2025-04-13 02:02:00');

CREATE TABLE carriage_class (
    id INT PRIMARY KEY AUTO_INCREMENT, 
    class_name VARCHAR(100) NOT NULL, 
    seating_capacity INT NOT NULL
);

INSERT INTO carriage_class (id, class_name, seating_capacity)
VALUES
(1, 'First Class', 60),
(2, 'Economy Class', 120);

CREATE TABLE carriage_price (
    schedule_id INT,
    carriage_class_id INT,
    price DECIMAL(10,2),
    FOREIGN KEY (schedule_id) REFERENCES schedule(id),
    FOREIGN KEY (carriage_class_id) REFERENCES carriage_class(id)
);

INSERT INTO carriage_price (schedule_id, carriage_class_id, price)
VALUES
(1, 1, 4500.00),
(1, 2, 1500.00),
(2, 1, 4500.00),
(2, 2, 1500.00), 
(3, 1, 4500.00), 
(3, 2, 1500.00);


CREATE TABLE journey_carriage (
    journey_id INT NOT NULL,
    carriage_class_id INT NOT NULL,
    position INT NOT NULL,
    PRIMARY KEY (journey_id, carriage_class_id),
    FOREIGN KEY (journey_id) REFERENCES train_journey(id),
    FOREIGN KEY (carriage_class_id) REFERENCES carriage_class(id)
);

INSERT INTO journey_carriage (journey_id, carriage_class_id, position)
VALUES
(1, 1, 1),
(1, 2, 2),
(2, 1, 1),
(2, 2, 2),
(3, 1, 1),
(3, 2, 2),
(4, 1, 1),
(4, 2, 2),
(5, 1, 1),
(5, 2, 2),
(6, 1, 1),
(6, 2, 2);

CREATE TABLE booking_status (
    id INT PRIMARY KEY,
    name VARCHAR(100) 
);

INSERT INTO booking_status (id, name)
VALUES
(1, 'Pending'),
(2, 'Confirmed'), 
(3, 'Cancelled');

CREATE TABLE passenger (
    id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email_address VARCHAR(100),
    password VARCHAR(100)
);

INSERT INTO passenger (id, first_name, last_name, email_address, password)
VALUES
(1, 'Rodney', 'Kaizari', 'rodneykaizari@gmail.com', 'rod473'),
(2, 'Emily', 'Atieno', 'emati242@gmail.com', '234eno'),
(3, 'Daphne', 'Mutisya', 'mutidaphne76@gmail.com', 'mu64da89'),
(4, 'Greg', 'Sieku', 'gsieku33@gmail.com', 'agdhu33');

CREATE TABLE booking (
    id INT PRIMARY KEY,
    carriage_class_id INT,
    passenger_id INT, 
    position INT,
    status_id INT,  
    booking_date TIMESTAMP, 
    starting_station_id INT, 
    ending_station_id INT, 
    train_journey_id INT, 
    ticket_class_id INT,
    amount_paid INT,
    ticket_no INT,
    seat_no INT,
    FOREIGN KEY (passenger_id) REFERENCES passenger(id),
    FOREIGN KEY (status_id) REFERENCES booking_status(id),
    FOREIGN KEY (starting_station_id) REFERENCES train_station(id),
    FOREIGN KEY (ending_station_id) REFERENCES train_station(id),
    FOREIGN KEY (train_journey_id) REFERENCES train_journey(id),
    FOREIGN KEY (ticket_class_id) REFERENCES carriage_class(id)
);

INSERT INTO booking (id, carriage_class_id, passenger_id, position, status_id, booking_date, 
starting_station_id, ending_station_id, train_journey_id, ticket_class_id, amount_paid, ticket_no,
seat_no)
VALUES
(1, 1, 3, 1, 2, '2025-04-12 08:00:00', 1, 4, 1, 1, 4500.00, 153, 23),
(2, 2, 1, 1, 1, '2025-04-13 02:02:00', 5, 6, 6, 2, 1500.00, 789, 59),
(3, 2, 4, 2, 2, '2025-04-12 16:27:00', 3, 6, 5, 2, 1500.00, 742, 104),
(4, 1, 2, 1, 3, '2025-04-12 15:00', 1, 5, 2, 1, 4500.00, 206, 6);
