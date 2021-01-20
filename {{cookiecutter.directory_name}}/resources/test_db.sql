-- TEST DB
-- Run this script on your local MySQL installation to be able to run the tests.

DROP DATABASE IF EXISTS `{{cookiecutter.app_name}}_test`;
DROP USER IF EXISTS `{{cookiecutter.app_name}}_test`@`localhost`;
CREATE DATABASE `{{cookiecutter.app_name}}_test`;
CREATE USER `{{cookiecutter.app_name}}`@`localhost` IDENTIFIED BY 'test';
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, INDEX, DROP, ALTER, CREATE TEMPORARY TABLES, LOCK TABLES 
	ON {{cookiecutter.app_name}}_test.* TO `{{cookiecutter.app_name}}`@`localhost`;

