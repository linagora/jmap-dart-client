import 'package:equatable/equatable.dart';
import 'contact_api_version.dart';

class Author with EquatableMixin {
  final String? name;
  final String? uri;

  Author({this.name, this.uri});

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      name: json['name'] as String?,
      uri: json['uri'] as String?,
    );
  }

  Map<String, dynamic> toVersionedJson(ContactApiVersion apiVersion) {
    final map = <String, dynamic>{};

    void writeNotNull(String key, dynamic value) {
      if (value != null) map[key] = value;
    }

    writeNotNull('@type', 'Author');
    writeNotNull('name', name);
    writeNotNull('uri', uri);
    return map;
  }

  @override
  List<Object?> get props => [name, uri];

  @override
  String toString() => 'Author(name: $name, uri: $uri)';
}
