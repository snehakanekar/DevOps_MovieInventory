drop database if exists onlinemoviebookingsystem;

create database onlinemoviebookingsystem;

use onlinemoviebookingsystem;

create table movie(movieCode varchar(255),movieName varchar(255),showDate varchar(255), lang varchar(255));

GRANT ALL PRIVILEGES ON onlinemoviebookingsystem.* TO 'root'@'%' IDENTIFIED BY 'root';
