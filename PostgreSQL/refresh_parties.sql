-- Truncate the PARTIES table
TRUNCATE TABLE "PARTIES";

-- Get the maximum snapshotid value from the SNAPSHOTS table
SELECT MAX(snapshotid) INTO @SNAPSHOT_ID FROM "SNAPSHOTS";

-- Get the current date and time
SELECT NOW();

-- Load data from the 'parties.tsv' file into the PARTIES table
COPY "PARTIES" FROM 'parties.tsv' DELIMITER E'\t' CSV HEADER;

-- Get the current date and time again
SELECT NOW();
