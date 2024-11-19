CREATE DATABASE ticketcreator;

\c ticketcreator;

CREATE TABLE IF NOT EXISTS company(
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    nit VARCHAR(50) NOT NULL,
    address VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS user_company(
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL,
    password VARCHAR(250) NOT NULL,
    company_id INT NOT NULL,
    FOREIGN KEY (company_id) REFERENCES company(id)
);

CREATE TABLE IF NOT EXISTS project(
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    description TEXT NOT NULL,
    company_id INT NOT NULL,
    FOREIGN KEY (company_id) REFERENCES company(id)
);

CREATE TABLE IF NOT EXISTS priority(
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS user_story(
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    description TEXT NOT NULL,
    priority_id INT NOT NULL,
    project_id INT NOT NULL,
    FOREIGN KEY (priority_id) REFERENCES priority(id),
    FOREIGN KEY (project_id) REFERENCES project(id)
);

CREATE TABLE IF NOT EXISTS state(
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS ticket(
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    description TEXT NOT NULL,
    state_id INT NOT NULL,
    user_story_id INT NOT NULL,
    FOREIGN KEY (state_id) REFERENCES state(id),
    FOREIGN KEY (user_story_id) REFERENCES user_story(id)
);

CREATE TABLE IF NOT EXISTS comment(
    id SERIAL PRIMARY KEY,
    description TEXT NOT NULL,
    ticket_id INT NOT NULL,
    user_id INT NOT NULL,
    FOREIGN KEY (ticket_id) REFERENCES ticket(id),
    FOREIGN KEY (user_id) REFERENCES user_company(id)
);

INSERT INTO priority(name) VALUES('Low');
INSERT INTO priority(name) VALUES('Medium');
INSERT INTO priority(name) VALUES('High');

INSERT INTO state(name) VALUES('Asset');
INSERT INTO state(name) VALUES('In Progress');
INSERT INTO state(name) VALUES('Done');
INSERT INTO state(name) VALUES('Canceled');