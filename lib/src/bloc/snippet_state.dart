import 'package:equatable/equatable.dart';
import 'package:quary/src/models/snippet.dart';

class SnippetState extends Equatable {
  const SnippetState({
    this.availableSnippets = const [],
    this.filteredSnippets = const [],
  });

  final List<Snippet> availableSnippets;
  final List<Snippet> filteredSnippets;

  @override
  List<Object?> get props => [availableSnippets];

  SnippetState copyWith({
    List<Snippet>? availableSnippets,
    List<Snippet>? filteredSnippets,
  }) {
    return SnippetState(
      availableSnippets: availableSnippets ?? this.availableSnippets,
      filteredSnippets: filteredSnippets ?? this.filteredSnippets,
    );
  }
}
