/*Queries that provide answers to the questions from all projects.*/

SELECT * from animals WHERE name LIKE '%mon%';

SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';

SELECT name FROM animals WHERE neutered IS true AND escape_attempts < 3 ;

SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';

SELECT name,escape_attempts FROM animals WHERE weight_kg > 10.5 ;

SELECT * FROM animals WHERE neutered = true ;

SELECT * FROM animals WHERE name <> 'Gabumon' ;

SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3 ;

BEGIN;
UPDATE animals SET species = 'unspecified' ;
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;


BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon%';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL ;
SELECT * FROM animals;
COMMIT;
SELECT * FROM animals;


BEGIN;
DELETE FROM animals;
ROLLBACK;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT SV1;
UPDATE animals SET weight_kg = (weight_kg * (-1));
ROLLBACK TO SV1;
UPDATE animals SET weight_kg = (weight_kg * (-1)) WHERE weight_kg < 0;
COMMIT;


SELECT COUNT(*) AS total_animals FROM animals;
SELECT COUNT(*) AS never_tried_to_escape FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) AS average_weight FROM animals;
SELECT neutered, MAX(escape_attempts) AS max_escape_attempts FROM animals GROUP BY neutered;
SELECT species, MIN(weight_kg) AS min_weight, MAX(weight_kg) AS max_weight FROM animals GROUP BY species;
SELECT species, AVG(escape_attempts) AS avg_escape_attempts FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;

-- queries using join

SELECT name AS melody_Pond_animals FROM animals 
INNER JOIN owners
ON animals.owner_id = owners.id
WHERE owners.full_name = 'Melody Pond';


SELECT animals.name AS pokemon FROM animals
INNER JOIN species
ON animals.species_id = species.id
WHERE species.name = 'Pokemon';


SELECT owners.full_name AS owner_name, animals.name AS animal FROM animals
FULL OUTER JOIN owners
ON animals.owner_id = owners.id;


SELECT species.name AS species_name, COUNT(species_id) AS animal_count
FROM animals
INNER JOIN species
ON animals.species_id = species.id
GROUP BY species.name;

SELECT animals.name AS digimons_own_by_Jennifer
 FROM animals
INNER JOIN owners ON animals.owner_id = owners.id
INNER JOIN species ON animals.species_id = species.id
WHERE owners.full_name = 'Jennifer Orwell' AND species.name = 'Digimon';


SELECT animals.name AS Owned_by_Dean_and_never_tried_to_escape 
FROM animals 
INNER JOIN owners ON animals.owner_id = owners.id
WHERE animals.escape_attempts = 0 AND owners.full_name = 'Dean Wimchester';

SELECT owners.full_name, COUNT(*) AS animal_count
FROM animals
INNER JOIN owners ON animals.owner_id = owners.id
GROUP BY owners.full_name
ORDER BY animal_count DESC
LIMIT 1;
