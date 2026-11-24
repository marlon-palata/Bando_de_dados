# Aula 12 — Subconsultas e Transações (TCL)

**Objetivo:** escrever consultas que dependem de outras consultas e agrupar comandos em transações "tudo ou nada".
Plano de curso: itens 2.12 (IN/NOT IN, ALL/ANY, EXISTS) e 2.13 (COMMIT, ROLLBACK, SAVEPOINT).

## Como rodar
1. MySQL Workbench aberto como **root**.
2. Não tem o banco? Rode `exemplos/00a-estrutura-aetheria.sql`.
3. **Todo mundo:** rode `exemplos/00b-dados-aetheria.sql`.
4. Rode os exemplos **bloco a bloco**.
5. Os exemplos 08 e 09 **alteram dados**: rode o 00b de novo antes dos exercícios.

## Arquivos
| Arquivo | Conteúdo |
|---|---|
| `Aula12_LiveCoding_Completo.sql` | a aula inteira num arquivo só |
| `exemplos/01-o-problema.sql` | calcular e copiar o número na mão |
| `exemplos/02-subconsulta-escalar.sql` | um valor (AVG, MAX) no WHERE e no SELECT |
| `exemplos/03-in.sql` | lista com IN, subconsulta dentro de subconsulta, erro 1242 |
| `exemplos/04-not-in-e-a-armadilha-do-null.sql` | NOT IN e o NULL |
| `exemplos/05-any-e-all.sql` | > ANY e > ALL |
| `exemplos/06-exists.sql` | EXISTS e NOT EXISTS |
| `exemplos/07-transacao-rollback.sql` | autocommit, START TRANSACTION, ROLLBACK |
| `exemplos/08-commit-tudo-ou-nada.sql` | troca de item com COMMIT |
| `exemplos/09-savepoint.sql` | SAVEPOINT e ROLLBACK TO SAVEPOINT |
| `exemplos/10-cuidados.sql` | DDL e transações |
| `exercicios/01-subconsultas.sql` | Atividade — Parte 1 (8 TODO) |
| `exercicios/02-transacoes.sql` | Atividade — Parte 2 (5 TODO) |
| `exercicios/gabarito/` | respostas (professor) |

## Tópicos cobertos
Subconsulta escalar · IN / NOT IN (armadilha do NULL) · ANY / ALL · EXISTS / NOT EXISTS · START TRANSACTION · COMMIT · ROLLBACK · SAVEPOINT.
