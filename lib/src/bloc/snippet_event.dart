import 'package:equatable/equatable.dart';
import 'package:quary/src/models/snippet.dart';

abstract class SnippetEvent extends Equatable {
  const SnippetEvent();
}

class FetchSnippetsRequested extends SnippetEvent {
  const FetchSnippetsRequested();

  @override
  List<Object?> get props => [];
}

class SnippetSaved extends SnippetEvent {
  final Snippet snippet;

  const SnippetSaved(this.snippet);

  @override
  List<Object?> get props => [snippet];
}

class SnippetCopied extends SnippetEvent {
  final Snippet snippet;

  const SnippetCopied(this.snippet);

  @override
  List<Object?> get props => [snippet];
}

class SnippetRemoved extends SnippetEvent {
  final Snippet snippet;

  const SnippetRemoved(this.snippet);

  @override
  List<Object?> get props => [snippet];
}

class FilterChanged extends SnippetEvent {
  final String filter;

  const FilterChanged(this.filter);

  @override
  List<Object?> get props => [filter];
}
