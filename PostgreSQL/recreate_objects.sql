-- Lets recreate the constraints after loading finnishes

alter table bwarm.parties add constraint parties_pkey primary key (feed_providers_party_id);
alter table bwarm.release_identifiers add constraint release_identifiers_pkey primary key (feed_providers_release_proprietary_identifier_id);
alter table bwarm.releases add constraint releases_pkey primary key (feed_providers_release_id);
alter table bwarm.recording_alternative_titles add constraint recording_alternative_titles_pkey primary key (feed_providers_recording_alternative_title_id);
alter table bwarm.recording_identifiers add constraint recording_identifiers_pkey primary key (feed_providers_recording_proprietary_identifier_id);
alter table bwarm.recordings add constraint recordings_pkey primary key (feed_providers_recording_id);
alter table bwarm.unclaimed_work_right_shares add constraint unclaimed_work_right_shares_pkey primary key (feed_providers_right_share_id);
alter table bwarm.work_alternative_titles add constraint work_alternative_titles_pkey primary key (feed_providers_work_alternative_title_id);
alter table bwarm.work_identifiers add constraint work_identifiers_pkey primary key (feed_providers_work_proprietary_identifier_id);
alter table bwarm.work_recordings add constraint work_recordings_pkey primary key (feed_providers_link_id);
alter table bwarm.work_right_shares add constraint work_right_shares_pkey primary key (feed_providers_work_right_share_id);
alter table bwarm.works add constraint works_pkey primary key (feed_providers_work_id);

alter table bwarm.parties add constraint parties_snapshot_id_fkey foreign key (snapshot_id) references bwarm.snapshots;
alter table bwarm.release_identifiers add constraint release_identifiers_snapshot_id_fkey foreign key (snapshot_id) references bwarm.snapshots;
alter table bwarm.releases add constraint releases_snapshot_id_fkey foreign key (snapshot_id) references bwarm.snapshots;
alter table bwarm.recording_alternative_titles add constraint recording_alternative_titles_snapshot_id_fkey foreign key (snapshot_id) references bwarm.snapshots;
alter table bwarm.recording_identifiers add constraint recording_identifiers_snapshot_id_fkey foreign key (snapshot_id) references bwarm.snapshots;
alter table bwarm.recordings add constraint recordings_snapshot_id_fkey foreign key (snapshot_id) references bwarm.snapshots;
alter table bwarm.unclaimed_work_right_shares add constraint unclaimed_work_right_shares_snapshot_id_fkey foreign key (snapshot_id) references bwarm.snapshots;
alter table bwarm.work_alternative_titles add constraint work_alternative_titles_snapshot_id_fkey foreign key (snapshot_id) references bwarm.snapshots;
alter table bwarm.work_identifiers add constraint work_identifiers_snapshot_id_fkey foreign key (snapshot_id) references bwarm.snapshots;
alter table bwarm.work_recordings add constraint work_recordings_snapshot_id_fkey foreign key (snapshot_id) references bwarm.snapshots;
alter table bwarm.work_right_shares add constraint work_right_shares_snapshot_id_fkey foreign key (snapshot_id) references bwarm.snapshots;
alter table bwarm.works add constraint works_snapshot_id_fkey foreign key (snapshot_id) references bwarm.snapshots;

alter table bwarm.release_identifiers add constraint release_identifiers_feed_providers_release_id_fkey foreign key (feed_providers_release_id) references bwarm.releases;
alter table bwarm.recording_alternative_titles add constraint recording_alternative_titles_feed_providers_recording_id_fkey foreign key (feed_providers_recording_id) references bwarm.recordings;
alter table bwarm.recording_identifiers add constraint recording_identifiers_feed_providers_recording_id_fkey foreign key (feed_providers_recording_id) references bwarm.recordings;
alter table bwarm.recordings add constraint recordings_feed_providers_release_id_fkey foreign key (feed_providers_release_id) references bwarm.releases;
alter table bwarm.unclaimed_work_right_shares add constraint unclaimed_work_right_shares_feed_providers_recording_id_fkey foreign key (feed_providers_recording_id) references bwarm.recordings;
alter table bwarm.unclaimed_work_right_shares add constraint unclaimed_work_right_shares_feed_providers_work_id_fkey foreign key (feed_providers_work_id) references bwarm.works;
alter table bwarm.work_alternative_titles add constraint work_alternative_titles_feed_providers_work_id_fkey foreign key (feed_providers_work_id) references bwarm.works;
alter table bwarm.work_identifiers add constraint work_identifiers_feed_providers_work_id_fkey foreign key (feed_providers_work_id) references bwarm.works;
alter table bwarm.work_recordings add constraint work_recordings_feed_providers_work_id_fkey foreign key (feed_providers_work_id) references bwarm.works;
alter table bwarm.work_recordings add constraint work_recordings_feed_providers_recording_id_fkey foreign key (feed_providers_recording_id) references bwarm.recordings;
alter table bwarm.work_right_shares add constraint work_right_shares_feed_providers_work_id_fkey foreign key (feed_providers_work_id) references bwarm.works;
alter table bwarm.work_right_shares add constraint work_right_shares_feed_providers_party_id_fkey foreign key (feed_providers_party_id) references bwarm.parties;



