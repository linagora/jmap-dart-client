import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:jmap_dart_client/jmap/contact/author.dart';

part 'note.g.dart';

@JsonSerializable(explicitToJson: true)
class Note with EquatableMixin {
  final String note;
  final String? created;
  final Author? author;

  Note({
    required this.note,
    this.created,
    this.author,
  });

  factory Note.fromJson(Map<String, dynamic> json) => _$NoteFromJson(json);

  Map<String, dynamic> toJson() => _$NoteToJson(this);

  @override
  List<Object?> get props => [note, created, author];

  @override
  String toString() => 'Note(note: $note, created: $created, author: $author)';
}
