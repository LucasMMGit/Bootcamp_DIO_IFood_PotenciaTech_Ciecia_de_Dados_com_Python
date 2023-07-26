USE oficina;

-- _________________________________________________
DESC cidades;
INSERT INTO cidades VALUES (1, 'Sao Paulo');
SELECT * FROM cidades;

DESC oficinas;
INSERT INTO oficinas VALUES (1, 'Oficina do Toretto', 'Galeria Prestes Maia, Centro, CEP 01007-030', '1');
SELECT * FROM oficinas;

DESC posicoes;
INSERT INTO posicoes VALUES (1, 'Dono'),
							(2, 'Gerente'),
                            (3, 'Atendente'),
                            (4, 'Mecanico'),
                            (5, 'Estagiario'),
                            (6, 'Jovem Aprendiz');
SELECT * FROM posicoes;

DESC empregados;
INSERT INTO empregados VALUES (1, 'Dominic Toretto', 12345678910, 1, 1, 'Galeria Prestes Maia, Centro, CEP 01007-030', '2000-01-01', NULL),
							  (2, 'Letty', 10987654321, 2, 1, 'Galeria Prestes Maia, Centro, CEP 01007-030', '2000-01-01', NULL),
                              (3, 'Mia', 21345678910, 3, 1, 'Rua Doutor Falcão Filho, Centro, CEP 01007-010', '2000-01-01', NULL),
                              (4, 'Brian OConner', 31245678910, 4, 1, 'Rua Doutor Falcão Filho, Centro, CEP 01007-010', '2000-01-01', NULL),
                              (5, 'Jesse', 41235678910, 5, 1, 'Rua Líbero Badaró, Centro, CEP 01008-000', '2000-01-02', '2000-10-01'),
                              (6, 'Vince', 51234678910, 6, 1, 'Rua São Bento, Centro, CEP 01011-000', '2000-01-03', '2001-01-10');
SELECT * FROM empregados;

DESC escalas;
INSERT INTO escalas VALUES (1, 1, 1, 1, '2000-01-01', '08:00:00', '18:00:00'),
						   (2, 1, 2, 2, '2000-01-01', '08:00:00', '18:00:00'),
                           (3, 1, 3, 3, '2000-01-01', '08:00:00', '18:00:00'),
                           (4, 1, 4, 4, '2000-01-01', '08:00:00', '18:00:00'),
                           (5, 1, 1, 1, '2000-01-03', '08:00:00', '18:00:00'),
						   (6, 1, 2, 2, '2000-01-03', '08:00:00', '18:00:00'),
                           (7, 1, 3, 3, '2000-01-03', '08:00:00', '18:00:00'),
                           (8, 1, 4, 4, '2000-01-03', '08:00:00', '18:00:00'),
                           (9, 1, 5, 5, '2000-01-03', '08:00:00', '18:00:00'),
                           (10, 1, 6, 6, '2000-01-03', '08:00:00', '18:00:00');
SELECT * FROM escalas;
-- DELETE FROM escalas WHERE id = 1;


-- _________________________________________________
DESC clientes;
INSERT INTO clientes VALUES (1, 'Johnny Tran', NULL, 10123456789, NULL, 1, NULL, '11 9 9999-9999', 'johnny_tran@gmail.com', NULL, '2000-01-01'),
							(2, 'Danny Yamato', NULL, 10213456789, NULL, 1, NULL, '11 9 9999-9998', 'danny_yamato@gmail.com', NULL, '2000-01-01'),
                            (3, 'Lance Nguyen', NULL, 10312456789, NULL, 1, NULL, '11 9 9999-9997', 'lance_nguyen@gmail.com', NULL, '2000-01-01'),
                            (4, 'Ted Levine', NULL, 10412356789, NULL, 1, NULL, '11 9 9999-9996', 'ted_levine@gmail.com', NULL, '2000-01-01'),
                            (5, 'Thom Barry', NULL, 10512346789, NULL, 1, NULL, '11 9 9999-9995', 'thom_barry@gmail.com', NULL, '2000-01-01'),
                            (6, NULL, 'The Racers Edge', NULL, 12345678910121, 1, NULL, '11 9 9999-9994', 'the_racers_edge@gmail.com', NULL, '2000-01-01');
SELECT * FROM clientes;
-- DELETE FROM clientes WHERE id IN (4,5,6);

DESC tipos_contato;
INSERT INTO tipos_contato VALUES (1, 'Informação'),
								 (2, 'Contrato de serviço');
SELECT * FROM tipos_contato;

DESC contatos;
INSERT INTO contatos VALUES (1, 2, 1, 3, NULL, '2000-01-01 09:00:00'),
							(2, 2, 2, 3, NULL, '2000-01-01 09:10:00'),
                            (3, 2, 3, 3, NULL, '2000-01-01 09:20:00'),
                            (4, 2, 3, 7, NULL, '2000-01-03 09:00:00'),
                            (5, 2, 2, 7, NULL, '2000-01-03 09:10:00'),
                            (6, 2, 3, 7, NULL, '2000-01-03 11:00:00');
