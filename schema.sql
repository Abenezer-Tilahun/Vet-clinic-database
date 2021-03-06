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

CREATE TABLE owners (
id INT GENERATED BY DEFAULT AS IDENTITY (START WITH 1 INCREMENT BY 1), 
full_name VARCHAR(50) NOT NULL ,
age INT ,
PRIMARY KEY(id)
);

CREATE TABLE  species (
id INT GENERATED BY DEFAULT AS IDENTITY (START WITH 1 INCREMENT BY 1), 
name VARCHAR(50) NOT NULL ,
PRIMARY KEY(id)
);

ALTER TABLE animals DROP COLUMN species;

ALTER TABLE animals ADD COLUMN species_id INT;

ALTER TABLE animals ADD CONSTRAINT fk_species FOREIGN KEY(species_id) REFERENCES species(id); 

ALTER TABLE animals ADD COLUMN owner_id INT;

ALTER TABLE animals ADD CONSTRAINT fk_owners FOREIGN KEY(owner_id) REFERENCES owners(id);

CREATE TABLE vets (
id INT GENERATED BY DEFAULT AS IDENTITY (START WITH 1 INCREMENT BY 1), 
name VARCHAR(50) NOT NULL ,
age INT ,
date_of_graduation DATE,
PRIMARY KEY(id)
);

CREATE TABLE specializations (
id INT GENERATED BY DEFAULT AS IDENTITY (START WITH 1 INCREMENT BY 1), 
species_id  INT,
vet_id    INT,
CONSTRAINT fk_species FOREIGN KEY (species_id) REFERENCES species(id),
CONSTRAINT fk_vets FOREIGN KEY (vet_id) REFERENCES vets(id),
PRIMARY KEY(id)
);

CREATE TABLE visits (
visit_id INT GENERATED BY DEFAULT AS IDENTITY (START WITH 1 INCREMENT BY 1), 
animal_id   INT,
vet_id      INT,
date_of_visit     DATE,
CONSTRAINT     fk_animals FOREIGN KEY(animal_id) REFERENCES animals(id),
CONSTRAINT     fk_vets FOREIGN KEY(vet_id) REFERENCES vets(id),
PRIMARY KEY(visit_id )
);

ALTER TABLE owners ADD COLUMN email VARCHAR(120);

CREATE INDEX ON owners(email);

CREATE INDEX ON visits(vet_id ASC);

CREATE INDEX ON visits(animal_id ASC);