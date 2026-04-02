// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TodoList)
final todoListProvider = TodoListProvider._();

final class TodoListProvider extends $NotifierProvider<TodoList, List<Todo>> {
  TodoListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'todoListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$todoListHash();

  @$internal
  @override
  TodoList create() => TodoList();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<Todo> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Todo>>(value),
    );
  }
}

String _$todoListHash() => r'ce1df4f72acdd2b64cc9f5fb24b30b442fca74de';

abstract class _$TodoList extends $Notifier<List<Todo>> {
  List<Todo> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<List<Todo>, List<Todo>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<Todo>, List<Todo>>,
              List<Todo>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(completedTodosCount)
final completedTodosCountProvider = CompletedTodosCountProvider._();

final class CompletedTodosCountProvider
    extends $FunctionalProvider<int, int, int>
    with $Provider<int> {
  CompletedTodosCountProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'completedTodosCountProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$completedTodosCountHash();

  @$internal
  @override
  $ProviderElement<int> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  int create(Ref ref) {
    return completedTodosCount(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$completedTodosCountHash() =>
    r'fce5040a1e07ad76da8acdd4f7f4b6d5d45d5ac5';

@ProviderFor(uncompletedTodosCount)
final uncompletedTodosCountProvider = UncompletedTodosCountProvider._();

final class UncompletedTodosCountProvider
    extends $FunctionalProvider<int, int, int>
    with $Provider<int> {
  UncompletedTodosCountProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'uncompletedTodosCountProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$uncompletedTodosCountHash();

  @$internal
  @override
  $ProviderElement<int> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  int create(Ref ref) {
    return uncompletedTodosCount(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$uncompletedTodosCountHash() =>
    r'2496c8246eec3b9e3cee00633811c2769a9c6103';