SELECT * FROM contatos;


-- _________________________________________________
DESC tipos_veiculo;
INSERT INTO tipos_veiculo VALUES (1, 'automóvel'),
								 (2, 'motocicleta');
SELECT * FROM tipos_veiculo;

DESC fabricantes;
INSERT INTO fabricantes VALUES (1, 'Honda');
SELECT * FROM fabricantes;

DESC modelos;
INSERT INTO modelos VALUES (1, 'S2000', 1, 1),
						   (2, 'CR250', 1, 2),
                           (3, 'Civic', 1, 1);
SELECT * FROM modelos;

DESC veiculos;
INSERT INTO veiculos VALUES (1, 'ABC-1234', '12345678911234567', 1, 1, '2000-01-01', NULL),
							(2, 'ABC-1243', '21345678911234567', 2, 2, '1970-01-01', NULL),
                            (3, 'ABC-2134', '31245678911234567', 2, 3, '1993-01-01', NULL),
                            (4, 'ACB-1234', '41235678911234567', 3, 2, '1993-01-01', NULL),
                            (5, 'ACB-3124', '61234578911234567', 3, 3, '1993-01-01', NULL);
SELECT * FROM veiculos;
-- DELETE FROM veiculos WHERE id IN (1,2,3,4,5,6);

-- _________________________________________________
DESC catalogo_tarefas;
INSERT INTO catalogo_tarefas VALUES (1, 'troca de óleo', NULL, 30, 100, true),
									(2, 'manutenção freios', NULL, 40, 500, true),
                                    (3, 'manutenção embreagem', NULL, 60, 500, true),
                                    (4, 'manutenção amortecedores', NULL, 40, 400, true),
                                    (5, 'manutenção sistema de arrefecimento', NULL, 15, 50, true),
                                    (6, 'manutenção filtros', NULL, 30, 100, true),
                                    (7, 'manutenção faróis', NULL, 30, 50, true),
                                    (8, 'manutenção elétrica', NULL, 60, 200, true),
                                    (9, 'manutenção funilaria e pintura', NULL, 60, 100, true),
                                    (10, 'manutenção pneus', NULL, 30, 50, true),
                                    (11, 'manutenção motor', NULL, 60, 200, true),
                                    (12, 'revisão', NULL, 15, 50, true),
                                    (13, 'tuning freios', NULL, 80, 5000, true),
                                    (14, 'tuning embreagem', NULL, 120, 5000, true),
                                    (15, 'tuning amortecedores', NULL, 80, 4000, true),
                                    (16, 'tuning sistema de arrefecimento', NULL, 30, 500, true),
                                    (17, 'tuning filtros', NULL, 60, 1000, true),
                                    (18, 'tuning faróis', NULL, 60, 500, true),
                                    (19, 'tuning elétrica', NULL, 120, 2000, true),
                                    (20, 'tuning pneus', NULL, 60, 500, true),
                                    (21, 'tuning motor', NULL, 120, 2000, true);
SELECT * FROM catalogo_tarefas;

DESC catalogo_servicos;
INSERT INTO catalogo_servicos VALUES (1, 'completo', 'Todas manutenções, troca de óleo e revisão', true),
									 (2, 'basico', 'Troca de óleo e revisão', true),
                                     (3, 'tuning completo', 'Todos os tunings', true);
SELECT * FROM catalogo_servicos;

DESC catalogos_servicos_tarefas;
INSERT INTO catalogos_servicos_tarefas VALUES (1,1),(1,2),(1,3),(1,4),(1,5),(1,6),(1,7),(1,8),(1,9),(1,10),(1,11),(1,12),
											  (2,1),(2,12),
                                              (3,13),(3,14),(3,15),(3,16),(3,17),(3,18),(3,19),(3,20),(3,21);
SELECT * FROM catalogos_servicos_tarefas;

DESC servicos;
INSERT INTO servicos VALUES (1, 1, 1, 3, 20500, 0, '2000-01-01 10:00:00'),
							(2, 2, 2, 2, 150, 0, '2000-01-01 10:30:00'),
                            (3, 3, 4, 1, 2300, 0, '2000-01-01 11:00:00'),
                            (4, 3, 4, 2, 150, 0, '2000-01-03 09:30:00'),
                            (5, 2, 3, 2, 150, 0, '2000-01-03 10:00:00'),
                            (6, 3, 5, 2, 150, 0, '2000-01-03 11:00:00');
SELECT * FROM servicos;
-- DELETE FROM servicos WHERE id IN (1,2,3,4,5,6);

DESC tarefas_por_servico;
INSERT INTO tarefas_por_servico VALUES
	(1,13,5000),(1,14,5000),(1,15,4000),(1,16,500),(1,17,1000),(1,18,500),(1,19,2000),(1,20,500),(1,21,2000),
	(2,1,100),(2,12,50),
	(3,1,100),(3,2,500),(3,3,500),(3,4,400),(3,5,50),(3,6,100),(3,7,50),(3,8,200),(3,9,100),(3,10,50),(3,11,200),(3,12,50),
	(4,1,100),(4,12,50),
    (5,1,100),(5,12,50),
    (6,1,100),(6,12,50);
