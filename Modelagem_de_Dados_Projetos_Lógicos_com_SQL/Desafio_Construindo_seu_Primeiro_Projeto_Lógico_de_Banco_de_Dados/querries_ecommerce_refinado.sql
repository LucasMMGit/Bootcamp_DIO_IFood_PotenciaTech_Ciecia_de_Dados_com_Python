-- "Posteriormente, realize a persistência de dados para realização de testes."

-- ==================================================
-- inserção de dados e queries
-- ==================================================
use ecommerce_refinado;

show tables;

DESC clients;
-- idClient, Fname, Minit, Lname, CPF, Address
insert into Clients (Fname, Minit, Lname, CPF, CNPJ, Address, company_name) 
	   values('Maria','M','Silva', 12346789, NULL,'rua silva de prata 29, Carangola - Cidade das flores', NULL),
		     ('Matheus','O','Pimentel', 987654321, NULL,'rua alemeda 289, Centro - Cidade das flores', NULL),
			 ('Ricardo','F','Silva', 45678913, NULL,'avenida alemeda vinha 1009, Centro - Cidade das flores', NULL),
			 ('Julia','S','França', 789123456, NULL,'rua lareijras 861, Centro - Cidade das flores', NULL),
			 ('Roberta','G','Assis', 98745631, NULL,'avenidade koller 19, Centro - Cidade das flores', NULL),
			 ('Isabela','M','Cruz', 654789123, NULL,'rua alemeda das flores 28, Centro - Cidade das flores', NULL),
             (NULL,NULL,NULL,NULL,12345678901234,NULL,'Supermercado XYZ');
SELECT * FROM clients;

DESC products;
-- idProduct, Pname, classification_kids, category, rating, size
insert into products (Pname, classification_kids, category, rating, size, weight, price) values
					  ('Fone de ouvido',false,'Eletrônico','4','10x5x3cm','300 g',42.90),
					  ('Barbie Elsa',true,'Brinquedos','3','30x20x10cm','1 kg',190),
					  ('Body Carters',true,'Vestimenta','5','5x5x1cm','500 g',50),
					  ('Microfone Vedo - Youtuber',False,'Eletrônico','4','10x10x5cm','2 kg',500),
					  ('Sofá retrátil',False,'Móveis','3','3x0.5x8m','20 kg',2000),
					  ('Farinha de arroz',False,'Alimentos','2','10x10x5cm','1 kg',10),
					  ('Fire Stick Amazon',False,'Eletrônico','3','10x7x4cm','500 g',399);
select * from products;

DESC orders;
-- idOrder, idOrderClient, orderStatus, orderDescription, sendValue, paymentCash
-- delete from orders where idOrder in  (13,14,15,16);
alter table orders auto_increment=1;
insert into orders (idOrderClient, orderStatus, orderDescription, total_price, payment_type) values 
							 (1,default,'compra via aplicativo',200,'Pix'),
                             (2,default,'compra via aplicativo',100,'Boleto'),
                             (3,'Aguardando Pagamento',null,50,'Cartão'),
                             (4,default,'compra via web site',150,'Pix');
select * from orders;

DESC products_orders;
-- idPOproduct, idPOorder, poQuantity, poStatus
insert into products_orders (idPOproduct, idPOorder, poQuantity, price_per_unit) values
						 (1,1,2,45),
                         (2,1,1,175),
                         (3,2,1,500);
                         -- (1,5,2,null),
                         -- (2,5,1,null),
                         -- (3,6,1,null);
SELECT * FROM products_orders;

DESC products_storages;
-- idProdStorage, storageLocation, quantity
insert into products_storages (storageLocation,quantity) values 
							('Rio de Janeiro',1000),
                            ('Rio de Janeiro',500),
                            ('São Paulo',10),
                            ('São Paulo',100),
                            ('São Paulo',10),
                            ('Brasília',60);
SELECT * FROM products_storages;

DESC storages_locations;
-- idLproduct, idLstorage, location
insert into storages_locations (idLproduct, idLstorage, location) values
						 (1,2,'RJ'),
                         (2,6,'GO');
SELECT * FROM storages_locations;

DESC suppliers;
-- idSupplier, SocialName, CNPJ, contact
-- delete from suppliers where idSupplier in  (1,2,3,4);
insert into suppliers (idSupplier, SocialName, CNPJ, contact) values 
							(1,'Almeida e filhos', 12345678912345,'21985474'),
                            (2,'Eletrônicos Silva', 85451964914347,'21985484'),
                            (3,'Eletrônicos Valma', 93456789393695,'21975474');
-- ELE INSERE 8 DIGITOS EM contact MESO SENDO CHAR(11), NAO DEVERIA PERMITIR ISSO...
SELECT * FROM suppliers;

DESC products_suppliers;
-- idPsSupplier, idPsProduct, quantity
insert into products_suppliers (idPsSupplier, idPsProduct, quantity) values
						 (1,1,500),
                         (1,2,400),
                         (2,4,633),
                         (3,3,5),
                         (2,5,10);
SELECT * FROM products_suppliers;

