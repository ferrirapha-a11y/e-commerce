-- sql
-- Criação do banco de dados para cenário E-commerce

CREATE DATABASE ecommerce;
USE ecommerce;

-- =====================================================
-- criar tabela cliente
-- =====================================================

CREATE TABLE clients(
    idClient INT AUTO_INCREMENT PRIMARY KEY,
    Fname VARCHAR(10),
    Minit CHAR(3),
    Lname VARCHAR(20),
    Address VARCHAR(30),
    Client_type ENUM('PF','PJ'),
    email VARCHAR(45),
    telefone VARCHAR(45)
);

-- =====================================================
-- criar tabela cliente pf
-- =====================================================

CREATE TABLE client_pf(
    idClientepf INT PRIMARY KEY,
    CPF CHAR(11) NOT NULL UNIQUE,
    BirthDate DATE,

    CONSTRAINT fk_clientpf 
        FOREIGN KEY(idClientepf) 
        REFERENCES clients(idClient)
);

-- =====================================================
-- criar tabela cliente pj
-- =====================================================

CREATE TABLE client_pj(
    idClientepj INT PRIMARY KEY,
    CNPJ CHAR(14) NOT NULL UNIQUE,
    razao_social VARCHAR(45),

    CONSTRAINT fk_clientpj 
        FOREIGN KEY(idClientepj) 
        REFERENCES clients(idClient)
);

-- =====================================================
-- criar tabela produto
-- =====================================================

CREATE TABLE product(
    idProduto INT AUTO_INCREMENT PRIMARY KEY,
    Pname VARCHAR(10) NOT NULL,
    classification_kids BOOL DEFAULT FALSE,
    category ENUM('Eletronico', 'Vestimenta', 'Brinquedos', 'Alimentos') NOT NULL,
    price DECIMAL(10,2),
    size VARCHAR(10)
);

-- =====================================================
-- criar tabela pedido
-- =====================================================

CREATE TABLE orders(
    idOrders INT AUTO_INCREMENT PRIMARY KEY,
    idCLientOrder INT,
    ordersStatus ENUM('Cancelado', 'Confirmado', 'Em processamento'),
    orderDescription VARCHAR(255),
    taxOrder FLOAT DEFAULT 10,
    paymentCash BOOL DEFAULT FALSE,

    CONSTRAINT fk_orders_client 
        FOREIGN KEY(idCLientOrder) 
        REFERENCES clients(idClient)
);

-- =====================================================
-- criar tabela pagamento
-- =====================================================

CREATE TABLE payment(
    idPayment INT AUTO_INCREMENT PRIMARY KEY,
    idOrderPayment INT,
    payment_type ENUM('Cartão', 'Boleto', 'Pix'),
    card_number VARCHAR(30),
    pix_code VARCHAR(100),

    CONSTRAINT fk_payment_order 
        FOREIGN KEY(idOrderPayment) 
        REFERENCES orders(idOrders)
);

-- =====================================================
-- criar tabela entrega
-- =====================================================

CREATE TABLE delivery(
    idDelivery INT AUTO_INCREMENT PRIMARY KEY,
    idDeliveryOrder INT,
    deliveryStatus ENUM('Processando', 'Enviado', 'Entregue') DEFAULT 'Processando',
    trackingCode VARCHAR(100),

    CONSTRAINT fk_delivery_order 
        FOREIGN KEY(idDeliveryOrder) 
        REFERENCES orders(idOrders)
);

-- =====================================================
-- criar tabela estoque
-- =====================================================

CREATE TABLE productStorage(
    idProdStorage INT AUTO_INCREMENT PRIMARY KEY,
    storageLocation VARCHAR(255),
    quantity INT DEFAULT 0
);

-- =====================================================
-- criar tabela fornecedor
-- =====================================================

CREATE TABLE supplier(
    idSupplier INT AUTO_INCREMENT PRIMARY KEY,
    razao_social VARCHAR(255) NOT NULL,
    CNPJ CHAR(14) NOT NULL,
    contact CHAR(11) NOT NULL,

    CONSTRAINT unique_supplier UNIQUE (CNPJ)
);

-- =====================================================
-- criar tabela vendedor
-- =====================================================

