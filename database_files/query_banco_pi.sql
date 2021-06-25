CREATE DATABASE IF NOT EXISTS sgav;
USE sgav;

CREATE TABLE IF NOT EXISTS cars(
	id_car INT PRIMARY KEY UNIQUE NOT NULL AUTO_INCREMENT,
    brand VARCHAR(75) UNIQUE NOT NULL COMMENT 'Marca do veículo',
	model VARCHAR(75) UNIQUE NOT NULL COMMENT 'Modelo do veículo',
    plate VARCHAR(25) NOT NULL COMMENT 'Placa do veículo',
    age YEAR(4) NOT NULL COMMENT 'Ano de lançamento',
    color VARCHAR(25) NOT NULL,
    chassis_number VARCHAR(25) NOT NULL COMMENT 'Chassi do veículo'
);

CREATE TABLE IF NOT EXISTS customers(
	id_customer INT PRIMARY KEY UNIQUE NOT NULL AUTO_INCREMENT,
    c_name VARCHAR(75) NOT NULL,
    born DATE COMMENT 'Data de nascimento',
    rg VARCHAR(25),
    cpf CHAR(11) UNIQUE NOT NULL,
    cell CHAR(11) NOT NULL,
    email VARCHAR(75) UNIQUE,
	address VARCHAR(75) NOT NULL,
    num VARCHAR(5) NOT NULL,
    district VARCHAR(75) NOT NULL COMMENT 'Bairro',
    complement VARCHAR(75)
);

CREATE TABLE IF NOT EXISTS rental_cars(
	id_rental_car INT PRIMARY KEY UNIQUE NOT NULL AUTO_INCREMENT,
    id_car INT NOT NULL,
    id_customer INT NOT NULL COMMENT 'Cliente',
    price DOUBLE(10, 2) NOT NULL COMMENT 'Preço do aluguel',
    rental_date DATE NOT NULL COMMENT 'Data do aluguel',
    return_date DATE NOT NULL NULL COMMENT 'Data da devolução',
    returned BOOLEAN DEFAULT 0 COMMENT 'Devolvido [sim = 1 | não = 0]',
    created_at TIMESTAMP NOT NULL,
    updated_at DATETIME DEFAULT NULL,
    CONSTRAINT fk_car FOREIGN KEY(id_car) REFERENCES cars(id_car) ON DELETE NO ACTION ON UPDATE CASCADE,
	CONSTRAINT fk_customer FOREIGN KEY(id_customer) REFERENCES customers(id_customer) ON DELETE NO ACTION ON UPDATE CASCADE
);