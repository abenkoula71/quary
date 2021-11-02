import 'package:flutter/material.dart';

class SnippetFormEntry {
  final String name;
  final String template;

  SnippetFormEntry({
    required this.name,
    required this.template,
  });
}

class SnippetForm extends StatefulWidget {
  const SnippetForm({Key? key}) : super(key: key);

  @override
  State<SnippetForm> createState() => _SnippetFormState();
}

class _SnippetFormState extends State<SnippetForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _templateController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 300,
        height: 450,
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Snippet name',
                    ),
                    autofocus: true,
                    controller: _nameController,
                    validator: (value) {
                      if (value != null && value.isNotEmpty) {
                        return null;
                      }
                      return 'This field is required';
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Snippet template',
                    ),
                    controller: _templateController,
                    maxLines: 8,
                    validator: (value) {
                      if (value != null && value.isNotEmpty) {
                        return null;
                      }
                      return 'This field is required';
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        final project = SnippetFormEntry(
                          name: _nameController.text,
                          template: _templateController.text,
                        );
                        Navigator.of(context).pop(project);
                      }
                    },
                    child: const Text('Create'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