CREATE TABLE seller(
    idSeller INT AUTO_INCREMENT PRIMARY KEY,
    razao_social VARCHAR(255) NOT NULL,
    nome_fantasia VARCHAR(255),
    location VARCHAR(255),
    CNPJ CHAR(14) NOT NULL,
    contact CHAR(11) NOT NULL,

    CONSTRAINT unique_cnpj_seller UNIQUE (CNPJ)
);

-- =====================================================
-- criar tabela produtos vendedor
-- =====================================================

CREATE TABLE productSeller(
    idProductSeller INT,
    idProdsell INT,
    quantity INT DEFAULT 1,

    PRIMARY KEY (idProductSeller, idProdsell),

    CONSTRAINT fk_prod_seller 
        FOREIGN KEY(idProductSeller) 
        REFERENCES seller(idSeller),

    CONSTRAINT fk_prod 
        FOREIGN KEY(idProdsell) 
        REFERENCES product(idProduto)
);

-- =====================================================
-- criar tabela produtos orders
-- =====================================================

CREATE TABLE productOrders(
    idPOproduct INT,
    idPOorder INT,
    quantity INT DEFAULT 1,

    POstatus ENUM('Disponivel', 'Sem estoque') DEFAULT 'Disponivel',

    PRIMARY KEY (idPOproduct, idPOorder),

    CONSTRAINT fk_product_order_product 
        FOREIGN KEY(idPOproduct) 
        REFERENCES product(idProduto),

    CONSTRAINT fk_product_order_order 
        FOREIGN KEY(idPOorder) 
        REFERENCES orders(idOrders)
);

-- =====================================================
-- criar tabela storage location
-- =====================================================

CREATE TABLE storageLocation(
    idPLproduct INT,
    idPLstorage INT,
    Location VARCHAR(255) NOT NULL,

    PRIMARY KEY (idPLproduct, idPLstorage),

    CONSTRAINT fk_prodlocal 
        FOREIGN KEY(idPLproduct) 
        REFERENCES product(idProduto),

    CONSTRAINT fk_storage_location 
        FOREIGN KEY(idPLstorage) 
        REFERENCES productStorage(idProdStorage)
);

-- =====================================================
-- criar tabela produto fornecedor
-- =====================================================

CREATE TABLE productSupplier(
    idPsSupplier INT,
    idPsProduct INT,
    quantity INT DEFAULT 1,

    PRIMARY KEY (idPsSupplier, idPsProduct),

    CONSTRAINT fk_product_supplier_supplier
        FOREIGN KEY(idPsSupplier)
        REFERENCES supplier(idSupplier),

    CONSTRAINT fk_product_supplier_product
        FOREIGN KEY(idPsProduct)
        REFERENCES product(idProduto)
);

-- =====================================================
-- inserir dados em clients
-- =====================================================

INSERT INTO clients 
(Fname, Minit, Lname, Address, Client_type, email, telefone)
VALUES
('Joao', 'A', 'Silva', 'Rua A', 'PF', 'joao@gmail.com', '119999999'),
('Maria', 'B', 'Souza', 'Rua B', 'PF', 'maria@gmail.com', '118888888'),
('Empresa', 'C', 'XPTO', 'Av Central', 'PJ', 'contato@xpto.com', '117777777');

-- =====================================================
-- inserir dados em client_pf
-- =====================================================

INSERT INTO client_pf
(idClientepf, CPF, BirthDate)
VALUES
(1, '12345678901', '1990-05-10'),
(2, '98765432100', '1985-08-15');

-- =====================================================
-- inserir dados em client_pj
-- =====================================================

INSERT INTO client_pj
(idClientepj, CNPJ, razao_social)
VALUES
(3, '12345678000199', 'XPTO LTDA');

-- =====================================================
-- inserir dados em product
-- =====================================================

INSERT INTO product
(Pname, classification_kids, category, price, size)
VALUES
('Notebook', FALSE, 'Eletronico', 3500.00, 'Grande'),
('Camisa', FALSE, 'Vestimenta', 80.00, 'M'),
('Boneca', TRUE, 'Brinquedos', 120.00, 'Pequeno'),
('Chocolate', FALSE, 'Alimentos', 15.00, 'Pequeno');

-- =====================================================
-- inserir dados em orders
-- =====================================================

INSERT INTO orders
(idCLientOrder, ordersStatus, orderDescription, taxOrder, paymentCash)
VALUES
(1, 'Confirmado', 'Compra notebook', 15, FALSE),
(2, 'Em processamento', 'Compra camisa', 10, TRUE),
(3, 'Confirmado', 'Compra boneca', 20, FALSE);

