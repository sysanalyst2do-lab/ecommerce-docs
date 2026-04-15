# Orders API

Base URL: `/api/v1`

Документ синхронизирован с текущей реализацией backend в `ecommerce-platform`.

---

## Реализованные методы

### 1) Получить список заказов

```
GET /api/v1/orders
```

Query-параметры (все опциональные):

| Параметр | Тип | Пример | Описание |
|---|---|---|---|
| `status` | string | `shipped` | Фильтр по статусу |
| `customer_id` | integer | `1` | Фильтр по клиенту |
| `limit` | integer | `10` | Количество записей (default: 20, max: 100) |
| `offset` | integer | `0` | Смещение для пагинации |

Ответ `200 OK`:

```json
{
  "data": [
    {
      "order_id": "ORD-2026-AB12",
      "status": "shipped",
      "is_paid": true,
      "customer": { "id": 1, "name": "Алексей Петров" },
      "total": 36680.0,
      "created_at": "2026-03-05T14:32:07+03:00"
    }
  ],
  "total": 1,
  "limit": 10,
  "offset": 0
}
```

---

### 2) Получить заказ по ID

```
GET /api/v1/orders/{order_id}
```

Ответ `200 OK`:

```json
{
  "order_id": "ORD-2026-AB12",
  "created_at": "2026-03-05T14:32:07+03:00",
  "updated_at": "2026-03-05T16:45:00+03:00",
  "status": "shipped",
  "is_paid": true,
  "comment": null,
  "meta": {
    "source": "web",
    "ip": "192.168.1.100",
    "tags": ["электроника", "промо"]
  },
  "customer": {
    "id": 1,
    "name": "Алексей Петров",
    "email": "a.petrov@example.com",
    "phone": "+79161234567"
  },
  "items": [
    {
      "product_id": "SKU-1001",
      "name": "Наушники Sony WH-1000XM5",
      "quantity": 1,
      "price": 32990.0,
      "in_stock": true
    }
  ],
  "payment": {
    "method": "card",
    "total": 36680.0,
    "currency": "RUB",
    "paid_at": "2026-03-05T14:33:12+03:00"
  }
}
```

Ответ `404 Not Found` (фактический формат FastAPI):

```json
{
  "detail": {
    "error": "NOT_FOUND",
    "message": "Заказ ORD-9999-0001 не найден"
  }
}
```

---

### 3) Создать заказ

```
POST /api/v1/orders
```

Тело запроса (актуально для backend):

```json
{
  "customer_id": 2,
  "comment": "Позвонить для уточнения",
  "source": "mobile",
  "tags": ["одежда"],
  "items": [
    {
      "product_id": "SKU-5010",
      "name": "Футболка белая L",
      "quantity": 3,
      "price": 1200.0,
      "in_stock": true
    }
  ],
  "payment": {
    "method": "cash",
    "total": 3600.0,
    "currency": "RUB"
  }
}
```

Ответ `201 Created`:

```json
{
  "order_id": "ORD-2026-7F2A",
  "status": "created",
  "is_paid": false,
  "created_at": "2026-03-05T15:10:00+03:00"
}
```

Ответ `400 Bad Request` (пример):

```json
{
  "detail": {
    "error": "VALIDATION_ERROR",
    "message": "Клиент 999 не найден"
  }
}
```

---

### 4) Обновить статус заказа

```
PATCH /api/v1/orders/{order_id}/status
```

Тело запроса:

```json
{
  "status": "delivered"
}
```

Ответ `200 OK`:

```json
{
  "order_id": "ORD-2026-AB12",
  "status": "delivered",
  "updated_at": "2026-03-08T10:00:00+03:00"
}
```

Ответ `422 Unprocessable Entity`:

```json
{
  "detail": {
    "error": "INVALID_TRANSITION",
    "message": "Нельзя перевести заказ из 'created' в 'delivered'"
  }
}
```

---

### 5) Удалить заказ

```
DELETE /api/v1/orders/{order_id}
```

Ответ:
- `204 No Content` — удалено успешно
- `404 Not Found` — заказ не найден

---

## Planned (пока не реализовано, но сохранено в контракте)

### A) Получить позиции заказа

```
GET /api/v1/orders/{order_id}/items
```

Статус: `Planned`

Целевой ответ `200 OK`:

```json
{
  "order_id": "ORD-2026-AB12",
  "items": [
    {
      "product_id": "SKU-1001",
      "name": "Наушники Sony WH-1000XM5",
      "quantity": 1,
      "price": 32990.0,
      "in_stock": true
    }
  ],
  "total_items": 1
}
```

---

### B) Получить заказы клиента

```
GET /api/v1/customers/{customer_id}/orders
```

Статус: `Planned`

Целевой ответ `200 OK`:

```json
{
  "customer": {
    "id": 1,
    "name": "Алексей Петров",
    "email": "a.petrov@example.com"
  },
  "orders": [
    {
      "order_id": "ORD-2026-AB12",
      "status": "shipped",
      "is_paid": true,
      "total": 36680.0,
      "items_count": 3,
      "created_at": "2026-03-05T14:32:07+03:00"
    }
  ],
  "total_orders": 1
}
```

---

## Сводная таблица эндпоинтов

| Метод | Endpoint | Статус | Описание |
|---|---|---|---|
| `GET` | `/api/v1/orders` | ✅ Implemented | Список заказов (фильтры + пагинация) |
| `GET` | `/api/v1/orders/{order_id}` | ✅ Implemented | Заказ по ID (полный объект) |
| `POST` | `/api/v1/orders` | ✅ Implemented | Создать заказ |
| `PATCH` | `/api/v1/orders/{order_id}/status` | ✅ Implemented | Обновить статус |
| `DELETE` | `/api/v1/orders/{order_id}` | ✅ Implemented | Удалить заказ |
| `GET` | `/api/v1/orders/{order_id}/items` | 🚧 Planned | Позиции заказа |
| `GET` | `/api/v1/customers/{customer_id}/orders` | 🚧 Planned | Заказы клиента |

---

## Жизненный цикл статусов

```
created ──▶ paid ──▶ processing ──▶ shipped ──▶ delivered
   │                                              │
   └──────────────▶ cancelled ◀───────────────────┘
```
