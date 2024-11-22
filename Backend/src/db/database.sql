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
    name VARCHAR(100) NOT NULL,
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
    name VARCHAR(100) NOT NULL,
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
    name VARCHAR(100) NOT NULL,
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
INSERT INTO project(name, description, company_id) VALUES('Gestión de Recursos Humanos', 'Desarrollar un software que permita a la empresa gestionar su personal, nómina y contrataciones.', 2);

INSERT INTO user_story(name, description, priority_id, project_id) VALUES('Gestión de Productos', 'Como gestor de inventario, quiero poder registrar nuevos productos en el sistema, para que pueda llevar un control preciso de los artículos disponibles.', 3, 1);
INSERT INTO user_story(name, description, priority_id, project_id) VALUES('Control de Stock', 'Como responsable de inventario, quiero poder ver el stock disponible de cada producto, para poder gestionar adecuadamente las órdenes y evitar faltantes.', 2, 1);
INSERT INTO user_story(name, description, priority_id, project_id) VALUES('Generación de Reportes', 'Como gerente, quiero poder generar reportes sobre el estado del inventario, para analizar las tendencias y tomar decisiones informadas sobre compras y ventas.', 2, 1);

INSERT INTO user_story(name, description, priority_id, project_id) VALUES('Registro de Clientes', 'Como administrador, quiero poder registrar nuevos clientes en el sistema, para poder llevar un control de las ventas y la atención al cliente.', 3, 2);
INSERT INTO user_story(name, description, priority_id, project_id) VALUES('Consulta de Facturas', 'Como cliente, quiero poder consultar mis facturas en línea, para poder verificar el estado de mis pagos y realizar reclamos si es necesario.', 1, 2);
INSERT INTO user_story(name, description, priority_id, project_id) VALUES('Soporte en Línea', 'Como cliente, quiero poder solicitar soporte técnico en línea, para poder resolver mis dudas y problemas de manera rápida y eficiente.', 3, 2);

INSERT INTO user_story(name, description, priority_id, project_id) VALUES('Registro de Empleados', 'Como gerente de recursos humanos, quiero poder registrar nuevos empleados en el sistema, para poder llevar un control de las contrataciones y despidos.', 3, 3);
INSERT INTO user_story(name, description, priority_id, project_id) VALUES('Gestión de Nómina', 'Como responsable de nómina, quiero poder calcular la nómina de los empleados, para poder realizar los pagos de manera oportuna y precisa.', 2, 3);
INSERT INTO user_story(name, description, priority_id, project_id) VALUES('Control de Vacaciones', 'Como empleado, quiero poder solicitar mis vacaciones en línea, para poder planificar mis descansos y evitar conflictos con el trabajo.', 1, 3);

INSERT INTO ticket(name, description, state_id, user_story_id) VALUES('Crear vista de lista de productos', 'Desarrollar una interfaz que muestre todos los productos registrados junto con su cantidad disponible.', 3, 1);
INSERT INTO ticket(name, description, state_id, user_story_id) VALUES('Implementar funcionalidad para actualizar cantidades', 'Permitir a los usuarios actualizar la cantidad disponible de un producto desde la vista de lista.', 2, 1);
INSERT INTO ticket(name, description, state_id, user_story_id) VALUES('Generar reporte de productos más vendidos', 'Desarrollar un reporte que muestre los productos más vendidos en un período de tiempo específico.', 1, 1);
INSERT INTO ticket(name, description, state_id, user_story_id) VALUES('Crear formulario de registro de clientes', 'Diseñar un formulario que permita a los usuarios registrar nuevos clientes en el sistema.', 3, 4);
INSERT INTO ticket(name, description, state_id, user_story_id) VALUES('Implementar funcionalidad para buscar facturas', 'Permitir a los clientes buscar sus facturas por número de factura o fecha de emisión.', 2, 5);
INSERT INTO ticket(name, description, state_id, user_story_id) VALUES('Agregar chat de soporte en línea', 'Incorporar un chat en vivo en el portal de clientes para brindar soporte técnico en tiempo real.', 3, 6);
INSERT INTO ticket(name, description, state_id, user_story_id) VALUES('Diseñar formulario de registro de empleados', 'Crear un formulario que permita a los gerentes registrar nuevos empleados en el sistema.', 3, 7);