DESC sellers;
-- idSeller, SocialName, AbstName, CNPJ, CPF, location, contact
insert into sellers (SocialName, AbstName, CNPJ, CPF, location, contact) values 
						('Tech eletronics', null, 12345678945632, null, 'Rio de Janeiro', 219946287),
					    ('Botique Durgas',null,null,12345678910,'Rio de Janeiro', 219567895),
						('Kids World',null,45678912365448,null,'São Paulo', 1198657484);
-- NOVAMENTE ELE SIMPLESMENTE IGNORA O FATO DE SER NECESSARIO 11 char NO contact
SELECT * FROM sellers;

DESC products_sellers;
-- idPseller, idPproduct, prodQuantity
insert into products_sellers (idPseller, idPproduct, prodQuantity) values 
						 (1,6,80),
                         (2,7,10);
select * from products_sellers;

select count(*) from clients;

select * from clients c, orders o where c.idClient = o.idOrderClient;
select Fname,Lname,idOrder,orderStatus from clients c, orders o where c.idClient = o.idOrderClient;
select concat(Fname,' ',Lname) as Full_Name, idOrder as Request, orderStatus as Order_Status from clients c, orders o where c.idClient = o.idOrderClient;

-- INSERT INTO orders (idOrderClient, orderStatus, orderDescription, total_price, payment_type) values 
							 (2, default,'compra via aplicativo',350,'Pix');
SELECT * FROM orders;
-- delete from orders where idOrder in  (10);
select count(*) from clients c, orders o 
			where c.idClient = o.idOrderClient;

-- recuperação de pedido com produto associado
select * from clients c
	inner join orders o ON c.idClient = o.idOrderClient
	inner join products_orders p on p.idPOorder = o.idOrder;
select idClient,idOrder,orderStatus,orderDescription,idPOorder,poQuantity from clients c
	inner join orders o ON c.idClient = o.idOrderClient
	inner join products_orders p on p.idPOorder = o.idOrder;
select idClient from clients c
	inner join orders o ON c.idClient = o.idOrderClient
	inner join products_orders p on p.idPOorder = o.idOrder
		group by c.idClient;
        
-- Recuperar quantos pedidos foram realizados pelos clientes
select c.idClient, Fname, count(*) as Number_of_orders from clients c 
				inner join orders o ON c.idClient = o.idOrderClient
		group by idClient;
        
        
-- ==================================================
-- "Especifique ainda queries mais complexas dos que apresentadas durante a explicação do desafio"
-- "Sendo assim, crie queries SQL com as cláusulas abaixo:"
-- ==================================================

-- "Recuperações simples com SELECT Statement"
SELECT * FROM clients;
SELECT * FROM orders;
SELECT * FROM products_orders;
SELECT * FROM products_storages;
SELECT * FROM products_suppliers;
SELECT * FROM products;
SELECT * FROM products_sellers;
SELECT * FROM sellers;
SELECT * FROM storages_locations;
SELECT * FROM suppliers;

-- "Filtros com WHERE Statement"
	-- Quais pedidos estão em processamento?
		SELECT * FROM orders
			WHERE orderStatus LIKE '%processamento%';
	-- Quais produtos são da categoria infantil?
		SELECT * FROM products
			WHERE classification_kids = true;

-- "Crie expressões para gerar atributos derivados"
	-- Crie uma coluna dando 10% de desconto para os pedidos com valor total maior igual a 200
		SELECT total_price,total_price*0.9 AS total_price_withDiscount FROM orders
			WHERE total_price >= 200;

-- "Defina ordenações dos dados com ORDER BY"
	-- Quais são os 5 melhores produtos com respeito à avaliação?
		SELECT * FROM products
			ORDER BY rating DESC
            LIMIT 5;
	-- Ordene os armazenamentos do maior para o menor em quantidade
		SELECT * FROM products_storages
			ORDER BY quantity DESC;

-- "Condições de filtros aos grupos – HAVING Statement"
	-- Quais cidades possuem uma quantidade de produtos em estoque maior do que 100?
		SELECT storageLocation, SUM(quantity) AS quantity_per_city FROM products_storages
			GROUP BY storageLocation
			HAVING quantity_per_city > 100
			ORDER BY quantity_per_city DESC;
	-- Quais categorias de produtos possuem mais do que 1 produto com avaliação maior ou igual a 3?
		SELECT category,COUNT(category) AS quantity_per_category FROM products
			WHERE rating >= 3
			GROUP BY category
			HAVING quantity_per_category > 1;

-- "Crie junções entre tabelas para fornecer uma perspectiva mais complexa dos dados"
	-- Como estimar o custo de entrega?
    -- Para poder estimar o custo de entrega, precisamos do tipo de produto (category), dimensões (size) e o endereço (Address)
    -- o peso também deveria ser considerado mas não temos essa informação.
    -- Para isso vamos, conectar estes campos a partir da tabela 'products' com 'clients'
		SELECT concat(Fname,' ',Minit,' ',Lname) AS Full_Name, Address, Pname, category, size FROM products AS p
			INNER JOIN products_orders AS po ON p.idProduct = po.idPOorder
			INNER JOIN orders AS o ON po.idPOorder = o.idOrder
			INNER JOIN clients AS c ON o.idOrderClient = c.idClient;
