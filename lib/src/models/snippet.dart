import 'package:equatable/equatable.dart';

class Snippet extends Equatable {
  const Snippet({
    required this.name,
    required this.template,
    required this.variables,
  });

  factory Snippet.fromJson(Map<String, dynamic> json) {
    return Snippet(
      name: json['name'] as String,
      template: json['template'] as String,
      variables: (json['variables'] as List).cast<String>(),
    );
  }

  final String name;
  final String template;
  final List<String> variables;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'template': template,
      'variables':  variables,
    };
  }

  @override
  List<Object?> get props => [name, template, variables];
}
