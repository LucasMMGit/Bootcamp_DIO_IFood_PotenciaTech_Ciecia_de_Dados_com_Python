-- “Refine o modelo apresentado acrescentando os seguintes pontos”
	-- Cliente PJ e PF – Uma conta pode ser PJ ou PF, mas não pode ter as duas informações;
	-- Pagamento – Pode ter cadastrado mais de uma forma de pagamento;
	-- Entrega – Possui status e código de rastreio;

-- -----------------------------------------------------
-- Schema ecommerce_refinado
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `ecommerce_refinado` ;

-- -----------------------------------------------------
-- Schema ecommerce_refinado
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ecommerce_refinado` DEFAULT CHARACTER SET utf8 ;
USE `ecommerce_refinado` ;

-- -----------------------------------------------------
-- Table `ecommerce_refinado`.`clients`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ecommerce_refinado`.`clients` ;

CREATE TABLE IF NOT EXISTS `ecommerce_refinado`.`clients` (
  `idClient` INT NOT NULL AUTO_INCREMENT,
  `Fname` VARCHAR(10) NULL,
  `Minit` CHAR(3) NULL,
  `Lname` VARCHAR(20) NULL,
  `CPF` CHAR(11) NULL,
  `CNPJ` CHAR(14) NULL,
  `Email` VARCHAR(255) NULL,
  `Address` VARCHAR(255) NULL,
  `legal_entity` TINYINT NULL,
  `company_name` VARCHAR(45) NULL,
  PRIMARY KEY (`idClient`),
  UNIQUE INDEX `CPF_UNIQUE` (`CPF` ASC) VISIBLE,
  UNIQUE INDEX `CNPJ_UNIQUE` (`CNPJ` ASC) VISIBLE,
  UNIQUE INDEX `Email_UNIQUE` (`Email` ASC) VISIBLE)
ENGINE = InnoDB;

DELIMITER //
CREATE TRIGGER insert_CPF_or_CNPJ BEFORE INSERT ON clients
FOR EACH ROW BEGIN
  IF (NEW.CPF IS NULL AND NEW.CNPJ IS NULL) THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = '\'CPF\' and \'CNPJ\' cannot both be null';
  END IF;
END//
CREATE TRIGGER update_CPF_or_CNPJ BEFORE UPDATE ON clients
FOR EACH ROW BEGIN
  IF (NEW.CPF IS NULL AND NEW.CNPJ IS NULL) THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = '\'CPF\' and \'CNPJ\' cannot both be null';
  END IF;
END//
DELIMITER ;

-- -----------------------------------------------------
-- Table `ecommerce_refinado`.`products`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ecommerce_refinado`.`products` ;

CREATE TABLE IF NOT EXISTS `ecommerce_refinado`.`products` (
  `idProduct` INT NOT NULL AUTO_INCREMENT,
  `Pname` VARCHAR(255) NOT NULL,
  `classification_kids` TINYINT NULL DEFAULT 0,
  `category` ENUM('Eletrônico', 'Vestimenta', 'Brinquedos', 'Alimentos', 'Móveis') NOT NULL,
  `rating` FLOAT NULL DEFAULT 0,
  `size` VARCHAR(10) NOT NULL,
  `weight` VARCHAR(10) NOT NULL,
  `description` TEXT(1000) NULL,
  `price` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`idProduct`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecommerce_refinado`.`payments`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ecommerce_refinado`.`payments` ;

CREATE TABLE IF NOT EXISTS `ecommerce_refinado`.`payments` (
  `idclient` INT NOT NULL,
  `idPayment` INT NOT NULL,
  `typePayment` ENUM('Boleto', 'Cartão', 'Dois cartões', 'Pix') NULL,
  `limitAvailable` FLOAT NULL,
  PRIMARY KEY (`idclient`, `idPayment`),
  CONSTRAINT `fk_payments_clients`
    FOREIGN KEY (`idclient`)
    REFERENCES `ecommerce_refinado`.`clients` (`idClient`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecommerce_refinado`.`orders`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ecommerce_refinado`.`orders` ;

CREATE TABLE IF NOT EXISTS `ecommerce_refinado`.`orders` (
  `idOrder` INT NOT NULL AUTO_INCREMENT,
  `idOrderClient` INT NULL,
  `orderStatus` ENUM('Cancelado', 'Aguardando Pagamento', 'Em processamento', 'Concluido') NOT NULL DEFAULT 'Em processamento',
  `orderDescription` VARCHAR(255) NULL,
  `freight` DECIMAL(10,2) NULL,
  `total_price` DECIMAL(10,2) NOT NULL,
  `payment_type` ENUM('Boleto', 'Cartão', 'Dois cartões', 'Pix') NOT NULL,
  `delivery_status` ENUM('Enviado', 'Saiu para entrega', 'Entregue') NULL,
  `tracking_code` VARCHAR(45) NULL,
  `date_time` DATETIME NULL,
  PRIMARY KEY (`idOrder`),
  INDEX `fk_ordes_client_idx` (`idOrderClient` ASC) VISIBLE,
  CONSTRAINT `fk_ordes_client`
    FOREIGN KEY (`idOrderClient`)
    REFERENCES `ecommerce_refinado`.`clients` (`idClient`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecommerce_refinado`.`products_storages`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ecommerce_refinado`.`products_storages` ;

CREATE TABLE IF NOT EXISTS `ecommerce_refinado`.`products_storages` (
  `idProdStorage` INT NOT NULL AUTO_INCREMENT,
  `storageLocation` VARCHAR(255) NULL,
  `quantity` INT NULL DEFAULT 0,
  PRIMARY KEY (`idProdStorage`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecommerce_refinado`.`suppliers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ecommerce_refinado`.`suppliers` ;

