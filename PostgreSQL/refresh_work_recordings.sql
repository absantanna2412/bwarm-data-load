SET SCHEMA 'bwarm';
CREATE PROCEDURE refresh_work_recordings(IN p_file_path CHARACTER VARYING)
  LANGUAGE plpgsql
AS
$$
DECLARE
  v_file VARCHAR;
BEGIN
  RAISE NOTICE 'Loading Work Recordings started : %', TO_CHAR(CURRENT_TIMESTAMP, 'DD/MM/YYYY HH24:MI:SS.MS');

  TRUNCATE TABLE work_recordings CASCADE;
  v_file := CONCAT(p_file_path, 'worksrecordings.tsv');

  EXECUTE FORMAT('COPY work_recordings (feed_providers_link_id,
  feed_providers_work_id,
  feed_providers_recording_id) FROM ''%s'' WITH CSV DELIMITER E''\t'';', v_file);

  RAISE NOTICE 'Loading Work Recordings finished : %', TO_CHAR(CURRENT_TIMESTAMP, 'DD/MM/YYYY HH24:MI:SS.MS');
END;
$$;
ALTER PROCEDURE refresh_work_recordings(VARCHAR) OWNER TO postgres;

