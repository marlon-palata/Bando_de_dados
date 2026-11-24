-- 00b | Dados prontos do Aetheria (usados nas aulas 10 a 14)
-- Rode DEPOIS do 00a. Ele APAGA os dados que você tinha e coloca um conjunto padrão,
-- para todo mundo ter os mesmos resultados que o professor.
USE aetheria_online;
SET NAMES utf8mb4;   -- garante os acentos (ç, ã, é) certos

-- Limpa tudo (filha antes do pai) e zera os contadores.
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE denuncia;  TRUNCATE troca;     TRUNCATE progresso; TRUNCATE equipamento;
TRUNCATE guerreiro; TRUNCATE mago;      TRUNCATE arqueiro;  TRUNCATE personagem;
TRUNCATE conta_premium; TRUNCATE jogador; TRUNCATE guilda;  TRUNCATE missao;
TRUNCATE item;      TRUNCATE moderador;
SET FOREIGN_KEY_CHECKS = 1;

INSERT INTO jogador (nome, email) VALUES
  ('Rafael Silva',   'rafael@pixelforge.com'),    -- 1
  ('Ayla Costa',     'ayla@pixelforge.com'),      -- 2
  ('Bruno Lima',     'bruno@pixelforge.com'),     -- 3
  ('Carla Souza',    'carla@pixelforge.com'),     -- 4
  ('Diego Martins',  'diego@pixelforge.com'),     -- 5
  ('Elisa Rocha',    'elisa@pixelforge.com'),     -- 6
  ('Felipe Nunes',   'felipe@pixelforge.com'),    -- 7
  ('Gabriela Alves', 'gabi@pixelforge.com');      -- 8 (ainda sem personagem)

INSERT INTO conta_premium (data_assinatura, id_jogador) VALUES
  ('2025-03-10', 1), ('2025-11-02', 2), ('2026-06-20', 5);

INSERT INTO guilda (nome, cidade) VALUES
  ('Legião de Ferro',  'Valdoria'),   -- 1
  ('Ordem Arcana',     'Eldmoor'),    -- 2
  ('Sombras do Norte', NULL),         -- 3 (cidade desconhecida)
  ('Clã dos Ventos',   'Portoclaro'); -- 4 (ainda sem membros)

INSERT INTO personagem (nome, level, vida, experiencia, id_jogador, id_guilda) VALUES
  ('Kaeldor',  45, 100, 128500, 1, 1),   -- 1 guerreiro
  ('Sylvara',  62, 100, 245800, 2, 2),   -- 2 mago
  ('Zephyros', 23,  80,  48200, 2, NULL),-- 3 arqueiro
  ('Thorin',   30, 100,  90000, 3, 1),   -- 4 guerreiro
  ('Lyria',    12,  60,   5400, 3, NULL),-- 5 mago
  ('Morgana',  55,  95, 198000, 4, 2),   -- 6 mago
  ('Ragnar',   38,  70, 110300, 5, 1),   -- 7 guerreiro
  ('Elowen',   41, 100, 132000, 5, 3),   -- 8 arqueiro
  ('Dravik',    8,  40,   1200, 6, NULL),-- 9 guerreiro
  ('Nyx',      50,  90, 175500, 6, 3),   -- 10 arqueiro
  ('Aldric',   27, 100,  61000, 7, 2),   -- 11 mago
  ('Brienne',  33,  85,  99000, 7, 1);   -- 12 guerreiro

INSERT INTO guerreiro (id_personagem, pontos_de_armadura, arma_equipada) VALUES
  (1, 50, 'Espada de ferro'), (4, 35, 'Machado anão'), (7, 42, 'Martelo de guerra'),
  (9, 10, 'Adaga'), (12, 38, 'Espada longa');
INSERT INTO mago (id_personagem, pontos_de_mana, grimorio) VALUES
  (2, 900, 'Tomo das Estrelas'), (5, 150, NULL), (6, 720, 'Livro das Sombras'), (11, 300, 'Grimório Verde');
INSERT INTO arqueiro (id_personagem, precisao_a_distancia, flechas_disponiveis) VALUES
  (3, 70, 120), (8, 85, 200), (10, 92, 60);

