/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name like '%mon';
SELECT * FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-01-01';
SELECT * FROM animals WHERE neutered = 'true' AND  escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR  name = 'Pikachu';
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = 'true';
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg BETWEEN 10.40 AND 17.3;

/*Inside a transaction update the animals table by setting the species column to unspecified. Verify that change was made. Then roll back the change and verify that species columns went back to the state before transaction.*/

BEGIN;
UPDATE animals SET species = 'unspecified'  WHERE neutered = 'false';
UPDATE animals SET species = 'unspecified'  WHERE neutered = 'true';
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;


/*Set species of all animals with names ending 'mon' to 'digimon' */

BEGIN;
UPDATE animals SET species = 'digimon'  WHERE name like '%mon';
UPDATE animals SET species = 'pokemon'  WHERE name not like '%mon';
COMMIT;
SELECT * FROM animals;


/*Now, take a deep breath and... Inside a transaction delete all records in the animals table, then roll back the transaction. After the roll back verify if all records in the animals table still exist. After that you can start breath as usual ;)*/

BEGIN;
SAVEPOINT SP1;
DELETE FROM animals WHERE species = 'digimon';
DELETE FROM animals WHERE species = 'pokemon';
SELECT * FROM animals;
ROLLBACK TO SP1;
SELECT * FROM animals;

/* inside a transaction delete, create a savepoint, rollback and update */

BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT SP1;
UPDATE animals SET weight_kg = weight_kg * 1;
ROLLBACK TO SP1;
COMMIT;

/* write queries to answer the following questions */

SELECT COUNT(*) FROM animals;
SELECT COUNT(*) FROM animals WHERE escape_attempts < 1;
SELECT AVG(weight_kg) FROM animals;
SELECT MAX(escape_attempts) FROM animals;
SELECT MAX(weight_kg), MIN(weight_kg) FROM animals GROUP BY species;
SELECT AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-01-01' GROUP BY species;

/* write queries to answer the questions */

SELECT animals.name FROM animals JOIN owners ON animals.owner_id = owners.id WHERE full_name = 'Melody Pond';

SELECT animals.name FROM animals JOIN species ON animals.species_id = species.id WHERE species.name = 'Pokemon';

SELECT species.name, COUNT(*) FROM animals JOIN species ON species.id = animals.species_id GROUP BY species.name;

SELECT animals.name, owners.full_name, species.name FROM animals
JOIN species ON species.id = animals.species_id
JOIN owners ON owners.id = animals.owner_id
WHERE owners.full_name = 'Jennifer Orwell' AND species.name = 'Digimon';

SELECT * FROM animals JOIN owners ON animals.owner_id = owners.id
WHERE animals.escape_attempts = 0 AND owners.fulL_name = 'Dean Winchester';

SELECT owners.full_name, COUNT(*) AS count FROM owners JOIN animals ON animals.owner_id = owners.id GROUP BY owners.id ORDER BY count DESC limit 1;