MATCH (n)
DETACH DELETE n;

// Create Species
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:///%s" AS row
FOREACH(ignoreMe IN CASE WHEN toInt(row.idTipoEspecie) = 1 THEN [1] ELSE [] END | 
    CREATE (:Species:Animal {NonScientificName: row.NombreVulgar, ScientificName: row.NombreCientifico, IDSpecies : toInt(row.idEspecie)})
)
FOREACH(ignoreMe IN CASE WHEN toInt(row.idTipoEspecie) = 2 THEN [1] ELSE [] END | 
    CREATE (:Species:Vegetal {NonScientificName: row.NombreVulgar, ScientificName: row.NombreCientifico, IDSpecies : toInt(row.idEspecie)})
)
FOREACH(ignoreMe IN CASE WHEN toInt(row.idTipoEspecie) = 3 THEN [1] ELSE [] END | 
    CREATE (:Species:Mineral {NonScientificName: row.NombreVulgar, ScientificName: row.NombreCientifico, IDSpecies : toInt(row.idEspecie)})
);



//Create index to ensure quick lookup when creating relations
CREATE INDEX ON :Animal(IDSpecies);
CREATE INDEX ON :Vegetal(IDSpecies);
CREATE INDEX ON :Mineral(IDSpecies);

// Creating chain relations
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:///%s" AS row
MATCH (speciesA:Species {IDSpecies: toInt(row.Cazador)})
MATCH (speciesB:Species {IDSpecies: toInt(row.Presa)})
MERGE (speciesA)-[:Come]->(speciesB);

MATCH (n)
RETURN n;