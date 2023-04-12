-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema A2_Locvrxxxxxx
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema A2_Locvrxxxxxx
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `A2_Locvrxxxxxx` DEFAULT CHARACTER SET utf8 ;
USE `A2_Locvrxxxxxx` ;

-- -----------------------------------------------------
-- Table `A2_Locvrxxxxxx`.`Parks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `A2_Locvrxxxxxx`.`Parks` (
  `parkID` INT NOT NULL AUTO_INCREMENT,
  `parkName` VARCHAR(255) NULL,
  `region` VARCHAR(45) NULL,
  `openDate` DATE NULL,
  `closeDate` DATE NULL,
  `parkType` VARCHAR(45) NULL,
  PRIMARY KEY (`parkID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `A2_Locvrxxxxxx`.`User`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `A2_Locvrxxxxxx`.`User` (
  `userID` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(45) NULL,
  `password` VARCHAR(45) NULL,
  `balanceAmt` DOUBLE NULL,
  PRIMARY KEY (`userID`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `A2_Locvrxxxxxx`.`Equipments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `A2_Locvrxxxxxx`.`Equipments` (
  `equipID` INT NOT NULL AUTO_INCREMENT,
  `equipName` VARCHAR(45) NULL,
  `availableQty` INT NULL,
  `price` DOUBLE NULL,
  PRIMARY KEY (`equipID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `A2_Locvrxxxxxx`.`Reservation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `A2_Locvrxxxxxx`.`Reservation` (
  `reservationID` INT NOT NULL AUTO_INCREMENT,
  `reservationName` VARCHAR(45) NULL,
  `arr_date` DATE NULL,
  `dep_date` DATE NULL,
  `countOfPax` INT NULL,
  `reservType` VARCHAR(45) NULL,
  `equipID` INT NULL,
  `totalAmt` DOUBLE NULL,
  `parkID` INT NULL,
  `userID` INT NULL,
  PRIMARY KEY (`reservationID`),
  INDEX `FK1_RES_PARK_idx` (`parkID` ASC) VISIBLE,
  INDEX `FK2_RES_USER_idx` (`userID` ASC) VISIBLE,
  INDEX `FK3_RES_EQUIP_idx` (`equipID` ASC) VISIBLE,
  CONSTRAINT `FK1_RES_PARK`
    FOREIGN KEY (`parkID`)
    REFERENCES `A2_Locvrxxxxxx`.`Parks` (`parkID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK2_RES_USER`
    FOREIGN KEY (`userID`)
    REFERENCES `A2_Locvrxxxxxx`.`User` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK3_RES_EQUIP`
    FOREIGN KEY (`equipID`)
    REFERENCES `A2_Locvrxxxxxx`.`Equipments` (`equipID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `A2_Locvrxxxxxx`.`eGiftCard`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `A2_Locvrxxxxxx`.`eGiftCard` (
  `giftCardID` INT NOT NULL,
  `recepientName` VARCHAR(45) NULL,
  `recepientEmail` VARCHAR(45) NULL,
  `valueAmt` DECIMAL(4,2) NULL,
  `sendersName` VARCHAR(45) NULL,
  `message` TEXT(255) NULL,
  `userID` INT NULL,
  PRIMARY KEY (`giftCardID`),
  INDEX `FK1_GIFT_USER_idx` (`userID` ASC) VISIBLE,
  CONSTRAINT `FK1_GIFT_USER`
    FOREIGN KEY (`userID`)
    REFERENCES `A2_Locvrxxxxxx`.`User` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `A2_Locvrxxxxxx`.`EventApplication`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `A2_Locvrxxxxxx`.`EventApplication` (
  `appID` INT NOT NULL AUTO_INCREMENT,
  `eventName` VARCHAR(45) NULL,
  `eventHost` VARCHAR(45) NULL,
  `count` INT NULL,
  `startDate` DATE NULL,
  `startTime` DATETIME NULL,
  `appStatus` VARCHAR(45) NULL,
  `userID` INT NULL,
  `parkID` INT NULL,
  PRIMARY KEY (`appID`),
  INDEX `FK1_EVENT_USER_idx` (`userID` ASC) VISIBLE,
  INDEX `FK2_EVENT_PARK_idx` (`parkID` ASC) VISIBLE,
  CONSTRAINT `FK1_EVENT_USER`
    FOREIGN KEY (`userID`)
    REFERENCES `A2_Locvrxxxxxx`.`User` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK2_EVENT_PARK`
    FOREIGN KEY (`parkID`)
    REFERENCES `A2_Locvrxxxxxx`.`Parks` (`parkID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
