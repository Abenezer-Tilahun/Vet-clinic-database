/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
id int GENERATED ALWAYS AS IDENTITY NOT NULL,
name VARCHAR(30) NOT NULL ,
date_of_birth date ,
escape_attempts integer ,
neutered boolean,
weight_kg decimal,
PRIMARY KEY(id)
);

ALTER TABLE animals ADD species VARCHAR(50);
