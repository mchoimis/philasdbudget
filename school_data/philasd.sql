--
-- Table for school locations
--
DROP TABLE IF EXISTS school_location;
CREATE TABLE school_location (
  id serial,
  school_code varchar(20));

SELECT AddGeometryColumn('school_location', 'geom', 4326, 'POINT', 2);

-- ----------------------------
--  Table structure for SCHOOL_ENROLLMENT
-- ----------------------------
DROP TABLE IF EXISTS SCHOOL_ENROLLMENT;
CREATE TABLE SCHOOL_ENROLLMENT (
  SCHOOL_CODE varchar(10) DEFAULT NULL,
  SCHOOL_YEAR varchar(255) DEFAULT NULL,
  SCH_ATTENDANCE float DEFAULT NULL,
  SCH_ENROLLMENT integer DEFAULT NULL,
  SCH_STUDENT_ENTERED integer DEFAULT NULL,
  SCH_STUDENT_WITHDREW integer DEFAULT NULL
);

-- ----------------------------
--  Table structure for SCHOOL_ETHNICITY_LOW_INCOME
-- ----------------------------
DROP TABLE IF EXISTS SCHOOL_ETHNICITY_LOW_INCOME;
CREATE TABLE SCHOOL_ETHNICITY_LOW_INCOME (
  SCHOOL_CODE integer DEFAULT NULL,
  SCHOOL_YEAR varchar(255) DEFAULT NULL,
  AFRICAN_AMERICAN float DEFAULT NULL,
  WHITE float DEFAULT NULL,
  ASIAN float DEFAULT NULL,
  LATINO float DEFAULT NULL,
  OTHER float DEFAULT NULL,
  PACIFIC_ISLANDER float DEFAULT NULL,
  AMERICAN_INDIAN float DEFAULT NULL,
  SCH_LOW_INCOME_FAMILY float DEFAULT NULL
);

-- ----------------------------
--  Table structure for SCHOOL_INFORMATION
-- ----------------------------
DROP TABLE IF EXISTS SCHOOL_INFORMATION;
CREATE TABLE SCHOOL_INFORMATION (
  SCHOOL_CODE integer DEFAULT NULL,
  SCHOOL_NAME_1 varchar(255) DEFAULT NULL,
  SCHOOL_NAME_2 varchar(255) DEFAULT NULL,
  ADDRESS varchar(255) DEFAULT NULL,
  SCHOOL_ZIP integer DEFAULT NULL,
  ZIP_PLUS_4 varchar(255) DEFAULT NULL,
  CITY varchar(255) DEFAULT NULL,
  STATE_CD varchar(255) DEFAULT NULL,
  PHONE_NUMBER varchar(30) DEFAULT NULL,
  SCH_START_GRADE integer DEFAULT NULL,
  SCH_TERM_GRADE integer DEFAULT NULL,
  HPADDR varchar(255) DEFAULT NULL,
  SCHOOL_LEVEL_NAME varchar(255) DEFAULT NULL
);

-- ----------------------------
--  Table structure for SCHOOL_PSSA
-- ----------------------------
DROP TABLE IF EXISTS SCHOOL_PSSA;
CREATE TABLE SCHOOL_PSSA (
  SCHOOL_CODE varchar(10) DEFAULT NULL,
  SCHOOL_YEAR varchar(255) DEFAULT NULL,
  GRADE integer DEFAULT NULL,
  MATH_ADVANCED_PERCENT varchar(255) DEFAULT NULL,
  MATH_PROFICIENT_PERCENT varchar(255) DEFAULT NULL,
  MATH_BASIC_PERCENT varchar(255) DEFAULT NULL,
  MATH_BELOW_BASIC_PERCENT varchar(255) DEFAULT NULL,
  READ_ADVANCED_PERCENT varchar(255) DEFAULT NULL,
  READ_PROFICIENT_PERCENT varchar(255) DEFAULT NULL,
  READ_BASIC_PERCENT varchar(255) DEFAULT NULL,
  READ_BELOW_BASIC_PERCENT varchar(255) DEFAULT NULL,
  MATH_COMBINED_PERCENT varchar(255) DEFAULT NULL,
  READ_COMBINED_PERCENT varchar(255) DEFAULT NULL
);

