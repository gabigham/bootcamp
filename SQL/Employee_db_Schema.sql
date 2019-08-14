-- Employee database Schemata written by G Bigham 8.13.19


-- DROP TABLE "departments" CASCADE;
CREATE TABLE "departments" (
    "dept_no" char(4)   NOT NULL,
    "dept_name" name   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

--DROP TABLE "dept_emp";
CREATE TABLE "dept_emp" (
    "emp_no" int   NOT NULL,
    "dept_no" char(4)   NOT NULL,
    "from_date" date   NOT NULL,
    "to_date" date   NOT NULL
);

--DROP TABLE "dept_manager";
CREATE TABLE "dept_manager" (
    "dept_no" char(4)   NOT NULL,
    "emp_no" int   NOT NULL,
    "from_date" date   NOT NULL,
    "to_date" date   NOT NULL
);

--DROP TABLE "employees" cascade;
CREATE TABLE "employees" (
    "emp_no" int   NOT NULL,
    "birth_date" date   NOT NULL,
    "first_name" name   NOT NULL,
    "last_name" name   NOT NULL,
    "gender" char(1)   NOT NULL,
    "hire_date" date   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

--DROP TABLE "salaries";
CREATE TABLE "salaries" (
    "emp_no" int   NOT NULL,
    "salary" float   NOT NULL,
    "from_date" date   NOT NULL,
    "to_date" date   NOT NULL
);

--DROP TABLE "titles";
CREATE TABLE "titles" (
    "emp_no" int   NOT NULL,
    "title" name   NOT NULL,
    "from_date" date   NOT NULL,
    "to_date" date   NOT NULL
);

