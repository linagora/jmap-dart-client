import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:jmap_dart_client/jmap/contact/author.dart';

part 'note.g.dart';

@JsonSerializable(explicitToJson: true)
class Note with EquatableMixin {
  @JsonKey(includeIfNull: false, name: '@type')
  final String? type;
  final String note;
  final String? created;
  final Author? author;

  Note({
    this.type,
    required this.note,
    this.created,
    this.author,
  });

  factory Note.note({
    required String note,
    String? created,
    Author? author,
  }) =>
      Note(
        type: 'Note',
        note: note,
        created: created,
        author: author,
      );

  factory Note.fromJson(Map<String, dynamic> json) => _$NoteFromJson(json);

  Map<String, dynamic> toJson() => _$NoteToJson(this);

  @override
  List<Object?> get props => [type, note, created, author];

  @override
  String toString() =>
      'Note(type: $type, note: $note, created: $created, author: $author)';
}
