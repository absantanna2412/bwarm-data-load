SET SCHEMA 'bwarm';
CREATE PROCEDURE refresh_release_identifiers(IN p_file_path CHARACTER VARYING)
  LANGUAGE plpgsql
AS
$$
DECLARE
  v_file VARCHAR;
BEGIN
  RAISE NOTICE 'Loading Release Identifiers started : %', TO_CHAR(CURRENT_TIMESTAMP, 'DD/MM/YYYY HH24:MI:SS.MS');

  TRUNCATE TABLE release_identifiers CASCADE;
  v_file := CONCAT(p_file_path, 'releaseidentifiers.tsv');

  EXECUTE FORMAT('COPY release_identifiers (feed_providers_release_proprietary_identifier_id,
  feed_providers_release_id,
  identifier,
  feed_providers_allocating_party_id) FROM ''%s'' WITH CSV DELIMITER E''\t'';', v_file);

  RAISE NOTICE 'Loading Release Identifiers finished : %', TO_CHAR(CURRENT_TIMESTAMP, 'DD/MM/YYYY HH24:MI:SS.MS');
END;
$$;
ALTER PROCEDURE refresh_release_identifiers(VARCHAR) OWNER TO postgres;

