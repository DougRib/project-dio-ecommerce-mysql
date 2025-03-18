use ecommerce;

-- idClient, FName, Minit, LName, CPF, Address
insert into clients (FName, Minit, LName, CPF, Address) values
	('Maria', 'M', 'Silva', 123456789, 'Rua Silva prata 29, Carangola - São paulo'),
	('João', 'M', 'Oliveira', 987654321, 'Avenida das Flores 120, Campinas - São Paulo'),
	('Ana', 'F', 'Costa', 456123789, 'Rua Palmeiras 45, Porto Alegre - Rio Grande do Sul'),
	('Pedro', 'M', 'Santos', 741852963, 'Travessa 89, Belo Horizonte - Minas Gerais'),
	('Luciana', 'F', 'Ferreira', 369258147, 'Praça das Árvores 17, Salvador - Bahia'),
	('Carlos', 'M', 'Souza', 159753468, 'Alameda do Bosque 56, Curitiba - Paraná')
;
select * from clients;

-- idAccountPJ, idClientPj, SocialName, CNPJ
insert into accountPj (idClient, SocialName, CNPJ) values
	(1, 'Empresa Alfa LTDA', 12347835261524),
    (2, 'Empresa Beta LTDA', 12347835251524),
    (3, 'Empresa TechSoft LTDA', 12347745261524),
    (4, 'Empresa GamaTech S.A.', 12347789261524),
    (5, 'Empresa Solutions', 12347835263944)
;
select * from accountPj;

-- idAccountCpf, idClientCpf, SocialName, CPF
insert into accountCpf (idClient, SocialName, CPF) values
	(1, 'João da silva', '14252637891'),
    (2, 'Janese santos', '14252625891'),
    (3, 'Almeraldo filho', '14252787891'),
    (4, 'Diego rosa', '14289637891')
;
select * from accountCpf;

-- idPayment, idClient, TypePayment('Dinheiro','Cartão','Dois Cartões','Boleto'), ValueNote, DatePayment
insert into payments (idClient, TypePayment, ValueNote, DatePayment) values
	(1, 'Cartão', 150.75, '2025-03-10 16:00:00'),
    (2, 'Boleto', 350.75, '2024-03-10 11:00:00'),
    (3, 'Dinheiro', 50.75, '2024-09-10 09:00:00'),
    (4, 'Cartão', 2000.75, '2025-01-03 13:00:00'),
    (5, 'Dinheiro', 450.75, '2024-01-10 20:00:00')
;
select * from payments;

-- idCard, IdPaymentCards, CardNumber, CardName, ExpirationDate
insert into paymentsCards (IdPaymentCards, CardNumber, CardName, ExpirationDate) values
	(1, '4738 2839 3749 1928', 'João da silva', '2030-10-14'),
    (4, '4738 2839 3149 1928', 'João da silva santos', '2030-10-11')
;
select * from paymentsCards;

-- idStatusPayments, idPaymentstatus, StatusPayment
insert into StatusPayments (idPaymentstatus, StatusPayment) values
	(1, 'Aprovado'),
    (2, 'Aprovado'),
    (3, 'Em Análise'),
    (4, 'Não Aprovado'),
    (5, 'Aprovado')
;
select * from StatusPayments;

-- idDelivery, idOrder, idClient, AddressDelivery, DeliveryExitDate, DeliveryDate
insert into delivery (idOrder, idClient, AddressDelivery, DeliveryExitDate, DeliveryDate) values
	(5, 1, 'Rua das acacias, 45 - São paulo, SP', '2024-03-15', '2024-03-17 10:00:00'),
    (6, 2, 'Rua moradas, 40 - São paulo, SP', '2025-01-15', '2025-01-19 19:00:00'),
    (7, 3, 'Rua aurora, 450 - Rio de janeiro, RJ', '2024-10-15', '2024-10-15 07:00:00'),
    (8, 4, 'Rua andradas, 145 - Porto alegre, RS', '2024-11-15', '2024-11-15 16:00:00')
;
select * from delivery;

