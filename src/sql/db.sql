-- CREAR SECUENCIAS 

-- Secuencia num_factura
CREATE SEQUENCE num_factura_seq 
    INCREMENT BY 1
    NO MAXVALUE
    MINVALUE 1000    
CACHE 1; 



--CREAR TABLAS


--Tabla cliente
create table cliente
(
    id_cliente varchar(30) not null,
    tipo_identificacion varchar (15) not null,
    tipo_cliente varchar (20) not null ,
    nombre varchar not null,
    direccion varchar not null, 
    telefono varchar(10), 
    correo varchar, 
    estado bool not null, 
    primary key(id_cliente,tipo_identificacion)
);



--Tabla trabajadores
create table trabajadores
(
    id_trabajador varchar(30) not null,
    tipo_identificacion varchar (15) not null,
    cargo varchar (20) not null ,
    nombre varchar not null,
    direccion varchar not null, 
    telefono varchar(10), 
    correo varchar, 
    estado bool not null, 
    primary key(id_trabajador,tipo_identificacion)
);


--Tabla planes
create table planes
(
    id_plan serial,
    nom_plan varchar(255) not null ,
    descripcion varchar not null ,
    precio money NOT NULL,
    limite_de_minutos int not null ,
    limite_de_datos int not null ,
    limite_de_mensajes int not null ,
    primary key (id_plan)
);


--Tabla numero
create table numero
(
    numero_tel varchar(10) not null,
    id_plan int,
    minutos_usados int not null ,
    datos_usados int not null ,
    mensajes_usados int not null ,
    primary key (numero_tel),
    foreign key (id_plan) references planes(id_plan)
);

--Tabla contrato
create table contratos
(
    num_contrato serial,
    fecha date not null,
    estado bool default true,
    primary key(num_contrato)
);

--Tabla factura

CREATE TABLE factura(
    
    num_factura integer DEFAULT nextval('num_factura_seq'::regclass) NOT NULL,
    num_contrato integer NOT NULL, 
    cantidad_pagada money NOT NULL, 
    total_a_pagar money NOT NULL, 
    fecha_creacion date NOT NULL, 
    fecha_pago date NULL, 
    fecha_vencimiento date NOT NULL,
    
    PRIMARY KEY(num_factura),
    FOREIGN KEY(num_contrato) references contratos(num_contrato)

);

--Tablas dependientes de otras:

--Tabla usuarios
create table usuarios (
id_trabajador varchar(30) not null,
tipo_identificacion varchar (15) not null,
contraseña varchar not null,
isactive bool default false,
foreign key (id_trabajador,tipo_identificacion) references trabajadores (id_trabajador,tipo_identificacion)
);


--Tabla Contratos-clientes
CREATE TABLE contratos_clientes(
    num_contrato int NOT NULL,
    tipo_identificacion VARCHAR(15) NOT NULL,
    id_cliente VARCHAR(30) NOT NULL,
    FOREIGN KEY (num_contrato) REFERENCES contratos(num_contrato),
    FOREIGN KEY (tipo_identificacion, id_cliente) REFERENCES cliente(tipo_identificacion, id_cliente)
);




--Tabla voucher
CREATE TABLE voucher (
    num_voucher integer NOT NULL,
    num_factura integer NOT NULL,
    cantidad money NOT NULL,
    banco VARCHAR(20) NOT NULL,
    PRIMARY KEY(num_voucher),
    FOREIGN KEY (num_factura) REFERENCES factura(num_factura)
);


-- TABLA contratos_telefonos

CREATE TABLE contratos_telefonos (
    num_contrato integer NOT NULL, 
    numero_tel VARCHAR(10) NOT NULL, 
    
    
    FOREIGN KEY (num_contrato) references contratos(num_contrato),
    FOREIGN KEY (numero_tel) references numero(numero_tel)
); 

-- Inserts
--Insert planes

insert into planes(nom_plan,descripcion,precio,limite_de_minutos,limite_de_datos,limite_de_mensajes)
values('plan cheverito','el plan mas cheverito de la vira','100000','10','20','30');

--Insert número

insert into numero(numero_tel,id_plan,minutos_usados,datos_usados,mensajes_usados)
values('3127093255',1,123413,412363,86553546);

--Insert contratos
insert into contratos (fecha)
values(current_timestamp),(current_timestamp);

--insert trabajadores
insert into trabajadores (id_trabajador,tipo_identificacion,cargo,nombre,direccion,telefono,correo,estado)
values ('1193552015','C.C','Gerente','Andres Felipe Giron Perez', 'carrera 1C 4 #53b-10', '3116259843', 'andresfelipe042001@gmail.com',true);

--insert cliente
insert into cliente (id_cliente,tipo_identificacion,tipo_cliente,nombre,direccion,telefono,correo,estado)
values ('31482384','C.C','Natural','Angelica Maria Perez Mina', 'carrera 1C 4 #53b-10', '3124215478', 'angieperez3120@gmail.com',true);

--insert usuarios
insert into usuarios (id_trabajador, tipo_identificacion,contraseña) values ('1193552015', 'C.C', 'A1193G');




-- Insert factura

INSERT INTO factura VALUES (nextval('num_factura_seq'), 1, 20000, 50000, DATE '2022-01-15', DATE '2022-01-16', DATE '2022-01-25');



-- Insert contratos clientes
INSERT INTO contratos_clientes VALUES(1,'C.C','31482384');
INSERT INTO contratos_clientes VALUES(2,'C.C','31482384');


