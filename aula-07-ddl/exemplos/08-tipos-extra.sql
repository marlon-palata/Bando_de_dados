-- ============================================================
-- 08 - TIPOS EXTRA (DECIMAL) + DROP TABLE - completando o slide
-- ============================================================
-- O slide de "CREATE TABLE - tipos de dado" cita DECIMAL(10,2)
-- como tipo pra casas decimais, mas nenhuma tabela anterior
-- usava esse tipo. Aqui a gente fecha esse buraco com um caso
-- real do Aetheria: a missao tem uma recompensa em moedas, que
-- pode ter centavos -> INT nao serve, precisa de DECIMAL.
USE aetheria_online;

CREATE TABLE missao (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(80) NOT NULL,

    -- DECIMAL(10,2) = ate 10 digitos no total, sendo 2 depois da
    -- virgula. Diferente de FLOAT/DOUBLE, o DECIMAL nao tem erro
    -- de arredondamento - por isso e' o tipo certo pra dinheiro/
    -- moeda do jogo, nunca use FLOAT pra valores monetarios.
    recompensa_base DECIMAL(10,2) NOT NULL DEFAULT 0.00
);

DESCRIBE missao;

-- ------------------------------------------------------------
-- DROP TABLE - o slide mostra "DROP TABLE personagem;" mas
-- nenhum arquivo chegava a executar um DROP TABLE de verdade.
-- Pra demonstrar sem arriscar as tabelas reais da aula, criamos
-- uma tabela descartavel so pra apagar em seguida:
-- ------------------------------------------------------------
CREATE TABLE teste_temp (
    id INT PRIMARY KEY AUTO_INCREMENT,
    observacao VARCHAR(50)
);

-- Confirma que a tabela existe antes de apagar:
SHOW TABLES LIKE 'teste_temp';

-- DROP TABLE apaga a ESTRUTURA + TODOS OS DADOS da tabela, sem
-- pedir confirmacao e sem volta (diferente do DROP DATABASE, que
-- apaga o banco inteiro, o DROP TABLE apaga so uma tabela).
DROP TABLE teste_temp;

-- Confirma que sumiu:
SHOW TABLES LIKE 'teste_temp';
