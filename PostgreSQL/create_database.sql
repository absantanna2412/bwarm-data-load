DROP TABLE IF EXISTS alternative_work_titles;
DROP TABLE IF EXISTS work_identifiers;
DROP TABLE IF EXISTS work_right_shares;
DROP TABLE IF EXISTS alternative_recording_titles;
DROP TABLE IF EXISTS recording_identifiers;
DROP TABLE IF EXISTS release_identifiers;
DROP TABLE IF EXISTS work_recordings;
DROP TABLE IF EXISTS unclaimed_works;
DROP TABLE IF EXISTS releases;
DROP TABLE IF EXISTS recordings;
DROP TABLE IF EXISTS parties;
DROP TABLE IF EXISTS works;
DROP TABLE IF EXISTS snapshots;

CREATE TABLE snapshots (
  snapshot_id SERIAL PRIMARY KEY,
  created_date TIMESTAMP
);

CREATE TABLE works (
  feed_providers_work_id VARCHAR(900) PRIMARY KEY,
  iswc VARCHAR(11),
  work_title TEXT,
  opus_number VARCHAR(900),
  composer_catalog_number VARCHAR(900),
  nominal_duration VARCHAR(900),
  has_rights_in_dispute VARCHAR(6),
  territory_of_public_domain TEXT,
  is_arrangement_of_traditional_work VARCHAR(6),
  alternative_work_for_us_statutory_reversion VARCHAR(900),
  us_statutory_reversion_date VARCHAR(100),
  snapshot_id INTEGER REFERENCES snapshots(snapshot_id)
);

CREATE TABLE alternative_work_titles (
  feed_providers_work_alternative_title_id VARCHAR(900) PRIMARY KEY,
  feed_providers_work_id VARCHAR(900) REFERENCES works(feed_providers_work_id),
  alternative_title TEXT,
  language_and_script_code VARCHAR(900),
  title_type VARCHAR(900),
  snapshot_id INTEGER REFERENCES snapshots(snapshot_id)
);

CREATE TABLE work_identifiers (
  feed_providers_work_proprietary_identifier_id VARCHAR(900) PRIMARY KEY,
  feed_providers_work_id VARCHAR(900) REFERENCES works(feed_providers_work_id),
  identifier VARCHAR(900),
  feed_providers_allocating_party_id VARCHAR(900),
  snapshot_id INTEGER REFERENCES snapshots(snapshot_id)
);

CREATE TABLE parties (
  feed_providers_party_id VARCHAR(900) PRIMARY KEY,
  isni VARCHAR(15),
  ipi_name_number BIGINT,
  cisac_society_id VARCHAR(3),
  dpid VARCHAR(100),
  full_name TEXT,
  names_before_key_name TEXT,
  key_name TEXT,
  names_after_key_name TEXT,
  snapshot_id INTEGER REFERENCES snapshots(snapshot_id)
);

CREATE TABLE work_right_shares (
  feed_providers_work_right_share_id VARCHAR(900) PRIMARY KEY,
  feed_providers_work_id VARCHAR(900) REFERENCES works(feed_providers_work_id),
  feed_providers_party_id VARCHAR(900) REFERENCES parties(feed_providers_party_id),
  party_role VARCHAR(100),
  right_share_percentage REAL,
  right_share_type VARCHAR(100),
  rights_type VARCHAR(100),
  validity_start_date VARCHAR(10),
  validity_end_date VARCHAR(10),
  feed_providers_parent_work_right_share_id VARCHAR(900),
  territory_code VARCHAR(900),
  use_type VARCHAR(900),
  snapshot_id INTEGER REFERENCES snapshots(snapshot_id)
);

CREATE TABLE recordings (
  feed_providers_recording_id VARCHAR(900) PRIMARY KEY,
  isrc VARCHAR(12),
  recording_title TEXT,
  recording_sub_title TEXT,
  display_artist_name TEXT,
  display_artist_isni VARCHAR(16),
  pline VARCHAR(900),
  duration VARCHAR(100),
  feed_providers_release_id VARCHAR(900),
  studio_producer_name TEXT,
  studio_producer_id VARCHAR(900),
  original_data_provider_name VARCHAR(900),
  original_data_provider_dpid VARCHAR(900),
  is_data_provided_as_received VARCHAR(6),
  snapshot_id INTEGER REFERENCES snapshots(snapshot_id)
);

CREATE TABLE alternative_recording_titles (
  feed_providers_recording_alternative_title_id VARCHAR(900) PRIMARY KEY,
  feed_providers_recording_id VARCHAR(900) REFERENCES recordings(feed_providers_recording_id),
  alternative_title TEXT,
  language_and_script_code VARCHAR(900),
  title_type VARCHAR(900),
  snapshot_id INTEGER REFERENCES snapshots(snapshot_id)
);

CREATE TABLE recording_identifiers (
  feed_providers_recording_proprietary_identifier_id VARCHAR(900) PRIMARY KEY,
  feed_providers_recording_id VARCHAR(900) REFERENCES recordings(feed_providers_recording_id),
  identifier VARCHAR(900),
  feed_providers_allocating_party_id VARCHAR(900),
  snapshot_id INTEGER REFERENCES snapshots(snapshot_id)
);

CREATE TABLE releases (
  feed_providers_release_id VARCHAR(900) PRIMARY KEY,
  icpn VARCHAR(15),
  release_title TEXT,
  release_sub_title TEXT,
  display_artist_name TEXT,
  display_artist_isni VARCHAR(16),
  label_name VARCHAR(900),
  release_date VARCHAR(10),
  original_data_provider_name VARCHAR(900),
  original_data_provider_dpid VARCHAR(900),
  is_data_provided_as_received VARCHAR(6),
  snapshot_id INTEGER REFERENCES snapshots(snapshot_id)
);

CREATE TABLE release_identifiers (
  feed_providers_release_proprietary_identifier_id VARCHAR(900) PRIMARY KEY,
  feed_providers_release_id VARCHAR(900) REFERENCES releases(feed_providers_release_id),
  identifier VARCHAR(900),
  feed_providers_allocating_party_id VARCHAR(900),
  snapshot_id INTEGER REFERENCES snapshots(snapshot_id)
);

CREATE TABLE work_recordings (
  feed_providers_link_id VARCHAR(900) PRIMARY KEY,
  feed_providers_work_id VARCHAR(900) REFERENCES works(feed_providers_work_id),
  feed_providers_recording_id VARCHAR(900) REFERENCES recordings(feed_providers_recording_id),
  snapshot_id INTEGER REFERENCES snapshots(snapshot_id)
);

CREATE TABLE unclaimed_works (
  feed_providers_right_share_id VARCHAR(900) PRIMARY KEY,
  feed_providers_recording_id VARCHAR(900) REFERENCES recordings(feed_providers_recording_id),
  feed_providers_work_id VARCHAR(900) REFERENCES works(feed_providers_work_id),
  isrc VARCHAR(11),
  dsp_recording_id VARCHAR(900),
  recording_title TEXT,
  recording_sub_title TEXT,
  alternative_recording_title TEXT,
  display_artist_name TEXT,
  display_artist_isni VARCHAR(16),
  duration VARCHAR(100),
  unclaimed_percentage REAL,
  percentile_for_prioritisation INTEGER,
  snapshot_id INTEGER REFERENCES snapshots(snapshot_id)
);

insert into snapshots (created_date) values (current_timestamp);
