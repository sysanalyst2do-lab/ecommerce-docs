# ecommerce-docs

Репозиторий технической и бизнес-документации для e-commerce системы.

## Навигация

[Структура](#структура) | [Быстрый старт](#быстрый-старт) | [Полезные файлы](#полезные-файлы) | [Автоматизация](#автоматизация)

Если ты здесь первый раз, не отвлекайся и переходи в [полезные файлы](#полезные-файлы) и скачивай лист онбординга.

## Структура

Документация организована в директории `docs/` по принципу последовательного изучения:

- **01-overview** - Обзор проекта и заинтересованные стороны
- **02-requirements** - Бизнес- и системные требования
- **03-architecture** - Архитектурные решения и диаграммы
- **04-design** - Детальный дизайн (API, БД, UI/UX)
- **05-implementation** - Руководства по разработке и развёртыванию
- **06-operations** - Операционная документация
- **07-references** - Справочные материалы

Подробнее см. [docs/README.md](./docs/README.md)

## Быстрый старт

1. Начните с [обзора проекта](./docs/01-overview/project-vision.md)
2. Изучите [бизнес-требования](./docs/02-requirements/business-requirements.md)
3. Ознакомьтесь с [архитектурой](./docs/03-architecture/c4/)

## Полезные файлы

- 📋 [Onboarding List](./onboarding/onboardingList.html) — чек-лист помошник для онбординга
- 📥 [Скачать Onboarding List](https://github.com/sysanalyst2do-lab/ecommerce-docs/raw/onboarding/onboarding/onboardingList.html)

## Автоматизация

- C4 диаграммы автоматически генерируются из PlantUML файлов через GitHub Actions
- Workflow: `.github/workflows/plantuml.yml`