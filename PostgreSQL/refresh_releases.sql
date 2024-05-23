SET SCHEMA 'bwarm';
CREATE OR REPLACE PROCEDURE refresh_releases(IN p_file_path CHARACTER VARYING)
  LANGUAGE plpgsql
AS
$$
DECLARE
  v_file VARCHAR;
BEGIN
  RAISE NOTICE 'Loading Releases started : %', TO_CHAR(TIMEOFDAY()::TIMESTAMP, 'DD/MM/YYYY HH24:MI:SS.MS');

  TRUNCATE TABLE releases CASCADE;
  v_file := CONCAT(p_file_path, 'releases.tsv');

  EXECUTE FORMAT('COPY releases (feed_providers_release_id,
  icpn,
  release_title,
  release_sub_title,
  display_artist_name,
  display_artist_isni,
  label_name,
  release_date,
  original_data_provider_name,
  original_data_provider_dpid,
  is_data_provided_as_received) FROM ''%s'' WITH CSV DELIMITER E''\t'';', v_file);

  RAISE NOTICE 'Loading Releases finished : %', TO_CHAR(TIMEOFDAY()::TIMESTAMP, 'DD/MM/YYYY HH24:MI:SS.MS');
END;
$$;
ALTER PROCEDURE refresh_releases(VARCHAR) OWNER TO postgres;

