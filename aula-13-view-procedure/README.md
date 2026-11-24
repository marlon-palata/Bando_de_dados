# Aula 13 — VIEW e STORED PROCEDURE

**Objetivo:** guardar consultas (VIEW) e rotinas (PROCEDURE) dentro do banco do Aetheria.
Plano de curso: itens 2.14 (VIEW) e 2.15 (STORED PROCEDURE).

## Como rodar
1. MySQL Workbench aberto como **root**.
2. Não tem o banco? Rode `exemplos/00a-estrutura-aetheria.sql`.
3. **Todo mundo:** rode `exemplos/00b-dados-aetheria.sql` (views e procedures não são apagadas por ele).
4. Rode os exemplos bloco a bloco. **Blocos com DELIMITER: selecione do `DELIMITER $$` até o `DELIMITER ;` e rode inteiro.**

## Arquivos
| Arquivo | Conteúdo |
|---|---|
| `Aula13_LiveCoding_Completo.sql` | a aula inteira num arquivo só |
| `exemplos/01-o-problema.sql` | a consulta repetida em vários sistemas |
| `exemplos/02-create-view.sql` | CREATE VIEW vw_ranking |
| `exemplos/03-view-roda-na-hora.sql` | a view reflete as mudanças |
| `exemplos/04-view-de-relatorio.sql` | view com JOIN + GROUP BY |
| `exemplos/05-alterar-listar-apagar-view.sql` | CREATE OR REPLACE, SHOW FULL TABLES, DROP VIEW |
| `exemplos/06-primeira-procedure.sql` | DELIMITER, CREATE PROCEDURE, CALL |
| `exemplos/07-parametro-in.sql` | parâmetro IN |
| `exemplos/08-procedure-que-grava.sql` | INSERT com parâmetros |
| `exemplos/09-parametro-out.sql` | OUT, INTO e @variavel |
| `exemplos/10-if-regra-de-negocio.sql` | IF / ELSE |
| `exemplos/11-procedure-com-transacao.sql` | START TRANSACTION dentro da procedure |
| `exemplos/12-listar-e-apagar-procedures.sql` | SHOW PROCEDURE STATUS, DROP PROCEDURE |
| `exercicios/01-views.sql` | Atividade — Parte 1 (6 TODO) |
| `exercicios/02-procedures.sql` | Atividade — Parte 2 (6 TODO) |
| `exercicios/gabarito/` | respostas (professor) |

## Tópicos cobertos
CREATE VIEW · CREATE OR REPLACE VIEW · DROP VIEW · VIEW e segurança · DELIMITER · CREATE PROCEDURE · IN · OUT · IF · CALL · DROP PROCEDURE.
