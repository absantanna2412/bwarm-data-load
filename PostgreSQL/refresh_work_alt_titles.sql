TRUNCATE TABLE alternative_work_titles;

SELECT to_char(current_timestamp, 'DD/MM/YYYY HH24:MI:SS.MS');

\copy alternative_work_titles FROM 'workalternativetitles.tsv' WITH (FORMAT csv, DELIMITER E'\t', NULL '', HEADER false, QUOTE '"', ESCAPE '\', FORCE_NULL ());

DO $$
  DECLARE
    snapshot_id INT;
  BEGIN
    SELECT MAX(snapshot_id) INTO snapshot_id FROM snapshots;

    UPDATE alternative_work_titles
    SET snapshot_id = snapshot_id
      WHERE snapshot_id IS NULL;
  END $$;

SELECT to_char(current_timestamp, 'DD/MM/YYYY HH24:MI:SS.MS');