-- =====================================================
-- inserir dados em payment
-- =====================================================

INSERT INTO payment
(idOrderPayment, payment_type, card_number, pix_code)
VALUES
(1, 'Cartão', '1111222233334444', NULL),
(1, 'Pix', NULL, 'PIX123456'),
(2, 'Boleto', NULL, NULL);

-- =====================================================
-- inserir dados em delivery
-- =====================================================

INSERT INTO delivery
(idDeliveryOrder, deliveryStatus, trackingCode)
VALUES
(1, 'Enviado', 'BR123456789'),
(2, 'Processando', 'BR987654321'),
(3, 'Entregue', 'BR111222333');

-- =====================================================
-- inserir dados em productStorage
-- =====================================================

INSERT INTO productStorage
(storageLocation, quantity)
VALUES
('Galpao A', 100),
('Galpao B', 50);

-- =====================================================
-- inserir dados em supplier
-- =====================================================

INSERT INTO supplier
(razao_social, CNPJ, contact)
VALUES
('Fornecedor Tech', '11111111000111', '11999999999'),
('Fornecedor Moda', '22222222000122', '11888888888');

-- =====================================================
-- inserir dados em seller
-- =====================================================

INSERT INTO seller
(razao_social, nome_fantasia, location, CNPJ, contact)
VALUES
('Vendas Tech', 'TechStore', 'São Paulo', '33333333000133', '11777777777'),
('Moda Fashion', 'FashionStore', 'Rio de Janeiro', '44444444000144', '11666666666');

-- =====================================================
-- inserir dados em productSeller
-- =====================================================

INSERT INTO productSeller
(idProductSeller, idProdsell, quantity)
VALUES
(1,1,10),
(2,2,20);

-- =====================================================
-- inserir dados em productOrders
-- =====================================================

INSERT INTO productOrders
(idPOproduct, idPOorder, quantity, POstatus)
VALUES
(1,1,1,'Disponivel'),
(2,2,2,'Disponivel'),
(3,3,1,'Sem estoque');

-- =====================================================
-- inserir dados em storageLocation
-- =====================================================

INSERT INTO storageLocation
(idPLproduct, idPLstorage, Location)
VALUES
(1,1,'Corredor A'),
(2,2,'Corredor B');

-- =====================================================
-- inserir dados em productSupplier
-- =====================================================

INSERT INTO productSupplier
(idPsSupplier, idPsProduct, quantity)
VALUES
(1,1,100),
(2,2,200);

-- =====================================================
-- queries simples
-- =====================================================

-- recuperar todos os clientes

SELECT * FROM clients;

-- recuperar produtos acima de 100 reais

SELECT Pname, price
FROM product
WHERE price > 100;

-- quantidade total por produto em pedidos

SELECT 
    p.Pname,
    po.quantity,
    p.price,
    (po.quantity * p.price) AS total_value
FROM productOrders po
JOIN product p
ON po.idPOproduct = p.idProduto;

-- ordenar produtos por preço

SELECT Pname, price
FROM product
ORDER BY price DESC;

-- quantidade de pedidos por cliente

SELECT 
    c.Fname,
    COUNT(o.idOrders) AS total_orders
FROM clients c
JOIN orders o
ON c.idClient = o.idCLientOrder
GROUP BY c.Fname
HAVING total_orders >= 1;

-- relação de produtos e fornecedores

SELECT
    p.Pname AS Produto,
    s.razao_social AS Fornecedor
FROM productSupplier ps
JOIN product p
ON ps.idPsProduct = p.idProduto
JOIN supplier s
ON ps.idPsSupplier = s.idSupplier;

-- relação de produtos, estoque e localização

SELECT
    p.Pname AS Produto,
    ps.storageLocation AS Estoque,
    sl.Location AS Localizacao,
    ps.quantity AS Quantidade
FROM storageLocation sl
JOIN product p
ON sl.idPLproduct = p.idProduto
JOIN productStorage ps
ON sl.idPLstorage = ps.idProdStorage;

-- verificar se algum vendedor também é fornecedor

SELECT 
    seller.razao_social AS Seller,
    supplier.razao_social AS Supplier
FROM seller
JOIN supplier
ON seller.CNPJ = supplier.CNPJ;

