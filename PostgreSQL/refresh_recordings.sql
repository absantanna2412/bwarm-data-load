SET SCHEMA 'bwarm';
CREATE OR REPLACE PROCEDURE refresh_recordings(IN p_file_path CHARACTER VARYING)
  LANGUAGE plpgsql
AS
$$
DECLARE
  v_file VARCHAR;
BEGIN
  RAISE NOTICE 'Loading Recordings started : %', TO_CHAR(TIMEOFDAY()::TIMESTAMP, 'DD/MM/YYYY HH24:MI:SS.MS');

  TRUNCATE TABLE recordings CASCADE;
  v_file := CONCAT(p_file_path, 'recordings.tsv');

  EXECUTE FORMAT('COPY recordings (feed_providers_recording_id,
  isrc,
  recording_title,
  recording_sub_title,
  display_artist_name,
  display_artist_isni,
  pline,
  duration,
  feed_providers_release_id,
  studio_producer_name,
  studio_producer_id,
  original_data_provider_name,
  original_data_provider_dpid,
  is_data_provided_as_received) FROM ''%s'' WITH CSV DELIMITER E''\t'';', v_file);

  RAISE NOTICE 'Loading Recordings finished : %', TO_CHAR(TIMEOFDAY()::TIMESTAMP, 'DD/MM/YYYY HH24:MI:SS.MS');
END;
$$;
ALTER PROCEDURE refresh_recordings(VARCHAR) OWNER TO postgres;

