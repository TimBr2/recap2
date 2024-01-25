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
-- Table `mydb`.`Medical`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Medical` (
  `Overtime_rate` INT NOT NULL,
  PRIMARY KEY (`Overtime_rate`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Docter`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Docter` (
  `Name` VARCHAR(45) NOT NULL,
  `Date_of_birth` DATE NULL,
  `Adresses` LONGTEXT NULL,
  `Phone_number` INT UNSIGNED NULL,
  `Salary` DECIMAL UNSIGNED NULL,
  `Medical_Overtime_rate` INT NOT NULL,
  PRIMARY KEY (`Name`),
  UNIQUE INDEX `Phone_number_UNIQUE` (`Phone_number` ASC) VISIBLE,
  INDEX `fk_Docter_Medical1_idx` (`Medical_Overtime_rate` ASC) VISIBLE,
  CONSTRAINT `fk_Docter_Medical1`
    FOREIGN KEY (`Medical_Overtime_rate`)
    REFERENCES `mydb`.`Medical` (`Overtime_rate`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Specialist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Specialist` (
  `Field_area` INT NOT NULL,
  `Docter_Name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Field_area`),
  INDEX `fk_Specialist_Docter1_idx` (`Docter_Name` ASC) VISIBLE,
  CONSTRAINT `fk_Specialist_Docter1`
    FOREIGN KEY (`Docter_Name`)
    REFERENCES `mydb`.`Docter` (`Name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Patient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Patient` (
  `Name_pat` VARCHAR(45) NOT NULL,
  `Adress_pat` LONGTEXT NOT NULL,
  `Phone_number_pat` INT UNSIGNED NOT NULL,
  `Date_of_birth_pat` DATE NOT NULL,
  PRIMARY KEY (`Name_pat`),
  UNIQUE INDEX `Phone_number_pat_UNIQUE` (`Phone_number_pat` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Appointment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Appointment` (
  `Date` DATE NOT NULL,
  `Time` TIME NULL,
  PRIMARY KEY (`Date`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Payment` (
  `Details` VARCHAR(45) NOT NULL,
  `Method` VARCHAR(45) NULL,
  PRIMARY KEY (`Details`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Bill`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Bill` (
  `Total` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`Total`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Payment_has_Bill`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Payment_has_Bill` (
  `Payment_Details` VARCHAR(45) NOT NULL,
  `Bill_Total` INT UNSIGNED NOT NULL,
  `Payment_Details1` VARCHAR(45) NOT NULL,
  `Bill_Total1` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`Payment_Details`, `Bill_Total`),
  INDEX `fk_Payment_has_Bill_Payment1_idx` (`Payment_Details1` ASC) VISIBLE,
  INDEX `fk_Payment_has_Bill_Bill1_idx` (`Bill_Total1` ASC) VISIBLE,
  CONSTRAINT `fk_Payment_has_Bill_Payment1`
    FOREIGN KEY (`Payment_Details1`)
    REFERENCES `mydb`.`Payment` (`Details`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Payment_has_Bill_Bill1`
    FOREIGN KEY (`Bill_Total1`)
    REFERENCES `mydb`.`Bill` (`Total`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Docter_has_Patient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Docter_has_Patient` (
  `Docter_Name` VARCHAR(45) NOT NULL,
  `Patient_Name_pat` VARCHAR(45) NOT NULL,
  `Appointment_Date` DATE NOT NULL,
  `Payment_has_Bill_Payment_Details` VARCHAR(45) NOT NULL,
  `Payment_has_Bill_Bill_Total` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`Docter_Name`, `Patient_Name_pat`),
  INDEX `fk_Docter_has_Patient_Patient1_idx` (`Patient_Name_pat` ASC) VISIBLE,
  INDEX `fk_Docter_has_Patient_Docter1_idx` (`Docter_Name` ASC) VISIBLE,
  INDEX `fk_Docter_has_Patient_Appointment1_idx` (`Appointment_Date` ASC) VISIBLE,
  INDEX `fk_Docter_has_Patient_Payment_has_Bill1_idx` (`Payment_has_Bill_Payment_Details` ASC, `Payment_has_Bill_Bill_Total` ASC) VISIBLE,
  CONSTRAINT `fk_Docter_has_Patient_Docter1`
    FOREIGN KEY (`Docter_Name`)
    REFERENCES `mydb`.`Docter` (`Name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Docter_has_Patient_Patient1`
    FOREIGN KEY (`Patient_Name_pat`)
    REFERENCES `mydb`.`Patient` (`Name_pat`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Docter_has_Patient_Appointment1`
    FOREIGN KEY (`Appointment_Date`)
    REFERENCES `mydb`.`Appointment` (`Date`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Docter_has_Patient_Payment_has_Bill1`
    FOREIGN KEY (`Payment_has_Bill_Payment_Details` , `Payment_has_Bill_Bill_Total`)
    REFERENCES `mydb`.`Payment_has_Bill` (`Payment_Details` , `Bill_Total`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
