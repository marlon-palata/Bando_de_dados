-- ============================================================
-- 02 - TABELA JOGADOR (tabela "pai" - sem FK, criada primeiro)
-- ============================================================
USE aetheria_online;

CREATE TABLE jogador (
    -- PRIMARY KEY = identifica cada linha de forma unica.
    -- AUTO_INCREMENT = o MySQL gera o proximo numero sozinho
    -- (1, 2, 3...). Nunca insira o id na mao quando ele e' AI.
    id INT PRIMARY KEY AUTO_INCREMENT,

    -- NOT NULL = campo obrigatorio, o MySQL recusa linha sem nome.
    nome VARCHAR(80) NOT NULL,

    -- NOT NULL + UNIQUE = obrigatorio E nao pode repetir. Impede
    -- dois jogadores cadastrados com o mesmo email.
    email VARCHAR(120) NOT NULL UNIQUE,

    -- DEFAULT CURRENT_TIMESTAMP = se ninguem informar a data, o
    -- MySQL preenche sozinho com a data/hora do momento do INSERT.
    data_criacao DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Conferindo a estrutura criada (equivalente a olhar a tabela no
-- painel Schemas do Workbench):
DESCRIBE jogador;
