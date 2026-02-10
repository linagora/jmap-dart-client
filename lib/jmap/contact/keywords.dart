import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'keywords.g.dart';

@JsonSerializable()
class Keywords with EquatableMixin {
  final Map<String, bool> values;

  Keywords({required this.values});

  factory Keywords.fromList(Iterable<String> tags) =>
      Keywords(values: {for (final t in tags) t: true});

  factory Keywords.fromJson(Map<String, dynamic> json) =>
      _$KeywordsFromJson(json);

  Map<String, dynamic> toJson() => _$KeywordsToJson(this);

  @override
  List<Object?> get props => [values];

  @override
  String toString() => 'Keywords(values: $values)';
}
