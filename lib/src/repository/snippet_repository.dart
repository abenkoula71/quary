import 'dart:convert';

import 'package:quary/src/models/snippet.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'package:mason/src/render.dart';

class SnippetRepository {
  Future<List<Snippet>> fetchSnipptes() async {
    final instance = await SharedPreferences.getInstance();
    return instance.getKeys().map((key) {
      final raw = json.decode(instance.getString(key)!);
      return Snippet.fromJson(raw);
    }).toList();
  }

  Future<void> saveSnippet(Snippet snippet) async {
    final instance = await SharedPreferences.getInstance();
    instance.setString(snippet.name, json.encode(snippet.toJson()));
  }

  Future<void> removeSnippet(Snippet snippet) async {
    final instance = await SharedPreferences.getInstance();
    instance.remove(snippet.name);
  }

  void copySnippet(
    Snippet snippet,
    Map<String, String> values,
  ) {
    final result = snippet.template.render(values);
    Clipboard.setData(ClipboardData(text: result));
  }
}
