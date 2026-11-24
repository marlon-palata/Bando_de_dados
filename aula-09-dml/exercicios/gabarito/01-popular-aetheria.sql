-- GABARITO | Exercício 1
USE aetheria_online;

-- 1
INSERT INTO item (nome, tipo) VALUES
  ('Poção de vida',   'consumível'),
  ('Espada de ferro', 'arma'),
  ('Elmo de bronze',  'armadura');

-- 2
INSERT INTO missao (nome, recompensa_base) VALUES
  ('Caçada ao Dragão',   500.00),
  ('Entrega de Poções',   25.50);

-- 3
INSERT INTO jogador (nome, email) VALUES ('Marlon Rodrigues', 'marlon@pixelforge.com');

-- 4  (LAST_INSERT_ID pega o id gerado no INSERT anterior)
INSERT INTO personagem (nome, level, id_jogador)
VALUES ('Aldric', 20, LAST_INSERT_ID());

-- 5
SELECT * FROM item;
SELECT * FROM missao;

-- 6  ERRO 1452 (foreign key constraint fails): não existe jogador com id 500,
--    e a FK impede o personagem de apontar para um dono inexistente.
INSERT INTO personagem (nome, level, id_jogador) VALUES ('Fantasma', 1, 500);
