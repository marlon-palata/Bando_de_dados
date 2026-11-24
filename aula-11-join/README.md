# Aula 11 — JOIN: associação de tabelas

**Objetivo:** consultar várias tabelas do Aetheria ao mesmo tempo, usando as FOREIGN KEY para ligá-las.
Plano de curso: item 2.11 (WHERE, CROSS JOIN, INNER JOIN, OUTER JOIN, LEFT, RIGHT).

## Como rodar
1. MySQL Workbench aberto como **root**.
2. Não tem o banco? Rode `exemplos/00a-estrutura-aetheria.sql`.
3. **Todo mundo:** rode `exemplos/00b-dados-aetheria.sql` (versão desta aula, com 4 guildas).
4. Confira: 12 personagens e 4 guildas.
5. Rode os exemplos **bloco a bloco**.

## Arquivos
| Arquivo | Conteúdo |
|---|---|
| `Aula11_LiveCoding_Completo.sql` | a aula inteira num arquivo só |
| `exemplos/01-o-problema.sql` | só aparece o número da FK |
| `exemplos/02-associacao-pelo-where.sql` | FROM a, b WHERE a.fk = b.pk |
| `exemplos/03-cross-join.sql` | produto cartesiano |
| `exemplos/04-inner-join.sql` | INNER JOIN ... ON e apelidos |
| `exemplos/05-inner-join-varias-tabelas.sql` | 3 tabelas, tabela associativa, ON × WHERE |
| `exemplos/06-left-join.sql` | LEFT JOIN e LEFT JOIN + IS NULL |
| `exemplos/07-right-join.sql` | RIGHT JOIN |
| `exemplos/08-outer-join-completo.sql` | LEFT UNION RIGHT |
| `exemplos/09-mesma-tabela-duas-vezes.sql` | troca: quem propõe × quem recebe |
| `exemplos/10-join-com-group-by.sql` | relatórios com nomes |
| `exercicios/01-joins-internos.sql` | Atividade — Parte 1 (7 TODO) |
| `exercicios/02-joins-externos.sql` | Atividade — Parte 2 (8 TODO) |
| `exercicios/gabarito/` | respostas (professor) |

## Tópicos cobertos
Associação pelo WHERE · CROSS JOIN · INNER JOIN · LEFT/RIGHT (OUTER) JOIN · OUTER completo com UNION · alias · JOIN + GROUP BY.
