# ☕ Cafeteria Bom Gosto - Sistema de Gestão de Vendas

## 📋 Sobre o Projeto

Este projeto foi desenvolvido como parte da **Atividade 8** da formação Full Stack Jr. da **MaisPraTi**. O sistema consiste na modelagem e implementação de um banco de dados para controle de vendas de uma cafeteria, incluindo gestão de comandas, cardápio e itens vendidos.

---

## 🎯 Objetivo

Desenvolver scripts SQL para criar e gerenciar um banco de dados que permita à Cafeteria Bom Gosto controlar suas vendas de café e outros produtos através de um sistema de comandas.

---

## 📊 Estrutura do Banco de Dados

### Tabelas Principais

#### `Comanda`

Armazena as informações das comandas dos clientes.

- `id_comanda` (PK): Código único da comanda
- `data`: Data da venda
- `nr_mesa`: Número da mesa do cliente
- `nome_cliente`: Nome do cliente

#### `Cardapio`

Contém os produtos disponíveis na cafeteria.

- `id_cardapio` (PK): Código único do item
- `nome_item`: Nome do produto (único)
- `descricao`: Descrição detalhada do produto
- `preco_unitario`: Preço unitário do item

#### `Item_Comanda`

Relaciona os itens do cardápio com as comandas.

- `id_item_comanda` (PK): Código único do item na comanda
- `quantidade`: Quantidade solicitada
- `id_comanda` (FK): Referência à comanda
- `id_cardapio` (FK): Referência ao cardápio
- **Constraint**: Não é possível inserir o mesmo item mais de uma vez na mesma comanda

---

## 📝 Requisitos e Consultas Implementadas

### 1️⃣ Listagem do Cardápio

Lista todos os itens do cardápio ordenados alfabeticamente por nome.

### 2️⃣ Detalhamento de Comandas

Apresenta todas as comandas com seus respectivos itens, incluindo:

- Código, data, mesa e nome do cliente
- Nome do café, descrição, quantidade, preço unitário e preço total
- Ordenação por data, código da comanda e nome do café

### 3️⃣ Comandas com Valor Total

Lista todas as comandas com uma coluna adicional contendo o valor total de cada comanda, ordenadas por data.

### 4️⃣ Comandas com Múltiplos Itens

Filtra e apresenta apenas as comandas que possuem mais de um tipo de café/item, incluindo o valor total e a quantidade de itens distintos.

### 5️⃣ Faturamento por Data

Calcula o total de faturamento agrupado por data, ordenado cronologicamente.

---

## 🚀 Como Utilizar

1. Execute o script SQL completo no seu SGBD (MySQL, PostgreSQL, SQL Server, etc.)
2. O script criará automaticamente:
   - O banco de dados `CafeteriaBomGosto`
   - Todas as tabelas necessárias
   - Dados de exemplo para testes
   - Todas as consultas solicitadas

---

## 📁 Arquivos do Projeto

- `BancoDeDadosCafeteria - Atividade 8.sql`: Script completo com criação do banco, tabelas, inserção de dados e consultas

---

## 👥 Clientes de Exemplo

- Geromel
- Kannemann
- Luan
- Luis Suárez
- Marcelo Grohe

---

## 🍽️ Cardápio

O cardápio da Cafeteria Bom Gosto inclui uma variedade de produtos típicos de cafeterias:

### Bebidas Quentes

- Café Expresso, Café com Leite, Cappuccino, Café Americano
- Chocolate Quente, Chá de Ervas

### Bebidas Frias

- Café Gelado, Suco Natural

### Salgados

- Coxinha, Pão de Queijo, Croissant

### Doces

- Brigadeiro

---

## 📚 Tecnologias Utilizadas

- SQL (Structured Query Language)
- Modelagem de Banco de Dados Relacional
- Consultas com JOIN, GROUP BY, HAVING e funções agregadas

---

## 📄 Licença

Este projeto foi desenvolvido para fins educacionais como parte da formação da MaisPraTi.
