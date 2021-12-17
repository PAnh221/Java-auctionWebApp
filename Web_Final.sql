-- MySQL Script generated by MySQL Workbench
-- Fri Dec 17 12:38:30 2021
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`CATEGORY`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`CATEGORY` ;

CREATE TABLE IF NOT EXISTS `mydb`.`CATEGORY` (
  `id_category` INT NOT NULL,
  `name` NVARCHAR(45) NULL,
  PRIMARY KEY (`id_category`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`SUBCATEGORY`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`SUBCATEGORY` ;

CREATE TABLE IF NOT EXISTS `mydb`.`SUBCATEGORY` (
  `id_subcategory` INT NOT NULL,
  `name` NVARCHAR(30) NOT NULL,
  `id_category` INT NOT NULL,
  PRIMARY KEY (`id_subcategory`),
  INDEX `category_to_subcategory_idx` (`id_category` ASC) VISIBLE,
  CONSTRAINT `category_to_subcategory`
    FOREIGN KEY (`id_category`)
    REFERENCES `mydb`.`CATEGORY` (`id_category`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ROLE`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`ROLE` ;

CREATE TABLE IF NOT EXISTS `mydb`.`ROLE` (
  `id_role` INT NOT NULL,
  `role_name` NVARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_role`),
  UNIQUE INDEX `role_name_UNIQUE` (`role_name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`USER`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`USER` ;

CREATE TABLE IF NOT EXISTS `mydb`.`USER` (
  `id_user` INT NOT NULL,
  `f_name` NVARCHAR(45) NOT NULL,
  `l_name` NVARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `negative_rate` INT NOT NULL DEFAULT 0,
  `positive_rate` INT NOT NULL DEFAULT 0,
  `id_role` INT NULL,
  PRIMARY KEY (`id_user`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  INDEX `user-ca_idx` (`id_role` ASC) VISIBLE,
  CONSTRAINT `user-ca`
    FOREIGN KEY (`id_role`)
    REFERENCES `mydb`.`ROLE` (`id_role`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ACCOUNT`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`ACCOUNT` ;

CREATE TABLE IF NOT EXISTS `mydb`.`ACCOUNT` (
  `id_account` INT NOT NULL,
  `username` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `id_user` INT NOT NULL,
  PRIMARY KEY (`id_account`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC) VISIBLE,
  UNIQUE INDEX `id_user_UNIQUE` (`id_user` ASC) VISIBLE,
  CONSTRAINT `id_user`
    FOREIGN KEY (`id_user`)
    REFERENCES `mydb`.`USER` (`id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`PRODUCT`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`PRODUCT` ;

CREATE TABLE IF NOT EXISTS `mydb`.`PRODUCT` (
  `id_product` INT NOT NULL,
  `name` NVARCHAR(45) NOT NULL,
  `id_seller` INT NOT NULL,
  `price` INT NULL,
  `BINP` INT NULL,
  `id_subcategory` INT NULL,
  `price_step` INT NULL,
  `date_start` DATETIME NULL,
  `date_end` DATETIME NULL,
  `pic` VARCHAR(45) NULL,
  `description` NVARCHAR(200) NULL,
  PRIMARY KEY (`id_product`),
  INDEX `product_subcategory_idx` (`id_subcategory` ASC) VISIBLE,
  INDEX `id_seller_idx` (`id_seller` ASC) VISIBLE,
  CONSTRAINT `product_subcategory`
    FOREIGN KEY (`id_subcategory`)
    REFERENCES `mydb`.`SUBCATEGORY` (`id_subcategory`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_seller`
    FOREIGN KEY (`id_seller`)
    REFERENCES `mydb`.`USER` (`id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`BIDDING`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`BIDDING` ;

CREATE TABLE IF NOT EXISTS `mydb`.`BIDDING` (
  `id_bidding` INT NOT NULL,
  `id_bidder` INT NULL,
  `id_product` INT NULL,
  `price` INT NULL,
  `date_time` DATETIME NULL,
  PRIMARY KEY (`id_bidding`),
  INDEX `id_pr_idx` (`id_product` ASC) VISIBLE,
  INDEX `id_bidder_idx` (`id_bidder` ASC) VISIBLE,
  CONSTRAINT `id_pr`
    FOREIGN KEY (`id_product`)
    REFERENCES `mydb`.`PRODUCT` (`id_product`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_bidder`
    FOREIGN KEY (`id_bidder`)
    REFERENCES `mydb`.`USER` (`id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`PICTURE`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`PICTURE` ;

CREATE TABLE IF NOT EXISTS `mydb`.`PICTURE` (
  `id_pic` INT NOT NULL,
  `id_pr` INT NOT NULL,
  `pic` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_pic`),
  INDEX `id_pr_pic_idx` (`id_pr` ASC) VISIBLE,
  CONSTRAINT `id_pr_pic`
    FOREIGN KEY (`id_pr`)
    REFERENCES `mydb`.`PRODUCT` (`id_product`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`WISHLIST`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`WISHLIST` ;

CREATE TABLE IF NOT EXISTS `mydb`.`WISHLIST` (
  `id_user` INT NOT NULL,
  `id_product` INT NOT NULL,
  PRIMARY KEY (`id_user`, `id_product`),
  INDEX `wishlist_pr_idx` (`id_product` ASC) VISIBLE,
  CONSTRAINT `wishlist_user`
    FOREIGN KEY (`id_user`)
    REFERENCES `mydb`.`USER` (`id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `wishlist_pr`
    FOREIGN KEY (`id_product`)
    REFERENCES `mydb`.`PRODUCT` (`id_product`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;