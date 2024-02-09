TRUNCATE TABLE unclaimed_works;

SELECT to_char(current_timestamp, 'DD/MM/YYYY HH24:MI:SS.MS');

\copy unclaimed_works FROM 'unclaimedworkrightshares.tsv' WITH (FORMAT csv, DELIMITER E'\t', NULL '', HEADER false, QUOTE '"', ESCAPE '\', FORCE_NULL ());

DO $$
  DECLARE
    snapshot_id INT;
  BEGIN
    SELECT MAX(snapshot_id) INTO snapshot_id FROM snapshots;

    UPDATE unclaimed_works
    SET snapshot_id = snapshot_id
      WHERE snapshot_id IS NULL;
  END $$;

SELECT to_char(current_timestamp, 'DD/MM/YYYY HH24:MI:SS.MS');
