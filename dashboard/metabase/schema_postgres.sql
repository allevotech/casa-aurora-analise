-- Carrega os CSVs limpos da Casa Aurora num PostgreSQL (base do dashboard no Metabase).
-- Aqui as datas viram DATE de verdade: dashboards precisam de eixo de tempo.
CREATE TABLE customers (
  customer_id TEXT PRIMARY KEY, signup_date DATE, state CHAR(2), region TEXT,
  acquisition_channel TEXT, age_band TEXT
);
CREATE TABLE products (
  product_id TEXT PRIMARY KEY, product_name TEXT, category TEXT, unit_cost NUMERIC(10,2)
);
CREATE TABLE orders (
  order_id TEXT PRIMARY KEY, customer_id TEXT REFERENCES customers, order_date DATE,
  channel TEXT, payment_method TEXT, coupon_code TEXT, shipping_cost NUMERIC(10,2),
  delivery_days INT, status TEXT, review_score INT
);
CREATE TABLE order_items (
  order_id TEXT REFERENCES orders, product_id TEXT REFERENCES products,
  quantity INT, unit_price NUMERIC(10,2), discount NUMERIC(10,2)
);
\copy customers   FROM '/data/customers.csv'   WITH (FORMAT csv, HEADER true)
\copy products    FROM '/data/products.csv'    WITH (FORMAT csv, HEADER true)
\copy orders      FROM '/data/orders.csv'      WITH (FORMAT csv, HEADER true)
\copy order_items FROM '/data/order_items.csv' WITH (FORMAT csv, HEADER true)

-- Visão de vendas: uma linha por item, com receita e custo já calculados.
CREATE VIEW sales AS
SELECT o.order_id, o.order_date, o.channel, o.payment_method,
       COALESCE(o.coupon_code, 'SEM CUPOM') AS coupon, o.status, o.delivery_days, o.review_score,
       c.customer_id, c.state, c.region, p.category, p.product_name,
       i.quantity, i.quantity * i.unit_price - i.discount AS revenue, i.quantity * p.unit_cost AS cost
FROM order_items i
JOIN orders o    ON o.order_id = i.order_id
JOIN products p  ON p.product_id = i.product_id
JOIN customers c ON c.customer_id = o.customer_id;
