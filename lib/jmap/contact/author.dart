import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'author.g.dart';

@JsonSerializable()
class Author with EquatableMixin {
  @JsonKey(includeIfNull: false, name: '@type')
  final String? type;
  @JsonKey(includeIfNull: false)
  final String? name;
  @JsonKey(includeIfNull: false)
  final String? uri;

  Author({this.type = 'Author', this.name, this.uri});

  factory Author.fromJson(Map<String, dynamic> json) =>
      _$AuthorFromJson(json);

  Map<String, dynamic> toJson() => _$AuthorToJson(this);

  @override
  List<Object?> get props => [type, name, uri];

  @override
  String toString() => 'Author(type: $type, name: $name, uri: $uri)';
}
