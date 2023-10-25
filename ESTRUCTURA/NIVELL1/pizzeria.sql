###################################### CREEM LA BASE DE DADES ###################################

CREATE DATABASE pizzeria;
USE pizzeria;

################################## CREEM LES TAULES ###########################################

CREATE TABLE Clients (
    ID_client INT(10) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Nom VARCHAR(50) NOT NULL,
    Cognoms VARCHAR(50) NOT NULL,
    Adreça VARCHAR(200) NOT NULL,
    CodiPostal VARCHAR(5) NOT NULL,
    Localitat VARCHAR(50) NOT NULL,
    Província VARCHAR(50) NOT NULL,
    Telèfon VARCHAR(15) NOT NULL
);

CREATE TABLE Categories (
    ID_categoria INT(10) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Nom VARCHAR(50) NOT NULL
);

CREATE TABLE CategoriesPizza (
    ID_categoriaPizza INT(10) NULL AUTO_INCREMENT PRIMARY KEY,
    NomCategoria VARCHAR(50) NOT NULL
);

CREATE TABLE Productes (
    ID_producte INT(10) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Nom VARCHAR(50) NOT NULL,
    Descripció VARCHAR(200) NOT NULL,
    Imatge BLOB NULL,
    Preu FLOAT NOT NULL,
    TipusProducte_ID INT(10) NOT NULL,
    CategoriaPizza_ID INT(10) NULL,
    FOREIGN KEY (TipusProducte_ID) REFERENCES Categories(ID_categoria),
    FOREIGN KEY (CategoriaPizza_ID) REFERENCES CategoriesPizza(ID_categoriaPizza)
);

CREATE TABLE Botigues (
    ID_botiga INT(10) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Adreça VARCHAR(200) NOT NULL,
    CodiPostal VARCHAR(5) NOT NULL,
    Localitat VARCHAR(50) NOT NULL,
    Província VARCHAR(50) NOT NULL
);

CREATE TABLE Empleats (
    ID_empleat INT(10) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Nom VARCHAR(50) NOT NULL,
    Cognoms VARCHAR(50) NOT NULL,
    NIF VARCHAR(9) NOT NULL,
    Telèfon VARCHAR(15) NOT NULL,
    tipusFeina ENUM('cuiner', 'repartidor') NOT NULL,
    Botiga_ID INT(10) NOT NULL,
    FOREIGN KEY (Botiga_ID) REFERENCES Botigues(ID_botiga)
);

CREATE TABLE Comandes (
    ID_comanda INT(10) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    DataHora DATETIME NOT NULL,
    TipusComanda ENUM('repartimentDomicili', 'recollirBotiga') NOT NULL,
    Repartidor_ID INT(10) NULL,
    DataHoraLliurament DATETIME NULL,
    PreuTotal FLOAT NULL,
    Client_ID INT(10) NOT NULL,
    Botiga_ID INT(10) NOT NULL,
    FOREIGN KEY (Client_ID) REFERENCES Clients(ID_client),
    FOREIGN KEY (Botiga_ID) REFERENCES Botigues(ID_botiga),
    FOREIGN KEY (Repartidor_ID) REFERENCES Empleats(ID_empleat)
);

CREATE TABLE ComandesProductes (
    Comanda_ID INT(10) NOT NULL,
    Producte_ID INT(10) NOT NULL,
    Quantitat INT(10) NOT NULL,
    FOREIGN KEY (Comanda_ID) REFERENCES Comandes(ID_comanda),
    FOREIGN KEY (Producte_ID) REFERENCES Productes(ID_producte)
);

############ FEM EL TRIGGER PER ANAR ACTUALITZANT EL PREU TOTAL A MIDA QUE AFEGIM PRODUCTES A LA COMANDA ##################3333

DELIMITER //
CREATE TRIGGER ActualizarPreuTotal
BEFORE INSERT ON ComandesProductes
FOR EACH ROW
BEGIN
    DECLARE afegit FLOAT;
    SET afegit = (SELECT Preu FROM Productes WHERE ID_producte = NEW.Producte_ID) * NEW.Quantitat;

    ## Actualitza el valor de PreuTotal en la taula Comandes
    UPDATE Comandes
    SET PreuTotal = IFNULL(PreuTotal, 0) + afegit
    WHERE ID_comanda = NEW.Comanda_ID;
END;
//
DELIMITER ;

##################################### INSERCIÓ DE DADES ###############################################

INSERT INTO Clients (Nom, Cognoms, Adreça, CodiPostal, Localitat, Província, Telèfon) VALUES
   ('Maria', 'Garcia', 'Carrer Gran de Gràcia 123', '08007', 'Barcelona', 'Barcelona', '666111222'),
   ('Jordi', 'Martínez', 'Passeig de Gràcia 45', '08008', 'Barcelona', 'Barcelona', '678123456'),
   ('Ana', 'López', 'Carrer del Diamant 77', '08028', 'Barcelona', 'Barcelona', '678967896'),
   ('David', 'Fernández', 'Carrer Catalunya 20', '08001', 'Barcelona', 'Barcelona', '933111333');
   
