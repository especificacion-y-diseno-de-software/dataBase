/*Proyecto CarpoolingTEC
	Base SQL Server

Gabriela �vila
Roberto Pereira
Ellioth Ramirez
Esteban Zuñiga 

NOTA: Script para crear la base de datos
*/

/*
USE master
GO
DROP DATABASE TECCONSTRUYE
GO
*/

--*****************************************************CREANDO LA BASE DE DATOS****************************************************

USE master
GO
if (db_id('CARPOOLINGTECWebService_db') is not null)
begin    
	DROP DATABASE CARPOOLINGTECWebService_db
end

CREATE DATABASE CARPOOLINGTECWebApi2019_db
GO 

USE CARPOOLINGTECWebService_db
GO

--****************************************************DEFINICION DE TABLAS DE LA BASE DE DATOS****************************************************

/*tabla para almacenar la informacion de los usuarios
	US_ID int					identificacion del usuario
	US_nombre varchar(50)		nombre
	US_apellido1 varchar(50)	apellido
	US_apellido2 varchar(50)	segundo apellido
	US_telefono varchar (8)		telefono, soporta hasta 8 caracteres
	US_correo varchar (50)		correo, verificar en la app si tiene la extension de xtec
	US_rol varchar (1)			para saber si es admin o no
	US_puntaje int				el puntaje
	US_estadoCuenta int			si ha eliminado la cuenta o si un admin ha desactivado la cuenta
	US_categoria int			el id de la categoria
*/
CREATE TABLE USUARIO (
	US_ID int not null,
	US_nombre varchar (50) NOT NULL,
	US_apellido1 varchar (50) NOT NULL,
	US_apellido2 varchar (50) NOT NULL,
	US_correo varchar (50) NOT NULL,
	US_rol varchar (1) NOT NULL,
	US_estadoCuenta int  default 0,
	US_categoria int default 0,

	PRIMARY KEY (US_ID)
);

/*tabla para almacenar la lista de telefonos del usuario
	TE_telefono varchar(8)	el numero de telefono del usuario
	TE_userID				el id del usuario
*/
CREATE TABLE TELEFONOS(
	TE_telefono varchar(8) NOT NULL,
	TE_userID int NOT NULL,

	PRIMARY KEY (TE_telefono)
);

/*tabla para almacenar la informacion de los carros
	CA_placa varchar(6)		la placa del carro
	CA_marca varchar(50)	la marca del carro
	CA_modelo varchar(50)	el modelo del carro
	CA_pasa_cant int		la cantidad de gente que aguanta el carro
	CA_userID int			el id del usuario dueño del carro
*/
CREATE TABLE CARRO (
	CA_placa varchar(6) NOT NULL,
	CA_marca varchar(50) NOT NULL,
	CA_modelo varchar(50) NOT NULL,
	CA_pasa_cant int NOT NULL,
	CA_userID int not null,

	PRIMARY KEY (CA_placa)
);

/*tabla para almacenar la informacion de los viajes
	VI_ID int					el id del viaje creado por el chofer
	VI_choferID int				el id del chofer que creo el viaje
	VI_fecha varchar(50)		la fecha en la que fue creado el viaje
	VI_parqueo int				la numeracion del parqueo autorizado.
	VI_placaCarro				la placa del carro asignado al viaje.
*/
CREATE TABLE VIAJES (
	VI_ID int NOT NULL identity(0,1),
	VI_choferID int not null,
	VI_fecha varchar(50) NOT NULL,
	VI_parqueo int default 0,
	VI_placaCarro varchar(6) not null,

	PRIMARY KEY (VI_ID)
);

/*tabla para almacenar la informacion de los viajes de un usuario
	VU_codigoViaje int			el codigo que ingresara el usuario al llegar al parqueo
	VU_viajeID int				el id del viaje asociado
	VU_userID int				el id de la persona que acepta el viaje
	VU_puntajeXviaje int		la cantidad de puntos que se gano
*/
CREATE TABLE VIAJESXUSUARIO (
	VU_codigoViaje int not null,
	VU_viajeID int NOT NULL, 
	VU_userID int NOT NULL, 
	VU_puntajeXviaje int default 0,

	PRIMARY KEY(VU_codigoViaje)
);

/*tabla para almacenar la lista de amigos agregados
	AA_userID int				el id del usuario
	AA_amigoID int				el id del amigo del usuario
*/
CREATE TABLE AMIGOS(
	AA_id int identity(0,1),
	AA_userID int NOT NULL,
	AA_amigoID int NOT NULL

	PRIMARY KEY (AA_id)
);

