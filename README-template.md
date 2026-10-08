# Casa Aurora · Onde o e-commerce está perdendo margem?

<!-- Troque tudo que está entre [colchetes]. Apague os comentários antes de publicar. -->

> Projeto de portfólio com **dados sintéticos** (fictícios), criados para estudo no Portfolio Blueprint da Allevo Tech. A empresa Casa Aurora não existe.

![Dashboard](images/dashboard.png)

**Ferramentas:** Excel · SQL (DuckDB no Google Colab) · [Power BI ou Metabase] · [Python (pandas, matplotlib, SciPy)]

## 1. Problema

<!-- 2–3 linhas. A pergunta de negócio, com suas palavras. -->
Em 2025, a Casa Aurora faturou mais, mas a margem caiu. A diretoria quer saber **[onde está a perda]** e **[o que fazer em 2026]**.

## 2. Dados

<!-- 3–4 linhas. De onde vêm, o que tem, período. -->
- 4 tabelas (clientes, produtos, pedidos, itens) · jan–dez/2025 · [7.868] pedidos
- Base bruta com problemas de qualidade (duplicatas, UF inconsistente, campos em branco) tratada no Excel
- Dicionário de dados: [`data-dictionary.md`](data-dictionary.md)

## 3. Análise

<!-- 1 linha por etapa: o que você fez, não o que a ferramenta é. -->
| Etapa | O que eu fiz |
|---|---|
| Excel | [Limpei 4 tipos de problema e resumi faturamento e margem por mês e categoria] |
| SQL | [Respondi 8 perguntas de negócio com JOIN, CTE e funções de janela] → [`notebooks/01_sql_duckdb.ipynb`](notebooks/01_sql_duckdb.ipynb) |
| Dashboard | [Montei um painel de vendas e margem em Power BI/Metabase] |
| Python | [Testei se o prazo de entrega afeta a nota (correlação de Spearman)] → [`notebooks/02_python_analysis.ipynb`](notebooks/02_python_analysis.ipynb) |

## 4. Insights

<!-- 3 bullets. Formato: achado → número que prova. -->
- **[Achado 1]:** [número]
- **[Achado 2]:** [número]
- **[Achado 3]:** [número]

## 5. Resultado e recomendações

<!-- 3 recomendações acionáveis + uma limitação honesta da análise. -->
1. [Recomendação 1, ligada ao achado 1]
2. [Recomendação 2]
3. [Recomendação 3]

**Limitações:** [ex.: dados de um único ano; a simulação de cupom supõe o mesmo volume de pedidos.]

## Como reproduzir

- Notebooks no Google Colab (não precisa instalar nada):
  [SQL](https://colab.research.google.com/github/[SEU-USUARIO]/casa-aurora-analise/blob/main/notebooks/01_sql_duckdb.ipynb) ·
  [Python](https://colab.research.google.com/github/[SEU-USUARIO]/casa-aurora-analise/blob/main/notebooks/02_python_analysis.ipynb)
- Metabase (opcional): veja `docker-compose.yml`. Copie `.env.example` para `.env` e rode `docker compose up -d`.

---
[Seu nome] · [LinkedIn] · Feito no Portfolio Blueprint · Allevo Tech
