SET SCHEMA 'bwarm';
CREATE OR REPLACE PROCEDURE refresh_recording_alternative_titles(IN p_file_path CHARACTER VARYING)
  LANGUAGE plpgsql
AS
$$
DECLARE
  v_file VARCHAR;
BEGIN
  RAISE NOTICE 'Loading Alternative Recording Titles started : %', TO_CHAR(TIMEOFDAY()::TIMESTAMP, 'DD/MM/YYYY HH24:MI:SS.MS');

  TRUNCATE TABLE recording_alternative_titles CASCADE;
  v_file := CONCAT(p_file_path, 'recordingalternativetitles.tsv');

  EXECUTE FORMAT('COPY recording_alternative_titles (feed_providers_recording_alternative_title_id,
  feed_providers_recording_id,
  alternative_title,
  language_and_script_code,
  title_type) FROM ''%s'' WITH CSV DELIMITER E''\t'';', v_file);

  RAISE NOTICE 'Loading Alternative Recording Titles finished : %', TO_CHAR(TIMEOFDAY()::TIMESTAMP, 'DD/MM/YYYY HH24:MI:SS.MS');
END;
$$;
ALTER PROCEDURE refresh_recording_alternative_titles(VARCHAR) OWNER TO postgres;

