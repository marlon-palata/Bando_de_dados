-- GABARITO | Exercício 1  (rode o 00b antes)
USE aetheria_online;
-- 1  média = 85 → Zephyros 80, Lyria 60, Ragnar 70, Dravik 40
SELECT nome, vida FROM personagem
WHERE vida < (SELECT AVG(vida) FROM personagem);
-- 2  Tesouro perdido
SELECT nome FROM missao
WHERE recompensa_base = (SELECT MAX(recompensa_base) FROM missao);
-- 3  Kaeldor, Sylvara, Morgana, Nyx
SELECT nome FROM personagem
WHERE id_personagem IN (SELECT id_personagem FROM equipamento
                        WHERE id_item IN (SELECT id_item FROM item WHERE tipo = 'poção'));
-- 4  Tesouro perdido
SELECT nome FROM missao
WHERE id_missao NOT IN (SELECT id_missao FROM progresso);
-- 5  Lyria, Dravik, Aldric, Brienne
SELECT nome FROM personagem
WHERE id_personagem NOT IN (SELECT id_personagem_propoe FROM troca)
  AND id_personagem NOT IN (SELECT id_personagem_recebe FROM troca);
-- 6  Sylvara, Morgana, Elowen, Nyx  (maior da guilda 1 = 128500)
SELECT nome, experiencia FROM personagem
WHERE experiencia > ALL (SELECT experiencia FROM personagem WHERE id_guilda = 1);
-- 7  9 personagens (menor arqueiro = level 23)
SELECT nome, level FROM personagem
WHERE level > ANY (SELECT p.level FROM personagem p
                   WHERE p.id_personagem IN (SELECT id_personagem FROM arqueiro));
-- 8  Lyria, Dravik, Brienne
SELECT p.nome FROM personagem p
WHERE NOT EXISTS (SELECT 1 FROM progresso pr
                  WHERE pr.id_personagem = p.id_personagem
                    AND pr.data_conclusao IS NOT NULL);
