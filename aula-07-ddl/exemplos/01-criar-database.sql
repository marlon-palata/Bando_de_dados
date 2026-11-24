-- ============================================================
-- 01 - CRIANDO O BANCO DE DADOS DO AETHERIA
-- ============================================================
-- Aqui a gente sai do desenho (MER normalizado) e cria o banco
-- de dados de verdade dentro do MySQL.

-- IF NOT EXISTS evita erro caso o banco ja exista (idempotente:
-- pode rodar esse script varias vezes sem quebrar).
CREATE DATABASE IF NOT EXISTS aetheria_online;

-- USE diz ao MySQL: "a partir de agora, todo comando que eu rodar
-- e' dentro desse banco". Sem isso, cada CREATE TABLE precisaria
-- ser escrito como aetheria_online.jogador, aetheria_online.personagem...
USE aetheria_online;

-- Se precisar recomecar do zero durante a aula, descomente a linha
-- abaixo. CUIDADO: DROP DATABASE apaga TUDO (todas as tabelas e
-- dados) sem confirmacao e sem volta.
-- DROP DATABASE aetheria_online;
