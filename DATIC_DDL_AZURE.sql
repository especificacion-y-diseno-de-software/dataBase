USE master
GO
if (db_id('DATICWebService_db') is not null)
begin    
	DROP DATABASE DATICWebService_db
end

CREATE DATABASE DATICWebService_db
GO 

USE DATICWebService_db
GO

/*tabla para almacenar la informacion de los usuarios
*/
CREATE TABLE USUARIO (
	US_ID int NOT NULL,
	US_contra int not null,

	PRIMARY KEY (US_ID)
);

go

CREATE PROCEDURE usp_GetUsuarios @Id int
AS 
BEGIN TRY
	BEGIN TRAN
		SELECT US_ID, US_contra FROM USUARIO where @Id=US_ID;
	COMMIT
END TRY
BEGIN CATCH
	ROLLBACK
END CATCH
GO

/*Procedure que agrega un cliente a la tabla CLIENTE
Clie_cedula numero de identificacion del cliente
Clie_nombre nombre del cliente o empresa
Clie_apellido1 primer apellido del cliente
Clie_apellido2 segundo apellido del cliente
Clie_telefono numero de telefono el cliente
*/
CREATE PROCEDURE usp_PostUsuario
	@id int,
	@contra int
AS
BEGIN TRY
	BEGIN TRAN
		INSERT INTO USUARIO(US_ID, US_contra) 
		VALUES (@id, @contra)
	COMMIT
END TRY
BEGIN CATCH
	ROLLBACK
END CATCH
GO 

/*Procedure que actualiza los atributos Deta_precio_real y Deta_cant_real de la tabla DETALLE
Clie_cedula numero de identificacion del cliente
Clie_nombre nombre del cliente o empresa
Clie_apellido1 primer apellido del cliente
Clie_apellido2 segundo apellido del cliente
Clie_telefono numero de telefono el cliente
*/
CREATE PROCEDURE usp_PutUsuario
	@id int,
	@contra int
AS
BEGIN TRY
	BEGIN TRAN
	UPDATE USUARIO
		SET US_contra = @contra
		WHERE US_ID=@id
	COMMIT
END TRY
BEGIN CATCH
	ROLLBACK
END CATCH	
GO

/*Procedure que elimina a un cliente de la base de datos.
Clie_cedula numero de identificacion del cliente
*/
CREATE PROCEDURE usp_DelUsuario
	@id int
AS
BEGIN TRY
	BEGIN TRAN
	DELETE FROM USUARIO
		WHERE US_ID=@id 
	COMMIT
END TRY
BEGIN CATCH
	ROLLBACK
END CATCH
GO