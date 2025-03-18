create database ecommerce;
use ecommerce;
show tables;

create table clients(
	idClient int auto_increment primary key,
    Fname varchar(10),
    Minit char(3),
    Lname varchar(20),
    CPF char (11) not null,
    Address varchar(30),
    constraint unique_cpf_client unique(CPF)
);
alter table clients auto_increment=1;
alter table clients modify column Address varchar(100);
desc clients;

create table accountPj(
	idAcconutPJ int primary key,
    idClient int not null,
    SocialName varchar(255) not null,
    CNPJ char(15) not null unique,
    constraint fk_accountpj_client foreign key(idClient) references clients(idClient) on delete cascade
);
alter table accountPj change idAcconutPJ idAccountPj int auto_increment;
desc accountPj;

create table accountCpf(
	idAcconutCpf int primary key,
    idClientCpf int not null,
    SocialName varchar(255) not null,
    CPF char(11) not null unique,
    constraint fk_accountcpf_client foreign key(idClientCpf) references clients(idClient) on delete cascade
);
alter table accountCpf change idAcconutCpf idAccountCpf int auto_increment;
alter table accountCpf change idClientCpf idClient int;
desc accountCpf;

create table product(
	idProduct int auto_increment primary key,
    Pname varchar(10) not null,
    Classifaction_kids bool default false,
    category enum('Eletrônico','Vestuário','Brinquedos','Informática','Móveis') not null,
    Avassessment float default 0,
    size varchar(30)
);
alter table product modify column Pname varchar(30);

create table payments(
	idPayment int auto_increment primary key,
    idClientPay int not null,
    TypePayment enum('Dinheiro','Cartão','Dois Cartões','Boleto') not null,
    ValueNote decimal(10, 2),
    DatePayment datetime,
    constraint fk_payment_client foreign key(idClientPay) references clients(idClient) on delete cascade
);
alter table payments add column ValueNote decimal(10, 2);
alter table payments add column DatePayment datetime;
alter table payments drop column CardNumber, drop column CardName, drop column ExpirationDate;
alter table payments change idClientPay idClient int;
desc payments;

create table paymentsCards(
	idCard int auto_increment primary key,
    IdPaymentCards int not null,
    CardNumber varchar(20) not null,
    CardName varchar(100) not null,
    ExpirationDate date,
	constraint fk_payment_card foreign key(IdPaymentCards) references payments(idPayment) on delete cascade
);
desc paymentsCards;

create table StatusPayments(
	idStatusPayments int auto_increment primary key,
    idPaymentStatus int not null unique,
    StatusPayment enum('Aprovado', 'Não Aprovado', 'Em Análise') default 'Em Análise',
    constraint fk_statuspayment_pay foreign key(idPaymentstatus) references payments(idPayment) on delete cascade
);
show create table StatusPayments;
alter table StatusPayments drop foreign key fk_statuspayment_client;
alter table StatusPayments drop column idClient;
alter table StatusPayments change idPayment idPaymentStatus int;
alter table StatusPayments auto_increment=1;
alter table StatusPayments modify idStatusPayments int auto_increment;
desc StatusPayments;

create table orders(
	idOrder int auto_increment primary key,
    idOrderClient int,
    OrderStatus enum('Em Processamento','Confirmado','Cancelado') default 'Em Processamento',
    OrderDescription varchar(255),
    SendFreight float default 10,
    Payment bool default false,
    idPayment int,
    constraint fk_order_client foreign key(idOrderClient) references clients(idClient),
    constraint fk_order_payment foreign key(idPayment) references payments(idPayment)
);
desc orders;

create table productStorage(
	idProductStorage int auto_increment primary key,
    StorageLocation varchar(255),
    Quantity int default 0
);
alter table productStorage change column StorageName StorageLocation varchar(255);
desc productStorage;

create table supplier(
	idSupplier int auto_increment primary key,
    SocialName varchar(255) not null,
    CNPJ char(15) not null,
    Contact char(11) not null,
    constraint unique_supplier unique(CNPJ)
);

create table productSupplier(
	idPsSupplier int,
    idPsProduct int,
    SQuantity int default 1,
    primary key (IdPsSupplier, idPsProduct),
    constraint fk_productsupplier_seller foreign key(IdPsSupplier) references productStorage(idProductStorage),
    constraint fk_product_supplier_product foreign key(idPsProduct) references product(idProduct)
);
desc productSupplier;

