import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quary/src/bloc/snippet_bloc.dart';
import 'package:quary/src/bloc/snippet_event.dart';
import 'package:quary/src/models/snippet.dart';
import 'package:quary/src/view/confirm_dialog.dart';
import 'package:quary/src/view/snippet_form.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late TextEditingController searchController;

  @override
  void initState() {
    searchController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<SnippetBloc>();

    return Scaffold(
      body: Focus(
        onKeyEvent: (FocusNode node, KeyEvent event) {
          final keys = RawKeyboard.instance.keysPressed;
          if ((keys.contains(LogicalKeyboardKey.keyC) &&
              keys.contains(LogicalKeyboardKey.controlLeft))) {
            if (bloc.state.availableSnippets.isNotEmpty) {
              bloc.add(SnippetCopied(bloc.state.availableSnippets.first));
              return KeyEventResult.handled;
            }
          }
          return KeyEventResult.ignored;
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Search for snippets...',
                      ),
                      autofocus: true,
                      controller: searchController,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      final entry = await showDialog(
                        context: context,
                        builder: (_) => const SnippetForm(),
                      );

                      if (entry != null) {
                        bloc.add(
                          SnippetSaved(
                            Snippet(
                              name: entry.name,
                              template: entry.template,
                              variables: const [],
                            ),
                          ),
                        );
                      }
                    },
                    icon: const Icon(Icons.add_sharp),
                  ),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      for (final snippet in bloc.state.availableSnippets)
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: InkWell(
                            onTap: () {
                              bloc.add(SnippetCopied(snippet));
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Snippet copied'),
                                ),
                              );
                            },
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Expanded(child: Text(snippet.name)),
                                    IconButton(
                                      onPressed: () async {
                                        final delete = await showDialog<bool?>(
                                          context: context,
                                          builder: (_) => const ConfirmDialog(),
                                        );

                                        if (delete ?? false) {
                                          bloc.add(SnippetRemoved(snippet));
                                        }
                                      },
                                      icon: const Icon(Icons.delete),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
