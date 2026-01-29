import 'package:jmap_dart_client/jmap/contact/context.dart';

class ContextTypeConverter {
  MapEntry<Context, bool> parseEntry(String key, bool value) => MapEntry(Context(key), value);

  MapEntry<String, bool> toJson(Context contextValue, bool value) => MapEntry(contextValue.value, value);
}