SELECT * FROM tarefas_por_servico;


INSERT INTO catalogo_tarefas VALUES (1, 'troca de óleo', NULL, 30, 100, true),
									(2, 'manutenção freios', NULL, 40, 500, true),
                                    (3, 'manutenção embreagem', NULL, 60, 500, true),
                                    (4, 'manutenção amortecedores', NULL, 40, 400, true),
                                    (5, 'manutenção sistema de arrefecimento', NULL, 15, 50, true),
                                    (6, 'manutenção filtros', NULL, 30, 100, true),
                                    (7, 'manutenção faróis', NULL, 30, 50, true),
                                    (8, 'manutenção elétrica', NULL, 60, 200, true),
                                    (9, 'manutenção funilaria e pintura', NULL, 60, 100, true),
                                    (10, 'manutenção pneus', NULL, 30, 50, true),
                                    (11, 'manutenção motor', NULL, 60, 200, true),
                                    (12, 'revisão', NULL, 15, 50, true),
                                    (13, 'tuning freios', NULL, 80, 5000, true),
                                    (14, 'tuning embreagem', NULL, 120, 5000, true),
                                    (15, 'tuning amortecedores', NULL, 80, 4000, true),
                                    (16, 'tuning sistema de arrefecimento', NULL, 30, 500, true),
                                    (17, 'tuning filtros', NULL, 60, 1000, true),
                                    (18, 'tuning faróis', NULL, 60, 500, true),
                                    (19, 'tuning elétrica', NULL, 120, 2000, true),
                                    (20, 'tuning pneus', NULL, 60, 500, true),
                                    (21, 'tuning motor', NULL, 120, 2000, true);


-- _________________________________________________
-- "crie queries SQL com as cláusulas abaixo:"

-- "Recuperações simples com SELECT Statement;"
	SHOW TABLES;
	SELECT * FROM catalogo_servicos;
	SELECT * FROM catalogo_tarefas;
	SELECT * FROM catalogos_servicos_tarefas;
	SELECT * FROM cidades;
	SELECT * FROM clientes;
	SELECT * FROM contatos;
	SELECT * FROM empregados;
	SELECT * FROM escalas;
	SELECT * FROM fabricantes;
	SELECT * FROM modelos;
	SELECT * FROM oficinas;
	SELECT * FROM posicoes;
	SELECT * FROM servicos;
	SELECT * FROM tarefas_por_servico;
	SELECT * FROM tipos_contato;
	SELECT * FROM tipos_veiculo;
	SELECT * FROM veiculos;

-- Filtros com WHERE Statement;
	SELECT * FROM catalogo_tarefas WHERE preco >= 1000; -- quais tarefas custam 1000 ou mais?

-- Crie expressões para gerar atributos derivados;
	SELECT preco, preco*0.9 AS preco_com_desconto FROM servicos; -- criando uma coluna nova com precos com desconto

-- Defina ordenações dos dados com ORDER BY;
	SELECT * FROM veiculos ORDER BY data_fabricacao ASC; -- ordenando os veiculos que passaram pela data de fabricacao

-- Condições de filtros aos grupos – HAVING Statement;
	SELECT id_servico,COUNT(*) AS quatidade_de_tarefas FROM tarefas_por_servico
		GROUP BY id_servico
        HAVING quatidade_de_tarefas >= 3; -- contando a quantidade de tarefas em servicos onde esta quantidade passa de 2

-- Crie junções entre tabelas para fornecer uma perspectiva mais complexa dos dados;
	SELECT DISTINCT oficinas.nome AS oficina, empregados.nome_completo, posicoes.nome AS posicao, cidades.nome AS cidade FROM escalas
		INNER JOIN oficinas ON oficinas.id = escalas.id_oficina
        INNER JOIN empregados ON empregados.id = escalas.id_empregado
        INNER JOIN posicoes ON posicoes.id = empregados.id_posicao
        INNER JOIN cidades ON cidades.id = empregados.id_cidade; -- quais emperegados, com nome, posicao e cidade trabalham em cada oficina?
	SELECT servicos.id AS id_servico, servicos.hora_criacao, modelos.nome AS modelo_veiculo, fabricantes.nome AS nome_fabricante, tipos_veiculo.nome AS tipo_veiculo, clientes.nome_pessoa AS nome_cliente
		FROM clientes
		INNER JOIN veiculos ON veiculos.id_cliente = clientes.id
        INNER JOIN servicos ON veiculos.id = servicos.id_veiculo
        INNER JOIN modelos ON modelos.id = veiculos.id_modelo
        INNER JOIN fabricantes ON fabricantes.id = modelos.id_fabricante
        INNER JOIN tipos_veiculo ON tipos_veiculo.id = modelos.id_tipo; -- quais sao os servicos realizados, em quais veiculos, de quais clientes, e quando eles aconteceram?