/*tabla para almacenar la informacion de las categorias
	CA_ID int					el id de la categoria
	CA_nombre varchar(50)		el nombre/descripcion de la categoria
	CA_puntaje int				el puntaje que otroga la categoria.
	CA_puntajeUmbral int		el umbral de viajes que se ocupa para llegar al siguiente nivel
	CA_puntajeUmbralPmes int	el umbral de viajes/mes que se ocupa para llegar al siguiente nivel
*/
CREATE TABLE CATEGORIAS(
	CA_ID int identity(0,1),
	CA_nombre varchar(50) NOT NULL,
	CA_puntaje int NOT NULL,
	CA_Umbral int not null,
	CA_UmbralPmes int not null,

	PRIMARY KEY (CA_ID)
);

/*tabla para almacenar la informacion de los objetos intercambiados
	OI_ID int					el id del objeto conseguido
	OI_userId					el id del usuario que intercambio el objeto.
	OI_nombre varchar(50)		el nombre del objeto canjeado
	OI_cantidad int				la cantidad de unidades de este que se pidieron
	OI_puntaje int				el puntaje invertido en el objeto canjeado
	OI_precio int				el precio del objeto en colones.
	OI_fecha varchar(50)		la fecha en la que fue emitido el intercambio.
*/
CREATE TABLE OBJETOS_INTERCAMBIO(
	OI_ID int NOT NULL,
	OI_userID int not null,
	OI_nombre varchar(50) NOT NULL,
	OI_cantidad int not null,
	OI_puntaje int NOT NULL,
	OI_precio int NOT NULL,
	OI_fecha varchar(50) not null,

	PRIMARY KEY (OI_ID)
);

/*tabla para almacenar la informacion de las categorias
	CA_ID int					el id de la categoria
	CA_nombre varchar(50)		el nombre/descripcion de la categoria
	CA_puntaje int				el puntaje que otroga la categoria.
	CA_puntajeUmbral int		el umbral de viajes que se ocupa para llegar al siguiente nivel
	CA_puntajeUmbralPmes int	el umbral de viajes/mes que se ocupa para llegar al siguiente nivel
*/
CREATE TABLE NOTIFICACIONES(
	NO_ID int identity(0,1),
	NO_usrID int NOT NULL,
	NO_descrip varchar(128) NOT NULL

	PRIMARY KEY (NO_ID)
);

--*****************************************************FOREAN KEYS PARA TABLAS****************************************************

ALTER TABLE CARRO ADD FOREIGN KEY (CA_userID) REFERENCES USUARIO (US_ID);
ALTER TABLE VIAJES ADD FOREIGN KEY (VI_choferID) REFERENCES USUARIO (US_ID);
ALTER TABLE VIAJES ADD FOREIGN KEY (VI_placaCarro) REFERENCES CARRO (CA_placa);
ALTER TABLE VIAJESXUSUARIO ADD FOREIGN KEY (VU_viajeID) REFERENCES VIAJES (VI_ID);
ALTER TABLE VIAJESXUSUARIO ADD FOREIGN KEY (VU_userID) REFERENCES USUARIO (US_ID);
ALTER TABLE TELEFONOS ADD FOREIGN KEY (TE_userID) REFERENCES USUARIO (US_ID);
ALTER TABLE AMIGOS ADD FOREIGN KEY (AA_userID) REFERENCES USUARIO (US_ID);
ALTER TABLE AMIGOS ADD FOREIGN KEY (AA_amigoID) REFERENCES USUARIO (US_ID);
ALTER TABLE OBJETOS_INTERCAMBIO ADD FOREIGN KEY (OI_userID) REFERENCES USUARIO (US_ID);
ALTER TABLE USUARIO ADD FOREIGN KEY (US_categoria) REFERENCES CATEGORIAS(CA_ID);
go

--*****************************************************STORE PROCEDURES PARA USUARIO****************************************************

/*Procedure que obtener la informarcion de un usuario
	id 					identificacion del usuario
*/
CREATE PROCEDURE usp_GetAllUser
AS 
BEGIN TRY
	BEGIN TRAN
		SELECT US_ID, US_nombre FROM USUARIO;
	COMMIT
END TRY
BEGIN CATCH
	ROLLBACK
END CATCH
GO

/*Procedure que obtener la informarcion de un usuario
	id 					identificacion del usuario
*/
CREATE PROCEDURE usp_GetUsuario
	@id int
