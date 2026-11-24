-- ============================================================
-- 04 - TABELA PERSONAGEM (tabela "filha" - tem 2 FOREIGN KEY)
-- ============================================================
-- IMPORTANTE: essa tabela SO pode ser criada DEPOIS de jogador e
-- guilda, porque as FOREIGN KEY abaixo referenciam as PK delas.
-- Se voce tentar criar personagem antes, o MySQL recusa com o
-- erro 1215 / 1824 (referencia a tabela que ainda nao existe).
USE aetheria_online;

CREATE TABLE personagem (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(80) NOT NULL,
    classe VARCHAR(30) NOT NULL,

    -- DEFAULT 1 = todo personagem novo comeca no level 1 se nada
    -- for informado. CHECK garante que nunca entra level <= 0.
    level INT DEFAULT 1 CHECK (level > 0),

    -- Colunas de FK: guardam o id da tabela referenciada.
    jogador_id INT NOT NULL,   -- todo personagem TEM que ter dono
    guilda_id INT,             -- personagem pode nao estar em guilda

    -- FOREIGN KEY = trava de integridade referencial. O MySQL
    -- recusa inserir/atualizar um personagem apontando para um
    -- jogador_id ou guilda_id que nao existe na tabela pai.
    FOREIGN KEY (jogador_id) REFERENCES jogador(id),
    FOREIGN KEY (guilda_id) REFERENCES guilda(id)
);

DESCRIBE personagem;

-- ------------------------------------------------------------
-- Teste rapido pra mostrar a FK funcionando (rodar so na
-- demonstracao, nao faz parte da estrutura do banco):
-- ------------------------------------------------------------
-- INSERT INTO jogador (nome, email) VALUES ('Rafael', 'rafael@aetheria.com');
-- INSERT INTO personagem (nome, classe, jogador_id) VALUES ('Kaeldor', 'Guerreiro', 1); -- funciona
-- INSERT INTO personagem (nome, classe, jogador_id) VALUES ('Fantasma', 'Mago', 999);   -- ERROR 1452 (FK falha)
