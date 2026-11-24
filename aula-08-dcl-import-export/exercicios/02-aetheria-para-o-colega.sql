-- ============================================================
-- DINÂMICA EM DUPLAS | Mande o Aetheria para o colega
-- Parte da dupla B (quem IMPORTA). Rode COMO ROOT.
-- ============================================================

-- Antes: a dupla A exportou o aetheria_online pelo Workbench
-- (Server > Data Export > arquivo único, SEM "Include Create Schema")
-- e mandou o .sql para vocês.

-- 1) Crie um banco novo para receber a cópia (nunca importe por cima do seu aetheria_online)
-- TODO: CREATE DATABASE ...

-- 2) Importe pelo Workbench: Server > Data Import > Import from Self-Contained File
--    Default Target Schema: aetheria_copia > Start Import

-- 3) Valide a cópia
-- TODO: liste as tabelas do aetheria_copia

-- TODO: compare COUNT(*) da tabela jogador no aetheria_online e no aetheria_copia
--       (as duas contagens têm que ser iguais)