AS 
BEGIN TRY
	BEGIN TRAN
		SELECT * FROM USUARIO where @id=US_ID;
	COMMIT
END TRY
BEGIN CATCH
	ROLLBACK
END CATCH
GO

/*Procedure que agrega un usuario
	US_ID int					identificacion del usuario
	US_nombre varchar(50)		nombre
	US_apellido1 varchar(50)	apellido
	US_apellido2 varchar(50)	segundo apellido
	US_correo varchar (50)		correo, verificar en la app si tiene la extension de xtec
	US_rol varchar (1)			para saber si es admin o no
	US_estadoCuenta int			si ha eliminado la cuenta o si un admin ha desactivado la cuenta
	US_categoria int			el id de la categoria
*/
CREATE PROCEDURE usp_PostUsuario
	@id int,
	@nombre varchar (50),
	@apellido1 varchar (50),
	@apellido2 varchar (50),
	@correo varchar (50),
	@rol varchar (1),
	@estadoCuenta int, 
	@categoria int
AS
BEGIN TRY
	BEGIN TRAN
		INSERT INTO USUARIO (US_ID,US_nombre,US_apellido1,US_apellido2,US_correo,US_rol,US_estadoCuenta, US_categoria ) 
		VALUES (@id,@nombre,@apellido1,@apellido2,@correo,@rol, @estadoCuenta, @categoria)
	COMMIT
END TRY
BEGIN CATCH
	ROLLBACK
END CATCH
GO 

/*Procedure que actualiza los atributos del usuario
	ID int					identificacion del usuario(no editable)
	nombre varchar(50)		nombre
	apellido1 varchar(50)	apellido
	apellido2 varchar(50)	segundo apellido
	correo varchar (50)		correo, verificar en la app si tiene la extension de xtec
	rol varchar (1)			para saber si es admin o no
	estadoCuenta int		si ha eliminado la cuenta o si un admin ha desactivado la cuenta
	categoria int			el id de la categoria
*/
CREATE PROCEDURE usp_PutUsuario
	@id int,
	@nombre varchar (50),
	@apellido1 varchar (50),
	@apellido2 varchar (50),
	@correo varchar (50),
	@tipo varchar (1),
	@estadoCuenta int,
	@categoria int
AS
BEGIN TRY
	BEGIN TRAN
	UPDATE USUARIO
		SET US_nombre=@nombre,
			US_apellido1=@apellido1,
			US_apellido2=@apellido2,
			US_correo=@correo,
			US_rol=@tipo,
			US_estadoCuenta=@estadoCuenta,
			US_categoria=@categoria
		WHERE US_ID=@id 
	COMMIT
END TRY
BEGIN CATCH
	ROLLBACK
END CATCH	
GO

/*Procedure que elimina a un usuario
	ID int					identificacion del usuario
*/
CREATE PROCEDURE usp_DelUsuario
	@id int
AS
BEGIN TRY
	BEGIN TRAN
	UPDATE USUARIO
		SET US_estadoCuenta=1
		WHERE US_ID=@id 
	COMMIT
END TRY
BEGIN CATCH
	ROLLBACK
END CATCH
GO

--*****************************************************STORE PROCEDURES PARA TELEFONOS****************************************************

/*Procedure para obtener nos numeros de telefono de un usuario
	userID			identificacion del usuario
*/
CREATE PROCEDURE usp_GetTelefonos
	@userID int
AS 
BEGIN TRY
	BEGIN TRAN
		SELECT TE_telefono FROM TELEFONOS where @userID=TE_userID;
	COMMIT
END TRY
BEGIN CATCH
	ROLLBACK
END CATCH
GO

/*Procedure para ingresar el telefono de un usuario.
	telefono		numero de telefono que se va a ingresar
	userID			identificacion del usuario
*/
CREATE PROCEDURE usp_PostTelefono
	@telefono varchar(8),
	@userID int
AS
BEGIN TRY
	BEGIN TRAN
		INSERT INTO TELEFONOS (TE_telefono, TE_userID) 
		VALUES (@telefono, @userID)
	COMMIT
END TRY
BEGIN CATCH
	ROLLBACK
END CATCH
GO 

/*Procedure para eliminar el telefono de un usuario.
	telefono		numero de telefono que se va a ingresar
	userID			identificacion del usuario
*/
CREATE PROCEDURE usp_DelTelefono
	@telefono varchar(8),
	@userID int
AS
BEGIN TRY
	BEGIN TRAN
	DELETE FROM TELEFONOS
		WHERE TE_telefono=@telefono and 
				TE_userID=@userID 
	COMMIT
