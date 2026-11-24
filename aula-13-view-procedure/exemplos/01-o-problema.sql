-- 01 | O problema: a mesma consulta grande toda hora
-- Antes: 00b (dados padrão). Rode bloco a bloco; blocos com DELIMITER rodam inteiros.
USE aetheria_online;

-- O site, o app e o painel do suporte precisam deste ranking:
SELECT p.nome AS personagem, p.level, j.nome AS jogador, g.nome AS guilda
FROM personagem p
INNER JOIN jogador j ON p.id_jogador = j.id_jogador
LEFT  JOIN guilda  g ON p.id_guilda  = g.id_guilda
ORDER BY p.level DESC;
-- Copiar e colar em três sistemas = três lugares para errar.
