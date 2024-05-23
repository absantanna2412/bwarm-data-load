SET SCHEMA 'bwarm';
CREATE OR REPLACE PROCEDURE refresh_recording_identifiers(IN p_file_path CHARACTER VARYING)
  LANGUAGE plpgsql
AS
$$
DECLARE
  v_file VARCHAR;
BEGIN
  RAISE NOTICE 'Loading Recording Identifiers started : %', TO_CHAR(TIMEOFDAY()::TIMESTAMP, 'DD/MM/YYYY HH24:MI:SS.MS');

  TRUNCATE TABLE recording_identifiers CASCADE;
  v_file := CONCAT(p_file_path, 'recordingidentifiers.tsv');

  EXECUTE FORMAT('COPY recording_identifiers (feed_providers_recording_proprietary_identifier_id,
  feed_providers_recording_id,
  identifier,
  feed_providers_allocating_party_id) FROM ''%s'' WITH CSV DELIMITER E''\t'';', v_file);

  RAISE NOTICE 'Loading Recording Identifiers finished : %', TO_CHAR(TIMEOFDAY()::TIMESTAMP, 'DD/MM/YYYY HH24:MI:SS.MS');
END;
$$;
ALTER PROCEDURE refresh_recording_identifiers(VARCHAR) OWNER TO postgres;

