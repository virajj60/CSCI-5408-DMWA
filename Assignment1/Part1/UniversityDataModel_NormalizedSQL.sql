-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema uni
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema uni
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `uni` DEFAULT CHARACTER SET utf8 ;
USE `uni` ;

-- -----------------------------------------------------
-- Table `uni`.`UNIVERSITY`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `uni`.`UNIVERSITY` (
  `uni_name` VARCHAR(45) NOT NULL,
  `uni_addr` VARCHAR(45) NULL,
  PRIMARY KEY (`uni_name`),
  UNIQUE INDEX `university_name_UNIQUE` (`uni_name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `uni`.`FACULTY`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `uni`.`FACULTY` (
  `faculty_id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `experience` DECIMAL(4,2) NULL,
  `faculty_type` VARCHAR(45) NULL,
  PRIMARY KEY (`faculty_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `uni`.`Department`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `uni`.`Department` (
  `dept_id` INT NOT NULL,
  `dept_name` VARCHAR(45) NULL,
  `dept_head` INT NULL,
  `UNIVERSITY_uni_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`dept_id`, `UNIVERSITY_uni_name`),
  UNIQUE INDEX `idDepartment_UNIQUE` (`dept_id` ASC) VISIBLE,
  INDEX `fk_Department_UNIVERSITY_idx` (`UNIVERSITY_uni_name` ASC) VISIBLE,
  INDEX `fk_Depart_Faculty_idx` (`dept_head` ASC) VISIBLE,
  CONSTRAINT `fk_Department_UNIVERSITY`
    FOREIGN KEY (`UNIVERSITY_uni_name`)
    REFERENCES `uni`.`UNIVERSITY` (`uni_name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Depart_Faculty`
    FOREIGN KEY (`dept_head`)
    REFERENCES `uni`.`FACULTY` (`faculty_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `uni`.`TutionFees`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `uni`.`TutionFees` (
  `tutionFees` DECIMAL(16,8) NOT NULL,
  PRIMARY KEY (`tutionFees`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `uni`.`Program`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `uni`.`Program` (
  `prog_id` VARCHAR(45) NOT NULL,
  `prog_name` VARCHAR(45) NULL,
  `prog_head` VARCHAR(45) NULL,
  `Department_dept_id` INT NOT NULL,
  `Department_UNIVERSITY_uni_name` VARCHAR(45) NOT NULL,
  `TutionFees_tutionFees` DECIMAL(16,8) NOT NULL,
  PRIMARY KEY (`prog_id`, `Department_dept_id`, `Department_UNIVERSITY_uni_name`, `TutionFees_tutionFees`),
  INDEX `fk_Program_Department1_idx` (`Department_dept_id` ASC, `Department_UNIVERSITY_uni_name` ASC) VISIBLE,
  INDEX `fk_Program_TutionFees1_idx` (`TutionFees_tutionFees` ASC) VISIBLE,
  CONSTRAINT `fk_Program_Department1`
    FOREIGN KEY (`Department_dept_id` , `Department_UNIVERSITY_uni_name`)
    REFERENCES `uni`.`Department` (`dept_id` , `UNIVERSITY_uni_name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Program_TutionFees1`
    FOREIGN KEY (`TutionFees_tutionFees`)
    REFERENCES `uni`.`TutionFees` (`tutionFees`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `uni`.`Student`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `uni`.`Student` (
  `student_id` INT NOT NULL,
  `student_name` VARCHAR(45) NULL,
  `student_DOB` DATE NULL,
  `UNIVERSITY_uni_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`student_id`, `UNIVERSITY_uni_name`),
  UNIQUE INDEX `student_id_UNIQUE` (`student_id` ASC) VISIBLE,
  INDEX `fk_Student_UNIVERSITY1_idx` (`UNIVERSITY_uni_name` ASC) VISIBLE,
  CONSTRAINT `fk_Student_UNIVERSITY1`
    FOREIGN KEY (`UNIVERSITY_uni_name`)
    REFERENCES `uni`.`UNIVERSITY` (`uni_name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `uni`.`Classroom`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `uni`.`Classroom` (
  `class_Id` INT NOT NULL,
  `classroom_name` VARCHAR(45) NULL,
  `classroom_addr` VARCHAR(45) NULL,
  PRIMARY KEY (`class_Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `uni`.`Laboratory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `uni`.`Laboratory` (
  `lab_name` VARCHAR(45) NULL,
  `lab_addr` VARCHAR(45) NULL,
  `lab_id` INT NOT NULL,
  PRIMARY KEY (`lab_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `uni`.`Course`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `uni`.`Course` (
  `course_id` INT NOT NULL,
  `course_name` VARCHAR(45) NULL,
  `course_credits` VARCHAR(45) NULL,
  `Program_Department_dept_id` INT NULL,
  `student_Id` INT NOT NULL,
  `FACULTY_faculty_id` INT NOT NULL,
  `class_Id` INT NOT NULL,
  `lab_id` INT NOT NULL,
  PRIMARY KEY (`course_id`, `student_Id`, `FACULTY_faculty_id`, `class_Id`, `lab_id`),
  INDEX `fk_Course_Program1_idx` (`Program_Department_dept_id` ASC) VISIBLE,
  INDEX `fk_course_student_idx` (`student_Id` ASC) VISIBLE,
  INDEX `fk_Course_FACULTY1_idx` (`FACULTY_faculty_id` ASC) VISIBLE,
  INDEX `fk_Course_Classroom1_idx` (`class_Id` ASC) VISIBLE,
  INDEX `fk_Course_Laboratory1_idx` (`lab_id` ASC) VISIBLE,
  CONSTRAINT `fk_Course_Program1`
    FOREIGN KEY (`Program_Department_dept_id`)
    REFERENCES `uni`.`Program` (`Department_dept_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_course_student`
    FOREIGN KEY (`student_Id`)
    REFERENCES `uni`.`Student` (`student_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Course_FACULTY1`
    FOREIGN KEY (`FACULTY_faculty_id`)
    REFERENCES `uni`.`FACULTY` (`faculty_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Course_Classroom1`
    FOREIGN KEY (`class_Id`)
    REFERENCES `uni`.`Classroom` (`class_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Course_Laboratory1`
    FOREIGN KEY (`lab_id`)
    REFERENCES `uni`.`Laboratory` (`lab_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `uni`.`Examination`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `uni`.`Examination` (
  `exam_id` INT NOT NULL,
  `exam_date` DATETIME NULL,
  `Course_course_id` INT NOT NULL,
  PRIMARY KEY (`exam_id`, `Course_course_id`),
  INDEX `fk_Examination_Course1_idx` (`Course_course_id` ASC) VISIBLE,
  CONSTRAINT `fk_Examination_Course1`
    FOREIGN KEY (`Course_course_id`)
    REFERENCES `uni`.`Course` (`course_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `uni`.`Schedule`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `uni`.`Schedule` (
  `schedule_id` INT NOT NULL,
  `schedule_info` VARCHAR(45) NULL,
  `Course_course_id` INT NULL,
  `Course_Program_Department_dept_id` INT NULL,
  PRIMARY KEY (`schedule_id`),
  UNIQUE INDEX `schedule_id_UNIQUE` (`schedule_id` ASC) VISIBLE,
  INDEX `fk_Schedule_Course1_idx` (`Course_course_id` ASC) VISIBLE,
  CONSTRAINT `fk1_Schedule_Course`
    FOREIGN KEY (`Course_course_id`)
    REFERENCES `uni`.`Course` (`course_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `uni`.`Campuses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `uni`.`Campuses` (
  `campus_name` VARCHAR(45) NOT NULL,
  `campus_addr` VARCHAR(45) NULL,
  `campus_map` GEOMETRY NULL,
  `UNIVERSITY_uni_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`campus_name`, `UNIVERSITY_uni_name`),
  UNIQUE INDEX `campus_name_UNIQUE` (`campus_name` ASC) VISIBLE,
  INDEX `fk_Campuses_UNIVERSITY1_idx` (`UNIVERSITY_uni_name` ASC) VISIBLE,
  CONSTRAINT `fk_Campuses_UNIVERSITY1`
    FOREIGN KEY (`UNIVERSITY_uni_name`)
    REFERENCES `uni`.`UNIVERSITY` (`uni_name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `uni`.`Library`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `uni`.`Library` (
  `library_id` INT NOT NULL,
  `library_name` VARCHAR(45) NULL,
  `Campuses_campus_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`library_id`, `Campuses_campus_name`),
  UNIQUE INDEX `library_id_UNIQUE` (`library_id` ASC) VISIBLE,
  INDEX `fk_Library_Campuses1_idx` (`Campuses_campus_name` ASC) VISIBLE,
  CONSTRAINT `fk_Library_Campuses1`
    FOREIGN KEY (`Campuses_campus_name`)
    REFERENCES `uni`.`Campuses` (`campus_name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `uni`.`Housing`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `uni`.`Housing` (
  `hostel_id` INT NOT NULL,
  `hostel_name` VARCHAR(45) NULL,
  `room_number` INT NULL,
  `room_status` VARCHAR(45) NULL,
  `Campuses_campus_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`hostel_id`, `Campuses_campus_name`),
  INDEX `fk_Housing_Campuses1_idx` (`Campuses_campus_name` ASC) VISIBLE,
  CONSTRAINT `fk_Housing_Campuses1`
    FOREIGN KEY (`Campuses_campus_name`)
    REFERENCES `uni`.`Campuses` (`campus_name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `uni`.`Alumni`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `uni`.`Alumni` (
  `alumni_id` INT NOT NULL,
  `first_name` VARCHAR(45) NULL,
  `last_name` VARCHAR(45) NULL,
  `program_id` VARCHAR(45) NULL,
  `passout_batch` VARCHAR(4) NULL,
  `UNIVERSITY_uni_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`alumni_id`, `UNIVERSITY_uni_name`),
  UNIQUE INDEX `alumni_id_UNIQUE` (`alumni_id` ASC) VISIBLE,
  INDEX `fk_Alumni_UNIVERSITY1_idx` (`UNIVERSITY_uni_name` ASC) VISIBLE,
  CONSTRAINT `fk_Alumni_UNIVERSITY1`
    FOREIGN KEY (`UNIVERSITY_uni_name`)
    REFERENCES `uni`.`UNIVERSITY` (`uni_name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `uni`.`SCHOLARSHIP`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `uni`.`SCHOLARSHIP` (
  `schol_id` INT NOT NULL,
  `schol_name` VARCHAR(45) NULL,
  `schol_amount` VARCHAR(45) NULL,
  `Student_student_id` INT NOT NULL,
  `UNIVERSITY_uni_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`schol_id`, `Student_student_id`, `UNIVERSITY_uni_name`),
  INDEX `fk_SCHOLARSHIP_Student1_idx` (`Student_student_id` ASC) VISIBLE,
  INDEX `fk_SCHOLARSHIP_UNIVERSITY1_idx` (`UNIVERSITY_uni_name` ASC) VISIBLE,
  CONSTRAINT `fk_SCHOLARSHIP_Student1`
    FOREIGN KEY (`Student_student_id`)
    REFERENCES `uni`.`Student` (`student_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_SCHOLARSHIP_UNIVERSITY1`
    FOREIGN KEY (`UNIVERSITY_uni_name`)
    REFERENCES `uni`.`UNIVERSITY` (`uni_name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `uni`.`Communities`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `uni`.`Communities` (
  `comm_name` VARCHAR(45) NOT NULL,
  `events` VARCHAR(45) NULL,
  `UNIVERSITY_uni_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`comm_name`, `UNIVERSITY_uni_name`),
  UNIQUE INDEX `comm_name_UNIQUE` (`comm_name` ASC) VISIBLE,
  INDEX `fk_Communities_UNIVERSITY1_idx` (`UNIVERSITY_uni_name` ASC) VISIBLE,
  CONSTRAINT `fk_Communities_UNIVERSITY1`
    FOREIGN KEY (`UNIVERSITY_uni_name`)
    REFERENCES `uni`.`UNIVERSITY` (`uni_name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `uni`.`International_Center`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `uni`.`International_Center` (
  `intl_events` VARCHAR(45) NOT NULL,
  `Communities_comm_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`intl_events`, `Communities_comm_name`),
  INDEX `fk_International_Center_Communities1_idx` (`Communities_comm_name` ASC) VISIBLE,
  CONSTRAINT `fk_International_Center_Communities1`
    FOREIGN KEY (`Communities_comm_name`)
    REFERENCES `uni`.`Communities` (`comm_name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `uni`.`DalCard`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `uni`.`DalCard` (
  `idDalCard` INT NOT NULL,
  `Upass_Start_Date` DATE NULL,
  `Upass_End_Date` DATE NULL,
  `card_balance` DOUBLE NULL,
  `card_transaction` DOUBLE NULL,
  `trans_amount` DOUBLE NULL,
  `Student_student_id` INT NOT NULL,
  PRIMARY KEY (`idDalCard`, `Student_student_id`),
  INDEX `fk_DalCard_Student1_idx` (`Student_student_id` ASC) VISIBLE,
  CONSTRAINT `fk_DalCard_Student1`
    FOREIGN KEY (`Student_student_id`)
    REFERENCES `uni`.`Student` (`student_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `uni`.`Dean`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `uni`.`Dean` (
  `faculty_id` INT NOT NULL,
  `faculty_type` VARCHAR(45) NOT NULL DEFAULT 'Dean',
  `office_address` VARCHAR(45) NULL,
  PRIMARY KEY (`faculty_id`, `faculty_type`),
  CONSTRAINT `fk1_dean_faculty`
    FOREIGN KEY (`faculty_id`)
    REFERENCES `uni`.`FACULTY` (`faculty_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `uni`.`INSTRUCTOR`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `uni`.`INSTRUCTOR` (
  `faculty_id` INT NOT NULL,
  `faculty_type` VARCHAR(45) NOT NULL DEFAULT 'Instructor',
  `office_hours` DATE NULL,
  PRIMARY KEY (`faculty_id`, `faculty_type`),
  CONSTRAINT `fk1_inst_facu`
    FOREIGN KEY (`faculty_id`)
    REFERENCES `uni`.`FACULTY` (`faculty_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `uni`.`PROFESSOR`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `uni`.`PROFESSOR` (
  `fauclty_id` INT NOT NULL,
  `faculty_type` VARCHAR(45) NOT NULL DEFAULT 'Professor',
  `office_hours` DATETIME NULL,
  PRIMARY KEY (`fauclty_id`, `faculty_type`),
  CONSTRAINT `fk1_prof_faculty`
    FOREIGN KEY (`fauclty_id`)
    REFERENCES `uni`.`FACULTY` (`faculty_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `uni`.`Building`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `uni`.`Building` (
  `building_id` INT NOT NULL,
  `building_name` VARCHAR(45) NULL,
  `building_addr` VARCHAR(45) NULL,
  `building_type` VARCHAR(45) NOT NULL,
  `UNIVERSITY_uni_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`building_id`, `building_type`, `UNIVERSITY_uni_name`),
  UNIQUE INDEX `building_id_UNIQUE` (`building_id` ASC) VISIBLE,
  INDEX `fk_Building_UNIVERSITY1_idx` (`UNIVERSITY_uni_name` ASC) VISIBLE,
  CONSTRAINT `fk_Building_UNIVERSITY1`
    FOREIGN KEY (`UNIVERSITY_uni_name`)
    REFERENCES `uni`.`UNIVERSITY` (`uni_name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `uni`.`FOODBANK`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `uni`.`FOODBANK` (
  `building_id` INT NOT NULL,
  `building_type` VARCHAR(45) NOT NULL DEFAULT 'foodbank',
  `start_time` DATETIME NULL,
  `end_time` DATETIME NULL,
  PRIMARY KEY (`building_id`, `building_type`),
  CONSTRAINT `fk1_food_build`
    FOREIGN KEY (`building_id` , `building_type`)
    REFERENCES `uni`.`Building` (`building_id` , `building_type`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `uni`.`BOOKSTORE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `uni`.`BOOKSTORE` (
  `building_id` INT NOT NULL,
  `building_type` VARCHAR(45) NOT NULL DEFAULT 'Bookstore',
  `book_name` VARCHAR(45) NULL,
  `book_amount` DECIMAL NULL,
  PRIMARY KEY (`building_id`, `building_type`),
  CONSTRAINT `fk1_book_build`
    FOREIGN KEY (`building_id` , `building_type`)
    REFERENCES `uni`.`Building` (`building_id` , `building_type`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `uni`.`OFFICE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `uni`.`OFFICE` (
  `building_id` INT NOT NULL,
  `building_type` VARCHAR(45) NOT NULL,
  `office_addr` VARCHAR(45) NULL,
  PRIMARY KEY (`building_id`, `building_type`),
  CONSTRAINT `fk1_off_build`
    FOREIGN KEY (`building_id` , `building_type`)
    REFERENCES `uni`.`Building` (`building_id` , `building_type`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `uni`.`ATHLETICS_CENTER`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `uni`.`ATHLETICS_CENTER` (
  `name` INT NOT NULL,
  `facility_time` DATETIME NULL,
  `UNIVERSITY_uni_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`name`, `UNIVERSITY_uni_name`),
  INDEX `fk_ATHLETICS_CENTER_UNIVERSITY1_idx` (`UNIVERSITY_uni_name` ASC) VISIBLE,
  CONSTRAINT `fk_ATHLETICS_CENTER_UNIVERSITY1`
    FOREIGN KEY (`UNIVERSITY_uni_name`)
    REFERENCES `uni`.`UNIVERSITY` (`uni_name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `uni`.`Insurance`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `uni`.`Insurance` (
  `insurance_name` VARCHAR(45) NOT NULL,
  `insured_amount` DECIMAL NULL,
  `Student_student_id` INT NOT NULL,
  PRIMARY KEY (`insurance_name`, `Student_student_id`),
  INDEX `fk_Insurance_Student1_idx` (`Student_student_id` ASC) VISIBLE,
  CONSTRAINT `fk_Insurance_Student1`
    FOREIGN KEY (`Student_student_id`)
    REFERENCES `uni`.`Student` (`student_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `uni`.`Application`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `uni`.`Application` (
  `application_Id` INT NOT NULL,
  `application_status` VARCHAR(45) NULL,
  `student_id` INT NULL,
  PRIMARY KEY (`application_Id`),
  INDEX `fk_app_stud_idx` (`student_id` ASC) VISIBLE,
  CONSTRAINT `fk_app_stud`
    FOREIGN KEY (`student_id`)
    REFERENCES `uni`.`Student` (`student_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `uni`.`Author`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `uni`.`Author` (
  `author_id` INT NOT NULL,
  `author_name` VARCHAR(45) NULL,
  PRIMARY KEY (`author_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `uni`.`Book`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `uni`.`Book` (
  `book_Id` INT NOT NULL,
  `book_name` VARCHAR(45) NULL,
  `book_price` DECIMAL NULL,
  `author_id` INT NULL,
  PRIMARY KEY (`book_Id`),
  INDEX `fk_book_auth_idx` (`author_id` ASC) VISIBLE,
  CONSTRAINT `fk_book_auth`
    FOREIGN KEY (`author_id`)
    REFERENCES `uni`.`Author` (`author_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `uni`.`BookBorrowed`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `uni`.`BookBorrowed` (
  `book_Id` INT NOT NULL,
  `student_id` VARCHAR(45) NULL,
  `library_id` INT NOT NULL,
  PRIMARY KEY (`book_Id`, `library_id`),
  INDEX `fk2_bookBorr_Lib_idx` (`library_id` ASC) VISIBLE,
  CONSTRAINT `fk1_bookBorr_Book`
    FOREIGN KEY (`book_Id`)
    REFERENCES `uni`.`Book` (`book_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk2_bookBorr_Lib`
    FOREIGN KEY (`library_id`)
    REFERENCES `uni`.`Library` (`library_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `uni`.`StudentGrades`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `uni`.`StudentGrades` (
  `student_id` INT NOT NULL,
  `course_id` INT NOT NULL,
  `grades` VARCHAR(2) NULL,
  PRIMARY KEY (`student_id`, `course_id`),
  INDEX `fk2-grade_course_idx` (`course_id` ASC) VISIBLE,
  CONSTRAINT `fk1_grade_stud`
    FOREIGN KEY (`student_id`)
    REFERENCES `uni`.`Student` (`student_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk2-grade_course`
    FOREIGN KEY (`course_id`)
    REFERENCES `uni`.`Course` (`course_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
