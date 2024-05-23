SET SCHEMA 'bwarm';

-- Drop refresh procedures if tey exists
DROP PROCEDURE IF EXISTS refresh_unclaimed_work_right_shares;
DROP PROCEDURE IF EXISTS refresh_work_recordings;
DROP PROCEDURE IF EXISTS refresh_release_identifiers;
DROP PROCEDURE IF EXISTS refresh_releases;
DROP PROCEDURE IF EXISTS refresh_recording_identifiers;
DROP PROCEDURE IF EXISTS refresh_recording_alternative_titles;
DROP PROCEDURE IF EXISTS refresh_recordings;
DROP PROCEDURE IF EXISTS refresh_work_right_shares;
DROP PROCEDURE IF EXISTS refresh_work_identifiers;
DROP PROCEDURE IF EXISTS refresh_work_alternative_titles;
DROP PROCEDURE IF EXISTS refresh_works;
DROP PROCEDURE IF EXISTS refresh_parties;

-- Drop tables if they exists
DROP TABLE IF EXISTS unclaimed_work_right_shares;
DROP TABLE IF EXISTS work_recordings;
DROP TABLE IF EXISTS release_identifiers;
DROP TABLE IF EXISTS releases;
DROP TABLE IF EXISTS recording_identifiers;
DROP TABLE IF EXISTS recording_alternative_titles;
DROP TABLE IF EXISTS recordings;
DROP TABLE IF EXISTS work_right_shares;
DROP TABLE IF EXISTS work_identifiers;
DROP TABLE IF EXISTS work_alternative_titles;
DROP TABLE IF EXISTS works;
DROP TABLE IF EXISTS parties;
DROP TABLE IF EXISTS snapshots;

-- Drop Trigger function if exists
DROP FUNCTION IF EXISTS get_snapshot_id;

-- Drop the Schema if exists
DROP SCHEMA IF EXISTS bwarm;

-- Recreate the objects
CREATE SCHEMA IF NOT EXISTS bwarm;
SET SCHEMA 'bwarm';
--
-- Trigger function to update snapshot_id
CREATE OR REPLACE FUNCTION get_snapshot_id()
  RETURNS TRIGGER AS
$body$
BEGIN
  SELECT MAX(snapshot_id)
    INTO new.snapshot_id
    FROM snapshots;

  RETURN new;
END;
$body$
  LANGUAGE 'plpgsql'
  STABLE
  CALLED ON NULL INPUT
  SECURITY INVOKER
  PARALLEL SAFE
  COST 100;

-- Snapshot table
CREATE TABLE snapshots
  (
    snapshot_id  SERIAL PRIMARY KEY,
    created_date TIMESTAMP);

-- Works table and snapshot trigger
CREATE TABLE works
  (
    feed_providers_work_id                      VARCHAR(900) PRIMARY KEY,
    iswc                                        VARCHAR(11),
    work_title                                  TEXT,
    opus_number                                 VARCHAR(900),
    composer_catalog_number                     VARCHAR(900),
    nominal_duration                            VARCHAR(900),
    has_rights_in_dispute                       VARCHAR(6),
    territory_of_public_domain                  TEXT,
    is_arrangement_of_traditional_work          VARCHAR(6),
    alternative_work_for_us_statutory_reversion VARCHAR(900),
    us_statutory_reversion_date                 VARCHAR(100),
    snapshot_id                                 INTEGER REFERENCES snapshots (snapshot_id));
CREATE TRIGGER works_tr
  BEFORE INSERT
  ON works
  FOR EACH ROW
EXECUTE PROCEDURE get_snapshot_id();

-- Alternative Work Titles table and snapshot trigger
CREATE TABLE work_alternative_titles
  (
    feed_providers_work_alternative_title_id VARCHAR(900) PRIMARY KEY,
    feed_providers_work_id                   VARCHAR(900) REFERENCES works (feed_providers_work_id),
    alternative_title                        TEXT,
    language_and_script_code                 VARCHAR(900),
    title_type                               VARCHAR(900),
    snapshot_id                              INTEGER REFERENCES snapshots (snapshot_id));
CREATE TRIGGER work_alternative_titles_tr
  BEFORE INSERT
  ON work_alternative_titles
  FOR EACH ROW
EXECUTE PROCEDURE get_snapshot_id();

