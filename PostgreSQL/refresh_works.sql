SET SCHEMA 'bwarm';
CREATE OR REPLACE PROCEDURE refresh_works(IN p_file_path CHARACTER VARYING)
  LANGUAGE plpgsql
AS
$$
DECLARE
  v_file VARCHAR;
BEGIN
  RAISE NOTICE 'Loading Works started : %', TO_CHAR(TIMEOFDAY()::TIMESTAMP, 'DD/MM/YYYY HH24:MI:SS.MS');

  TRUNCATE TABLE works CASCADE;
  v_file := CONCAT(p_file_path, 'works.tsv');

  EXECUTE FORMAT('COPY works (feed_providers_work_id,
  iswc,
  work_title,
  opus_number,
  composer_catalog_number,
  nominal_duration,
  has_rights_in_dispute,
  territory_of_public_domain,
  is_arrangement_of_traditional_work,
  alternative_work_for_us_statutory_reversion,
  us_statutory_reversion_date) FROM ''%s'' WITH CSV DELIMITER E''\t'';', v_file);

  RAISE NOTICE 'Loading Works finished : %', TO_CHAR(TIMEOFDAY()::TIMESTAMP, 'DD/MM/YYYY HH24:MI:SS.MS');
END;
$$;
ALTER PROCEDURE refresh_works(VARCHAR) OWNER TO postgres;

