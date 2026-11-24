-- 03 | IN: a subconsulta devolve uma LISTA
-- Antes: 00b (dados padrão). Rode bloco a bloco.
USE aetheria_online;

-- Quem concluiu a missão 2 (Caçada ao dragão)?
SELECT nome
FROM personagem
WHERE id_personagem IN (SELECT id_personagem
                        FROM progresso
                        WHERE id_missao = 2 AND data_conclusao IS NOT NULL);
-- Kaeldor, Sylvara, Nyx

-- Subconsulta dentro de subconsulta: pela missão pelo NOME
SELECT nome
FROM personagem
WHERE id_personagem IN (SELECT id_personagem FROM progresso
                        WHERE data_conclusao IS NOT NULL
                          AND id_missao = (SELECT id_missao FROM missao
                                           WHERE nome = 'Caçada ao dragão'));

-- Se a subconsulta devolver mais de um valor e você usar "=" em vez de IN:
-- SELECT nome FROM personagem WHERE id_personagem = (SELECT id_personagem FROM progresso);
-- ERRO ESPERADO 1242: Subquery returns more than 1 row
