SET SCHEMA 'bwarm';
CREATE OR REPLACE PROCEDURE refresh_parties(IN p_file_path CHARACTER VARYING)
  LANGUAGE plpgsql
AS
$$
DECLARE
  v_file VARCHAR;
BEGIN
  RAISE NOTICE 'Loading Parties started : %', TO_CHAR(TIMEOFDAY()::TIMESTAMP, 'DD/MM/YYYY HH24:MI:SS.MS');

  TRUNCATE TABLE parties CASCADE;
  v_file := CONCAT(p_file_path, 'parties.tsv');

  EXECUTE FORMAT('COPY parties (feed_providers_party_id,
  isni,
  ipi_name_number,
  cisac_society_id,
  dpid,
  full_name,
  names_before_key_name,
  key_name,
  names_after_key_name,
  contact_name,
  contact_email,
  contact_phone,
  contact_address,
  no_valid_contact_information_avaliable) FROM ''%s'' WITH CSV DELIMITER E''\t'';', v_file);

  RAISE NOTICE 'Loading Parties finished : %', TO_CHAR(TIMEOFDAY()::TIMESTAMP, 'DD/MM/YYYY HH24:MI:SS.MS');
END;
$$;
ALTER PROCEDURE refresh_parties(VARCHAR) OWNER TO postgres;

