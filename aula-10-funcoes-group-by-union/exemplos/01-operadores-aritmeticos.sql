-- 01 | Operadores aritméticos  ( +  -  *  /  % )
-- Antes: 00a (estrutura) e 00b (dados). Rode bloco a bloco.
USE aetheria_online;

-- A conta acontece no RESULTADO. A tabela continua igual.
SELECT nome, level, level + 1 AS proximo_level FROM personagem;

SELECT nome, recompensa_base,
       recompensa_base * 2   AS evento_em_dobro,     -- multiplicação
       recompensa_base / 2   AS dividido_em_dupla    -- divisão
FROM missao;

SELECT nome, experiencia, experiencia % 1000 AS sobra_do_milhar FROM personagem;  -- resto

-- Operador dentro do WHERE: personagens com menos da metade da vida
SELECT nome, vida FROM personagem WHERE vida < 100 / 2;
