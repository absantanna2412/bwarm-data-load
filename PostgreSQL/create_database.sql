DROP TABLE IF EXISTS "SNAPSHOTS";
DROP TABLE IF EXISTS "PUBLIC_DB_STATS";
DROP TABLE IF EXISTS "WORKS";
DROP TABLE IF EXISTS "ALTERNATIVE_WORK_TITLES";
DROP TABLE IF EXISTS "WORK_IDENTIFIERS";
DROP TABLE IF EXISTS "PARTIES";
DROP TABLE IF EXISTS "WORK_RIGHT_SHARES";
DROP TABLE IF EXISTS "RECORDINGS";
DROP TABLE IF EXISTS "ALTERNATIVE_RECORDING_TITLES";
DROP TABLE IF EXISTS "RECORDING_IDENTIFIERS";
DROP TABLE IF EXISTS "RELEASES";
DROP TABLE IF EXISTS "RELEASE_IDENTIFIERS";
DROP TABLE IF EXISTS "WORK_RECORDINGS";
DROP TABLE IF EXISTS "UNCLAIMED_WORKS";

CREATE TABLE "SNAPSHOTS" (
  snapshotid SERIAL PRIMARY KEY,
  created_date DATE
);

CREATE TABLE "WORKS" (
  FeedProvidersWorkId VARCHAR(3000) PRIMARY KEY,
  ISWC VARCHAR(11),
  WorkTitle TEXT,
  OpusNumber VARCHAR(3000),
  ComposerCatalogNumber VARCHAR(3000),
  NominalDuration VARCHAR(3000),
  HasRightsInDispute VARCHAR(6),
  TerritoryOfPublicDomain TEXT,
  IsArrangementOfTraditionalWork VARCHAR(6),
  AlternativeWorkForUsStatutoryReversion VARCHAR(3000),
  UsStatutoryReversionDate VARCHAR(100),
  snapshotid INT
);

CREATE TABLE "ALTERNATIVE_WORK_TITLES" (
  FeedProvidersWorkAlternativeTitleId VARCHAR(3000) PRIMARY KEY,
  FeedProvidersWorkId VARCHAR(3000),
  AlternativeTitle TEXT,
  LanguageAndScriptCode VARCHAR(3000),
  TitleType VARCHAR(3000),
  snapshotid INT
);

CREATE TABLE "WORK_IDENTIFIERS" (
  FeedProvidersWorkProprietaryIdentifierId VARCHAR(3000) PRIMARY KEY,
  FeedProvidersWorkId VARCHAR(3000),
  Identifier VARCHAR(3000),
  FeedProvidersAllocatingPartyId VARCHAR(3000),
  snapshotid INT
);

CREATE TABLE "PARTIES" (
  FeedProvidersPartyId VARCHAR(3000) PRIMARY KEY,
  ISNI VARCHAR(15),
  IpiNameNumber INTEGER,
  CisacSocietyId VARCHAR(3),
  DPID VARCHAR(100),
  FullName TEXT,
  NamesBeforeKeyName TEXT,
  KeyName TEXT,
  NamesAfterKeyName TEXT,
  snapshotid INT
);

CREATE TABLE "WORK_RIGHT_SHARES" (
  FeedProvidersWorkRightShareId VARCHAR(3000) PRIMARY KEY,
  FeedProvidersWorkId VARCHAR(3000),
  FeedProvidersPartyId VARCHAR(3000),
  PartyRole VARCHAR(100),
  RightSharePercentage FLOAT,
  RightShareType VARCHAR(100),
  RightsType VARCHAR(100),
  ValidityStartDate VARCHAR(10),
  ValidityEndDate VARCHAR(10),
  FeedProvidersParentWorkRightShareId VARCHAR(3000),
  TerritoryCode VARCHAR(3000),
  UseType VARCHAR(3000),
  snapshotid INT
);

CREATE TABLE "RECORDINGS" (
  FeedProvidersRecordingId VARCHAR(3000) PRIMARY KEY,
  ISRC VARCHAR(12),
  RecordingTitle TEXT,
  RecordingSubTitle TEXT,
  DisplayArtistName TEXT,
  DisplayArtistISNI VARCHAR(16),
  PLine VARCHAR(3000),
  Duration  VARCHAR(100),
  FeedProvidersReleaseId VARCHAR(3000),
  StudioProducerName TEXT,
  StudioProducerId VARCHAR(3000),
  OriginalDataProviderName VARCHAR(3000),
  OriginalDataProviderDPID VARCHAR(3000),
  IsDataProvidedAsReceived VARCHAR(6),
  snapshotid INT
);

CREATE TABLE "ALTERNATIVE_RECORDING_TITLES" (
  FeedProvidersRecordingAlternativeTitleId VARCHAR(3000) PRIMARY KEY,
  FeedProvidersRecordingId VARCHAR(3000),
  AlternativeTitle TEXT,
  LanguageAndScriptCode VARCHAR(3000),
  TitleType VARCHAR(3000),
  snapshotid INT
);

CREATE TABLE "RECORDING_IDENTIFIERS" (
  FeedProvidersRecordingProprietaryIdentifierId VARCHAR(3000) PRIMARY KEY,
  FeedProvidersRecordingId VARCHAR(3000),
  Identifier VARCHAR(3000),
  FeedProvidersAllocatingPartyId VARCHAR(3000),
  snapshotid INT
);

CREATE TABLE "RELEASES" (
  FeedProvidersReleaseId VARCHAR(3000) PRIMARY KEY,
  ICPN VARCHAR(15),
  ReleaseTitle TEXT,
  ReleaseSubTitle TEXT,
  DisplayArtistName TEXT,
  DisplayArtistISNI VARCHAR(16),
  LabelName VARCHAR(3000),
  ReleaseDate VARCHAR(10),
  OriginalDataProviderName VARCHAR(3000),
  OriginalDataProviderDPID VARCHAR(3000),
  IsDataProvidedAsReceived VARCHAR(6),
  snapshotid INT
);

CREATE TABLE "RELEASE_IDENTIFIERS" (
  FeedProvidersReleaseProprietaryIdentifierId VARCHAR(3000) PRIMARY KEY,
  FeedProvidersReleaseId VARCHAR(3000),
  Identifier VARCHAR(3000),
  FeedProvidersAllocatingPartyId VARCHAR(3000),
  snapshotid INT
);

CREATE TABLE "WORK_RECORDINGS" (
  FeedProvidersLinkId VARCHAR(3000) PRIMARY KEY,
  FeedProvidersWorkId VARCHAR(3000),
  FeedProvidersRecordingId VARCHAR(3000),
  snapshotid INT
);

CREATE TABLE "UNCLAIMED_WORKS" (
  FeedProvidersRightShareId VARCHAR(3000) PRIMARY KEY,
  FeedProvidersRecordingId VARCHAR(3000),
  FeedProvidersWorkId VARCHAR(3000),
  ISRC  VARCHAR(11),
  DspRecordingId  VARCHAR(3000),
  RecordingTitle TEXT,
  RecordingSubTitle TEXT,
  AlternativeRecordingTitle TEXT,
  DisplayArtistName TEXT,
  DisplayArtistISNI VARCHAR(16),
  Duration VARCHAR(100),
  UnclaimedPercentage FLOAT,
  PercentileForPrioritisation INTEGER,
  snapshotid INT
);
