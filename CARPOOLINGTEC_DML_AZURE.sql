USE CARPOOLINGTECWebService_db
GO

INSERT INTO CATEGORIAS(CA_nombre, CA_puntaje,CA_Umbral, CA_UmbralPmes)
	values	('bronce',10, 0, 0),
			('hierro',20, 10, 5),
			('cobre',30, 20, 10),
			('plata',60, 30, 15),
			('oro',80, 50, 17),
			('titanio',100, 70, 20); 

INSERT INTO USUARIO (US_ID, US_nombre, US_apellido1, US_apellido2, US_correo, US_rol)
	values	(2014057732, 'ellioth', 'ramirez', 'trejos', 'elliot22rx7@xtec.ac.cr', 'A'),
			(2016224877, 'hernaldo', 'castillo', 'alba', 'reivrbviue@xtec.ac.cr', 'U'),
			(2017541286, 'jairo', 'ortega', 'soto', 'cierbvwcowe@xtec.ac.cr', 'A'),
			(2013456789, 'luis', 'piedra', 'calderon', 'mwcornvieunr@xtec.ac.cr', 'U'),
			(2014579341, 'cristian', 'noguera', 'vargas', 'mcqprveoi@xtec.ac.cr', 'U'),
			(2016789232, 'roberto', 'cortes', 'ramirez', 'cmwqiovnerubvie@xtec.ac.cr', 'U'),
			(2016719468, 'esteban', 'villegas', 'chacon', 'cwovnoeivbt@xtec.ac.cr', 'A'),
			(2012490463, 'gabriela', 'calderon', 'bisbal', 'cioevebrvueb@xtec.ac.cr', 'U'),
			(2014056032, 'alexandra', 'fernandez', 'juanillo', 'cqeivbiru293823f4@xtec.ac.cr', 'U'),
			(2013056943, 'anna', 'castrillo', 'domingo', 'cqriviuerv@xtec.ac.cr', 'U'); 

INSERT INTO TELEFONOS (TE_telefono, TE_userID)
	values	('61167409',2014057732),
			('85761483',2016224877),
			('67492568',2017541286),
			('25556879',2017541286),
			('35478956',2013456789),
			('64897256',2014579341),
			('47896532',2016789232),
			('47896742',2016719468),
			('47893275',2012490463),
			('54761665',2014056032),
			('84579624',2013056943);

INSERT INTO CARRO(CA_placa, CA_marca, CA_modelo, CA_pasa_cant, CA_userID)
	values	('pdf657','hunday','elantra','5',2014057732),
			('vcf159','hunday','elantra','5',2016224877),
			('892657','hunday','elantra','5',2017541286),
			('246657','hunday','elantra','5',2017541286),
			('bbq657','hunday','elantra','5',2016719468),
			('wtf657','hunday','elantra','5',2012490463),
			('tgf434','hunday','elantra','5',2014056032),
			('peq134','hunday','elantra','5',2013056943);

INSERT INTO AMIGOS(AA_amigoID, AA_userID)
	values	(2017541286,2014057732),
			(2016224877,2014057732),
			(2014579341,2014057732),
			(2016789232,2014057732),
			(2014057732,2016224877),
			(2013056943,2016224877),
			(2012490463,2016224877),
			(2016789232,2016224877),
			(2013456789,2016224877),
			(2017541286,2016224877),
			(2014057732,2017541286),
			(2016224877,2017541286),
			(2016224877,2013456789),
			(2016224877,2014579341),
			(2016224877,2016789232),
			(2016224877,2016719468),
			(2016224877,2012490463),
			(2016224877,2014056032),
			(2014057732,2014056032),
			(2016224877,2013056943);

INSERT INTO VIAJES (VI_choferID, VI_fecha, VI_placaCarro)
	values	(2014057732, '7/8/19','pdf657'),
			(2014057732, '6/3/19','pdf657'),
			(2016719468, '7/8/19','bbq657'),
			(2014056032, '10/5/19','tgf434');

INSERT INTO VIAJESXUSUARIO(VU_codigoViaje, VU_userID, VU_viajeID)
	values	(61986518,2014057732,0),
			(16813156,2016224877,0),
			(68131684,2017541286,0),
			(74468718,2014579341,0),
			(61646868,2016789232,0),
			(69814143,2014057732,1),
			(81495158,2016224877,1),
			(68416868,2017541286,1),
			(87164368,2014579341,1),
			(68176899,2016789232,1),
			(96171695,2016719468,2),
			(96849499,2016224877,2),
			(36989917,2016719468,2),
			(68716979,2014056032,3),
			(67813939,2014056032,3),
			(32654871,2016224877,3),
			(86894193,2014057732,3);

INSERT INTO OBJETOS_INTERCAMBIO(OI_ID, OI_nombre, OI_cantidad, OI_fecha, OI_precio, OI_puntaje, OI_userID)
	values	(6578, 'abrigo logo tec azul', 1, '7/10/19', 20000, 5000, 2014057732),
			(6538, 'cuaderno d/200 pag', 5, '6/3/19', 7000, 950, 2014057732),
			(6472, 'lapiz negro grafito', 15, '30/11/19', 3000, 700, 2016224877),
			(6781, 'cafe organico ambiental', 1, '7/10/19', 20000, 5000, 2017541286),
			(6096, 'jarra cafe logo tec negra', 3, '7/10/19', 20000, 5000, 2013456789);
go