INSERT INTO item (nome, tipo) VALUES
  ('Espada de ferro',    'arma'),       -- 1
  ('Arco élfico',        'arma'),       -- 2
  ('Cajado de cristal',  'arma'),       -- 3
  ('Elmo de bronze',     'armadura'),   -- 4
  ('Peitoral de aço',    'armadura'),   -- 5
  ('Poção de vida',      'poção'),      -- 6
  ('Poção de mana',      'poção'),      -- 7
  ('Anel do dragão',     'acessório');  -- 8 (ninguém equipou)

INSERT INTO equipamento (id_personagem, id_item, data_equipado, durabilidade_atual) VALUES
  (1, 1, '2026-01-15', 80), (1, 4, '2026-01-15', 95), (1, 6, '2026-03-02', 100),
  (2, 3, '2025-12-01', 60), (2, 7, '2026-02-10', 100),
  (3, 2, '2026-02-20', 75),
  (4, 5, '2026-04-11', 50),
  (6, 3, '2026-05-05', 90), (6, 7, '2026-05-05', 100),
  (7, 1, '2026-06-01', 30), (7, 5, '2026-06-01', 70),
  (8, 2, '2026-03-18', 88),
  (10, 2, '2026-07-22', 95), (10, 6, '2026-07-22', 100);

INSERT INTO missao (nome, recompensa_base) VALUES
  ('Patrulha da vila',     50.00),    -- 1
  ('Caçada ao dragão',   1500.00),    -- 2
  ('Entrega de poções',    25.50),    -- 3
  ('Ruínas de Eldmoor',   400.00),    -- 4
  ('Defesa do castelo',   850.00),    -- 5
  ('Tesouro perdido',    2000.00);    -- 6 (ninguém tentou)

-- data_conclusao NULL = missão em andamento
INSERT INTO progresso (id_personagem, id_missao, data_conclusao, recompensa_recebida) VALUES
  (1, 1, '2026-01-20',   50.00), (1, 2, '2026-04-02', 1500.00), (1, 5, NULL, 0.00),
  (2, 2, '2026-03-15', 1500.00), (2, 4, '2026-05-01',  400.00),
  (3, 1, '2026-02-25',   50.00), (3, 3, '2026-02-26',   25.50),
  (4, 5, '2026-06-30',  850.00),
  (6, 4, '2026-05-20',  400.00), (6, 2, NULL, 0.00),
  (7, 1, '2026-06-05',   50.00), (7, 5, '2026-07-10',  850.00),
  (8, 3, '2026-03-20',   25.50),
  (10, 4, '2026-08-01',  400.00), (10, 2, '2026-09-12', 1500.00),
  (11, 1, '2026-09-30',   50.00);

INSERT INTO moderador (nome) VALUES ('Mod Helena'), ('Mod Otávio');

INSERT INTO troca (data_troca, id_personagem_propoe, id_personagem_recebe) VALUES
  ('2026-02-14 19:30:00', 1, 4),   -- 1
  ('2026-03-01 21:10:00', 2, 6),   -- 2
  ('2026-05-18 18:45:00', 3, 8),   -- 3
  ('2026-07-04 22:05:00', 7, 1),   -- 4
  ('2026-09-09 20:00:00', 10, 3);  -- 5

INSERT INTO denuncia (id_troca, id_moderador, motivo) VALUES
  (4, 1, 'Item duplicado por bug'),
  (5, 2, 'Suspeita de venda por dinheiro real');

-- Conferência rápida: quantas linhas em cada tabela principal
SELECT 'jogador' AS tabela, COUNT(*) AS linhas FROM jogador
UNION ALL SELECT 'guilda',     COUNT(*) FROM guilda
UNION ALL SELECT 'personagem', COUNT(*) FROM personagem
UNION ALL SELECT 'progresso',  COUNT(*) FROM progresso
UNION ALL SELECT 'equipamento', COUNT(*) FROM equipamento;
-- jogador 8 · guilda 4 · personagem 12 · progresso 16 · equipamento 14
