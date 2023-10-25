#####################################  INDIQUEM l'ÚS DE LA BASE DE DADES #########################################
CREATE DATABASE opticaculampolla;
USE opticaculampolla;

################################# CREACIÓ DE LES TABLES ##################################################
CREATE TABLE Proveidors (
    ID_proveidor INT(10) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(50) NOT NULL,
    carrer VARCHAR(50) NOT NULL,
    numero INT (4) NOT NULL,
    pis INT(2) NULL,
    porta VARCHAR(2) NULL,
	ciutat VARCHAR(50) NOT NULL,
    codiPostal INT(5) NOT NULL,
    pais VARCHAR(50) NOT NULL,
    telefon INT(9) NOT NULL,
    fax INT(9) NULL,
    NIF VARCHAR(9) NOT NULL
);

CREATE TABLE Marques (
    ID_marca INT(10) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nomMarca VARCHAR(50) NOT NULL
);

CREATE TABLE Ulleres (
    ID_ulleres INT (10) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    marca_ID INT(10) NOT NULL,
    graduacioVidreEsq FLOAT NOT NULL,
    graduacioVidreDret FLOAT NOT NULL,
    tipusMontura ENUM ('Flotant', 'Pasta', 'Metalica') NOT NULL, 
    colorMontura VARCHAR(50) NOT NULL,
    colorVidreEsqu VARCHAR(50) NOT NULL,
    colorVidreDret VARCHAR(50) NOT NULL,
    preu FLOAT NOT NULL,
    proveidor_ID INT (10) NOT NULL,
    FOREIGN KEY (marca_ID) REFERENCES Marques(ID_marca),
    FOREIGN KEY (proveidor_ID) REFERENCES Proveidors(ID_proveidor)
);

CREATE TABLE Clients (
    ID_client INT(10) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(50) NOT NULL,
    carrer VARCHAR(50) NOT NULL,
    numero INT (4) NOT NULL,
    pis INT(2) NOT NULL,
    porta VARCHAR(2) NOT NULL,
    ciutat VARCHAR(50) NOT NULL,
    codiPostal INT(5) NOT NULL,
    pais VARCHAR(50) NOT NULL,
    telefon INT(9) NOT NULL,
    eMail VARCHAR(50) NULL,
    dataRegistre DATE NOT NULL,
    clientRecomanador INT (10) NULL,
    FOREIGN KEY (clientRecomanador) REFERENCES Clients(ID_client)
);


CREATE TABLE Empleats (
    ID_empleat INT(10) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(50) NOT NULL
);

CREATE TABLE Vendas (
    ID_venda INT(10) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    dataVenda DATE NOT NULL,
    client_ID INT (10) NOT NULL,
    ulleres_ID INT (10) NOT NULL,
    empleat_ID INT (10) NOT NULL,
    FOREIGN KEY (client_ID) REFERENCES Clients(ID_client),
    FOREIGN KEY (ulleres_ID) REFERENCES Ulleres(ID_ulleres),
    FOREIGN KEY (empleat_ID) REFERENCES Empleats(ID_empleat)
);

####################  INSERCIÓ DE DADES PER PROBAR LA ESTRUCTURA  ###################################

INSERT INTO Proveidors (nom, carrer, numero, pis, porta, ciutat, codiPostal, pais, telefon, fax, NIF) VALUES
    ('Optica2000', 'Carrer sense nom', 123, NULL, NULL, 'Rubí', 08191, 'Espanya', 936995000, 936995001, 'A5034567X'),
    ('Optica Universidad', 'Carrer Estació', 45, 1, 'B', 'Bellaterra', 08098, 'Espanya', 935909090, NULL, 'B5054321Y'),
    ('Ulleres92', 'Carrer quart', 78, NULL, NULL, 'Sabadell', 08230, 'Espanya', 938902030, NULL, 'C4076543Z'),
    ('Gafas Muntaner', 'Carrer Muntaner', 87, NULL, NULL,  'Barcelona', 08080, 'Espanya', '633666666', NULL, 'D3034567W');

INSERT INTO Marques (nomMarca) VALUES
    ('M1'),
    ('M2'),
    ('M3'),
    ('M4');
    
INSERT INTO Ulleres (marca_ID, graduacioVidreEsq, graduacioVidreDret, tipusMontura, colorMontura, colorVidreEsqu, colorVidreDret,
					preu, proveidor_ID) VALUES
    (1, 2.1, 2.3, 'Flotant', 'Negre', 'Transparent', 'Transparent', 99.99, 1),
    (2, 1.5, 1.5, 'Pasta', 'Blau', 'Verd', 'Vermell', 80.50, 2),
    (1, 3.0, 3.6, 'Metalica', 'Plata', 'Gris', 'Gris', 119.90, 3),
    (4, 2.5, 2.5, 'Pasta', 'Vermell', 'Blanc', 'Blanc', 79.98, 1);

INSERT INTO Clients (nom, carrer, numero, pis, porta, ciutat, codiPostal, pais, telefon, eMail, dataRegistre, clientRecomanador) VALUES
    ('Maria Agut', 'Calle Principal', 123, 1, 'A', 'Barcelona', 08001, 'España', 935555555, 'maria@example.com', '2023-10-15', NULL),
    ('Juan Rodríguez', 'Avenida Central', 45, 2, 'B', 'Madrid', 28001, 'España', 912345678, 'juan@example.com', '2023-10-14', NULL),
    ('Lluisa García', 'Calle del Sol', 67, 3, 4, 'Valencia', 46001, 'España', 963333333, NULL, '2023-10-13', NULL),
    ('Carles Martínez', 'Paseo Marítimo', 33, 4, 'C', 'Barcelona', 08002, 'España', 937777777, 'carlos@example.com', '2023-10-12', 1);

INSERT INTO Empleats (nom)
VALUES
    ('Manel'),
    ('Xavi'),
    ('Laura'),
    ('Sofia');
    
  INSERT INTO Vendas (dataVenda, client_ID, ulleres_ID, empleat_ID) VALUES
    ('2023-10-20', 1, 5, 1),
    ('2023-10-21', 2, 6, 2),
    ('2023-10-22', 3, 7, 3),
    ('2023-10-23', 4, 8, 4);  
    
    
    ##############  FEM LES 3 CONSULTES PÊR VERIFICAR EL FUNCIONAMENT ##############3
    
# Llista el total de compres d’un client/a.
SELECT Clients.nom AS Client, SUM(Ulleres.preu) AS TotalCompres FROM Clients 
LEFT JOIN Vendas ON Clients.ID_client = Vendas.client_ID LEFT JOIN Ulleres ON Vendas.ulleres_ID = Ulleres.ID_ulleres
WHERE Clients.ID_client = 1 GROUP BY Clients.nom;


# Llista les diferents ulleres que ha venut un empleat durant un any.
SELECT Ulleres.ID_ulleres, Ulleres.preu FROM Vendas LEFT JOIN Ulleres ON Vendas.ulleres_ID = Ulleres.ID_ulleres
WHERE Vendas.empleat_ID = 1 AND YEAR(Vendas.dataVenda) = 2023;

# Llista els diferents proveïdors que han subministrat ulleres venudes amb èxit per l'òptica
SELECT Proveidors.nom FROM Proveidors WHERE Proveidors.ID_proveidor 
IN (SELECT Ulleres.proveidor_ID FROM Ulleres INNER JOIN Vendas ON Ulleres.ID_ulleres = Vendas.ulleres_ID);







