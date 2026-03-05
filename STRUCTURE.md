├── docs/                         # Основная директория с документацией
│   ├── README.md                 # Навигация по документации
│   ├── 01-overview/              # Обзор проекта
│   │   ├── project-vision.md     # Видение проекта
│   │   ├── stakeholders.md       # Заинтересованные стороны
│   │   └── actors-and-roles.md   # Новое: актёры и роли системы
│   ├── 02-requirements/          # Требования к системе
│   │   ├── business-requirements.md              # Бизнес-требования (BR)
│   │   ├── system-requirements.md                # Системные требования (SR)
│   │   ├── non-functional-requirements.md        # Нефункциональные требования (NFR)
│   │   ├── nfr-localization-currency-retention.md# Новое: расширение NFR
│   │   └── traceability-matrix.md               # Матрица трассируемости требований
│   ├── 03-architecture/          # Архитектурная документация
│   │   ├── adr/                  # Architecture Decision Records (ADR)
│   │   │   ├── ADR-0001-architecture-style-mvp-vs-platform.md
│   │   │   ├── ADR-0002-add-kafka-and-integration-services.md
│   │   │   ├── ADR-0003-extract-domain-services-from-monolith.md
│   │   │   └── ADR-0004-nfr-and-architecture-constraints.md
│   │   └── c4/                   # C4 диаграммы архитектуры
│   │       ├── README.md
│   │       ├── C1-mvp-ecommerce.puml
│   │       ├── C1_MVP_Ecommerce.png
│   │       ├── C1-platform-ecommerce.puml
│   │       ├── C1_Platform_Ecommerce.png
│   │       ├── C2-mvp-ecommerce.puml
│   │       ├── C2_MVP_Ecommerce.png
│   │       ├── C2-platform-ecommerce.puml
│   │       ├── C2_Platform_Ecommerce.png
│   │       ├── C2-transitional-ecommerce.puml
│   │       └── C2_Transitional_Ecommerce.png
│   ├── 04-design/                # Детальный дизайн
│   │   ├── api/                  # API спецификации
│   │   │   └── README.md
│   │   ├── database/             # Схемы БД
│   │   │   └── README.md
│   │   ├── ui/                   # UI/UX спецификации
│   │   │   └── README.md
│   │   ├── uml/                  # Новое: UML-диаграммы (puml/png)
│   │   │   ├── domain-class-diagram.puml
│   │   │   ├── use-cases-overview.puml
│   │   │   ├── checkout-sequence.puml
│   │   │   └── order-tracking-sequence.puml
│   │   └── domain/               # Новое: доменная логика / модели
│   │       └── lifecycle-state-machines.md
│   ├── 05-implementation/        # Руководства по реализации
│   │   ├── development-guide.md
│   │   ├── testing-strategy.md
│   │   └── deployment-guide.md
│   ├── 06-operations/            # Операционная документация
│   │   ├── monitoring.md
│   │   ├── troubleshooting.md
│   │   └── runbooks.md
│   └── 07-references/            # Справочные материалы
│       ├── glossary.md           # Глоссарий терминов
│       ├── abbreviations.md      # Сокращения и аббревиатуры
│       └── standards.md          # Стандарты и соглашения
├── CONTRIBUTING.md               # Руководство по внесению вклада
├── README.md                     # Основной README проекта
└── STRUCTURE.md                  # Описание структуры репозитория

### docs/01-overview/actors-and-roles.md

Описание актёров и ролей системы (клиенты, операторы, маркетинг, склад и т.д.) и их целей. Используется как база для Use Case диаграмм и RBAC.

### docs/02-requirements/nfr-localization-currency-retention.md

Расширение базового NFR-документа: локализация UI и уведомлений, поддержка валют, форматирование дат/цен, политика хранения персональных данных и логов.

### docs/04-design/domain/lifecycle-state-machines.md

Жизненные циклы ключевых доменных сущностей (Order, Payment, Return, Support Ticket) в виде таблиц статусов и PlantUML state machine диаграмм.

### docs/04-design/uml/

Каталог UML-диаграмм (PlantUML исходники и, при необходимости, сгенерированные изображения) для доменной модели, сценариев использования и последовательностей.
