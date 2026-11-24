-- ============================================================
-- 03 - TABELA GUILDA (tambem "pai" - sem FK, sem depender de nada)
-- ============================================================
USE aetheria_online;

CREATE TABLE guilda (
    id INT PRIMARY KEY AUTO_INCREMENT,

    -- UNIQUE aqui porque duas guildas nao podem ter o mesmo nome
    -- no jogo (regra de negocio do Aetheria).
    nome VARCHAR(60) NOT NULL UNIQUE,

    -- Sem NOT NULL: cidade e' informacao opcional (uma guilda pode
    -- nao ter sede fisica declarada ainda).
    cidade VARCHAR(60)
);

DESCRIBE guilda;
