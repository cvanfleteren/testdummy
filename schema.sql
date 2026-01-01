CREATE TABLE customers (
    id          BIGSERIAL PRIMARY KEY,
    email       TEXT NOT NULL UNIQUE,
    name        TEXT NOT NULL,
    created_at  TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE orders (
    id           BIGSERIAL PRIMARY KEY,
    customer_id  BIGINT NOT NULL REFERENCES customers (id),
    total_cents  INTEGER NOT NULL CHECK (total_cents >= 0),
    status       TEXT NOT NULL DEFAULT 'pending',
    placed_at    TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX orders_customer_idx ON orders (customer_id);

SELECT c.name, count(o.id) AS order_count, sum(o.total_cents) / 100.0 AS total
FROM customers c
LEFT JOIN orders o ON o.customer_id = c.id
GROUP BY c.name
ORDER BY total DESC NULLS LAST;
