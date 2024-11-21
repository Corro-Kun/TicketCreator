CREATE DATABASE ticketcreator;

\c ticketcreator;

CREATE TABLE IF NOT EXISTS company(
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    nit VARCHAR(50) NOT NULL,
    address VARCHAR(50) NOT NULL,
    telephone VARCHAR(50) NOT NULL,
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

INSERT INTO company(name, nit, address, email, telephone) VALUES('Code Innovations', '900.321.654-8', 'Calle 30 # 45-67', ' contacto@codeinnovations.com', '(1) 345-6789');
INSERT INTO company(name, nit, address, email, telephone) VALUES('SoftWave Ltda', '800.654.321-0', 'Avenida Digital # 88', 'info@softwave.com', '(4) 789-0123');
INSERT INTO company(name, nit, address, email, telephone) VALUES('DevSphere', '900.987.123-4', 'Carrera 15 # 22-45,', 'soporte@devsphere.com', '(5) 890-1234');

INSERT INTO project(name, description, company_id) VALUES('Gestión de Inventarios', 'Desarrollar un software que permita a la empresa gestionar su inventario en tiempo real.', 1);
INSERT INTO project(name, description, company_id) VALUES('Portal de Clientes', 'Desarrollar un portal web donde los clientes puedan acceder a información relevante sobre sus pedidos, facturas y soporte.', 1);