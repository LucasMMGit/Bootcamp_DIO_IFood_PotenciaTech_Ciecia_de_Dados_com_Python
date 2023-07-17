-- "Posteriormente, realize a persistência de dados para realização de testes."

-- ==================================================
-- inserção de dados e queries
-- ==================================================
use ecommerce;

show tables;

DESC clients;
-- idClient, Fname, Minit, Lname, CPF, Address
insert into Clients (Fname, Minit, Lname, CPF, Address) 
	   values('Maria','M','Silva', 12346789, 'rua silva de prata 29, Carangola - Cidade das flores'),
		     ('Matheus','O','Pimentel', 987654321,'rua alemeda 289, Centro - Cidade das flores'),
			 ('Ricardo','F','Silva', 45678913,'avenida alemeda vinha 1009, Centro - Cidade das flores'),
			 ('Julia','S','França', 789123456,'rua lareijras 861, Centro - Cidade das flores'),
			 ('Roberta','G','Assis', 98745631,'avenidade koller 19, Centro - Cidade das flores'),
			 ('Isabela','M','Cruz', 654789123,'rua alemeda das flores 28, Centro - Cidade das flores');
SELECT * FROM clients;

DESC products;
-- idProduct, Pname, classification_kids, category, rating, size
insert into products (Pname, classification_kids, category, rating, size) values
							  ('Fone de ouvido',false,'Eletrônico','4',null),
                              ('Barbie Elsa',true,'Brinquedos','3',null),
                              ('Body Carters',true,'Vestimenta','5',null),
                              ('Microfone Vedo - Youtuber',False,'Eletrônico','4',null),
                              ('Sofá retrátil',False,'Móveis','3','3x57x80'),
                              ('Farinha de arroz',False,'Alimentos','2',null),
                              ('Fire Stick Amazon',False,'Eletrônico','3',null);
select * from products;

DESC orders;
-- idOrder, idOrderClient, orderStatus, orderDescription, sendValue, paymentCash

delete from orders where idOrderClient in  (1,2,3,4);
insert into orders (idOrderClient, orderStatus, orderDescription, sendValue, paymentCash) values 
							 (1,default,'compra via aplicativo',null,1),
                             (2,default,'compra via aplicativo',50,0),
                             (3,'Confirmado',null,null,1),
                             (4,default,'compra via web site',150,0);
select * from orders;

DESC product_orders;
-- idPOproduct, idPOorder, poQuantity, poStatus
insert into product_orders (idPOproduct, idPOorder, poQuantity, poStatus) values
						 (1,1,2,null),
                         (2,1,1,null),
                         (3,2,1,null);
                         -- (1,5,2,null),
                         -- (2,5,1,null),
                         -- (3,6,1,null);
SELECT * FROM product_orders;

DESC product_storages;

-- idProdStorage, storageLocation, quantity
insert into product_storages (storageLocation,quantity) values 
							('Rio de Janeiro',1000),
                            ('Rio de Janeiro',500),
                            ('São Paulo',10),
                            ('São Paulo',100),
                            ('São Paulo',10),
                            ('Brasília',60);
SELECT * FROM product_storages;

DESC storage_locations;
-- idLproduct, idLstorage, location
insert into storage_locations (idLproduct, idLstorage, location) values
						 (1,2,'RJ'),
                         (2,6,'GO');
SELECT * FROM storage_locations;

DESC suppliers;
-- idSupplier, SocialName, CNPJ, contact
-- delete from suppliers where idSupplier in  (1,2,3,4);
insert into suppliers (idSupplier, SocialName, CNPJ, contact) values 
							(1,'Almeida e filhos', 12345678912345,'21985474'),
                            (2,'Eletrônicos Silva', 85451964914347,'21985484'),
                            (3,'Eletrônicos Valma', 93456789393695,'21975474');
-- ELE INSERE 8 DIGITOS EM contact MESO SENDO CHAR(11), NAO DEVERIA PERMITIR ISSO...
SELECT * FROM suppliers;

DESC product_suppliers;
-- idPsSupplier, idPsProduct, quantity
insert into product_suppliers (idPsSupplier, idPsProduct, quantity) values
						 (1,1,500),
                         (1,2,400),
                         (2,4,633),
                         (3,3,5),
                         (2,5,10);
SELECT * FROM product_suppliers;

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

SELECT * FROM clients;
SELECT * FROM orders;
SELECT * FROM product_orders;
SELECT * FROM product_storages;
SELECT * FROM product_suppliers;
SELECT * FROM products;
SELECT * FROM products_sellers;
SELECT * FROM sellers;
SELECT * FROM storage_locations;
SELECT * FROM suppliers;
SELECT * FROM payments; -- faltou inserir

select count(*) from clients;

select * from clients c, orders o where c.idClient = o.idOrderClient;
select Fname,Lname,idOrder,orderStatus from clients c, orders o where c.idClient = o.idOrderClient;
select concat(Fname,' ',Lname) as Full_Name, idOrder as Request, orderStatus as Order_Status from clients c, orders o where c.idClient = o.idOrderClient;

-- INSERT INTO orders (idOrderClient, orderStatus, orderDescription, sendValue, paymentCash) values 
							 (2, default,'compra via aplicativo',null,1);
SELECT * FROM orders;
-- delete from orders where idOrder in  (10);
select count(*) from clients c, orders o 
			where c.idClient = o.idOrderClient;

-- recuperação de pedido com produto associado
DESC orders;
select * from clients c
	inner join orders o ON c.idClient = o.idOrderClient
	inner join product_orders p on p.idPOorder = o.idOrder;
select idClient,idOrder,orderStatus,orderDescription,idPOorder,poQuantity from clients c
	inner join orders o ON c.idClient = o.idOrderClient
	inner join product_orders p on p.idPOorder = o.idOrder;
select idClient from clients c
	inner join orders o ON c.idClient = o.idOrderClient
	inner join product_orders p on p.idPOorder = o.idOrder
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
SELECT * FROM product_orders;
SELECT * FROM product_storages;
SELECT * FROM product_suppliers;
SELECT * FROM products;
SELECT * FROM products_sellers;
SELECT * FROM sellers;
SELECT * FROM storage_locations;
SELECT * FROM suppliers;

-- "Filtros com WHERE Statement"
	-- Quais pedidos estão em processamento?
		SELECT * FROM orders
			WHERE orderStatus LIKE '%processamento%';
	-- Quais produtos são da categoria infantil?
		SELECT * FROM products
			WHERE classification_kids = true;

-- "Crie expressões para gerar atributos derivados"
	-- Crie uma coluna com 10% de desconto para o frete
		SELECT sendValue,sendValue*0.9 AS sendValue_withDiscount FROM orders
			WHERE sendValue IS NOT NULL;

-- "Defina ordenações dos dados com ORDER BY"
	-- Quais são os 5 melhores produtos com respeito à avaliação?
		SELECT * FROM products
			ORDER BY rating DESC
            LIMIT 5;
	-- Ordene os armazenamentos do maior para o menor em quantidade
		SELECT * FROM product_storages
			ORDER BY quantity DESC;

-- "Condições de filtros aos grupos – HAVING Statement"
	-- Quais cidades possuem uma quantidade de produtos em estoque maior do que 100?
		SELECT storageLocation, SUM(quantity) AS quantity_per_city FROM product_storages
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
			INNER JOIN product_orders AS po ON p.idProduct = po.idPOorder
			INNER JOIN orders AS o ON po.idPOorder = o.idOrder
			INNER JOIN clients AS c ON o.idOrderClient = c.idClient;