-- Work Identifiers table and snapshot trigger
CREATE TABLE work_identifiers
  (
    feed_providers_work_proprietary_identifier_id VARCHAR(900) PRIMARY KEY,
    feed_providers_work_id                        VARCHAR(900) REFERENCES works (feed_providers_work_id),
    identifier                                    VARCHAR(900),
    feed_providers_allocating_party_id            VARCHAR(900),
    snapshot_id                                   INTEGER REFERENCES snapshots (snapshot_id));
CREATE TRIGGER work_identifiers_tr
  BEFORE INSERT
  ON work_identifiers
  FOR EACH ROW
EXECUTE PROCEDURE get_snapshot_id();

-- Parties table and snapshot trigger
CREATE TABLE parties
  (
    feed_providers_party_id                VARCHAR(900) PRIMARY KEY,
    isni                                   VARCHAR(15),
    ipi_name_number                        BIGINT,
    cisac_society_id                       VARCHAR(3),
    dpid                                   VARCHAR(100),
    full_name                              TEXT,
    names_before_key_name                  TEXT,
    key_name                               TEXT,
    names_after_key_name                   TEXT,
    contact_name                           TEXT,
    contact_email                          TEXT,
    contact_phone                          TEXT,
    contact_address                        TEXT,
    no_valid_contact_information_avaliable BOOLEAN,
    snapshot_id                            INTEGER REFERENCES snapshots (snapshot_id));
CREATE TRIGGER parties_tr
  BEFORE INSERT
  ON parties
  FOR EACH ROW
EXECUTE PROCEDURE get_snapshot_id();

-- Work Right Shares table and snapshot trigger
CREATE TABLE work_right_shares
  (
    feed_providers_work_right_share_id        VARCHAR(900) PRIMARY KEY,
    feed_providers_work_id                    VARCHAR(900) REFERENCES works (feed_providers_work_id),
    feed_providers_party_id                   VARCHAR(900) REFERENCES parties (feed_providers_party_id),
    party_role                                VARCHAR(100),
    right_share_percentage                    REAL,
    right_share_type                          VARCHAR(100),
    rights_type                               VARCHAR(100),
    validity_start_date                       VARCHAR(100),
    validity_end_date                         VARCHAR(100),
    feed_providers_parent_work_right_share_id VARCHAR(900),
    territory_code                            VARCHAR(900),
    use_type                                  VARCHAR(900),
    snapshot_id                               INTEGER REFERENCES snapshots (snapshot_id));
CREATE TRIGGER work_right_shares_tr
  BEFORE INSERT
  ON work_right_shares
  FOR EACH ROW
EXECUTE PROCEDURE get_snapshot_id();

-- Releases table and snapshot trigger
CREATE TABLE releases
  (
    feed_providers_release_id    VARCHAR(900) PRIMARY KEY,
    icpn                         VARCHAR(100),
    release_title                TEXT,
    release_sub_title            TEXT,
    display_artist_name          TEXT,
    display_artist_isni          VARCHAR(100),
    label_name                   VARCHAR(900),
    release_date                 VARCHAR(100),
    original_data_provider_name  VARCHAR(900),
    original_data_provider_dpid  VARCHAR(900),
    is_data_provided_as_received VARCHAR(6),
    snapshot_id                  INTEGER REFERENCES snapshots (snapshot_id));
CREATE TRIGGER releases_tr
  BEFORE INSERT
  ON releases
  FOR EACH ROW
EXECUTE PROCEDURE get_snapshot_id();

-- Release Identifiers table and snapshot trigger
CREATE TABLE release_identifiers
  (
    feed_providers_release_proprietary_identifier_id VARCHAR(900) PRIMARY KEY,
    feed_providers_release_id                        VARCHAR(900) REFERENCES releases (feed_providers_release_id),
    identifier                                       VARCHAR(900),
    feed_providers_allocating_party_id               VARCHAR(900),
    snapshot_id                                      INTEGER REFERENCES snapshots (snapshot_id));
CREATE TRIGGER release_identifiers_tr
  BEFORE INSERT
  ON release_identifiers
  FOR EACH ROW
EXECUTE PROCEDURE get_snapshot_id();

