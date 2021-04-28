CREATE DATABASE IF NOT EXISTS sgav;
USE sgav;

CREATE TABLE IF NOT EXISTS states(
	id_state INT PRIMARY KEY UNIQUE NOT NULL AUTO_INCREMENT,
    state_name VARCHAR(75) UNIQUE NOT NULL,
    acronym CHAR(2) UNIQUE NOT NULL  COMMENT 'Sigla',
    region VARCHAR(25) NOT NULL,
	created_at TIMESTAMP NOT NULL,
    updated_at DATETIME DEFAULT NULL
);

CREATE TABLE IF NOT EXISTS counties(
	id_county INT PRIMARY KEY UNIQUE NOT NULL AUTO_INCREMENT,
    id_state INT NOT NULL,
    county VARCHAR(150) NOT NULL  COMMENT 'Município',
    created_at TIMESTAMP NOT NULL,
    updated_at DATETIME DEFAULT NULL,
	CONSTRAINT fk_state FOREIGN KEY(id_state) REFERENCES states(id_state) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS address(
	id_address INT PRIMARY KEY UNIQUE NOT NULL AUTO_INCREMENT,
    id_county INT NOT NULL  COMMENT 'Município',
    address VARCHAR(150) NOT NULL,
    num VARCHAR(4) NOT NULL,
    district VARCHAR(150) NOT NULL COMMENT 'Bairro',
    complement VARCHAR(100) DEFAULT NULL,
    created_at TIMESTAMP NOT NULL,
    updated_at DATETIME DEFAULT NULL,
    CONSTRAINT fk_county FOREIGN KEY(id_county) REFERENCES counties(id_county) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS departments(
	id_department INT PRIMARY KEY UNIQUE NOT NULL AUTO_INCREMENT,
    d_name VARCHAR(100) UNIQUE NOT NULL  COMMENT 'Departamento',
    locale VARCHAR(50) NOT NULL,
    created_at TIMESTAMP NOT NULL,
    updated_at DATETIME DEFAULT NULL,
    actived BOOLEAN DEFAULT 1
);

CREATE TABLE IF NOT EXISTS roles(
	id_role INT PRIMARY KEY UNIQUE NOT NULL AUTO_INCREMENT,
    id_department INT NOT NULL,
    r_name VARCHAR(50) NOT NULL COMMENT 'Função',
    created_at TIMESTAMP NOT NULL,
    updated_at DATETIME DEFAULT NULL,
    actived BOOLEAN DEFAULT 1,
    CONSTRAINT fk_department FOREIGN KEY(id_department) REFERENCES departments(id_department) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS employees(
	id_employee INT PRIMARY KEY UNIQUE NOT NULL AUTO_INCREMENT,
    id_role INT NOT NULL COMMENT 'Função',
    id_address INT NOT NULL,
    e_name VARCHAR(150) NOT NULL,
    born DATE NOT NULL COMMENT 'Data de nascimento',
    rg VARCHAR(25) NOT NULL,
    cpf CHAR(1) UNIQUE NOT NULL,
    ctps VARCHAR(25) UNIQUE NOT NULL,
    landline CHAR(10) NOT NULL COMMENT 'Telefone fixo',
    cell CHAR(1) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    admission DATE NOT NULL COMMENT 'Data de admissão',
    wage DOUBLE(10, 2) NOT NULL COMMENT 'Salário',
    created_at TIMESTAMP NOT NULL,
    updated_at DATETIME DEFAULT NULL,
    CONSTRAINT fk_role FOREIGN KEY(id_role) REFERENCES roles(id_role) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_address FOREIGN KEY(id_address) REFERENCES address(id_address) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS brands(
	id_brand INT PRIMARY KEY UNIQUE NOT NULL AUTO_INCREMENT,
    brand VARCHAR(50) UNIQUE NOT NULL COMMENT 'Marca do veículo',
    created_at TIMESTAMP NOT NULL,
    updated_at DATETIME DEFAULT NULL
);

CREATE TABLE IF NOT EXISTS models(
	id_model INT PRIMARY KEY UNIQUE NOT NULL AUTO_INCREMENT,
    id_brand INT NOT NULL COMMENT 'Marca do veículo',
    model VARCHAR(100) UNIQUE NOT NULL COMMENT 'Modelo do veículo',
	created_at TIMESTAMP NOT NULL,
    updated_at DATETIME DEFAULT NULL,
    CONSTRAINT fk_brand FOREIGN KEY(id_brand) REFERENCES brands(id_brand) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS cars(
	id_car INT PRIMARY KEY UNIQUE NOT NULL AUTO_INCREMENT,
    id_model INT UNIQUE NOT NULL,
    plate VARCHAR(20) NOT NULL COMMENT 'Placa do veículo',
    age YEAR(4) NOT NULL COMMENT 'Ano de lançamento',
    color VARCHAR(15) NOT NULL,
    chassis_number VARCHAR(50) NOT NULL COMMENT 'Chassi do veículo',
    category VARCHAR(50) NOT NULL,
    air_conditioning BOOLEAN DEFAULT 0,
    airbag BOOLEAN DEFAULT 0,
    automatic_gearbox BOOLEAN DEFAULT 0 COMMENT 'Câmbio automático',
    maximum_speed VARCHAR(4) NOT NULL COMMENT 'Velocidade máxima',
    purchase_date DATE NOT NULL COMMENT 'Data da compra do veículo',
    purchase_price DOUBLE(10, 2) NOT NULL COMMENT 'Preço do veículo',
    created_at TIMESTAMP NOT NULL,
    updated_at DATETIME DEFAULT NULL,
	CONSTRAINT fk_model FOREIGN KEY(id_model) REFERENCES models(id_model) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS rental_cars(
	id_rental_car INT PRIMARY KEY UNIQUE NOT NULL AUTO_INCREMENT,
    id_car INT NOT NULL,
    id_employee INT NOT NULL,
    price DOUBLE(10, 2) NOT NULL COMMENT 'Preço do aluguel',
    rental_date DATE NOT NULL COMMENT 'Data do aluguel',
    return_date DATE NOT NULL NULL COMMENT 'Data da devolução',
    returned BOOLEAN DEFAULT 0 COMMENT 'Devolvido [sim = 1 | não = 0]',
    created_at TIMESTAMP NOT NULL,
    updated_at DATETIME DEFAULT NULL,
    CONSTRAINT fk_car FOREIGN KEY(id_car) REFERENCES cars(id_car) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_employee FOREIGN KEY(id_employee) REFERENCES employees(id_employee) ON DELETE CASCADE ON UPDATE CASCADE
);

/*INSERT INTO states (state_name, acronym, region) VALUES ('Rondônia','RO','Norte'),('Acre','AC','Norte'),('Amazonas','AM','Norte'),('Roraima','RR','Norte'),('Pará','PA','Norte'),('Amapá','AP','Norte'),('Tocantins','TO','Norte'),
('Maranhão','MA','Nordeste'),('Piauí','PI','Nordeste'),('Ceará','CE','Nordeste'),('Rio Grande do Norte','RN','Nordeste'),('Paraíba','PB','Nordeste'),('Pernambuco','PE','Nordeste'),('Alagoas','AL','Nordeste'),
('Sergipe','SE','Nordeste'),('Bahia','BA','Nordeste'),('Minas Gerais','MG','Sudeste'),('Espírito Santo','ES','Sudeste'),('Rio de Janeiro','RJ','Sudeste'),('São Paulo','SP','Sudeste'),('Paraná','PR','Sul'),
('Santa Catarina','SC','Sul'),('Rio Grande do Sul','RS','Sul'),('Mato Grosso do Sul','MS','Centro-oeste'),('Mato Grosso','MT','Centro-oeste'),('Goiás','GO','Centro-oeste'),('Distrito Federal','DF','Centro-oeste');

INSERT INTO counties (id_county, id_state, county) VALUES (1,1,'Alta Floresta D\'Oeste'),(2,1,'Ariquemes'),(3,1,'Cabixi'),(4,1,'Cacoal'),(5,1,'Cerejeiras'),(6,1,'Colorado do Oeste'),(7,1,'Corumbiara'),
(8,1,'Costa Marques'),(9,1,'Espigão D\'Oeste'),(10,1,'Guajará-Mirim'),(11,1,'Jaru'),(12,1,'Ji-Paraná'),(13,1,'Machadinho D\'Oeste'),(14,1,'Nova Brasilândia D\'Oeste'),(15,1,'Ouro Preto do Oeste'),
(16,1,'Pimenta Bueno'),(17,1,'Porto Velho'),(18,1,'Presidente Médici'),(19,1,'Rio Crespo'),(20,1,'Rolim de Moura'),(21,1,'Santa Luzia D\'Oeste'),(22,1,'Vilhena'),(23,1,'São Miguel do Guaporé'),
(24,1,'Nova Mamoré'),(25,1,'Alvorada D\'Oeste'),(26,1,'Alto Alegre dos Parecis'),(27,1,'Alto Paraíso'),(28,1,'Buritis'),(29,1,'Novo Horizonte do Oeste'),(30,1,'Cacaulândia'),(31,1,'Campo Novo de Rondônia'),
(32,1,'Candeias do Jamari'),(33,1,'Castanheiras'),(34,1,'Chupinguaia'),(35,1,'Cujubim'),(36,1,'Governador Jorge Teixeira'),(37,1,'Itapuã do Oeste'),(38,1,'Ministro Andreazza'),(39,1,'Mirante da Serra'),
(40,1,'Monte Negro'),(41,1,'Nova União'),(42,1,'Parecis'),(43,1,'Pimenteiras do Oeste'),(44,1,'Primavera de Rondônia'),(45,1,'São Felipe D\'Oeste'),(46,1,'São Francisco do Guaporé'),(47,1,'Seringueiras'),
(48,1,'Teixeirópolis'),(49,1,'Theobroma'),(50,1,'Urupá'),(51,1,'Vale do Anari'),(52,1,'Vale do Paraíso');*/