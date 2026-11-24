-- 02 | INSERT contra as travas da tabela (os erros são DE PROPÓSITO)
USE aetheria_online;

-- NOT NULL: email é obrigatório
INSERT INTO jogador (nome) VALUES ('Sem Email');
-- ERRO 1364: Field 'email' doesn't have a default value

-- UNIQUE: o e-mail do Rafael já existe
INSERT INTO jogador (nome, email) VALUES ('Outro Rafael', 'rafael@pixelforge.com');
-- ERRO 1062: Duplicate entry

-- CHECK: personagem.level tem CHECK (level > 0)
INSERT INTO personagem (nome, level, id_jogador) VALUES ('Bugado', 0, 1);
-- ERRO 3819: Check constraint is violated

-- FOREIGN KEY: não existe jogador 999
INSERT INTO personagem (nome, level, id_jogador) VALUES ('Fantasma', 10, 999);
-- ERRO 1452: Cannot add or update a child row
