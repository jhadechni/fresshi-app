import 'package:loggy/loggy.dart';

/// Mixin for UI layer logging (screens, widgets).
/// Use for user interactions, navigation events, UI state changes.
mixin UiLoggy implements LoggyType {
  @override
  Loggy<UiLoggy> get loggy => Loggy<UiLoggy>('UI - $runtimeType');
}

/// Mixin for data layer logging (repositories, datasources).
/// Use for data operations, cache hits/misses, data transformations.
mixin DataLoggy implements LoggyType {
  @override
  Loggy<DataLoggy> get loggy => Loggy<DataLoggy>('DATA - $runtimeType');
}

/// Mixin for network layer logging (API calls, HTTP operations).
/// Use for request/response logging, network errors.
mixin NetworkLoggy implements LoggyType {
  @override
  Loggy<NetworkLoggy> get loggy => Loggy<NetworkLoggy>('NETWORK - $runtimeType');
}

/// Mixin for domain layer logging (use cases, business logic).
/// Use for business rule execution, validation, domain events.
mixin DomainLoggy implements LoggyType {
  @override
  Loggy<DomainLoggy> get loggy => Loggy<DomainLoggy>('DOMAIN - $runtimeType');
}

/// Mixin for provider/state management logging.
/// Use for state changes, provider lifecycle events.
mixin ProviderLoggy implements LoggyType {
  @override
  Loggy<ProviderLoggy> get loggy => Loggy<ProviderLoggy>('PROVIDER - $runtimeType');
}