INSERT INTO Categories (Nom) VALUES
   ('Pizza'),
   ('Hamburguesa'),
   ('Beguda');

INSERT INTO CategoriesPizza (NomCategoria) VALUES
   ('Pizza Normal'),
   ('Pizza Premium');
   
INSERT INTO Productes (Nom, Descripció, Preu, TipusProducte_ID, CategoriaPizza_ID) VALUES
   ('Pizza Margarita', 'Tomàquet, mozzarella', 10.99, 1, 1),
   ('Hamburguesa BBQ', 'Carn a la parrilla, ceba', 8.99, 2, NULL),
   ('Coca-Cola', 'Refresc amb molt de sucre', 1.99, 3, NULL),
   ('Pizza 4 Estacions', 'Pernil, bolets, olives', 12.99, 1, 1),
   ('Hamburguesa Deluxe', 'Carn, bacon, formatge', 9.99, 2, NULL),
   ('Fanta Naranja', 'Refresc de taronja', 1.99, 3, NULL),
   ('Pizza Vegetariana', 'Tomàquet, mozzarella, bolets', 11.99, 1, 2),
   ('Pizza Hawaiana', 'Pernil, pinya, tomaquet', 11.99, 1, 2);

INSERT INTO Botigues (Adreça, CodiPostal, Localitat, Província) VALUES
   ('Carrer Provença 56', '08015', 'Barcelona', 'Barcelona'),
   ('Rambla de Catalunya 2', '08007', 'Barcelona', 'Barcelona'),
   ('Pasaje de los Huertos, 2', '08191', 'Rubi', 'Barcelona');

INSERT INTO Empleats (Nom, Cognoms, NIF, Telèfon, tipusFeina, Botiga_ID) VALUES
   ('Marc', 'Sánchez', '52083374G', '654987321', 'cuiner', 1),
   ('Laura', 'Gómez', '62083374H', '678123987', 'repartidor', 2),
   ('Carla', 'Pérez', '72083374I', '678456123', 'cuiner', 2),
   ('Hector', 'Rodríguez', '82083374J', '666987654', 'repartidor', 1);

INSERT INTO Comandes (DataHora, TipusComanda, Repartidor_ID, PreuTotal, Client_ID, Botiga_ID) VALUES
   ('2023-10-23 14:00:00', 'repartimentDomicili', 2, NULL, 1, 3),
   ('2023-10-23 19:30:00', 'recollirBotiga', 1, NULL, 2, 3),
   ('2023-10-22 20:15:00', 'repartimentDomicili', 3, NULL, 3, 2),
   ('2023-10-21 12:45:00', 'repartimentDomicili', 1, NULL, 4, 2),
   ('2023-10-20 17:00:00', 'recollirBotiga', 2, NULL, 1, 1),
   ('2023-10-19 13:30:00', 'repartimentDomicili', 2, NULL, 3, 2),
   ('2023-10-18 11:00:00', 'repartimentDomicili', 1, NULL, 4, 2);

INSERT INTO ComandesProductes (Comanda_ID, Producte_ID, Quantitat) VALUES
   (1, 1, 2),
   (1, 3, 3),
   (2, 4, 1),
   (2, 7, 2),
   (3, 2, 4),
   (4, 6, 3),
   (5, 1, 2),
   (6, 3, 3),
   (7, 8, 4);

######################  PROVEM LA BBDD AMB AQUESTES DUES CONSULTES   #################################################

## Llista quants productes de tipus “Begudes” s'han venut en una determinada localitat.
SELECT COUNT(*) AS NumBegudesVendides FROM Comandes JOIN ComandesProductes ON Comandes.ID_comanda = ComandesProductes.Comanda_ID
JOIN Productes ON ComandesProductes.Producte_ID = Productes.ID_producte JOIN Botigues ON Comandes.Botiga_ID = Botigues.ID_botiga
WHERE Productes.TipusProducte_ID = 3 AND Botigues.Localitat = 'Barcelona';

## Llista quantes comandes ha efectuat un determinat empleat/da
SELECT Empleats.Nom AS NomEmpleat, COUNT(Comandes.ID_comanda) AS CantidadComandes FROM Empleats
JOIN Comandes ON Empleats.ID_empleat = Comandes.Repartidor_ID WHERE Empleats.Nom = 'Laura';

# També probem que funcioni bé el Trigger que em fet per actualitzar el preuTotal.
# Agafem els ID_comanda = 1,2 que estàn compostos de varis productes.
SELECT ID_comanda, PreuTotal
FROM Comandes
WHERE ID_comanda IN (1, 2);