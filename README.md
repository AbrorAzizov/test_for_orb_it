
## Структура проекта

Исходный код находится в директории `lib` и организован следующим образом:

- **`lib/config`**: Конфигурационные файлы, включая специфические настройки окружения, маршруты (routes) и темы.
- **`lib/core`**: Базовые утилиты и сервисы, используемые во многих фичах (например, Сеть, Обработка ошибок, DI, Логирование).
- **`lib/features`**: Основная бизнес-логика и UI, разделенные по фичам (например, `auth`, `goals`, `home`).
- **`lib/shared`**: Переиспользуемые UI компоненты, миксины и виджеты, общие для всего приложения.
- **`main.dart`**: Точка входа в приложение.
- **`bootstrap.dart`**: Обрабатывает инициализацию приложения (DI, логирование и т.д.) перед его запуском.

## Архитектура

Мы следуем принципам **Clean Architecture** для разделения ответственности и обеспечения независимости между слоями. Каждая фича самодостаточна и состоит из трех основных слоев:

1.  **Domain (Внутренний слой)**
    -   Содержит «Бизнес-логику» фичи.
    -   **Entities**: Чистые Dart классы, представляющие объекты данных.
    -   **Repositories (Interfaces)**: Абстрактные определения того, как данные должны быть получены.
    -   **Use Cases**: Инкапсулируют конкретные бизнес-правила и взаимодействуют с репозиториями.
    -   *Важно: этот слой НЕ имеет зависимостей от Flutter или внешних библиотек (по большей части).*

2.  **Data (Внешний слой)**
    -   Отвечает за получение и хранение данных.
    -   **Repositories (Implementations)**: Конкретные реализации интерфейсов, определенных в слое Domain.
    -   **Data Sources**: Логика получения данных из удаленных API (RemoteDataSource) или локального хранилища (LocalDataSource).
    -   **Models**: Объекты передачи данных (DTO), которые расширяют Entities, часто включая методы `fromJson`/`toJson`.

3.  **Presentation (UI слой)**
    -   Отвечает за UI и управление состоянием.
    -   **Pages/Screens**: Основные экраны фич.
    -   **Widgets**: Более мелкие, переиспользуемые части UI, специфичные для фичи.
    -   **State Management**: Мы используем `Bloc` или `Cubit` (flutter_bloc) для управления состоянием.

## Структура фичи

Типичная директория фичи (например, `lib/features/my_feature`) выглядит так:

```
lib/features/my_feature/
├── data/
│   ├── datasources/        # Remote/Local data sources (Источники данных)
│   ├── models/             # DTOs, расширяющие Entities
│   └── repositories/       # Реализация Domain Repositories
├── di/                     # Настройка DI для конкретной фичи
├── domain/
│   ├── entities/           # Чистые бизнес-объекты
│   ├── repositories/       # Абстрактные определения репозиториев
│   └── usecases/           # Единицы бизнес-логики
└── presentation/
    ├── bloc/               # Классы BLoC/Cubit
    ├── pages/              # Полноэкранные виджеты (страницы)
    └── widgets/            # Виджеты, специфичные для фичи
```

## Как создать новую фичу

Следуйте этому чек-листу, чтобы добавить новую фичу в StudyNinja:

### 1. Создайте структуру директорий
Создайте новую папку в `lib/features/` (например, `new_feature`) и создайте подпапки: `data`, `domain`, `presentation`, `di`.

### 2. Domain Layer (Начните отсюда)
1.  **Entities**: Определите ваши бизнес-объекты в `domain/entities`.
2.  **Repository Interface**: Создайте абстрактный класс в `domain/repositories`, определяющий необходимые операции с данными.
3.  **Use Cases**: Создайте классы в `domain/usecases`, которые зависят от интерфейса Repository для выполнения конкретных действий.

### 3. Data Layer
1.  **Models**: Создайте модели в `data/models`, которые расширяют ваши Entities. Добавьте сериализацию JSON, если нужно.
2.  **Data Sources**: Создайте data sources в `data/datasources` для вызова API или проверки локальной БД.
3.  **Repository Implementation**: Реализуйте абстрактный Repository из слоя Domain в `data/repositories`. Он должен использовать Data Sources для получения Models и маппинга их в Entities.

### 4. Presentation Layer
1.  **State Management**: Создайте ваш Cubit/Bloc в `presentation/bloc`. Он должен зависеть от Use Cases, а не от Repositories напрямую.
2.  **UI**: Создайте ваши Pages и Widgets в `presentation/pages` и `presentation/widgets`.

### 5. Dependency Injection (DI)
1.  Создайте `lib/features/new_feature/di/new_feature_module.dart`.
2.  Определите функцию (например, `initNewFeatureModule`) для регистрации ваших Data Sources, Repositories, Use Cases и Blocs используя `get_it`.
3.  Вызовите эту функцию в `lib/core/di/injection_container.dart`, чтобы убедиться, что она загружается при старте.

### 6. Навигация
1.  Добавьте ваши новые маршруты в `lib/config/routes/app_routes.dart` (или эквивалент).
2.  Зарегистрируйте маршрут в `lib/config/routes/app_router.dart`.


## To run test mode
```
flutter run --dart-define=ENV=test
```