END TRY
BEGIN CATCH
	ROLLBACK
END CATCH
GO


--*****************************************************STORE PROCEDURES PARA CARROS****************************************************

/*Procedure obtener todos los carros de una persona
	userID		identificacion del usuario dueño de los carros
*/
CREATE PROCEDURE usp_GetCarro
	@userID int
AS 
BEGIN TRY
	BEGIN TRAN
		SELECT CA_placa,CA_marca,CA_modelo,CA_pasa_cant FROM CARRO where @userID=CA_userID;
	COMMIT
END TRY
BEGIN CATCH
	ROLLBACK
END CATCH
GO

/*Procedure para agregar un nuevo carro
	placa		placa del carro
	marca		marca del carro
	modelo		modelo del carro
	pas_cant	cantidad de pasajeros que puede soportar el carro
	userID		identificacion del usuario dueño de los carros
*/
CREATE PROCEDURE usp_PostCarro
	@placa int,
	@marca varchar (50),
	@modelo varchar (50),
	@pas_cant int,
	@userID int
AS
BEGIN TRY
	BEGIN TRAN
		INSERT INTO CARRO (CA_placa,CA_marca,CA_modelo,CA_pasa_cant, CA_userID) 
		VALUES (@placa,@marca,@modelo,@pas_cant,@userID)
	COMMIT
END TRY
BEGIN CATCH
	ROLLBACK
END CATCH
GO 

/*Procedure para eliminar el carro de una persona.
	userID		identificacion del usuario dueño de los carros
*/
CREATE PROCEDURE usp_DelCarro
	@placa int
AS
BEGIN TRY
	BEGIN TRAN
	DELETE FROM CARRO
		WHERE CA_placa=@placa 
	COMMIT
END TRY
BEGIN CATCH
	ROLLBACK
END CATCH
GO

--*****************************************************STORE PROCEDURES PARA CATEGORIAS****************************************************

/*Procedure preguntar sobre todas las categorias que se disponen en la app.
*/
CREATE PROCEDURE usp_GetCategorias
AS 
BEGIN TRY
	BEGIN TRAN
		SELECT CA_ID, CA_nombre, CA_puntaje, CA_Umbral, CA_UmbralPmes FROM CATEGORIAS;
	COMMIT
END TRY
BEGIN CATCH
	ROLLBACK
END CATCH
GO

/*Procedure que agrega una categoria
	id				identificador de la categoria
	nombre			nombre de la categoria
	puntaje			puntaje que ofrece en su maxime en la categoria
	umbral			cantidad de viajes necesarios para alcanzar la categoria
	umbralPmes		cuota de viajes al mes para estar en la categoria.
*/
CREATE PROCEDURE usp_PostCategoria
	@nombre varchar(50),
	@puntaje int,
	@umbral int,
	@umbralPmes int
AS
BEGIN TRY
	BEGIN TRAN
		INSERT INTO CATEGORIAS( CA_nombre, CA_puntaje, CA_Umbral, CA_UmbralPmes) 
		VALUES ( @nombre, @puntaje, @umbral, @umbralPmes)
	COMMIT
END TRY
BEGIN CATCH
	ROLLBACK
END CATCH
GO 

/*Procedure que modificiar una categoria
	id				identificador de la categoria( no se modifica)
	nombre			nombre de la categoria
	puntaje			puntaje que ofrece en su maxime en la categoria
	umbral			cantidad de viajes necesarios para alcanzar la categoria
	umbralPmes		cuota de viajes al mes para estar en la categoria.
*/
CREATE PROCEDURE usp_PutCategoria
	@id int,
	@nombre varchar(50),
	@puntaje int,
	@umbral int,
	@umbralPmes int
AS
BEGIN TRY
	BEGIN TRAN
	UPDATE CATEGORIAS
		SET CA_nombre=@nombre,
			CA_puntaje=@puntaje,
			 CA_Umbral=@umbral,
			 CA_UmbralPmes=@umbralPmes
		WHERE CA_ID=@id
	COMMIT
END TRY
BEGIN CATCH
	ROLLBACK
END CATCH	
GO

/*Procedure que eliminar una categoria
	id				identificador de la categoria
*/
CREATE PROCEDURE usp_DelCategoria
	@id int
AS
BEGIN TRY
	BEGIN TRAN
	DELETE FROM CATEGORIAS
		WHERE CA_ID=@id
	COMMIT
END TRY
BEGIN CATCH
	ROLLBACK
