-- ============================================================
-- PostgreSQL схема для e-commerce (Order domain)
-- ============================================================
--
--  ┌────────────┐       ┌────────────┐
--  │ customers  │──1:N─▶│   orders    │
--  └────────────┘       └─────┬──────┘
--                             │
--                  ┌─────1:N──┴──1:1──┐
--                  ▼                  ▼
--          ┌──────────────┐   ┌────────────┐
--          │ order_items   │   │  payments   │
--          └──────────────┘   └────────────┘


-- ============================================================
-- customers
-- ============================================================
CREATE TABLE customers (
    id         SERIAL        PRIMARY KEY,
    name       VARCHAR(100)  NOT NULL,
    email      VARCHAR(255)  NOT NULL UNIQUE,
    phone      VARCHAR(20),
    created_at TIMESTAMPTZ   NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_customers_email ON customers (email);


-- ============================================================
-- orders
-- ============================================================
CREATE TABLE orders (
    order_id    VARCHAR(20)   PRIMARY KEY,
    customer_id INTEGER       NOT NULL REFERENCES customers(id),
    status      VARCHAR(20)   NOT NULL DEFAULT 'created'
                              CHECK (status IN ('created','paid','processing','shipped','delivered','cancelled')),
    is_paid     BOOLEAN       NOT NULL DEFAULT FALSE,
    comment     TEXT,

    -- meta
    source      VARCHAR(20),
    ip          VARCHAR(45),
    tags        TEXT[],

    created_at  TIMESTAMPTZ   NOT NULL DEFAULT NOW(),
    updated_at  TIMESTAMPTZ   NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_orders_customer  ON orders (customer_id);
CREATE INDEX idx_orders_status    ON orders (status);
CREATE INDEX idx_orders_created   ON orders (created_at);


-- ============================================================
-- order_items
-- ============================================================
CREATE TABLE order_items (
    id          SERIAL        PRIMARY KEY,
    order_id    VARCHAR(20)   NOT NULL REFERENCES orders(order_id) ON DELETE CASCADE,
    product_id  VARCHAR(20)   NOT NULL,
    name        VARCHAR(255)  NOT NULL,
    quantity    INTEGER       NOT NULL CHECK (quantity > 0),
    price       NUMERIC(10,2) NOT NULL CHECK (price >= 0),
    in_stock    BOOLEAN       NOT NULL DEFAULT TRUE
);

CREATE INDEX idx_order_items_order ON order_items (order_id);


-- ============================================================
-- payments
-- ============================================================
CREATE TABLE payments (
    id        SERIAL        PRIMARY KEY,
    order_id  VARCHAR(20)   NOT NULL REFERENCES orders(order_id) ON DELETE CASCADE,
    method    VARCHAR(20)   NOT NULL CHECK (method IN ('card','cash','sbp','wallet')),
    total     NUMERIC(10,2) NOT NULL CHECK (total > 0),
    currency  CHAR(3)       NOT NULL DEFAULT 'RUB',
    paid_at   TIMESTAMPTZ
);

CREATE INDEX idx_payments_order ON payments (order_id);


-- ============================================================
-- Тестовые данные
-- ============================================================
INSERT INTO customers (id, name, email, phone)
VALUES
    (1, 'Алексей Петров',  'a.petrov@example.com',  '+79161234567'),
    (2, 'Мария Иванова',   'm.ivanova@example.com', '+79269876543'),
    (3, 'Дмитрий Сидоров', 'd.sidorov@example.com', NULL);

INSERT INTO orders (order_id, customer_id, status, is_paid, comment, source, ip, tags, created_at)
VALUES
    ('ORD-2026-0042', 1, 'shipped',   TRUE,  NULL,                    'web',    '192.168.1.100', ARRAY['электроника','промо'],       '2026-03-05T14:32:07+03:00'),
    ('ORD-2026-0043', 2, 'created',   FALSE, 'Позвонить для уточнения', 'mobile', '10.0.0.55',    ARRAY['одежда'],                    '2026-03-05T15:10:00+03:00'),
    ('ORD-2026-0044', 1, 'delivered', TRUE,  NULL,                    'web',    '192.168.1.100', ARRAY['электроника','повторный_клиент'], '2026-03-01T09:00:00+03:00');

INSERT INTO order_items (order_id, product_id, name, quantity, price, in_stock)
VALUES
    ('ORD-2026-0042', 'SKU-1001', 'Наушники Sony WH-1000XM5', 1, 32990.00, TRUE),
    ('ORD-2026-0042', 'SKU-2045', 'Чехол для наушников',       2,  1500.00, TRUE),
    ('ORD-2026-0042', 'SKU-3378', 'Кабель USB-C 2м',           1,   690.00, FALSE),
    ('ORD-2026-0043', 'SKU-5010', 'Футболка белая L',           3,  1200.00, TRUE),
    ('ORD-2026-0044', 'SKU-1002', 'Наушники Sony WH-1000XM4',  1, 24990.00, TRUE);

INSERT INTO payments (order_id, method, total, currency, paid_at)
VALUES
    ('ORD-2026-0042', 'card', 36680.00, 'RUB', '2026-03-05T14:33:12+03:00'),
    ('ORD-2026-0044', 'sbp',  24990.00, 'RUB', '2026-03-01T09:01:30+03:00');
