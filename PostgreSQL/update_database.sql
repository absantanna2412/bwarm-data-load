SET SCHEMA 'bwarm';
--INSERT INTO snapshots (created_date) VALUES (current_timestamp);

CALL refresh_parties('/opt/bwarm/');
CALL refresh_works('/opt/bwarm/');
CALL refresh_work_identifiers('/opt/bwarm/');
CALL refresh_work_alternative_titles('/opt/bwarm/');
CALL refresh_work_right_shares('/opt/bwarm/');
CALL refresh_recordings('/opt/bwarm/');
CALL refresh_recording_identifiers('/opt/bwarm/');
CALL refresh_recording_alternative_titles('/opt/bwarm/');
CALL refresh_releases('/opt/bwarm/');
CALL refresh_release_identifiers('/opt/bwarm/');
CALL refresh_work_recordings('/opt/bwarm/');
CALL refresh_unclaimed_work_right_shares('/opt/bwarm/');
