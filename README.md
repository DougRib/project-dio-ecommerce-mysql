# project-dio-ecommerce-mysql

# E-commerce Database Project

Este projeto define a estrutura de um sistema de e-commerce utilizando SQL. O banco de dados foi desenhado para gerenciar clientes, produtos, pagamentos, pedidos, entregas, vendedores, fornecedores e a relação entre produtos e estoques. A seguir, você encontrará detalhes sobre a modelagem, as relações entre as tabelas e exemplos de queries que podem ser utilizadas para extrair informações relevantes.

---

## Visão Geral do Projeto

O sistema foi desenvolvido para atender a um ambiente e-commerce completo, englobando:

- Cadastro e gerenciamento de clientes.  
- Contas diferenciadas para pessoa jurídica (PJ) e pessoa física (CPF).  
- Catálogo de produtos com classificações (incluindo produtos para crianças), categorias e avaliações.  
- Processamento de pagamentos com diferentes tipos (dinheiro, cartão, boleto) e rastreamento do status de cada pagamento.  
- Gestão de pedidos com controle de status, valor do frete e vínculo com pagamentos.  
- Administração de estoques e localização dos produtos em diferentes armazéns.  
- Relação entre fornecedores, vendedores e os produtos ofertados.
- Logística de entrega e rastreamento das entregas por meio de códigos únicos.

---

## Estrutura do Banco de Dados

O banco de dados é composto por diversas tabelas, cada uma responsável por uma área do sistema:

- **clients**  
  Armazena os dados dos clientes, incluindo o nome, CPF e endereço.

- **accountPj** e **accountCpf**  
  Gerenciam as contas de clientes, diferenciando entre pessoa jurídica e pessoa física.

- **product**  
  Cadastro de produtos com atributos como nome, categoria, classificação para o público infantil, avaliação e tamanho.

- **payments**  
  Registra as informações dos pagamentos efetuados pelos clientes, com tipo de pagamento, valor e data.

- **paymentsCards**  
  Armazena os dados dos cartões utilizados nos pagamentos, vinculando-os à tabela de pagamentos.

- **StatusPayments**  
  Controla o status do pagamento, associando cada pagamento a um status (Aprovado, Não Aprovado, Em Análise).

- **orders**  
  Contém os pedidos realizados, relacionando o cliente, o status do pedido, descrição, frete, se o pagamento foi concluído e referência ao pagamento.

- **productStorage**  
  Define os armazéns ou depósitos, contendo o nome do depósito e a quantidade total disponível.

- **supplier**  
  Cadastro dos fornecedores, com informações de contato e CNPJ.

- **productSupplier**  
  Associação entre produtos e os depósitos dos fornecedores, informando a quantidade de cada produto presente no estoque.

- **delivery**  
  Tabelas que registram os detalhes das entregas, vinculando pedidos e clientes com os endereços de entrega e datas-chave.

- **tracking**  
  Permite o rastreamento das entregas, com código de rastreamento, status, data de atualização e localização real.

- **seller**  
  Armazena os dados dos vendedores, com informações empresariais (Social Name, Fantasy Name, CNPJ) e dados de contato.

- **productSeller**  
  Liga os vendedores aos produtos que eles comercializam, indicando a quantidade disponível de cada produto.

- **productOrder**  
  Associa produtos aos pedidos, registrando a quantidade solicitada e o status do produto (Disponível ou Sem Estoque).

- **storageLocation**  
  Mapeia a localização exata dos produtos dentro dos depósitos, facilitando a logística e a organização do estoque.

---

## Exemplos de Queries e Atributos Derivados

### 1. Quantos pedidos foram feitos por cada cliente?

Consulta que agrega os pedidos por cliente, mostrando o nome completo (derivado pela concatenação dos nomes) e a quantidade total de pedidos:

```sql
SELECT 
    c.idClient, 
    CONCAT(c.Fname, ' ', c.Lname) AS ClientName, 
    COUNT(o.idOrder) AS TotalOrders
FROM clients c
LEFT JOIN orders o 
    ON c.idClient = o.idOrderClient
GROUP BY c.idClient, c.Fname, c.Lname;
