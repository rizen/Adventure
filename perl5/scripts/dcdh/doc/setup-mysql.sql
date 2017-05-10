CREATE USER 'devel'@'localhost' IDENTIFIED BY '!S0Me#P%ss';
CREATE database music;
GRANT ALL PRIVILEGES ON music.* TO 'devel'@'localhost';
FLUSH PRIVILEGES;
