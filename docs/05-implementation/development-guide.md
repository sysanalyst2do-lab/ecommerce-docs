# Руководство по разработке

## Начало работы

### Требования

- Python 3.11+
- Node.js 18+
- PostgreSQL 14+
- Docker и Docker Compose (для локальной разработки)

### Установка

```bash
# Клонирование репозитория
git clone <repository-url>
cd ecommerce-docs

# Установка зависимостей backend
cd backend
pip install -r requirements.txt

# Установка зависимостей frontend
cd ../frontend
npm install
```

## Стандарты кодирования

### Backend (Python)

- Следовать PEP 8
- Использовать type hints
- Покрытие тестами не менее 80%
- Документация docstrings для публичных API

### Frontend (React/TypeScript)

- Следовать ESLint правилам
- Использовать TypeScript строго
- Компоненты должны быть переиспользуемыми
- Тестирование компонентов с Jest и React Testing Library

## Git workflow

- Использовать feature branches
- Коммиты должны быть атомарными и описательными
- Pull requests требуют code review
- CI/CD проверяет код перед merge

## Тестирование

- Unit тесты для бизнес-логики
- Integration тесты для API
- E2E тесты для критических сценариев

## Разработка

Раздел в разработке. Детальные инструкции будут добавлены по мере развития проекта.
