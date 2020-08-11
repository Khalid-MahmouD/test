-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mydb` ;

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`language`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`language` ;

CREATE TABLE IF NOT EXISTS `mydb`.`language` (
  `language_id` TINYINT NOT NULL,
  `name` CHAR(20) NOT NULL,
  `last_update` TIMESTAMP NOT NULL,
  PRIMARY KEY (`language_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`book`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`book` ;

CREATE TABLE IF NOT EXISTS `mydb`.`book` (
  `book_id` SMALLINT NOT NULL,
  `title` VARCHAR(255) NOT NULL,
  `description` TEXT NULL,
  `release_year` YEAR NULL,
  `language_id` TINYINT(3) NOT NULL,
  `original_language_id` TINYINT(3) NULL,
  `rental_duration` TINYINT(3) NOT NULL,
  `rental_rate` DECIMAL(4,2) NOT NULL,
  `length` SMALLINT(5) NULL,
  `replacement_cost` DECIMAL(5,2) NOT NULL,
  `rating` ENUM('G', 'PG', 'PG-13', 'R', 'NC-17') NULL DEFAULT 'G',
  `special_features` SET('Trailers', 'Commentaries', 'Deleted Scenes', 'Behind the Scenes') NULL,
  `last_update` TIMESTAMP NOT NULL,
  `bookcol` VARCHAR(45) NULL,
  PRIMARY KEY (`book_id`),
  INDEX `fk_book_language1_idx` (`language_id` ASC) VISIBLE,
  INDEX `fk_book_language2_idx` (`original_language_id` ASC) VISIBLE,
  CONSTRAINT `fk_book_language1`
    FOREIGN KEY (`language_id`)
    REFERENCES `mydb`.`language` (`language_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_book_language2`
    FOREIGN KEY (`original_language_id`)
    REFERENCES `mydb`.`language` (`language_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`category` ;

CREATE TABLE IF NOT EXISTS `mydb`.`category` (
  `category_id` TINYINT NOT NULL,
  `name` VARCHAR(25) NOT NULL,
  `last_update` TIMESTAMP NOT NULL,
  PRIMARY KEY (`category_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`book_category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`book_category` ;

CREATE TABLE IF NOT EXISTS `mydb`.`book_category` (
  `book_id` SMALLINT NOT NULL,
  `category_id` TINYINT NOT NULL,
  `last_update` TIMESTAMP NOT NULL,
  PRIMARY KEY (`book_id`, `category_id`),
  INDEX `fk_book_category_category1_idx` (`category_id` ASC) VISIBLE,
  CONSTRAINT `fk_book_category_book1`
    FOREIGN KEY (`book_id`)
    REFERENCES `mydb`.`book` (`book_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_book_category_category1`
    FOREIGN KEY (`category_id`)
    REFERENCES `mydb`.`category` (`category_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`authour`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`authour` ;

CREATE TABLE IF NOT EXISTS `mydb`.`authour` (
  `authour_id` SMALLINT NOT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `last_update` TIMESTAMP NOT NULL,
  PRIMARY KEY (`authour_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`book_authour`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`book_authour` ;

CREATE TABLE IF NOT EXISTS `mydb`.`book_authour` (
  `authour_id` SMALLINT NOT NULL,
  `book_id` SMALLINT NOT NULL,
  `last_update` TIMESTAMP NOT NULL,
  PRIMARY KEY (`authour_id`, `book_id`),
  INDEX `fk_book_authour_book1_idx` (`book_id` ASC) VISIBLE,
  CONSTRAINT `fk_book_authour_authour1`
    FOREIGN KEY (`authour_id`)
    REFERENCES `mydb`.`authour` (`authour_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_book_authour_book1`
    FOREIGN KEY (`book_id`)
    REFERENCES `mydb`.`book` (`book_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`country`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`country` ;

CREATE TABLE IF NOT EXISTS `mydb`.`country` (
  `country_id` SMALLINT NOT NULL,
  `country` VARCHAR(45) NOT NULL,
  `last_update` TIMESTAMP NOT NULL,
  PRIMARY KEY (`country_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`city`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`city` ;

CREATE TABLE IF NOT EXISTS `mydb`.`city` (
  `city_id` SMALLINT NOT NULL,
  `city` VARCHAR(50) NOT NULL,
  `country_id` SMALLINT NOT NULL,
  `last_update` TIMESTAMP NOT NULL,
  PRIMARY KEY (`city_id`),
  INDEX `fk_city_country_idx` (`country_id` ASC) VISIBLE,
  CONSTRAINT `fk_city_country`
    FOREIGN KEY (`country_id`)
    REFERENCES `mydb`.`country` (`country_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`address` ;

CREATE TABLE IF NOT EXISTS `mydb`.`address` (
  `address_id` SMALLINT NOT NULL,
  `address` VARCHAR(50) NOT NULL,
  `address2` VARCHAR(45) NULL,
  `district` VARCHAR(20) NOT NULL,
  `city_id` SMALLINT NOT NULL,
  `postal_code` VARCHAR(10) NULL,
  `phone` VARCHAR(20) NOT NULL,
  `last_update` TIMESTAMP NOT NULL,
  PRIMARY KEY (`address_id`),
  INDEX `fk_address_city1_idx` (`city_id` ASC) VISIBLE,
  CONSTRAINT `fk_address_city1`
    FOREIGN KEY (`city_id`)
    REFERENCES `mydb`.`city` (`city_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`staff`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`staff` ;

CREATE TABLE IF NOT EXISTS `mydb`.`staff` (
  `staff_id` TINYINT NOT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `address_id` SMALLINT NOT NULL,
  `picture` BLOB NULL,
  `email` VARCHAR(60) NULL,
  `active` TINYINT NOT NULL,
  `username` VARCHAR(16) NOT NULL,
  `password` VARCHAR(40) NULL,
  `last_update` TIMESTAMP NOT NULL,
  PRIMARY KEY (`staff_id`),
  INDEX `fk_staff_address1_idx` (`address_id` ASC) VISIBLE,
  CONSTRAINT `fk_staff_address1`
    FOREIGN KEY (`address_id`)
    REFERENCES `mydb`.`address` (`address_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`library`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`library` ;

CREATE TABLE IF NOT EXISTS `mydb`.`library` (
  `library_id` TINYINT NOT NULL,
  `manager_staff_id` TINYINT NOT NULL,
  `address_id` SMALLINT NOT NULL,
  `last_update` TIMESTAMP NOT NULL,
  PRIMARY KEY (`library_id`),
  INDEX `fk_library_address1_idx` (`address_id` ASC) VISIBLE,
  INDEX `fk_library_staff1_idx` (`manager_staff_id` ASC) VISIBLE,
  UNIQUE INDEX `manager_staff_id_UNIQUE` (`manager_staff_id` ASC) VISIBLE,
  CONSTRAINT `fk_library_address1`
    FOREIGN KEY (`address_id`)
    REFERENCES `mydb`.`address` (`address_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_library_staff1`
    FOREIGN KEY (`manager_staff_id`)
    REFERENCES `mydb`.`staff` (`staff_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`inventory`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`inventory` ;

CREATE TABLE IF NOT EXISTS `mydb`.`inventory` (
  `inventory_id` MEDIUMINT NOT NULL,
  `book_id` SMALLINT NOT NULL,
  `library_id` TINYINT NOT NULL,
  `last_update` TIMESTAMP NOT NULL,
  PRIMARY KEY (`inventory_id`),
  INDEX `fk_inventory_library1_idx` (`library_id` ASC) VISIBLE,
  INDEX `fk_inventory_book1_idx` (`book_id` ASC) VISIBLE,
  CONSTRAINT `fk_inventory_library1`
    FOREIGN KEY (`library_id`)
    REFERENCES `mydb`.`library` (`library_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_inventory_book1`
    FOREIGN KEY (`book_id`)
    REFERENCES `mydb`.`book` (`book_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`customer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`customer` ;

CREATE TABLE IF NOT EXISTS `mydb`.`customer` (
  `customer_id` SMALLINT NOT NULL,
  `library_id` TINYINT NOT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `email` VARCHAR(60) NULL,
  `address_id` SMALLINT NOT NULL,
  `active` TINYINT NOT NULL,
  `create_date` DATETIME NOT NULL,
  `last_update` TIMESTAMP NOT NULL,
  PRIMARY KEY (`customer_id`),
  INDEX `fk_customer_address1_idx` (`address_id` ASC) VISIBLE,
  INDEX `fk_customer_library1_idx` (`library_id` ASC) VISIBLE,
  CONSTRAINT `fk_customer_address1`
    FOREIGN KEY (`address_id`)
    REFERENCES `mydb`.`address` (`address_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_customer_library1`
    FOREIGN KEY (`library_id`)
    REFERENCES `mydb`.`library` (`library_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`rental`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`rental` ;

CREATE TABLE IF NOT EXISTS `mydb`.`rental` (
  `rental_id` INT NOT NULL,
  `rental_date` DATETIME NOT NULL,
  `inventory_id` MEDIUMINT NOT NULL,
  `customer_id` SMALLINT NOT NULL,
  `return_date` DATETIME NULL,
  `staff_id` TINYINT NOT NULL,
  `last_update` TIMESTAMP NOT NULL,
  PRIMARY KEY (`rental_id`),
  INDEX `fk_rental_customer1_idx` (`customer_id` ASC) VISIBLE,
  INDEX `fk_rental_inventory1_idx` (`inventory_id` ASC) VISIBLE,
  CONSTRAINT `fk_rental_customer1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `mydb`.`customer` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_rental_inventory1`
    FOREIGN KEY (`inventory_id`)
    REFERENCES `mydb`.`inventory` (`inventory_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`payment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`payment` ;

CREATE TABLE IF NOT EXISTS `mydb`.`payment` (
  `payment_id` SMALLINT NOT NULL,
  `customer_id` SMALLINT NOT NULL,
  `staff_id` TINYINT NOT NULL,
  `rental_id` INT NULL,
  `amount` DECIMAL(5,2) NOT NULL,
  `payment_date` DATETIME NOT NULL,
  `last_update` TIMESTAMP NULL,
  PRIMARY KEY (`payment_id`),
  INDEX `fk_payment_customer1_idx` (`customer_id` ASC) VISIBLE,
  INDEX `fk_payment_staff1_idx` (`staff_id` ASC) VISIBLE,
  INDEX `fk_payment_rental1_idx` (`rental_id` ASC) VISIBLE,
  CONSTRAINT `fk_payment_customer1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `mydb`.`customer` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_payment_staff1`
    FOREIGN KEY (`staff_id`)
    REFERENCES `mydb`.`staff` (`staff_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_payment_rental1`
    FOREIGN KEY (`rental_id`)
    REFERENCES `mydb`.`rental` (`rental_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `mydb` ;

-- -----------------------------------------------------
-- Placeholder table for view `mydb`.`book_list`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`book_list` (`FID` INT, `title` INT, `description` INT, `category` INT, `price` INT, `length` INT, `rating` INT, `authours` INT);

-- -----------------------------------------------------
-- Placeholder table for view `mydb`.`sales_by_library`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`sales_by_library` (`library` INT, `manager` INT, `total_sales` INT);

-- -----------------------------------------------------
-- Placeholder table for view `mydb`.`authour_info`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`authour_info` (`authour_id` INT, `first_name` INT, `last_name` INT, `book_info` INT);

-- -----------------------------------------------------
-- procedure book_in_stock
-- -----------------------------------------------------

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`book_in_stock`;

DELIMITER $$
USE `mydb`$$
-- Given the book_id and library_id, find the book count
CREATE PROCEDURE book_in_stock(
   IN  p_book_id INT,
   IN  p_library_id INT,
   OUT p_book_count INT)
READS SQL DATA
BEGIN
   SELECT inventory_id
     FROM inventory
     WHERE book_id = p_book_id
       AND library_id = p_library_id
       AND inventory_in_stock(inventory_id);
 
   SELECT FOUND_ROWS() INTO p_book_count;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- function inventory_in_stock
-- -----------------------------------------------------

USE `mydb`;
DROP function IF EXISTS `mydb`.`inventory_in_stock`;

DELIMITER $$
USE `mydb`$$
CREATE FUNCTION inventory_in_stock(p_inventory_id INT) RETURNS BOOLEAN
READS SQL DATA
BEGIN
   DECLARE v_rentals INT;
   DECLARE v_out     INT;

   # AN ITEM IS IN-STOCK IF THERE ARE EITHER NO ROWS IN THE rental TABLE
   # FOR THE ITEM OR ALL ROWS HAVE return_date POPULATED
   SELECT COUNT(*) INTO v_rentals
   FROM rental
   WHERE inventory_id = p_inventory_id;
 
   IF v_rentals = 0 THEN
      RETURN TRUE;
   END IF;
 
   SELECT COUNT(rental_id) INTO v_out
   FROM inventory LEFT JOIN rental USING(inventory_id)
   WHERE inventory.inventory_id = p_inventory_id AND rental.return_date IS NULL;
 
   IF v_out > 0 THEN
      RETURN FALSE;
   ELSE
      RETURN TRUE;
   END IF;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- View `mydb`.`book_list`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`book_list`;
DROP VIEW IF EXISTS `mydb`.`book_list` ;
USE `mydb`;
CREATE  OR REPLACE VIEW book_list
AS
SELECT 
  book.book_id AS FID,
  book.title AS title,
  book.description AS description,
  category.name AS category,
  book.rental_rate AS price,
  book.length AS length,
  book.rating AS rating,
  GROUP_CONCAT(CONCAT(authour.first_name, _utf8' ', authour.last_name) SEPARATOR ', ') AS authours
FROM category 
  LEFT JOIN book_category ON category.category_id = book_category.category_id
  LEFT JOIN book ON book_category.book_id = book.book_id
  JOIN book_authour ON book.book_id = book_authour.book_id
  JOIN authour ON book_authour.authour_id = authour.authour_id
GROUP BY book.book_id;

-- -----------------------------------------------------
-- View `mydb`.`sales_by_library`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`sales_by_library`;
DROP VIEW IF EXISTS `mydb`.`sales_by_library` ;
USE `mydb`;
CREATE  OR REPLACE VIEW sales_by_library
AS
SELECT
  CONCAT(c.city, _utf8',', cy.country) AS library,
  CONCAT(m.first_name, _utf8' ', m.last_name) AS manager,
  SUM(p.amount) AS total_sales
FROM payment AS p
  INNER JOIN rental AS r ON p.rental_id = r.rental_id
  INNER JOIN inventory AS i ON r.inventory_id = i.inventory_id
  INNER JOIN library AS s ON i.library_id = s.library_id
  INNER JOIN address AS a ON s.address_id = a.address_id
  INNER JOIN city AS c ON a.city_id = c.city_id
  INNER JOIN country AS cy ON c.country_id = cy.country_id
  INNER JOIN staff AS m ON s.manager_staff_id = m.staff_id
GROUP BY s.library_id
ORDER BY cy.country, c.city;

-- -----------------------------------------------------
-- View `mydb`.`authour_info`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`authour_info`;
DROP VIEW IF EXISTS `mydb`.`authour_info` ;
USE `mydb`;
CREATE 
   OR REPLACE DEFINER=CURRENT_USER
  SQL SECURITY INVOKER
  VIEW authour_info
AS
SELECT
  a.authour_id,
  a.first_name,
  a.last_name,
  GROUP_CONCAT(
     DISTINCT
     CONCAT(c.name, ': ',
        (SELECT 
           GROUP_CONCAT(f.title ORDER BY f.title SEPARATOR ', ')
           FROM mydb.book f
           INNER JOIN mydb.book_category fc ON f.book_id = fc.book_id
           INNER JOIN mydb.book_authour fa ON f.book_id = fa.book_id
           WHERE fc.category_id = c.category_id AND fa.authour_id = a.authour_id)
        )  -- end CONCAT
     ORDER BY c.name
     SEPARATOR '; ') AS book_info
FROM mydb.authour a
LEFT JOIN mydb.book_authour fa ON a.authour_id = fa.authour_id
LEFT JOIN mydb.book_category fc ON fa.book_id = fc.book_id
LEFT JOIN mydb.category c ON fc.category_id = c.category_id
GROUP BY
  a.authour_id,
  a.first_name,
  a.last_name;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
