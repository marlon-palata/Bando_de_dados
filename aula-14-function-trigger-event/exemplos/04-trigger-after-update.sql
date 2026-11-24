-- 04 | TRIGGER: o banco reagindo sozinho
-- Antes: 00b (dados padrão). Blocos com DELIMITER rodam inteiros.
USE aetheria_online;
SET NAMES utf8mb4;
DROP TRIGGER IF EXISTS tg_historico_level;   -- permite rodar de novo

-- Tabela EXTRA (fora do diagrama do Aetheria): o histórico de mudanças de level.
CREATE TABLE IF NOT EXISTS historico_level (
    id_historico  INT PRIMARY KEY AUTO_INCREMENT,
    id_personagem INT NOT NULL,
    level_antigo  INT NOT NULL,
    level_novo    INT NOT NULL,
    data_mudanca  DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- AFTER UPDATE: depois de cada UPDATE em personagem, grava o histórico.
-- OLD = a linha ANTES · NEW = a linha DEPOIS
DELIMITER $$
CREATE TRIGGER tg_historico_level
AFTER UPDATE ON personagem
FOR EACH ROW
BEGIN
    IF NEW.level <> OLD.level THEN
        INSERT INTO historico_level (id_personagem, level_antigo, level_novo)
        VALUES (NEW.id_personagem, OLD.level, NEW.level);
    END IF;
END $$
DELIMITER ;

UPDATE personagem SET level = 46 WHERE id_personagem = 1;   -- Kaeldor sobe
UPDATE personagem SET vida = 90 WHERE id_personagem = 1;    -- muda só a vida
SELECT * FROM historico_level;   -- só UMA linha (45 → 46): ninguém escreveu esse INSERT!
