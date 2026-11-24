-- ============================================================
-- 05 - ALTER TABLE - mudando estrutura sem perder dados
-- ============================================================
-- O jogo evoluiu e a tabela personagem precisa acompanhar, mesmo
-- que ja existam personagens cadastrados.
USE aetheria_online;

-- ADD COLUMN: acrescenta um campo novo. Linhas que ja existiam
-- recebem o valor DEFAULT (aqui, 0) automaticamente.
ALTER TABLE personagem ADD COLUMN xp INT DEFAULT 0;

-- MODIFY COLUMN: muda o tipo/tamanho de um campo que ja existe.
-- Aqui aumentamos o limite de caracteres do nome.
ALTER TABLE personagem MODIFY COLUMN nome VARCHAR(100);

-- ADD FOREIGN KEY: usado quando voce esqueceu de criar a FK no
-- CREATE TABLE original, ou precisa conectar tabelas depois.
-- (exemplo hipotetico - so funcionaria se personagem ja nao
-- tivesse a FK de guilda_id declarada)
-- ALTER TABLE personagem ADD FOREIGN KEY (guilda_id) REFERENCES guilda(id);

-- DROP COLUMN: remove um campo. CUIDADO: apaga os dados dessa
-- coluna pra sempre. Descomente so se quiser demonstrar.
-- ALTER TABLE personagem DROP COLUMN xp;

DESCRIBE personagem;
