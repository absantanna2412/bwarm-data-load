TRUNCATE TABLE recording_identifiers;

SELECT to_char(current_timestamp, 'DD/MM/YYYY HH24:MI:SS.MS');

\copy recording_identifiers FROM 'recordingidentifiers.tsv' WITH (FORMAT csv, DELIMITER E'\t', NULL '', HEADER false, QUOTE '"', ESCAPE '\', FORCE_NULL ());

DO $$
  DECLARE
    snapshot_id INT;
  BEGIN
    SELECT MAX(snapshot_id) INTO snapshot_id FROM snapshots;

    UPDATE recording_identifiers
    SET snapshot_id = snapshot_id
      WHERE snapshot_id IS NULL;
  END $$;

SELECT to_char(current_timestamp, 'DD/MM/YYYY HH24:MI:SS.MS');
