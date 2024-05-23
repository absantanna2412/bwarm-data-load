#!/bin/bash

# Change the path to reflect the files in your system
BWARM_PATH="/opt/bwarm/"

# Exec each load function and after that compress TSV files to save space
psql -d bwarm -c "SET SCHEMA 'bwarm'; CALL refresh_parties('$BWARM_PATH');" && tar -czf processed/parties.tar parties.tsv --remove-files &
psql -d bwarm -c "SET SCHEMA 'bwarm'; CALL refresh_works('$BWARM_PATH');" && tar -czf processed/works.tar works.tsv --remove-files &
psql -d bwarm -c "SET SCHEMA 'bwarm'; CALL refresh_work_identifiers('$BWARM_PATH');" && tar -czf processed/workidentifiers.tar workidentifiers.tsv --remove-files &
psql -d bwarm -c "SET SCHEMA 'bwarm'; CALL refresh_work_alternative_titles('$BWARM_PATH');" && tar -czf processed/workalternativetitles.tar workalternativetitles.tsv --remove-files &
psql -d bwarm -c "SET SCHEMA 'bwarm'; CALL refresh_work_right_shares('$BWARM_PATH');" && tar -czf processed/workrightshares.tar workrightshares.tsv --remove-files &
psql -d bwarm -c "SET SCHEMA 'bwarm'; CALL refresh_recordings('$BWARM_PATH');" && tar -czf processed/recordings.tar recordings.tsv --remove-files &
psql -d bwarm -c "SET SCHEMA 'bwarm'; CALL refresh_recording_identifiers('$BWARM_PATH');" && tar -czf processed/recordingidentifiers.tar recordingidentifiers.tsv --remove-files &
psql -d bwarm -c "SET SCHEMA 'bwarm'; CALL refresh_recording_alternative_titles('$BWARM_PATH');" && tar -czf processed/recordingalternativetitles.tar recordingalternativetitles.tsv --remove-files &
psql -d bwarm -c "SET SCHEMA 'bwarm'; CALL refresh_releases('$BWARM_PATH');" && tar -czf processed/releases.tar releases.tsv --remove-files &
psql -d bwarm -c "SET SCHEMA 'bwarm'; CALL refresh_release_identifiers('$BWARM_PATH');" && tar -czf processed/releaseidentifiers.tar releaseidentifiers.tsv --remove-files &
psql -d bwarm -c "SET SCHEMA 'bwarm'; CALL refresh_work_recordings('$BWARM_PATH');" && tar -czf processed/worksrecordings.tar worksrecordings.tsv --remove-files &
psql -d bwarm -c "SET SCHEMA 'bwarm'; CALL refresh_unclaimed_work_right_shares('$BWARM_PATH');" && tar -czf processed/unclaimedworkrightshares.tar unclaimedworkrightshares.tsv --remove-files &
