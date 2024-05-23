SET SCHEMA 'bwarm';
CREATE OR REPLACE PROCEDURE refresh_work_right_shares(IN p_file_path CHARACTER VARYING)
  LANGUAGE plpgsql
AS
$$
DECLARE
  v_file VARCHAR;
BEGIN
  RAISE NOTICE 'Loading Work Shares started : %', TO_CHAR(TIMEOFDAY()::TIMESTAMP, 'DD/MM/YYYY HH24:MI:SS.MS');

  TRUNCATE TABLE work_right_shares CASCADE;
  v_file := CONCAT(p_file_path, 'workrightshares.tsv');

  EXECUTE FORMAT('COPY work_right_shares (feed_providers_work_right_share_id,
  feed_providers_work_id,
  feed_providers_party_id,
  party_role,
  right_share_percentage,
  right_share_type,
  rights_type,
  validity_start_date,
  validity_end_date,
  feed_providers_parent_work_right_share_id,
  territory_code,
  use_type) FROM ''%s'' WITH CSV DELIMITER E''\t'';', v_file);

  RAISE NOTICE 'Loading Work Shares finished : %', TO_CHAR(TIMEOFDAY()::TIMESTAMP, 'DD/MM/YYYY HH24:MI:SS.MS');
END;
$$;
ALTER PROCEDURE refresh_work_right_shares(VARCHAR) OWNER TO postgres;

