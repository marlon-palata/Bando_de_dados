-- 03 | INSERT nas tabelas filhas: o pai entra primeiro
USE aetheria_online;

-- 1) pai
INSERT INTO guilda (nome, cidade) VALUES ('Legião de Ferro', 'Valdoria');

-- 2) filha: aponta para o pai que acabou de entrar
INSERT INTO personagem (nome, level, vida, experiencia, id_jogador, id_guilda)
VALUES ('Kaeldor', 45, 100, 128500, 1, 1);

-- LAST_INSERT_ID(): o id que o AUTO_INCREMENT acabou de gerar
SELECT LAST_INSERT_ID();

-- 3) subclasse: mesmo id do personagem (PK = FK)
INSERT INTO guerreiro (id_personagem, pontos_de_armadura, arma_equipada)
VALUES (LAST_INSERT_ID(), 50, 'Espada de ferro');

SELECT * FROM guerreiro;

-- 4) mais personagens para a turma ter o que consultar depois
INSERT INTO personagem (nome, level, vida, experiencia, id_jogador, id_guilda) VALUES
  ('Sylvara',  62, 100, 245800, 2, 1),
  ('Zephyros', 23,  80,  48200, 2, NULL),
  ('Thorin',   30, 100,  90000, 3, 1),
  ('Lyria',    12,  60,   5400, 3, NULL);

SELECT * FROM personagem;
