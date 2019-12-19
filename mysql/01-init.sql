CREATE DATABASE IF NOT EXISTS TrackErrors;
CREATE USER IF NOT EXISTS 'TrackErrors' identified by 'letmein12';
GRANT ALL ON `TrackErrors`.* TO 'TrackErrors';