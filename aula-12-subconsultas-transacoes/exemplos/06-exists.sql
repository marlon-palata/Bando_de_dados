-- 06 | EXISTS: existe pelo menos uma linha?
-- Antes: 00b (dados padrão). Rode bloco a bloco.
USE aetheria_online;

-- Jogadores que TÊM conta premium
SELECT j.nome
FROM jogador j
WHERE EXISTS (SELECT 1 FROM conta_premium c
              WHERE c.id_jogador = j.id_jogador);              -- Rafael, Ayla, Diego

-- NOT EXISTS: guildas sem membros (aqui o NULL não atrapalha)
SELECT g.nome
FROM guilda g
WHERE NOT EXISTS (SELECT 1 FROM personagem p
                  WHERE p.id_guilda = g.id_guilda);             -- Clã dos Ventos

-- A subconsulta usa "j" e "g" de fora: ela roda uma vez para CADA linha de fora.
