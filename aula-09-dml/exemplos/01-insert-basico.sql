-- 01 | INSERT — colocando dados no Aetheria
USE aetheria_online;

-- uma linha: colunas entre parênteses, valores na MESMA ordem
INSERT INTO jogador (nome, email) VALUES ('Rafael Silva', 'rafael@pixelforge.com');

-- id_jogador não aparece: é AUTO_INCREMENT, o MySQL preenche
SELECT * FROM jogador;

-- várias linhas de uma vez: um VALUES, vários parênteses separados por vírgula
INSERT INTO jogador (nome, email) VALUES
  ('Ayla Costa',  'ayla@pixelforge.com'),
  ('Bruno Lima',  'bruno@pixelforge.com'),
  ('Carla Souza', 'carla@pixelforge.com');

SELECT * FROM jogador;