CREATE TABLE IF NOT EXISTS `ecommerce_refinado`.`suppliers` (
  `idSupplier` INT NOT NULL AUTO_INCREMENT,
  `SocialName` VARCHAR(255) NOT NULL,
  `CNPJ` CHAR(14) NOT NULL,
  `contact` CHAR(11) NOT NULL,
  PRIMARY KEY (`idSupplier`),
  UNIQUE INDEX `CNPJ_UNIQUE` (`CNPJ` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecommerce_refinado`.`sellers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ecommerce_refinado`.`sellers` ;

CREATE TABLE IF NOT EXISTS `ecommerce_refinado`.`sellers` (
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


-- -----------------------------------------------------
-- Table `ecommerce_refinado`.`products_sellers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ecommerce_refinado`.`products_sellers` ;

CREATE TABLE IF NOT EXISTS `ecommerce_refinado`.`products_sellers` (
  `idPseller` INT NOT NULL,
  `idPproduct` INT NOT NULL,
  `prodQuantity` INT NULL DEFAULT 1,
  PRIMARY KEY (`idPseller`, `idPproduct`),
  INDEX `fk_product_product_idx` (`idPproduct` ASC) VISIBLE,
  CONSTRAINT `fk_product_seller`
    FOREIGN KEY (`idPseller`)
    REFERENCES `ecommerce_refinado`.`sellers` (`idSeller`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_product_product`
    FOREIGN KEY (`idPproduct`)
    REFERENCES `ecommerce_refinado`.`products` (`idProduct`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecommerce_refinado`.`products_orders`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ecommerce_refinado`.`products_orders` ;

CREATE TABLE IF NOT EXISTS `ecommerce_refinado`.`products_orders` (
  `idPOproduct` INT NOT NULL,
  `idPOorder` INT NOT NULL,
  `poQuantity` INT NULL DEFAULT 1,
  `price_per_unit` DECIMAL(10,2) NULL,
  PRIMARY KEY (`idPOproduct`, `idPOorder`),
  INDEX `fk_productorder_order_idx` (`idPOorder` ASC) VISIBLE,
  CONSTRAINT `fk_productorder_product`
    FOREIGN KEY (`idPOproduct`)
    REFERENCES `ecommerce_refinado`.`products` (`idProduct`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_productorder_order`
    FOREIGN KEY (`idPOorder`)
    REFERENCES `ecommerce_refinado`.`orders` (`idOrder`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecommerce_refinado`.`storages_locations`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ecommerce_refinado`.`storages_locations` ;

CREATE TABLE IF NOT EXISTS `ecommerce_refinado`.`storages_locations` (
  `idLproduct` INT NOT NULL,
  `idLstorage` INT NOT NULL,
  `location` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`idLproduct`, `idLstorage`),
  INDEX `fk_storage_location_storage_idx` (`idLstorage` ASC) VISIBLE,
  CONSTRAINT `fk_storage_location_product`
    FOREIGN KEY (`idLproduct`)
    REFERENCES `ecommerce_refinado`.`products` (`idProduct`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_storage_location_storage`
    FOREIGN KEY (`idLstorage`)
    REFERENCES `ecommerce_refinado`.`products_storages` (`idProdStorage`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecommerce_refinado`.`products_suppliers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ecommerce_refinado`.`products_suppliers` ;

CREATE TABLE IF NOT EXISTS `ecommerce_refinado`.`products_suppliers` (
  `idPsSupplier` INT NOT NULL,
  `idPsProduct` INT NOT NULL,
  `quantity` INT NOT NULL,
  PRIMARY KEY (`idPsSupplier`, `idPsProduct`),
  INDEX `fk_product_supplier_prodcut_idx` (`idPsProduct` ASC) VISIBLE,
  CONSTRAINT `fk_product_supplier_supplier`
    FOREIGN KEY (`idPsSupplier`)
    REFERENCES `ecommerce_refinado`.`suppliers` (`idSupplier`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_product_supplier_prodcut`
    FOREIGN KEY (`idPsProduct`)
    REFERENCES `ecommerce_refinado`.`products` (`idProduct`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