-- idTracking, idDelivery,TrackingCode, StatusTracking('Em Transporte', 'Saiu para Entrega', 'Entregue'),DateUpdate, RealLocation
insert into tracking (idDelivery, TrackingCode, StatusTracking, DateUpdate, RealLocation) values
	(26, 'TKR2025982839001', 'Em Transporte', '2024-03-15', 'Centro de distribuição - São Paulo'),
    (27, 'TKR2025982839002', 'Entregue', '2025-01-15', 'Centro de distribuição - São Paulo'),
    (28, 'TKR2025982839003', 'Entregue', '2024-10-15', 'Centro de distribuição - Rio de janeiro'),
    (29, 'TKR2025982839004', 'Entregue', '2024-11-15', 'Centro de distribuição - Porto alegre')
;
select * from tracking;

-- idProduct, Pname, classifaction_kids boolean, category('Eletrônico','Vestuário','Brinquedos','Informática','Móveis'), avaliação, size
insert into product (Pname, classifaction_kids, category, avassessment, size) values
	('Fone de ouvido', false, 'Eletrônico', '4', null),
	('Camiseta', true, 'Vestuário', '3', null),
	('Urso de Pelúcia', false, 'Brinquedos', '1', null),
	('Mesa de Escritório', true, 'Móveis', '4', '3x58x80'),
	('Monitor', true, 'Eletrônico', '6', null),
	('Carregador', false, 'Eletrônico', '2', null),
	('Caixa de Som', true, 'Eletrônico', '8', null)
;
select * from product;

delete from orders where idOrderClient in (2,3,4,5);
-- idOrder, idOrderClient, orderStatus, orderDescription, SendFreight, payment
insert into orders (idOrderClient, orderStatus, orderDescription, SendFreight, payment) values
	(2, default, 'compra via app', null, 2),
	(3, default, 'compra via app', 50, 3),
	(4, 'Confirmado', null, null, 4),
	(5, default, 'compra via site', 80, 5)
;
select * from orders;

-- idPOproduct, idPOorder, PoQuantity, PoStatus
insert into productOrder (idPOproduct, idPOorder, PoQuantity, PoStatus) values
	(15, 5, 2, null),
    (16, 6, 3, null),
    (17, 7, 2, null)
;
select * from productOrder;

-- storageLocation, quantity
insert into productStorage (storageLocation, quantity) values
	('São Paulo', 1000),
	('São Paulo', 500),
	('Salvador', 900),
	('Curitiba', 1000),
	('Porto Alegre', 600),
	('Rio de Janeiro', 1000)
;
select * from productStorage;

-- idLproduct. idLStorage, Location
insert into storageLocation (idLProduct, idLStorage, Location) values
	(15, 2, 'RJ'),
    (16, 6, 'SP')
;
select * from storageLocation;

-- idSupplier, SocialName, CNPJ, Contact 
insert into supplier (SocialName, CNPJ, Contact) values
	('Almeida e filho', 123456789010123, '30594600'),
    ('Almeraldo transp', 975784564789543, '84567451'),
    ('TransTrem', 563784935261427, '34667890')
;
select * from supplier;

-- IdPsSupplier, idPsProduct, SQuantity
insert into productSupplier (IdPsSupplier, idPsProduct, SQuantity) values
	(1, 15, 500),
    (1, 16, 200),
    (2, 17, 50),
    (2, 18, 110),
    (3, 19, 345)
;
select * from productSupplier;

-- idSeller, SocialName, FantasyName, CNPJ, CPF, Location, Contact
insert into seller (SocialName, FantasyName, CNPJ, CPF, Location, Contact) values
	('Tech Eletro', null, 127394658364860, null, 'São Paulo', 34673457),
	('Boutique', null, null, 123456789, 'Belo Horizonte', 1134673458),
	('Kids Tec', null, 127394658364862, null, 'Curitiba', 34673459),
	('Tech Eletro', null, 127394658364863, null, 'Salvador', 34673460)
;
select * from seller;

-- IdPSeller, idPproduct, ProdQuantity
insert into productseller (IdPSeller, idPproduct, ProdQuantity) values
	(1, 16, 80),
    (2, 17, 90),
    (3, 18, 67)
;
select * from productseller;

select * from clients c, orders o where c.idClient = idOrderClient;
select concat(FName, ' ', LName) as Cliente, idOrder as Request, orderStatus as Status from clients c, orders o where c.idClient = idOrderClient;

-- recuperação de pedidos com produto associado
select * from clients c
	inner join orders o on c.idClient = o.idOrderClient
    inner join productOrder p on p.idPOorder = o.idOrder
    group by idClient;


