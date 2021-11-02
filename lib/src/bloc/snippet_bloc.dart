import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quary/src/bloc/snippet_event.dart';
import 'package:quary/src/bloc/snippet_state.dart';
import 'package:quary/src/repository/snippet_repository.dart';

class SnippetBloc extends Bloc<SnippetEvent, SnippetState> {
  SnippetBloc({
    required this.repository,
  }) : super(const SnippetState()) {
    on<FetchSnippetsRequested>(_handleFetchSnippetsRequested);
    on<SnippetSaved>(_handleSnippetSaved);
    on<SnippetRemoved>(_handleSnippetRemoved);
    on<SnippetCopied>(_handleSnippetCopied);
  }

  final SnippetRepository repository;

  Future<void> _handleFetchSnippetsRequested(
    FetchSnippetsRequested event,
    Emitter<SnippetState> emit,
  ) async {
    final snippets = await repository.fetchSnipptes();
    emit(state.copyWith(availableSnippets: snippets));
  }

  Future<void> _handleSnippetSaved(
    SnippetSaved event,
    Emitter<SnippetState> emit,
  ) async {
    await repository.saveSnippet(event.snippet);
    emit(
      state.copyWith(
        availableSnippets: [
          ...state.availableSnippets,
          event.snippet,
        ],
      ),
    );
  }

  Future<void> _handleSnippetRemoved(
    SnippetRemoved event,
    Emitter<SnippetState> emit,
  ) async {
    await repository.removeSnippet(event.snippet);
    emit(
      state.copyWith(
        availableSnippets: [
          ...state.availableSnippets.where(
            (element) => element.name != event.snippet.name,
          ),
        ],
      ),
    );
  }

  void _handleSnippetCopied(
    SnippetCopied event,
    Emitter<SnippetState> emit,
  ) {
    repository.copySnippet(event.snippet, {});
  }
}