END CATCH
GO

--*****************************************************STORE PROCEDURES PARA AMIGOS****************************************************

/*Procedure para preguntar los amigos de una persona.
	userID		la identificacion del usuario que pregunta.
*/
CREATE PROCEDURE usp_GetAmigos
	@userID int
AS 
BEGIN TRY
	BEGIN TRAN
		SELECT AA_amigoID, US_nombre, US_apellido1 FROM 
				(AMIGOS inner join USUARIO on AA_amigoID=US_ID) 
				where @userID=AA_userID;
	COMMIT
END TRY
BEGIN CATCH
	ROLLBACK
END CATCH
GO

/*Procedure para preguntar los amigos de una persona.
	userID		la identificacion del usuario.
	amigoID		la identificacion del amigo a agregar.
*/
CREATE PROCEDURE usp_PostAmigo
	@userID int,
	@amigoID int
AS
BEGIN TRY
	BEGIN TRAN
		INSERT INTO AMIGOS(AA_userID, AA_amigoID) 
		VALUES (@userID, @amigoID)
	COMMIT
END TRY
BEGIN CATCH
	ROLLBACK
END CATCH
GO 

/*Procedure para eliminar algun amigo de una persona.
	userID		la identificacion del usuario.
	amigoID		la identificacion del amigo a agregar.
*/
CREATE PROCEDURE usp_DelAmigo
	@userID int,
	@amigoID int
AS
BEGIN TRY
	BEGIN TRAN
	DELETE FROM AMIGOS
		WHERE AA_amigoID=@amigoID 
		and AA_userID=@userID
	COMMIT
END TRY
BEGIN CATCH
	ROLLBACK
END CATCH
GO

--*********************************************STORE PROCEDURES PARA OBJETOS INTERCAMBIADOS******************************************************

/*Procedure buscar la informacion de los objetos intercambiados por puntos
	userID			identificacion del usuario
*/
CREATE PROCEDURE usp_GetObjIntercambios
	@userID int
AS 
BEGIN TRY
	BEGIN TRAN
		SELECT OI_fecha, OI_ID, OI_nombre, OI_cantidad, OI_precio, OI_puntaje  FROM OBJETOS_INTERCAMBIO
			WHERE OI_userID=@userID;
	COMMIT
END TRY
BEGIN CATCH
	ROLLBACK
END CATCH
GO

/*Procedure agregar un objeto intercambiado por puntos
	id				identificador del objeto de compra.
	userID			identificacion del usuario.
	nombre			nombre del objeto intercambiado
	cantidad		cantidad de este objeto que se intercambiaron
	puntaje			costo del objeto en puntos.
	precio			precio en colones del objeto
	fecha			fecha de compra del objeto.
*/
CREATE PROCEDURE usp_PostObjIntercambio
	@id int,
	@userID int,
	@nombre varchar(50),
	@cantidad int,
	@puntaje int,
	@precio int,
	@fecha varchar(50)
AS
BEGIN TRY
	BEGIN TRAN
		INSERT INTO OBJETOS_INTERCAMBIO(OI_ID, OI_nombre, OI_cantidad, OI_precio, OI_puntaje, OI_userID, OI_fecha) 
		VALUES (@id, @nombre, @cantidad, @puntaje, @precio, @userID, @fecha)
	COMMIT
END TRY
BEGIN CATCH
	ROLLBACK
END CATCH
GO 


/*Procedure agregar un objeto intercambiado por puntos
	userID			identificacion del usuario.
*/
CREATE PROCEDURE usp_GetPuntosGastados
	@userID int
AS
BEGIN TRY
	BEGIN TRAN
		SELECT sum (OI_puntaje) pGastados  FROM OBJETOS_INTERCAMBIO
			WHERE OI_userID=@userID;
	COMMIT
END TRY
BEGIN CATCH
	ROLLBACK
END CATCH
GO 

/*Procedure obtener todos los puntos ganados en los viajes.
	userID			identificacion del usuario.
*/
CREATE PROCEDURE usp_GetPuntosGanados
	@userID int
AS
BEGIN TRY
	BEGIN TRAN
		SELECT sum (VU_puntajeXviaje) pGanados  FROM VIAJESXUSUARIO
			WHERE VU_userID=@userID;
	COMMIT
END TRY
BEGIN CATCH
	ROLLBACK
END CATCH
GO 


--******************************************************Store procedures para los viajes*******************************************************

/*	Buscar los viajes realizados por una persona para el dashboard.
	userID		numero de identificacion del usuario
*/
CREATE PROCEDURE usp_GetViajes
	@userID int
