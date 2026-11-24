-- =====================================================================
-- EXERCÍCIO 2 | TRIGGER e EVENT  (Aula 14)
-- Rode o 00b ANTES. Escreva embaixo de cada TODO.
-- Prefixos tg_ e ev_. Comece com DROP ... IF EXISTS e use DELIMITER.
-- =====================================================================
USE aetheria_online;

-- Tabela EXTRA (fora do diagrama) para o TODO 1 — só rode:
CREATE TABLE IF NOT EXISTS auditoria_jogador (
    id_auditoria INT PRIMARY KEY AUTO_INCREMENT,
    acao         VARCHAR(30) NOT NULL,
    nome_jogador VARCHAR(80) NOT NULL,
    data_acao    DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- TODO 1: crie tg_auditoria_jogador que, DEPOIS de cada INSERT em jogador,
--         grava na auditoria_jogador a ação 'novo jogador' e o nome.
--         Teste cadastrando a jogadora 'Lara Teles' (lara@pixelforge.com)
--         e mostre a auditoria.


-- TODO 2: crie tg_missao_sem_negativo que, ANTES de cada INSERT em missao,
--         troca recompensa_base negativa por 0.
--         Teste inserindo 'Missão bugada' com recompensa -100. Quanto ficou?


-- TODO 3: liste os triggers do banco. Quais tabelas têm trigger?


-- TODO 4: crie o evento ev_evento_de_fim_de_semana que roda UMA vez,
--         daqui a 1 minuto, e insere a missão 'Invasão de goblins' com
--         recompensa 600. Espere 1 minuto e confira na tabela missao.


-- TODO 5: crie o evento ev_desgaste que, a cada 1 minuto, tira 5 da
--         durabilidade_atual de tudo que está acima de 5 na tabela equipamento.
--         Confira depois de 1 minuto, PAUSE o evento (sem apagar) e liste os eventos.
--         No fim, APAGUE o ev_desgaste.


-- TODO 6 (desafio): crie tg_item_em_uso que, ANTES de apagar um item, verifica
--         se ele está equipado por alguém. Se estiver, barra com SIGNAL e a
--         mensagem 'Item em uso: não pode ser apagado'.
--         Teste apagando o item 1 (em uso) e o item 8 (Anel do dragão, livre).
