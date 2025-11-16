-- Banco de Dados:

CREATE DATABASE CafeteriaBomGosto;

-- Tabela Comanda:

CREATE TABLE Comanda(
	id_comanda INT PRIMARY KEY NOT NULL,
	data DATE NOT NULL,
	nr_mesa INT NOT NULL,
	nome_cliente VARCHAR(100) NOT NULL
);

-- Tabela Cardápio:

CREATE TABLE Cardapio (
	id_cardapio INT PRIMARY KEY NOT NULL,
	nome_item VARCHAR(100) UNIQUE NOT NULL,
	descricao TEXT,
	preco_unitario DECIMAL (10, 2) NOT NULL
);

-- Tabela Item da Comanda:

CREATE TABLE Item_Comanda (
	id_item_comanda INT PRIMARY KEY NOT NULL,
	quantidade INT NOT NULL,
	id_comanda INT NOT NULL,
	id_cardapio INT NOT NULL,
	FOREIGN KEY(id_comanda) REFERENCES Comanda(id_comanda),
	FOREIGN KEY(id_cardapio) REFERENCES Cardapio(id_cardapio),
    UNIQUE (id_comanda, id_cardapio)
);


-- Inserção de Dados:

-- Comandas
INSERT INTO Comanda(id_comanda, data, nr_mesa, nome_cliente)
VALUES (1, '2025-10-12', 5, 'Geromel'),
(2, '2025-10-12', 5, 'Kannemann'),
(3, '2025-10-13', 7, 'Luan'),
(4, '2025-10-19', 1, 'Luis Suárez'),
(5, '2025-10-19', 8, 'Marcelo Grohe'); 

-- Cardápio de Bebidas Quentes
INSERT INTO Cardapio (id_cardapio, nome_item, descricao, preco_unitario)
VALUES (1, 'Café Expresso', 'Café puro e intenso, extraído sob pressão.', 4.50),
(2, 'Café com Leite', 'Café expresso com leite vaporizado na medida certa.', 6.00),
(3, 'Cappuccino', 'Expresso, leite vaporizado e espuma de leite cremosa com canela.', 10.50),
(4, 'Café Americano', 'Café expresso diluído em água quente, sabor suave.', 5.00),
(5, 'Chocolate Quente', 'Chocolate belga derretido com leite cremoso e chantilly.', 12.00),
(6, 'Chá de Ervas', 'Chá de camomila, hortelã ou erva-doce. Escolha o sabor.', 7.50);

-- Cardápio de Bebidas Frias e Salgados
INSERT INTO Cardapio (id_cardapio, nome_item, descricao, preco_unitario)
VALUES (7, 'Café Gelado', 'Café expresso gelado com cubos de gelo e açúcar.', 8.00),
(8, 'Suco Natural', 'Suco de laranja, maracujá ou abacaxi. Feito na hora.', 9.00),
(9, 'Coxinha', 'Coxinha de frango com catupiry, massa crocante.', 6.50),
(10, 'Pão de Queijo', 'Pão de queijo mineiro, quentinho e macio. Unidade.', 3.50),
(11, 'Croissant', 'Croissant francês recheado com presunto e queijo.', 8.50),
(12, 'Brigadeiro', 'Brigadeiro caseiro com granulado. Unidade.', 4.00);

-- Itens da Comanda
INSERT INTO Item_Comanda (id_item_comanda, quantidade, id_comanda, id_cardapio)
VALUES
-- Comanda 1 (Geromel, 2025-10-12)
(1, 2, 1, 1),
(2, 1, 1, 3),
(3, 2, 1, 10),

-- Comanda 2 (Kannemann, 2025-10-12)
(4, 1, 2, 3),
(5, 1, 2, 9),

-- Comanda 3 (Luan, 2025-10-13)
(6, 1, 3, 2),
(7, 2, 3, 1),
(8, 1, 3, 11),

-- Comanda 4 (Luis Suárez, 2025-10-19)
(9, 1, 4, 1),
(10, 1, 4, 3),
(11, 3, 4, 12),

-- Comanda 5 (Marcelo Grohe, 2025-10-19)
(12, 1, 5, 4),
(13, 1, 5, 8);

-- CONSULTAS:

-- 1) Cardápio ordenada por nome:
SELECT
    id_cardapio, nome_item, descricao, preco_unitario
FROM
    Cardapio
ORDER BY
    nome_item;

-- 2) Ordenar por data, código e por nome do café:

SELECT 
    comanda.id_comanda,
    comanda.data,
    comanda.nr_mesa,
    comanda.nome_cliente,
    cardapio.nome_item,
    cardapio.descricao,
    item_comanda.quantidade,
    cardapio.preco_unitario,
    (item_comanda.quantidade * cardapio.preco_unitario) AS preco_total
FROM 
    Comanda comanda
JOIN 
    Item_Comanda item_comanda 
    ON comanda.id_comanda = item_comanda.id_comanda
JOIN 
    Cardapio cardapio 
    ON item_comanda.id_cardapio = cardapio.id_cardapio
ORDER BY 
    comanda.data,
    comanda.id_comanda,
    cardapio.nome_item;
-- 3) Listar todas as comandas e mostrar o valor total da comanda, ordenando por data a listagem:
SELECT 
    comanda.id_comanda,
    comanda.nome_cliente,
    comanda.nr_mesa,
    comanda.data,
    SUM(item_comanda.quantidade * cardapio.preco_unitario) AS total_comanda
FROM 
    Comanda comanda
JOIN 
    Item_Comanda item_comanda 
    ON comanda.id_comanda = item_comanda.id_comanda
JOIN 
    Cardapio cardapio 
    ON item_comanda.id_cardapio = cardapio.id_cardapio
GROUP BY 
    comanda.id_comanda,
    comanda.nome_cliente,
    comanda.nr_mesa,
    comanda.data
ORDER BY 
    comanda.data;


-- 4) Mesma listagem das comandas da questão anterior, mas trazendo apenas as comandas que possuem mais do que um tipo de café na comanda:

SELECT 
    comanda.id_comanda,
    comanda.nome_cliente,
    comanda.nr_mesa,
    comanda.data,
    SUM(item_comanda.quantidade * cardapio.preco_unitario) AS total_comanda,
    COUNT(DISTINCT cardapio.id_cardapio) AS qtd_itens
FROM 
    Comanda comanda
JOIN 
    Item_Comanda item_comanda 
    ON comanda.id_comanda = item_comanda.id_comanda
JOIN 
    Cardapio cardapio 
    ON item_comanda.id_cardapio = cardapio.id_cardapio
GROUP BY 
    comanda.id_comanda,
    comanda.nome_cliente,
    comanda.nr_mesa,
    comanda.data
HAVING 
    COUNT(DISTINCT cardapio.id_cardapio) > 1
ORDER BY 
    comanda.data;

-- 5) Total de faturamento por data, ordenando por data a consulta:

SELECT 
    comanda.data,
    SUM(item_comanda.quantidade * cardapio.preco_unitario) AS faturamento_total
FROM 
    Comanda comanda
JOIN 
    Item_Comanda item_comanda 
    ON comanda.id_comanda = item_comanda.id_comanda
JOIN 
    Cardapio cardapio 
    ON item_comanda.id_cardapio = cardapio.id_cardapio
GROUP BY 
    comanda.data
ORDER BY 
    comanda.data;
