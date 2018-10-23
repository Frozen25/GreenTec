// Create Especie
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:///Especie.csv" AS row
CREATE (:Especie {Name: row.NombreV, EspecieId: row.idEspecie});

// Create index to ensure quick lookup when creating relations
CREATE INDEX ON :Especie(Name);
CREATE INDEX ON :Especie(EspecieId);

// As the indexes are created after the nodes are inserted,
// their population happens asynchronously,
// so we use schema await (a shell command) to block until they are 
// populated.
// schema await 

// Creating chain relations
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:///Cadena.csv" AS row
MATCH (EspecieA:Especie {EspecieId: row.Depredador})
MATCH (EspecieB:Especie {EspecieId: row.Presa})
WHERE 1=1
MERGE (EspecieA)-[:Come]->(EspecieB);
