-- 02 | Associação pelo WHERE (o jeito antigo)
-- Antes: 00a (estrutura) e 00b (dados). Rode bloco a bloco.
USE aetheria_online;

-- Duas tabelas no FROM + a condição que liga a FK à PK no WHERE.
SELECT personagem.nome, guilda.nome
FROM personagem, guilda
WHERE personagem.id_guilda = guilda.id_guilda;      -- 9 linhas

-- Funciona, mas mistura "ligar tabelas" com "filtrar linhas" no mesmo WHERE.
