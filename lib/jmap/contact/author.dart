import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'author.g.dart';

@JsonSerializable()
class Author with EquatableMixin {
  final String? type;
  final String? name;
  final String? uri;

  Author({this.type, this.name, this.uri});

  factory Author.fromJson(Map<String, dynamic> json) =>
      _$AuthorFromJson(json);

  Map<String, dynamic> toJson() {
    final map = _$AuthorToJson(this);

    map['@type'] = 'Author';
    return map;
  }

  @override
  List<Object?> get props => [name, uri];

  @override
  String toString() => 'Author(name: $name, uri: $uri)';
}
