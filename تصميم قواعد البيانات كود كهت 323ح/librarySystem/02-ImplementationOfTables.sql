-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema lib
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `lib` ;

-- -----------------------------------------------------
-- Schema lib
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `lib` DEFAULT CHARACTER SET utf8 ;
USE `lib` ;

-- -----------------------------------------------------
-- Table `lib`.`authour`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `lib`.`authour` ;

CREATE TABLE IF NOT EXISTS `lib`.`authour` (
  `authour_id` INT NOT NULL,
  `first_name` VARCHAR(50) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `birth` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`authour_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `lib`.`book`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `lib`.`book` ;

CREATE TABLE IF NOT EXISTS `lib`.`book` (
  `book_id` INT NOT NULL,
  `book_name` VARCHAR(45) NOT NULL,
  `language_id` INT NOT NULL,
  `description` TEXT NULL DEFAULT NULL,
  `isbn` INT NOT NULL,
  PRIMARY KEY (`book_id`),
  INDEX `fk_book_language1_idx` (`language_id` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `lib`.`category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `lib`.`category` ;

CREATE TABLE IF NOT EXISTS `lib`.`category` (
  `category_id` INT NOT NULL,
  `category` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`category_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `lib`.`country`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `lib`.`country` ;

CREATE TABLE IF NOT EXISTS `lib`.`country` (
  `country_id` INT NOT NULL,
  `country` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`country_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `lib`.`classification`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `lib`.`classification` ;

CREATE TABLE IF NOT EXISTS `lib`.`classification` (
  `category_id` INT NOT NULL,
  `book_id` INT NOT NULL,
  INDEX `fk_book_category_book1_idx` (`book_id` ASC) VISIBLE,
  INDEX `fk_book_category_category1` (`category_id` ASC) VISIBLE,
  CONSTRAINT `fk_book_category_book1`
    FOREIGN KEY (`book_id`)
    REFERENCES `lib`.`book` (`book_id`),
  CONSTRAINT `fk_book_category_category1`
    FOREIGN KEY (`category_id`)
    REFERENCES `lib`.`category` (`category_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `lib`.`city`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `lib`.`city` ;

CREATE TABLE IF NOT EXISTS `lib`.`city` (
  `city_id` INT NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `country_id` INT NOT NULL,
  PRIMARY KEY (`city_id`),
  INDEX `fk_city_country1_idx` (`country_id` ASC) VISIBLE,
  CONSTRAINT `fk_city_country1`
    FOREIGN KEY (`country_id`)
    REFERENCES `lib`.`country` (`country_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `lib`.`customer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `lib`.`customer` ;

CREATE TABLE IF NOT EXISTS `lib`.`customer` (
  `customer_id` INT NOT NULL,
  `first_name` VARCHAR(20) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `regestaration_date` DATETIME NOT NULL,
  `address_id` INT NOT NULL,
  PRIMARY KEY (`customer_id`),
  INDEX `fk_customer_address1_idx` (`address_id` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `lib`.`description`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `lib`.`description` ;

CREATE TABLE IF NOT EXISTS `lib`.`description` (
  `authour_id` INT NOT NULL,
  `book_id` INT NOT NULL,
  INDEX `fk_description_book1_idx` (`book_id` ASC) VISIBLE,
  INDEX `fk_authour_book_authour1` (`authour_id` ASC) VISIBLE,
  CONSTRAINT `fk_authour_book_authour1`
    FOREIGN KEY (`authour_id`)
    REFERENCES `lib`.`authour` (`authour_id`),
  CONSTRAINT `fk_description_book1`
    FOREIGN KEY (`book_id`)
    REFERENCES `lib`.`book` (`book_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `lib`.`payment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `lib`.`payment` ;

CREATE TABLE IF NOT EXISTS `lib`.`payment` (
  `payment_id` INT NOT NULL,
  `amount` DECIMAL(5,2) NOT NULL,
  `paymen_date` DATETIME NOT NULL,
  `customer_id` INT NOT NULL,
  `book_id` INT NOT NULL,
  PRIMARY KEY (`payment_id`),
  INDEX `fk_payment_customer1_idx` (`customer_id` ASC) VISIBLE,
  INDEX `fk_payment_book1_idx` (`book_id` ASC) VISIBLE,
  CONSTRAINT `fk_payment_customer1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `lib`.`customer` (`customer_id`),
  CONSTRAINT `fk_payment_book1`
    FOREIGN KEY (`book_id`)
    REFERENCES `lib`.`book` (`book_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `lib`.`publicher`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `lib`.`publicher` ;

CREATE TABLE IF NOT EXISTS `lib`.`publicher` (
  `publicher_id` INT NOT NULL,
  `first_name` VARCHAR(15) NOT NULL,
  `last_name` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`publicher_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `lib`.`publiching`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `lib`.`publiching` ;

CREATE TABLE IF NOT EXISTS `lib`.`publiching` (
  `publicher_id` INT NOT NULL,
  `book_id` INT NOT NULL,
  INDEX `fk_book_publicher_publicher1_idx` (`publicher_id` ASC) VISIBLE,
  INDEX `fk_publiching_book1_idx` (`book_id` ASC) VISIBLE,
  CONSTRAINT `fk_book_publicher_publicher1`
    FOREIGN KEY (`publicher_id`)
    REFERENCES `lib`.`publicher` (`publicher_id`),
  CONSTRAINT `fk_publiching_book1`
    FOREIGN KEY (`book_id`)
    REFERENCES `lib`.`book` (`book_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `lib`.`rental`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `lib`.`rental` ;

CREATE TABLE IF NOT EXISTS `lib`.`rental` (
  `rental_id` INT NOT NULL,
  `cutomer_id` INT NOT NULL,
  `book_id` INT NOT NULL,
  `return_date` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`rental_id`),
  INDEX `fk_rental_customer1_idx` (`cutomer_id` ASC) VISIBLE,
  INDEX `fk_rental_book1_idx` (`book_id` ASC) VISIBLE,
  CONSTRAINT `fk_rental_book1`
    FOREIGN KEY (`book_id`)
    REFERENCES `lib`.`book` (`book_id`),
  CONSTRAINT `fk_rental_customer1`
    FOREIGN KEY (`cutomer_id`)
    REFERENCES `lib`.`customer` (`customer_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `lib`.`address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `lib`.`address` ;

CREATE TABLE IF NOT EXISTS `lib`.`address` (
  `address_id` INT NOT NULL,
  `address` VARCHAR(45) NOT NULL,
  `address2` VARCHAR(45) NULL,
  `city_id` INT NOT NULL,
  `zipcode` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`address_id`),
  INDEX `fk_address_city1_idx` (`city_id` ASC) VISIBLE,
  CONSTRAINT `fk_address_city1`
    FOREIGN KEY (`city_id`)
    REFERENCES `lib`.`city` (`city_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lib`.`language`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `lib`.`language` ;

CREATE TABLE IF NOT EXISTS `lib`.`language` (
  `language_id` INT NOT NULL,
  `language` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`language_id`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
