SET SCHEMA 'bwarm';
CREATE OR REPLACE PROCEDURE refresh_work_identifiers(IN p_file_path CHARACTER VARYING)
  LANGUAGE plpgsql
AS
$$
DECLARE
  v_file VARCHAR;
BEGIN
  RAISE NOTICE 'Loading Work Identifiers started : %', TO_CHAR(TIMEOFDAY()::TIMESTAMP, 'DD/MM/YYYY HH24:MI:SS.MS');

  TRUNCATE TABLE work_identifiers CASCADE;
  v_file := CONCAT(p_file_path, 'workidentifiers.tsv');

  EXECUTE FORMAT('COPY work_identifiers (feed_providers_work_proprietary_identifier_id,
  feed_providers_work_id,
  identifier,
  feed_providers_allocating_party_id) FROM ''%s'' WITH CSV DELIMITER E''\t'';', v_file);

  RAISE NOTICE 'Loading Work Identifiers finished : %', TO_CHAR(TIMEOFDAY()::TIMESTAMP, 'DD/MM/YYYY HH24:MI:SS.MS');
END;
$$;
ALTER PROCEDURE refresh_work_identifiers(VARCHAR) OWNER TO postgres;