-- Recordings table and snapshot trigger
CREATE TABLE recordings
  (
    feed_providers_recording_id  VARCHAR(900) PRIMARY KEY,
    isrc                         VARCHAR(100),
    recording_title              TEXT,
    recording_sub_title          TEXT,
    display_artist_name          TEXT,
    display_artist_isni          VARCHAR(100),
    pline                        VARCHAR(900),
    duration                     VARCHAR(100),
    feed_providers_release_id    VARCHAR(900) REFERENCES releases (feed_providers_release_id),
    studio_producer_name         TEXT,
    studio_producer_id           VARCHAR(900),
    original_data_provider_name  VARCHAR(900),
    original_data_provider_dpid  VARCHAR(900),
    is_data_provided_as_received VARCHAR(6),
    snapshot_id                  INTEGER REFERENCES snapshots (snapshot_id));
CREATE TRIGGER recordings_tr
  BEFORE INSERT
  ON recordings
  FOR EACH ROW
EXECUTE PROCEDURE get_snapshot_id();

-- Alternative Recording Titles table and snapshot trigger
CREATE TABLE recording_alternative_titles
  (
    feed_providers_recording_alternative_title_id VARCHAR(900) PRIMARY KEY,
    feed_providers_recording_id                   VARCHAR(900) REFERENCES recordings (feed_providers_recording_id),
    alternative_title                             TEXT,
    language_and_script_code                      VARCHAR(900),
    title_type                                    VARCHAR(900),
    snapshot_id                                   INTEGER REFERENCES snapshots (snapshot_id));
CREATE TRIGGER recording_alternative_titles_tr
  BEFORE INSERT
  ON recording_alternative_titles
  FOR EACH ROW
EXECUTE PROCEDURE get_snapshot_id();

-- Recordings Identifiers table and snapshot trigger
CREATE TABLE recording_identifiers
  (
    feed_providers_recording_proprietary_identifier_id VARCHAR(900) PRIMARY KEY,
    feed_providers_recording_id                        VARCHAR(900) REFERENCES recordings (feed_providers_recording_id),
    identifier                                         VARCHAR(900),
    feed_providers_allocating_party_id                 VARCHAR(900),
    snapshot_id                                        INTEGER REFERENCES snapshots (snapshot_id));
CREATE TRIGGER recording_identifiers_tr
  BEFORE INSERT
  ON recording_identifiers
  FOR EACH ROW
EXECUTE PROCEDURE get_snapshot_id();

-- Work Recordings table and snapshot trigger
CREATE TABLE work_recordings
  (
    feed_providers_link_id      VARCHAR(900) PRIMARY KEY,
    feed_providers_work_id      VARCHAR(900) REFERENCES works (feed_providers_work_id),
    feed_providers_recording_id VARCHAR(900) REFERENCES recordings (feed_providers_recording_id),
    snapshot_id                 INTEGER REFERENCES snapshots (snapshot_id));
CREATE TRIGGER work_recordings_tr
  BEFORE INSERT
  ON work_recordings
  FOR EACH ROW
EXECUTE PROCEDURE get_snapshot_id();

-- Unclaimed Work Right Shares table and snapshot trigger
CREATE TABLE unclaimed_work_right_shares
  (
    feed_providers_right_share_id VARCHAR(900) PRIMARY KEY,
    feed_providers_recording_id   VARCHAR(900) REFERENCES recordings (feed_providers_recording_id),
    feed_providers_work_id        VARCHAR(900) REFERENCES works (feed_providers_work_id),
    isrc                          VARCHAR(100),
    dsp_recording_id              VARCHAR(900),
    recording_title               TEXT,
    recording_sub_title           TEXT,
    alternative_recording_title   TEXT,
    display_artist_name           TEXT,
    display_artist_isni           VARCHAR(100),
    duration                      VARCHAR(100),
    unclaimed_percentage          REAL,
    percentile_for_prioritisation INTEGER,
    snapshot_id                   INTEGER REFERENCES snapshots (snapshot_id));
CREATE TRIGGER unclaimed_work_right_shares_tr
  BEFORE INSERT
  ON unclaimed_work_right_shares
  FOR EACH ROW
EXECUTE PROCEDURE get_snapshot_id();

-- Call scripts to create load procedures
\i refresh_parties.sql
\i refresh_recording_alt_titles.sql
\i refresh_recording_ids.sql
\i refresh_recordings.sql
\i refresh_release_ids.sql
\i refresh_releases.sql
\i refresh_unclaimed.sql
\i refresh_work_alt_titles.sql
\i refresh_work_ids.sql
\i refresh_work_recordings.sql
\i refresh_work_shares.sql
\i refresh_works.sql
