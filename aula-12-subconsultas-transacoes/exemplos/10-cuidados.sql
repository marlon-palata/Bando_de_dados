-- 10 | Cuidados com transação
-- Antes: 00b (dados padrão). Rode bloco a bloco.
USE aetheria_online;

-- 1) CREATE, ALTER e DROP (DDL) fazem COMMIT sozinhos: não dá ROLLBACK neles.
-- 2) Transação aberta e esquecida segura as linhas: sempre termine com COMMIT ou ROLLBACK.
-- 3) Só funciona em tabela InnoDB (o padrão do MySQL 8).

-- Para voltar aos dados padrão depois desta aula: rode o 00b de novo.