-- ----------------------------
--  Table structure for SCHOOL_SERIOUS_INCIDENTS
-- ----------------------------
DROP TABLE IF EXISTS SCHOOL_SERIOUS_INCIDENTS;
CREATE TABLE SCHOOL_SERIOUS_INCIDENTS (
  ULCS_NO integer DEFAULT NULL,
  SCHOOL_YEAR varchar(255) DEFAULT NULL,
  ASSAULT integer DEFAULT NULL,
  DRUG integer DEFAULT NULL,
  MORALS integer DEFAULT NULL,
  WEAPONS integer DEFAULT NULL,
  THEFT integer DEFAULT NULL
);

-- ----------------------------
--  Table structure for SCHOOL_STUDENT
-- ----------------------------
DROP TABLE IF EXISTS SCHOOL_STUDENT;
CREATE TABLE SCHOOL_STUDENT (
  SCHOOL_CODE integer DEFAULT NULL,
  SCHOOL_YEAR varchar(255) DEFAULT NULL,
  SCH_SPEC_ED_SERVICES float DEFAULT NULL,
  SCH_MG float DEFAULT NULL,
  SCH_ESOL_SERVICES float DEFAULT NULL
);

-- ----------------------------
--  Table structure for SCHOOL_SUSPENSIONS
-- ----------------------------
DROP TABLE IF EXISTS SCHOOL_SUSPENSIONS;
CREATE TABLE SCHOOL_SUSPENSIONS (
  SCHOOL_CODE integer DEFAULT NULL,
  SCHOOL_YEAR varchar(255) DEFAULT NULL,
  TOTAL_SUSPENSIONS integer DEFAULT NULL,
  SCH_ONE_TIME_SUSP integer DEFAULT NULL,
  SCH_TWO_TIME_SUSP integer DEFAULT NULL,
  SCH_THREE_TIME_SUSP integer DEFAULT NULL,
  SCH_MORE_THAN_THREE_SUSP integer DEFAULT NULL
);

-- ----------------------------
--  Table structure for TEACHER_ATTEND
-- ----------------------------
DROP TABLE IF EXISTS TEACHER_ATTEND;
CREATE TABLE TEACHER_ATTEND (
  SCHOOL_CODE integer DEFAULT NULL,
  SCHOOL_YEAR varchar(255) DEFAULT NULL,
  SCH_TEACHER_ATTEND float DEFAULT NULL,
  SDP_TEACHER_ATTEND_AVG float DEFAULT NULL
);

\copy school_enrollment FROM 'school_enrollment.csv' DELIMITER ','
\copy school_ethnicity_low_income FROM 'school_ethnicity_low_income.csv' DELIMITER ','
\copy school_information FROM 'school_information.csv' DELIMITER ',' CSV HEADER
\copy school_pssa FROM 'school_pssa.csv' DELIMITER ',' CSV HEADER
\copy school_serious_incidents FROM 'school_serious_incidents.csv' DELIMITER ',' CSV HEADER
\copy school_student FROM 'school_student.csv' DELIMITER ',' CSV HEADER
\copy school_suspensions FROM 'school_suspensions.csv' DELIMITER ',' CSV HEADER
\copy teacher_attend FROM 'teacher_attend.csv' DELIMITER ',' CSV HEADER


DROP TABLE IF EXISTS school_location_tmp;
CREATE TABLE school_location_tmp (
  school_code varchar(20),
  lat real,
  lng real);

\copy school_location_tmp FROM 'schools_geocoded.csv' DELIMITER ',' CSV HEADER

INSERT INTO school_location (school_code, geom)
  SELECT school_code, ST_SetSRID(makepoint(lng, lat), 4326)
  FROM school_location_tmp;

DROP TABLE IF EXISTS school_location_tmp;
