# Dicionário de dados · Casa Aurora

Período: 01/01/2025 a 31/12/2025 · Dados **sintéticos** (fictícios) para estudo.

## Arquivos

| Arquivo | Para quê | Linhas |
|---|---|---|
| `data/raw/casa_aurora_raw.xlsx` | Etapa 1 (Excel): aba `pedidos` = "export do sistema", **com sujeira de propósito**; aba `uf_referencia` = de-para nome do estado → sigla | 19.651 |
| `data/clean/customers.csv` | Etapas 2 a 4: clientes | 5.000 |
| `data/clean/products.csv` | Etapas 2 a 4: catálogo | 120 |
| `data/clean/orders.csv` | Etapas 2 a 4: pedidos | 7.868 |
| `data/clean/order_items.csv` | Etapas 2 a 4: itens de cada pedido | 19.554 |

Os CSVs usam vírgula como separador e ponto como decimal (padrão internacional). No Excel em português, **não dê dois cliques no CSV**: use *Dados > Obter dados > De texto/CSV* e, no Power Query, em cada coluna de número, *Alterar tipo > Usando a localidade… > Decimal / Inglês (Estados Unidos)*. Sem isso, `51.9` vira `519`. Pelo Google Sheets (*Arquivo > Importar*) o problema não acontece.

## Tabelas

### `orders` — um pedido por linha
| Coluna | Tipo | Significado |
|---|---|---|
| `order_id` | texto | Código do pedido (A00001…) |
| `customer_id` | texto | Quem comprou → `customers` |
| `order_date` | data (AAAA-MM-DD) | Dia do pedido |
| `channel` | texto | `site`, `app` ou `marketplace` |
| `payment_method` | texto | `pix`, `credit_card` ou `boleto` |
| `coupon_code` | texto | `AURORA20`, `BEMVINDO10`, `FRETEGRATIS` ou vazio (sem cupom) |
| `shipping_cost` | número (R$) | Frete pago pelo cliente (não entra na receita) |
| `delivery_days` | inteiro | Dias até a entrega · vazio se cancelado |
| `status` | texto | `delivered` (entregue), `canceled` (cancelado) ou `returned` (devolvido) |
| `review_score` | inteiro 1–5 | Nota do cliente · só em pedidos entregues e nem todo mundo avalia |

### `order_items` — um produto de um pedido por linha
| Coluna | Tipo | Significado |
|---|---|---|
| `order_id` | texto | → `orders` |
| `product_id` | texto | → `products` |
| `quantity` | inteiro | Unidades |
| `unit_price` | número (R$) | Preço de tabela unitário |
| `discount` | número (R$) | Desconto total da linha (promoção + cupom) |

### `products`
| Coluna | Significado |
|---|---|
| `product_id` | Código (P001…) |
| `product_name` | Nome |
| `category` | `Cozinha`, `Decoração`, `Cama, Mesa e Banho`, `Organização`, `Iluminação` |
| `unit_cost` | Custo unitário (R$) |

### `customers`
| Coluna | Significado |
|---|---|
| `customer_id` | Código (C00001…) |
| `signup_date` | Data de cadastro |
| `state` / `region` | UF e região |
| `acquisition_channel` | Como o cliente chegou: `organic_search` (busca orgânica), `paid_social` (redes sociais pagas), `google_ads`, `email`, `referral` (indicação) |
| `age_band` | Faixa etária |

## Regras de negócio (use em todas as etapas)

- **Faturamento** = soma da receita dos pedidos com `status = delivered`.
- **Receita do item** = `quantity × unit_price − discount`.
- **Custo do item** = `quantity × unit_cost`.
- **Margem bruta %** = (receita − custo) ÷ receita.
- **Ticket médio** = faturamento ÷ número de pedidos entregues.
- **Recompra** = cliente com 2 ou mais pedidos no ano, contando pedidos de **qualquer status**.
- **Retorno em 60 dias** (só na etapa 4) = cliente cujo 2º pedido veio até 60 dias depois do 1º. É outra métrica: não compare com a recompra.

## Como as tabelas se ligam

```
customers 1 ──< orders 1 ──< order_items >── 1 products
```
