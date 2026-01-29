import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/jmap/contact/author.dart';
import 'package:jmap_dart_client/jmap/contact/contact_api_version.dart';

class Note with EquatableMixin {
  final String note;
  final String? created; 
  final Author? author;

  Note({
    required this.note,
    this.created,
    this.author,
  });

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      note: json['note'] as String,
      created: json['created'] as String?,
      author: json['author'] != null
          ? Author.fromJson(json['author'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toVersionedJson(ContactApiVersion apiVersion) {
    final map = <String, dynamic>{};

    void writeNotNull(String key, dynamic value) {
      if (value != null) map[key] = value;
    }
    writeNotNull('note', note);
    writeNotNull('created', created);
    if (author != null) {
      writeNotNull('author', author!.toVersionedJson(apiVersion));
    }
    return map;
  }

  @override
  List<Object?> get props => [note, created, author];

  @override
  String toString() => 'Note(note: $note, created: $created, author: $author)';
}
