-- 02 | CREATE VIEW: guardar a consulta com um nome
-- Antes: 00b (dados padrão). Rode bloco a bloco; blocos com DELIMITER rodam inteiros.
USE aetheria_online;
DROP VIEW IF EXISTS vw_ranking;   -- permite rodar de novo

CREATE VIEW vw_ranking AS
SELECT p.nome AS personagem, p.level, j.nome AS jogador, g.nome AS guilda
FROM personagem p
INNER JOIN jogador j ON p.id_jogador = j.id_jogador
LEFT  JOIN guilda  g ON p.id_guilda  = g.id_guilda;

-- Agora usa-se como se fosse uma tabela:
SELECT * FROM vw_ranking ORDER BY level DESC;
SELECT * FROM vw_ranking WHERE guilda = 'Ordem Arcana';
SELECT personagem, level FROM vw_ranking ORDER BY level DESC LIMIT 3;
