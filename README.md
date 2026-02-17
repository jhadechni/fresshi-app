# Fresshi

E-Commerce Flutter app built as part of the Pragma Flutter Growth Path.

## Architecture

Feature-First Clean Architecture with MVVM pattern.

### Stack

| Concern | Package |
|---|---|
| State management | `flutter_riverpod` |
| Navigation | `go_router` |
| Networking | `dio` |
| JSON serialization | `json_serializable` + `build_runner` |
| Error handling | `dartz` (Either) |
| Models | `equatable` |

### Folder structure

```
lib/
├── core/
│   ├── constants/       # API and app constants
│   ├── errors/          # Failures and exceptions
│   ├── network/         # Dio client setup
│   └── utils/           # Result<T> and Command pattern
├── features/
│   ├── auth/            # Login & register screens
│   ├── cart/            # Cart state and screen
│   ├── home/            # Home screen with featured products
│   ├── products/        # Product list, detail, category filter
│   └── search/          # Full-text product search
├── routes/              # GoRouter configuration
└── shared/
    └── ui/
        └── theme/       # Light & dark Material 3 theme
```

Each feature follows three layers:

- **data/** — models (JSON), remote datasources, repository implementations
- **domain/** — entities, repository interfaces, use-cases
- **presentation/** — Riverpod providers, screens, widgets

### Key design decisions

- **Result\<T\>** (`core/utils/result.dart`) — sealed type for synchronous success/error without exceptions
- **Either\<Failure, T\>** (dartz) — used at repository boundaries for async operations
- **Failures** (`core/errors/failures.dart`) — sealed class hierarchy maps domain errors cleanly to UI states
- **Command pattern** (`core/utils/command.dart`) — encapsulates ViewModel actions with loading/error state tracking
- **`package:` imports everywhere** — enforced by `always_use_package_imports` lint rule

## Getting started

```bash
# Install dependencies
fvm flutter pub get

# Generate JSON serialization code
fvm flutter pub run build_runner build --delete-conflicting-outputs

# Run the app
fvm flutter run

# Analyze
fvm flutter analyze
```

## Growth Path Phases

| Phase | Status | Description |
|---|---|---|
| 1 | Skipped | Basic Flutter app |
| 2 | In progress | Fake Store API consumption |
| 3 | Pending | Create & publish a package |
| 4 | Pending | Design system (Atomic Design) |
| 5 | Pending | E-Commerce application |
| 6 | Pending | Testing & coverage >80% |
| 7 | Pending | JSON parametrization |
| 8 | Pending | Accessibility (Semantics) |