AS 
BEGIN TRY
	BEGIN TRAN
		SELECT US_nombre, US_apellido1, VI_fecha, VI_parqueo, VU_puntajeXviaje
			FROM (USUARIO inner join 
					(VIAJES inner join VIAJESXUSUARIO on VI_ID=VU_viajeID)
							on VI_choferID=US_ID)
			WHERE VU_userID=@userID
	COMMIT
END TRY
BEGIN CATCH
	ROLLBACK
END CATCH
GO

/*	Buscar la cantidad de personas que participaron en los viajes que alguien participo.
	userID		numero de identificacion del usuario
*/
CREATE PROCEDURE usp_GetCantPassViaje
	@userID int
AS 
BEGIN TRY
	BEGIN TRAN
		select count(VU_userID) cantPass, t2.VU_viajeID  from (VIAJESXUSUARIO inner join
				(select VU_viajeID from VIAJESXUSUARIO where VU_userID=@userID) t2
				on VIAJESXUSUARIO.VU_viajeID=t2.VU_viajeID)
				group by t2.VU_viajeID;
	COMMIT
END TRY
BEGIN CATCH
	ROLLBACK
END CATCH
GO

/*	Buscar la informacion de una solicitud de viaje
	viajeID		numero del viaje
*/
CREATE PROCEDURE usp_GetInfoViaje
	@viajeID int
AS 
BEGIN TRY
	BEGIN TRAN
		SELECT US_nombre, US_apellido1, CA_marca, CA_modelo, CA_placa
		FROM (CARRO inner join 
					(VIAJES inner join USUARIO on VI_choferID=US_ID)
					 on VI_placaCarro=CA_placa and VI_choferID=CA_userID)  
		where @viajeID=VI_ID;
	COMMIT
END TRY
BEGIN CATCH
	ROLLBACK
END CATCH
GO

/*	Crea un viaje
	choferID			identificacion del chofer que crea el viaje.
	fecha				la fecha en la que se crea el viaje.
	placaCarro			la placa del carro que se va a usar para el viaje.
*/
CREATE PROCEDURE usp_PostViajes
	@choferID int,
	@fecha varchar(50),
	@placaCarro varchar(6)
AS
BEGIN TRY
	BEGIN TRAN
		INSERT INTO VIAJES (VI_choferID, VI_fecha, VI_placaCarro) 
		VALUES (@choferID, @fecha, @placaCarro);
		select MAX(VI_ID) from VIAJES;
	COMMIT
END TRY
BEGIN CATCH
	ROLLBACK
END CATCH
GO  

/*	Crea una relacion de un viaje por usuario
	userID				identificacion del usuario
	viajeID				numero del viaje creado por el chofer
	codigoViaje			el codigo asignado al usuario por 
						el viaje asociado
*/
CREATE PROCEDURE usp_PostViajesXusuario
	@userID int,
	@viajeID int,
	@codigoViaje int
AS
BEGIN TRY
	BEGIN TRAN
		INSERT INTO VIAJESXUSUARIO(VU_userID, VU_viajeID, VU_codigoViaje) 
		VALUES (@userID, @viajeID, @codigoViaje);
	COMMIT
END TRY
BEGIN CATCH
	ROLLBACK
END CATCH
GO 

/*	Crea agrega un parqueo a un viaje.
	id					el id del viaje.
	parqueo				el numero del parqueo.
*/
CREATE PROCEDURE usp_PutNoParqueo
	@id int,
	@parqueo int
AS
BEGIN TRY
	BEGIN TRAN
		UPDATE VIAJES
		SET VI_parqueo=@parqueo
		WHERE VI_ID=@id 
	COMMIT
END TRY
BEGIN CATCH
	ROLLBACK
END CATCH
GO 

/*	Crea agrega un parqueo a un viaje.
	@viajeID			el id del viaje al que se le asocia el puntaje.
	@userID				el usuario al que se le va a poner el puntaje.
	@puntaje			el numero del parqueo.
*/
CREATE PROCEDURE usp_PutPuntaje
	@viajeID int,
	@userID int,
	@puntaje int
AS
BEGIN TRY
	BEGIN TRAN
		UPDATE VIAJESXUSUARIO
		SET VU_puntajeXviaje=@puntaje
		WHERE VU_userID=@userID and VU_viajeID=@viajeID 
	COMMIT
END TRY
BEGIN CATCH
	ROLLBACK
END CATCH
GO 