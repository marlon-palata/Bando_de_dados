# Aula 10 — Operadores, Funções, GROUP BY e UNION

**Objetivo:** usar o SELECT para calcular, transformar e resumir os dados do Aetheria, sem alterar nenhuma tabela.
Plano de curso: itens 2.7 (operadores), 2.8 (funções), 2.9 (GROUP BY) e 2.10 (UNION).

## Como rodar
1. MySQL Workbench aberto como **root**.
2. Não tem o banco? Rode `exemplos/00a-estrutura-aetheria.sql`.
3. **Todo mundo:** rode `exemplos/00b-dados-aetheria.sql` (apaga os dados antigos e coloca o conjunto padrão).
4. Confira: `SELECT COUNT(*) FROM personagem;` → **12**.
5. Rode os exemplos **bloco a bloco** (selecione + Ctrl+Enter).

## Arquivos
| Arquivo | Conteúdo |
|---|---|
| `Aula10_LiveCoding_Completo.sql` | a aula inteira num arquivo só |
| `exemplos/00a-estrutura-aetheria.sql` | as 14 tabelas |
| `exemplos/00b-dados-aetheria.sql` | dados padrão (usados nas aulas 10 a 14) |
| `exemplos/01-operadores-aritmeticos.sql` | + - * / % |
| `exemplos/02-funcoes-texto.sql` | CONCAT, UPPER, LOWER, CHAR_LENGTH, SUBSTRING, REPLACE, TRIM |
| `exemplos/03-funcoes-matematicas.sql` | ROUND, CEIL, FLOOR, ABS, MOD |
| `exemplos/04-funcoes-data-hora.sql` | NOW, CURDATE, YEAR, MONTH, DATEDIFF, DATE_ADD, DATE_FORMAT |
| `exemplos/05-funcoes-agregacao.sql` | COUNT, SUM, AVG, MAX, MIN |
| `exemplos/06-group-by.sql` | GROUP BY |
| `exemplos/07-having.sql` | HAVING e a ordem das cláusulas |
| `exemplos/08-union.sql` | UNION e UNION ALL |
| `exercicios/01-funcoes-e-operadores.sql` | Atividade — Parte 1 (7 TODO) |
| `exercicios/02-relatorios-agrupados.sql` | Atividade — Parte 2 (8 TODO) |
| `exercicios/gabarito/` | respostas (professor) |

## Tópicos cobertos
Operadores aritméticos · funções de texto, matemáticas, data e hora, agregação · GROUP BY · HAVING · UNION / UNION ALL.
