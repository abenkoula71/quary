import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quary/src/bloc/snippet_bloc.dart';
import 'package:quary/src/bloc/snippet_event.dart';
import 'package:quary/src/repository/snippet_repository.dart';
import 'package:quary/src/view/home.dart';

class QuaryApp extends StatefulWidget {
  const QuaryApp({Key? key}) : super(key: key);

  @override
  State<QuaryApp> createState() => _QuaryAppState();
}

class _QuaryAppState extends State<QuaryApp> {
  @override
  Widget build(BuildContext context) {
    final snippetRepository = SnippetRepository();

    return BlocProvider<SnippetBloc>(
      create: (_) {
        return SnippetBloc(repository: snippetRepository)
            ..add(const FetchSnippetsRequested());
      },
      child: const MaterialApp(
        home: Home(),
      ),
    );
  }
}
