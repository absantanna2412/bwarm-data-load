SET SCHEMA 'bwarm';
CREATE PROCEDURE refresh_unclaimed_work_right_shares(IN p_file_path CHARACTER VARYING)
  LANGUAGE plpgsql
AS
$$
DECLARE
  v_file VARCHAR;
BEGIN
  RAISE NOTICE 'Loading Unclaimed started : %', TO_CHAR(CURRENT_TIMESTAMP, 'DD/MM/YYYY HH24:MI:SS.MS');

  TRUNCATE TABLE unclaimed_work_right_shares CASCADE;
  v_file := CONCAT(p_file_path, 'unclaimedworkrightshares.tsv');

  EXECUTE FORMAT('COPY unclaimed_work_right_shares (feed_providers_right_share_id,
  feed_providers_recording_id,
  feed_providers_work_id,
  isrc,
  dsp_recording_id,
  recording_title,
  recording_sub_title,
  alternative_recording_title,
  display_artist_name,
  display_artist_isni,
  duration,
  unclaimed_percentage,
  percentile_for_prioritisation) FROM ''%s'' WITH CSV DELIMITER E''\t'';', v_file);

  RAISE NOTICE 'Loading Unclaimed finished : %', TO_CHAR(CURRENT_TIMESTAMP, 'DD/MM/YYYY HH24:MI:SS.MS');
END;
$$;
ALTER PROCEDURE refresh_unclaimed_work_right_shares(VARCHAR) OWNER TO postgres;

