-- ============================================================
-- 06 - CREATE INDEX / DROP INDEX - acelerando buscas
-- ============================================================
-- Indice = atalho de busca. So compensa em colunas MUITO
-- consultadas (WHERE, ORDER BY frequentes) - cada indice ocupa
-- espaco e deixa INSERT/UPDATE um pouco mais lento.
USE aetheria_online;

-- Cenario: o time percebeu que buscas por nome de personagem
-- estao lentas (ex.: tela de ranking, busca de jogador).
CREATE INDEX idx_personagem_nome ON personagem(nome);

-- Pra remover o indice se ele deixar de ser necessario:
-- DROP INDEX idx_personagem_nome ON personagem;

-- Conferindo os indices existentes na tabela:
SHOW INDEX FROM personagem;
