import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/jmap/calendar/participants.dart';
import 'package:jmap_dart_client/jmap/calendar/recurrence_rules.dart';

import 'extension_fields.dart';
import 'organizer.dart';

import 'package:json_annotation/json_annotation.dart';

part 'blob_id.g.dart';

@JsonSerializable()
class BlobId with EquatableMixin {
  final String? uid;
  final String? title;
  final String? description;
  final String? start;
  final String? duration;
  final String? end;
  final String? timeZone;
  final String? location;
  final String? method;
  final int? sequence;
  final int? priority;
  final String? freeBusyStatus;
  final String? privacy;
  final Organizer? organizer;
  final List<Participants>? participants;
  final ExtensionFields? extensionFields;
  final List<RecurrenceRules>? recurrenceRules;

  BlobId(
      {this.uid,
      this.title,
      this.description,
      this.start,
      this.duration,
      this.end,
      this.timeZone,
      this.location,
      this.method,
      this.sequence,
      this.priority,
      this.freeBusyStatus,
      this.privacy,
      this.organizer,
      this.participants,
      this.extensionFields,
      this.recurrenceRules});

  factory BlobId.fromJson(Map<String, dynamic> json) => _$BlobIdFromJson(json);

  Map<String, dynamic> toJson() => _$BlobIdToJson(this);

  @override
  List<Object?> get props => [
        uid,
        title,
        description,
        start,
        duration,
        end,
        timeZone,
        location,
        method,
        sequence,
        priority,
        freeBusyStatus,
        privacy,
        organizer,
        participants,
        extensionFields,
        recurrenceRules
      ];
}
