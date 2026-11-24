-- 03 | A VIEW não guarda dados: ela roda a consulta na hora
-- Antes: 00b (dados padrão). Rode bloco a bloco; blocos com DELIMITER rodam inteiros.
USE aetheria_online;

UPDATE personagem SET level = 70 WHERE id_personagem = 5;   -- Lyria treinou muito
SELECT * FROM vw_ranking ORDER BY level DESC LIMIT 3;       -- Lyria já está no topo
UPDATE personagem SET level = 12 WHERE id_personagem = 5;   -- volta ao normal

-- Criar de novo com o mesmo nome dá erro:
-- CREATE VIEW vw_ranking AS SELECT nome FROM personagem;
-- ERRO ESPERADO 1050: Table 'vw_ranking' already exists