create table delivery(
	idDelivery int auto_increment primary key,
    idOrder int not null,
    idClient int not null,
    AddressDelivery varchar(100),
    DeliveryExitDate date,
    DeliveryDate datetime,
    constraint fk_delivery_orders foreign key(idOrder) references orders(idOrder),
    constraint fk_delivery_client foreign key(idClient) references clients(idClient)
);
alter table delivery modify idOrder int not null, modify idClient int not null;
desc delivery;

create table tracking(
	idTracking int auto_increment primary key,
    idDelivery int not null,
    TrackingCode varchar(20) unique not null,
    StatusTracking enum('Em Transporte', 'Saiu para Entrega', 'Entregue') not null,
    DateUpdate timestamp default current_timestamp on update current_timestamp,
    RealLocation varchar(200),
    constraint fk_tracking_delivery foreign key (idDelivery) references delivery(idDelivery) 
);
show create table tracking;
alter table tracking drop constraint fk_tracking_delivery;
alter table tracking add constraint fk_tracking_delivery foreign key (idDelivery) references delivery(idDelivery);
alter table tracking change idDeliveryTrack idDelivery int;
desc tracking;

create table seller(
	idSeller int auto_increment primary key,
    SocialName varchar(255) not null,
    FantasyName varchar(255),
    CNPJ char(15),
    CPF char(9),
    Location varchar(255),
    Contact char(11) not null,
    constraint unique_cnpj_seler unique(CNPJ),
    constraint unique_cpf_seller unique(CPF)
);
desc seller;

create table productSeller(
	IdPSeller int,
    idPproduct int,
    ProdQuantity int default 1,
    primary key (idPSeller, idPproduct),
    constraint fk_product_seller foreign key(idPSeller) references seller(idSeller),
    constraint fk_product_product foreign key(idPproduct) references product(idProduct)
);
desc productSeller;

create table productOrder(
	idPOproduct int,
    idPOorder int,
    PoQuantity int default 1,
    PoStatus enum('Disponível','Sem Estoque') default 'Disponível',
    primary key (idPOproduct, idPOorder),
    constraint fk_productorder_seller foreign key(idPOproduct) references product(idProduct),
    constraint fk_productorder_product foreign key(idPOorder) references orders(idOrder)
); 
desc productOrder;

create table storageLocation(
	idLProduct int,
    idLStorage int,
    Location varchar(255) not null,
    primary key (idLProduct, idLStorage),
    constraint fk_storage_location_product foreign key(idLProduct) references product(idProduct),
    constraint fk_storage_location_storage foreign key(idLStorage) references productStorage(idProductStorage)
);
desc storageLocation;

-- Quantos pedidos foram feitos por cada cliente?
select 
    c.idClient, 
    CONCAT(c.Fname, ' ', c.Lname) as ClientName, 
    COUNT(o.idOrder) as TotalOrders
from clients c
left join orders o 
    ON c.idClient = o.idOrderClient
GROUP BY c.idClient, c.Fname, c.Lname;

-- Algum vendedor também é fornecedor?
select 
    s.idSeller, 
    s.SocialName as SellerName, 
    sup.idSupplier, 
    sup.SocialName as SupplierName
from seller s
inner join supplier sup 
    on s.CNPJ = sup.CNPJ;

-- Relação de produtos, estoques e armazenamento
select 
    p.idProduct, 
    p.Pname, 
    ps.SQuantity as QuantityInSupplier, 
    psn.idProductStorage,
    psn.StorageLocation, 
    psn.Quantity as TotalInStorage
from productSupplier ps
inner join product p 
    on ps.idPsProduct = p.idProduct
inner join productStorage psn 
    on ps.idPsSupplier = psn.idProductStorage;
    
-- Relação de nomes dos fornecedores e nomes dos produtos
select 
    sup.SocialName as Fornecedor, 
    p.Pname as Produto
from supplier sup
inner join seller s 
    on s.CNPJ = sup.CNPJ
inner join productSeller ps 
    on s.idSeller = ps.IdPSeller
inner join product p 
    on ps.idPproduct = p.idProduct;

-- Gerando o Período de Pagamento com Base na Data (Atributo "PaymentPeriod")
SELECT 
  idPayment, 
  DATE_FORMAT(DatePayment, '%Y-%m') AS PaymentPeriod,
  ValueNote,
  TypePayment
FROM payments;

-- Criando um Resumo do Pedido (Atributo Derivado "OrderSummary")
SELECT
  idOrder,
  CONCAT('Pedido ', idOrder, ': ', OrderDescription, ' (Frete: ', SendFreight, ')') AS OrderSummary,
  OrderStatus,
  Payment
FROM orders;


