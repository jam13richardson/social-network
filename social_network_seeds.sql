TRUNCATE TABLE users RESTART IDENTITY;
TRUNCATE TABLE posts RESTART IDENTITY;

INSERT INTO users (email, username) VALUES ('Jamie', 'jamie@richardson.com');
INSERT INTO users (email, username) VALUES ('Bella', 'Bella@Vita.com');

INSERT INTO posts (title, content, views) VALUES ('Great movies', 'Shrek, Shrek 2, Shrek 3, Shrek 4', 5);
INSERT INTO posts (title, content, views) VALUES ('Why porridge sucks', 'Is it just me or... ', 60);