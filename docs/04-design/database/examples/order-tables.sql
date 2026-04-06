-- ============================================================
-- Один объект Order → 4 таблицы
-- ============================================================
--
--  ┌────────────┐       ┌────────────┐
--  │ customers  │──────▶│   orders    │
--  └────────────┘       └─────┬──────┘
--                             │
--                  ┌──────────┴──────────┐
--                  ▼                     ▼
--          ┌──────────────┐      ┌────────────┐
--          │ order_items   │      │  payments   │
--          └──────────────┘      └────────────┘
--

-- 1. customers ← order.customer
CREATE TABLE customers (
    id    INTEGER      PRIMARY KEY,
    name  VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    phone VARCHAR(20)
);

INSERT INTO customers (id, name, email, phone)
VALUES (1023, 'Алексей Петров', 'a.petrov@example.com', '+79161234567');


-- 2. orders ← корневые поля + order.meta
CREATE TABLE orders (
    order_id    VARCHAR(20)  PRIMARY KEY,
    customer_id INTEGER      NOT NULL REFERENCES customers(id),
    created_at  TIMESTAMPTZ  NOT NULL,
    status      VARCHAR(20)  NOT NULL,
    is_paid     BOOLEAN      NOT NULL DEFAULT FALSE,
    comment     TEXT,
    source      VARCHAR(20),
    ip          VARCHAR(45),
    tags        TEXT[]
);

INSERT INTO orders (order_id, customer_id, created_at, status, is_paid, comment, source, ip, tags)
VALUES (
    'ORD-2026-0042', 1023,
    '2026-03-05T14:32:07+03:00', 'shipped', TRUE, NULL,
    'web', '192.168.1.100',
    ARRAY['электроника', 'промо', 'повторный_клиент']
);


-- 3. order_items ← order.items[]
CREATE TABLE order_items (
    id         SERIAL       PRIMARY KEY,
    order_id   VARCHAR(20)  NOT NULL REFERENCES orders(order_id),
    product_id VARCHAR(20)  NOT NULL,
    name       VARCHAR(255) NOT NULL,
    quantity   INTEGER      NOT NULL,
    price      NUMERIC(10,2) NOT NULL,
    in_stock   BOOLEAN      NOT NULL DEFAULT TRUE
);

INSERT INTO order_items (order_id, product_id, name, quantity, price, in_stock)
VALUES
    ('ORD-2026-0042', 'SKU-1001', 'Наушники Sony WH-1000XM5', 1, 32990.00, TRUE),
    ('ORD-2026-0042', 'SKU-2045', 'Чехол для наушников',       2,  1500.00, TRUE),
    ('ORD-2026-0042', 'SKU-3378', 'Кабель USB-C 2м',           1,   690.00, FALSE);


-- 4. payments ← order.payment
CREATE TABLE payments (
    id        SERIAL       PRIMARY KEY,
    order_id  VARCHAR(20)  NOT NULL REFERENCES orders(order_id),
    method    VARCHAR(20)  NOT NULL,
    total     NUMERIC(10,2) NOT NULL,
    currency  CHAR(3)      NOT NULL DEFAULT 'RUB',
    paid_at   TIMESTAMPTZ
);

INSERT INTO payments (order_id, method, total, currency, paid_at)
VALUES ('ORD-2026-0042', 'card', 36680.00, 'RUB', '2026-03-05T14:33:12+03:00');


-- Собрать заказ целиком:
SELECT o.order_id, o.status, c.name, oi.name AS product, oi.quantity, oi.price, p.total
FROM orders o
JOIN customers c ON o.customer_id = c.id
JOIN order_items oi ON oi.order_id = o.order_id
JOIN payments p ON p.order_id = o.order_id
WHERE o.order_id = 'ORD-2026-0042';
