import 'package:jmap_dart_client/jmap/contact/context.dart';

class ContextConverter {
  MapEntry<Context, bool> parseEntry(String key, bool value) => MapEntry(Context(key), value);

  MapEntry<String, bool> toJson(Context context, bool value) => MapEntry(context.value, value);
}

