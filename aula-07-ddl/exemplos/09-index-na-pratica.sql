-- 09 - INDEX + SELECT básico (rodar depois do DDL completo)
USE aetheria_online;

-- 1) 10 jogadores
INSERT INTO jogador (nome, email) VALUES
('Rafael Silva',  'rafael@pixelforge.com'),
('Ayla Costa',    'ayla@pixelforge.com'),
('Bruno Lima',    'bruno@pixelforge.com'),
('Carla Souza',   'carla@pixelforge.com'),
('Diego Alves',   'diego@pixelforge.com'),
('Elisa Ramos',   'elisa@pixelforge.com'),
('Fabio Neves',   'fabio@pixelforge.com'),
('Gabi Torres',   'gabi@pixelforge.com'),
('Hugo Pires',    'hugo@pixelforge.com'),
('Iara Matos',    'iara@pixelforge.com');

-- 2) 10 personagens (id_jogador = dono)
INSERT INTO personagem (nome, level, experiencia, id_jogador) VALUES
('Kaeldor',  45, 128500, 1),
('Sylvara',  62, 245800, 2),
('Zephyros', 23,  48200, 3),
('Thorin',   30,  90000, 4),
('Lyria',    12,   5400, 5),
('Gorak',    78, 301000, 6),
('Elowen',   50, 150000, 7),
('Draven',   33,  70000, 8),
('Mira',      8,   1200, 9),
('Aldric',   45, 120000, 10);

-- 3) SELECT: ver os dados
SELECT * FROM personagem;

-- 4) SELECT com filtro (WHERE)
SELECT * FROM personagem WHERE nome = 'Kaeldor';

-- 5) EXPLAIN SEM índice (experiencia ainda não tem índice)
--    olhe: type = ALL (lê tudo) e cost = custo estimado
EXPLAIN FORMAT=TREE SELECT * FROM personagem WHERE experiencia = 128500;
SELECT * FROM personagem WHERE experiencia = 128500;

-- 6) criar o índice
CREATE INDEX idx_personagem_experiencia ON personagem(experiencia);
SHOW INDEX FROM personagem;

-- 7) EXPLAIN COM índice: a mesma consulta
--    olhe: "Index lookup" e cost menor
EXPLAIN FORMAT=TREE SELECT * FROM personagem WHERE experiencia = 128500;
SELECT * FROM personagem WHERE experiencia = 128500;
