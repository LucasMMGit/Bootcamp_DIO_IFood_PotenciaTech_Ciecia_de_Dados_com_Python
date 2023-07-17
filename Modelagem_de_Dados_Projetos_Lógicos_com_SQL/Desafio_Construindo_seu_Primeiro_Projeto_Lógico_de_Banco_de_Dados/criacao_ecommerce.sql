-- "Assim como demonstrado durante o desafio, realize a criação do Script SQL para criação do esquema do banco de dados"

-- -----------------------------------------------------
-- Schema ecommerce
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `ecommerce` ;

-- -----------------------------------------------------
-- Schema ecommerce
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ecommerce` DEFAULT CHARACTER SET utf8;
-- 1 row(s) affected, 1 warning(s): 3719 'utf8' is currently an alias for the character set UTF8MB3, 
	-- but will be an alias for UTF8MB4 in a future release. Please consider using UTF8MB4 in order to be unambiguous.

USE `ecommerce` ;

-- -----------------------------------------------------
-- Table `ecommerce`.`clients`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ecommerce`.`clients` ;

CREATE TABLE IF NOT EXISTS `ecommerce`.`clients` (
  `idClient` INT NOT NULL AUTO_INCREMENT,
  `Fname` VARCHAR(10) NULL,
  `Minit` CHAR(3) NULL,
  `Lname` VARCHAR(20) NULL,
  `CPF` CHAR(11) NOT NULL,
  `Address` VARCHAR(255) NULL,
  PRIMARY KEY (`idClient`),
  UNIQUE INDEX `CPF_UNIQUE` (`CPF` ASC) VISIBLE)
ENGINE = InnoDB;

alter table clients auto_increment=1;


-- -----------------------------------------------------
-- Table `ecommerce`.`products`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ecommerce`.`products` ;

CREATE TABLE IF NOT EXISTS `ecommerce`.`products` (
  `idProduct` INT NOT NULL AUTO_INCREMENT,
  `Pname` VARCHAR(255) NOT NULL,
  `classification_kids` TINYINT NULL DEFAULT 0,
  `category` ENUM('Eletrônico', 'Vestimenta', 'Brinquedos', 'Alimentos', 'Móveis') NOT NULL,
  `rating` FLOAT NULL DEFAULT 0,
  `size` VARCHAR(10) NULL,
  PRIMARY KEY (`idProduct`))
ENGINE = InnoDB;

alter table products auto_increment=1;

-- -----------------------------------------------------
-- Table `ecommerce`.`payments`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ecommerce`.`payments` ;

