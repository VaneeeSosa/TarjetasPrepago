use BDTarjetas


DROP TABLE usuarios;


CREATE TABLE Usuarios (
    Curp VARCHAR2(18) NOT NULL,
    Nombre VARCHAR2(100) NOT NULL,
    Contrasena VARCHAR2(100) NOT NULL,
    IDROL INT NOT NULL,
    IDESTATUS INT NOT NULL,
    Usuario VARCHAR2(100) NOT NULL,
    CONSTRAINT Usuarios_pk PRIMARY KEY (Curp)
);

SELECT Curp, Nombre, Contrasena, IDROL, Usuario FROM Usuarios
select * from Usuarios
select * from Rol


Create Table Rol (
IDROL int not null,
rol varchar2(100) not null,
CONSTRAINT Rol_pk PRIMARY KEY (IDROL)
);


INSERT INTO Rol (IDROL, Rol) VALUES (1, 'Empleado');
INSERT INTO Rol (IDROL, Rol) VALUES (2, 'Administrador');

SELECT u.Curp, u.Nombre, u.Contrasena, r.rol as Rol, u.Usuario FROM Usuarios u JOIN Rol r ON u.IDROL = r.IDROL;


Create table Estatus(
IDESTATUS int not null,
Estatus varchar2(100) not null,
CONSTRAINT Estatus_pk PRIMARY KEY (IDESTATUS)
);

INSERT INTO Estatus (IDESTATUS, Estatus) VALUES (1, 'Activo');
INSERT INTO Estatus (IDESTATUS, Estatus) VALUES (2, 'Inactivo');

SELECT * FROM Estatus;

SELECT u.Curp, u.Nombre, u.Contrasena, r.rol as Rol, e.Estatus as Estado, u.Usuario 
    FROM Usuarios u 
    JOIN Rol r ON u.IDROL = r.IDROL
    JOIN Estatus e ON u.IDESTATUS = e.IDESTATUS
    
INSERT INTO Usuarios (Curp, Nombre, Contrasena, IDROL, IDESTATUS, Usuario)
VALUES ('SASGHL12ED45HMGW24', 'admin', 'admin', 2, 1, 'admin');


CREATE TABLE Clientes (
    CURP VARCHAR2(18),
    NombreCom VARCHAR2(100),
    Telefono NUMBER,
    Direccion VARCHAR2(400),
    Vigencia DATE
);

select*from Clientes;

CREATE TABLE Tarjetas (
    NumeroTarjeta VARCHAR2(20) PRIMARY KEY,
    CURP VARCHAR2(18),
    FechaEmision DATE,
    FechaExpiracion DATE,
    FOREIGN KEY (CURP) REFERENCES Clientes(CURP)
);

ALTER TABLE Clientes
ADD CONSTRAINT pk_curp PRIMARY KEY (CURP);

select*from Tarjetas;

SELECT c.CURP, c.NombreCom, c.Telefono, c.Direccion, TO_CHAR(c.Vigencia, 'YYYY-MM-DD') AS Vigencia, t.NumeroTarjeta, TO_CHAR(t.FechaExpiracion, 'YYYY-MM-DD') AS Pago 
FROM Clientes c 
INNER JOIN Tarjetas t ON c.CURP = t.CURP 
WHERE t.NumeroTarjeta = :numero_tarjeta

CREATE TABLE Ventas (
    IDVenta INT PRIMARY KEY,
    Fecha DATE NOT NULL,
    CurpEmpleado VARCHAR2(18) NOT NULL,
    CurpCliente VARCHAR2(18) NOT NULL,
    NumeroTarjeta VARCHAR2(20) NOT NULL,
    Monto NUMBER NOT NULL,
    FOREIGN KEY (CurpEmpleado) REFERENCES Usuarios(Curp),
    FOREIGN KEY (CurpCliente) REFERENCES Clientes(Curp),
    FOREIGN KEY (NumeroTarjeta) REFERENCES Tarjetas(NumeroTarjeta)
);


-- Consulta para el corte de caja para una fecha específica
SELECT CurpEmpleado, SUM(Monto) AS TotalVentas
FROM Ventas
WHERE Fecha = TO_DATE('2024-07-19', 'YYYY-MM-DD')
GROUP BY CurpEmpleado;


