# Объект Order — демонстрация форматов данных

## Структура объекта

```
order                          ← главный объект
├── order_id      (string)
├── created_at    (datetime)
├── status        (string/enum)
├── is_paid       (boolean)
├── comment       (null)
│
├── meta                       ← вложенный объект (метаданные)
│   ├── source    (string)
│   ├── ip        (string)
│   └── tags[]    (список строк)
│
├── customer                   ← вложенный объект
│   ├── id        (integer)
│   ├── name      (string)
│   ├── email     (string)
│   └── phone     (string)
│
├── items[]                    ← список объектов
│   ├── product_id (string)
│   ├── name       (string)
│   ├── quantity   (integer)
│   ├── price      (float)
│   └── in_stock   (boolean)
│
└── payment                    ← вложенный объект
    ├── method    (string)
    ├── total     (float)
    ├── currency  (string)
    └── paid_at   (datetime)
```

## Типы данных

| Тип | Пример в объекте |
|---|---|
| string | `"ORD-2026-0042"`, `"Алексей Петров"` |
| integer | `1023`, `1`, `2` |
| float | `32990.00`, `36680.00` |
| boolean | `true`, `false` |
| datetime | `"2026-03-05T14:32:07+03:00"` |
| null | `comment: null` |
| список строк | `tags: ["электроника", "промо"]` |
| список объектов | `items: [{...}, {...}, {...}]` |
| вложенный объект | `customer`, `meta`, `payment` |

## Файлы

| Файл | Формат |
|---|---|
| [order.json](./order.json) | JSON |
| [order.yaml](./order.yaml) | YAML |
| [order.xml](./order.xml) | XML |
| [order-tables.sql](./order-tables.sql) | SQL (4 таблицы PostgreSQL) |

## Раскладка по таблицам

```
  ┌────────────┐       ┌────────────┐
  │ customers  │──────▶│   orders    │
  └────────────┘       └─────┬──────┘
                             │
                  ┌──────────┴──────────┐
                  ▼                     ▼
          ┌──────────────┐      ┌────────────┐
          │ order_items   │      │  payments   │
          └──────────────┘      └────────────┘
```

| JSON путь | Таблица | Связь |
|---|---|---|
| корень + `meta.*` | `orders` | Основная таблица (meta — плоские поля + массив tags) |
| `customer.*` | `customers` | `orders.customer_id → customers.id` |
| `items[]` | `order_items` | `order_items.order_id → orders.order_id` |
| `payment.*` | `payments` | `payments.order_id → orders.order_id` |