CREATE TABLE IF NOT EXISTS `ecommerce`.`payments` (
  `idclient` INT NOT NULL,
  `idPayment` INT NOT NULL,
  `typePayment` ENUM('Boleto', 'Cartão', 'Dois cartões') NULL,
  `limitAvailable` FLOAT NULL,
  PRIMARY KEY (`idclient`, `idPayment`),
  CONSTRAINT `fk_payments_clients`
    FOREIGN KEY (`idclient`)
    REFERENCES `ecommerce`.`clients` (`idClient`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecommerce`.`orders`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ecommerce`.`orders` ;

CREATE TABLE IF NOT EXISTS `ecommerce`.`orders` (
  `idOrder` INT NOT NULL AUTO_INCREMENT,
  `idOrderClient` INT NULL,
  `orderStatus` ENUM('Cancelado', 'Confirmado', 'Em processamento') NULL DEFAULT 'Em processamento',
  `orderDescription` VARCHAR(255) NULL,
  `sendValue` FLOAT NULL DEFAULT 10,
  `paymentCash` TINYINT NULL DEFAULT 0,
  PRIMARY KEY (`idOrder`),
  INDEX `fk_ordes_client_idx` (`idOrderClient` ASC) VISIBLE,
  CONSTRAINT `fk_ordes_client`
    FOREIGN KEY (`idOrderClient`)
    REFERENCES `ecommerce`.`clients` (`idClient`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;

alter table orders auto_increment=1;


-- -----------------------------------------------------
-- Table `ecommerce`.`product_storages`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ecommerce`.`product_storages` ;

CREATE TABLE IF NOT EXISTS `ecommerce`.`product_storages` (
  `idProdStorage` INT NOT NULL AUTO_INCREMENT,
  `storageLocation` VARCHAR(255) NULL,
  `quantity` INT NULL DEFAULT 0,
  PRIMARY KEY (`idProdStorage`))
ENGINE = InnoDB;

alter table product_storages auto_increment=1;


-- -----------------------------------------------------
-- Table `ecommerce`.`suppliers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ecommerce`.`suppliers` ;

CREATE TABLE IF NOT EXISTS `ecommerce`.`suppliers` (
  `idSupplier` INT NOT NULL AUTO_INCREMENT,
  `SocialName` VARCHAR(255) NOT NULL,
  `CNPJ` CHAR(14) NOT NULL,
  `contact` CHAR(11) NOT NULL,
  PRIMARY KEY (`idSupplier`),
  UNIQUE INDEX `CNPJ_UNIQUE` (`CNPJ` ASC) VISIBLE)
ENGINE = InnoDB;

alter table suppliers auto_increment=1;


-- -----------------------------------------------------
-- Table `ecommerce`.`sellers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ecommerce`.`sellers` ;

CREATE TABLE IF NOT EXISTS `ecommerce`.`sellers` (
  `idSeller` INT NOT NULL AUTO_INCREMENT,
  `SocialName` VARCHAR(255) NOT NULL,
  `AbstName` VARCHAR(255) NULL,
  `CNPJ` CHAR(14) NULL,
  `CPF` CHAR(11) NULL,
  `location` VARCHAR(255) NULL,
  `contact` CHAR(11) NOT NULL,
  PRIMARY KEY (`idSeller`),
  UNIQUE INDEX `CNPJ_UNIQUE` (`CNPJ` ASC) VISIBLE,
  UNIQUE INDEX `CPF_UNIQUE` (`CPF` ASC) VISIBLE)
ENGINE = InnoDB;

alter table sellers auto_increment=1;


-- -----------------------------------------------------
-- Table `ecommerce`.`products_sellers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ecommerce`.`products_sellers` ;

CREATE TABLE IF NOT EXISTS `ecommerce`.`products_sellers` (
  `idPseller` INT NOT NULL,
  `idPproduct` INT NOT NULL,
  `prodQuantity` INT NULL DEFAULT 1,
  PRIMARY KEY (`idPseller`, `idPproduct`),
  INDEX `fk_product_product_idx` (`idPproduct` ASC) VISIBLE,
  CONSTRAINT `fk_product_seller`
    FOREIGN KEY (`idPseller`)
    REFERENCES `ecommerce`.`sellers` (`idSeller`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_product_product`
    FOREIGN KEY (`idPproduct`)
    REFERENCES `ecommerce`.`products` (`idProduct`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecommerce`.`product_orders`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ecommerce`.`product_orders` ;

CREATE TABLE IF NOT EXISTS `ecommerce`.`product_orders` (
  `idPOproduct` INT NOT NULL,
  `idPOorder` INT NOT NULL,
  `poQuantity` INT NULL DEFAULT 1,
  `poStatus` ENUM('Disponível', 'Sem estoque') NULL DEFAULT 'Disponível',
  PRIMARY KEY (`idPOproduct`, `idPOorder`),
  INDEX `fk_productorder_order_idx` (`idPOorder` ASC) VISIBLE,
  CONSTRAINT `fk_productorder_product`
    FOREIGN KEY (`idPOproduct`)
    REFERENCES `ecommerce`.`products` (`idProduct`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_productorder_order`
    FOREIGN KEY (`idPOorder`)
    REFERENCES `ecommerce`.`orders` (`idOrder`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecommerce`.`storage_locations`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ecommerce`.`storage_locations` ;

CREATE TABLE IF NOT EXISTS `ecommerce`.`storage_locations` (
  `idLproduct` INT NOT NULL,
  `idLstorage` INT NOT NULL,
  `location` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`idLproduct`, `idLstorage`),
  INDEX `fk_storage_location_storage_idx` (`idLstorage` ASC) VISIBLE,
  CONSTRAINT `fk_storage_location_product`
    FOREIGN KEY (`idLproduct`)
    REFERENCES `ecommerce`.`products` (`idProduct`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_storage_location_storage`
    FOREIGN KEY (`idLstorage`)
    REFERENCES `ecommerce`.`product_storages` (`idProdStorage`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecommerce`.`product_suppliers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ecommerce`.`product_suppliers` ;

CREATE TABLE IF NOT EXISTS `ecommerce`.`product_suppliers` (
  `idPsSupplier` INT NOT NULL,
  `idPsProduct` INT NOT NULL,
  `quantity` INT NOT NULL,
  PRIMARY KEY (`idPsSupplier`, `idPsProduct`),
  INDEX `fk_product_supplier_prodcut_idx` (`idPsProduct` ASC) VISIBLE,
  CONSTRAINT `fk_product_supplier_supplier`
    FOREIGN KEY (`idPsSupplier`)
    REFERENCES `ecommerce`.`suppliers` (`idSupplier`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_product_supplier_prodcut`
    FOREIGN KEY (`idPsProduct`)
    REFERENCES `ecommerce`.`products` (`idProduct`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SHOW TABLES;

-- show databases;
use information_schema;
-- show tables;
desc referential_constraints;
select * from referential_constraints where constraint_schema = 'ecommerce';