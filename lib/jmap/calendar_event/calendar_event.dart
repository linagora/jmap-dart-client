import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/http/converter/calendar_event/calendar_event_id_nullable_converter.dart';
import 'package:jmap_dart_client/http/converter/unsigned_int_nullable_converter.dart';
import 'package:jmap_dart_client/jmap/calendar_event/participant_value.dart';
import 'package:jmap_dart_client/jmap/calendar_event/recurrence_rules.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:jmap_dart_client/jmap/calendar_event/alert_value.dart';
import 'package:jmap_dart_client/http/converter/calendar_event/alert_value_converter.dart';
import 'package:jmap_dart_client/http/converter/calendar_event/participant_value_converter.dart';
import 'package:jmap_dart_client/jmap/calendar_event/keywords.dart';
import 'package:jmap_dart_client/http/converter/calendar_event/location_value_converter.dart';
import 'package:jmap_dart_client/jmap/calendar_event/location_value.dart';

@UnsignedIntNullableConverter()
@CalendarEventIdNullableConverter()
class CalendarEvent with EquatableMixin {

  @JsonKey(includeIfNull: false)
  final CalendarEventId? id;

  @JsonKey(includeIfNull: false)
  final CalendarEventId? baseEventId;

  @JsonKey(name: '@type', includeIfNull: false)
  final String? type;

  @JsonKey(includeIfNull: false)
  final bool? isDraft;

  @JsonKey(includeIfNull: false)
  final bool? isOrigin;

  @JsonKey(includeIfNull: false)
  final String? start;

  @JsonKey(includeIfNull: false)
  final String? utcStart;

  @JsonKey(includeIfNull: false)
  final String? utcEnd;

  @JsonKey(includeIfNull: false)
  final String? title;

  @JsonKey(includeIfNull: false)
  final String? uid;

  @JsonKey(includeIfNull: false)
  final String? prodId;

  @JsonKey(includeIfNull: false)
  final String? status;

  @JsonKey(includeIfNull: false)
  final String? created;

  @JsonKey(includeIfNull: false)
  final String? updated;

  @JsonKey(includeIfNull: false)
  final String? duration;

  @JsonKey(includeIfNull: false)
  final bool? showWithoutTime;

  final Map<AlertId, AlertValue>? alerts;

  final Map<ParticipantId, ParticipantValue>? participants;

  @JsonKey(includeIfNull: false)
  final String? timeZone;

  @JsonKey(includeIfNull: false)
  final int? sequence;

  @JsonKey(includeIfNull: false)
  final String? description;

  @JsonKey(includeIfNull: false)
  final String? privacy;

  final Keyword? keywords;

  /// Singular recurrence rule (ietf)
  @JsonKey(includeIfNull: false)
  final RecurrenceRules? recurrenceRule;

  /// Multiple recurrence rules (Cyrus style)
  @JsonKey(includeIfNull: false)
  final List<RecurrenceRules>? recurrenceRules;

  final Map<LocationId, LocationValue>? locations;

  @JsonKey(includeIfNull: false)
  final String? freeBusyStatus;

  @JsonKey(includeIfNull: false)
  final Map<String, bool>? calendarIds;

  @JsonKey(includeIfNull: false)
  final Map<String, Map<String, dynamic>>? recurrenceOverrides;

  @JsonKey(includeIfNull: false)
  final String? organizerCalendarAddress;

  @JsonKey(includeIfNull: false)
  final bool? useDefaultAlerts;

  @JsonKey(includeIfNull: false)
  final bool? mayInviteSelf;

  @JsonKey(includeIfNull: false)
  final bool? mayInviteOthers;

  @JsonKey(includeIfNull: false)
  final bool? hideAttendees;


  CalendarEvent({
    this.id,
    this.baseEventId,
    this.type = 'Event',
    this.isDraft,
    this.isOrigin,  // isOrigin is server-set
    this.start,
    this.utcStart,
    this.utcEnd,
    this.title,
    this.uid,
    this.updated,
    this.duration,
    this.showWithoutTime,
    this.alerts,
    this.participants,
    this.timeZone,
    this.status,
    this.prodId,
    this.sequence,
    this.description,
    this.created,
    this.privacy,
    this.keywords,
    this.recurrenceRule,   
    this.recurrenceRules,       
    this.locations,
    this.freeBusyStatus,
    this.calendarIds,
    this.recurrenceOverrides,
    this.organizerCalendarAddress,
    this.useDefaultAlerts,
    this.mayInviteSelf,
    this.mayInviteOthers,
    this.hideAttendees,
  });

  factory CalendarEvent.fromJson(Map<String, dynamic> json) =>
      _$CalendarEventFromJson(json);

  Map<String, dynamic> toJson() => _$CalendarEventToJson(this);

  @override
  List<Object?> get props => [
        id,
        type,
        start,
        title,
        uid,
        prodId,
        status,
        created,
        updated,
        duration,
        showWithoutTime,
        alerts,
        participants,
        timeZone,
        sequence,
        description,
        privacy,
        keywords,
        recurrenceRule,
        recurrenceRules,
        locations,
        freeBusyStatus,
        calendarIds,
        recurrenceOverrides,
        organizerCalendarAddress,
        isDraft,
        useDefaultAlerts,
        mayInviteSelf,
        mayInviteOthers,
        hideAttendees,
      ];

  @override
  String toString() {
    return 'CalendarEvent('
        'id: $id, '
        'type: $type, '
        'start: $start, '
        'title: $title, '
        'uid: $uid, '
        'prodId: $prodId, '
        'status: $status, '
        'created: $created, '
        'updated: $updated, '
        'duration: $duration, '
        'showWithoutTime: $showWithoutTime, '
        'timeZone: $timeZone, '
        'sequence: $sequence, '
        'description: $description, '
        'privacy: $privacy, '
        'calendarIds: $calendarIds, '
        'alerts: $alerts, '
        'participants: $participants, '
        'locations: $locations, '
        'keywords: $keywords, '
        'recurrenceRule: $recurrenceRule, '
        'recurrenceRules: $recurrenceRules, '
        'recurrenceOverrides: $recurrenceOverrides, '
        'freeBusyStatus: $freeBusyStatus, '
        'organizerCalendarAddress: $organizerCalendarAddress, '
        'isDraft: $isDraft, '
        'useDefaultAlerts: $useDefaultAlerts, '
        'mayInviteSelf: $mayInviteSelf, '
        'mayInviteOthers: $mayInviteOthers, '
        'hideAttendees: $hideAttendees'
        ')';
  }
}

CalendarEvent _$CalendarEventFromJson(Map<String, dynamic> json) =>
    CalendarEvent(
      id: const CalendarEventIdNullableConverter()
          .fromJson(json['id'] as String?),
      baseEventId: const CalendarEventIdNullableConverter()
          .fromJson(json['baseEventId'] as String?),
      isDraft: json['isDraft'] as bool?,
      isOrigin: json['isOrigin'] as bool?,
      type: json['@type'] as String?,
      start: json['start'] as String?,
      utcStart: json['utcStart'] as String?,
      utcEnd: json['utcEnd'] as String?,  
      title: json['title'] as String?,
      uid: json['uid'] as String?,
      created: json['created'] as String?,
      updated: json['updated'] as String?,
      duration: json['duration'] as String?,
      showWithoutTime: json['showWithoutTime'] as bool?,
      alerts: (json['alerts'] as Map<String, dynamic>?)?.map(
        (key, value) => AlertValueConverter().parseEntry(key, value),
      ),
      participants: (json['participants'] as Map<String, dynamic>?)?.map(
        (key, value) => ParticipantValueConverter().parseEntry(key, value),
      ),
      timeZone: json['timeZone'] as String?,
      status: json['status'] as String?,
      prodId: json['prodId'] as String?,
      sequence: json['sequence'] as int?,
      description: json['description'] as String?,
      privacy: json['privacy'] as String?,
      keywords: json['keywords'] == null
          ? null
          : Keyword.fromJson(json['keywords'] as Map<String, dynamic>),

       // If recurrenceRule exists, use it and ignore recurrenceRules
      recurrenceRule: json['recurrenceRule'] == null
          ? null
          : RecurrenceRules.fromJson(
              json['recurrenceRule'] as Map<String, dynamic>,
            ),
      recurrenceRules: json['recurrenceRule'] != null
          ? null
          : (json['recurrenceRules'] as List<dynamic>?)
              ?.map((e) => RecurrenceRules.fromJson(
                    e as Map<String, dynamic>,
                  ))
              .toList(),
      locations: (json['locations'] as Map<String, dynamic>?)?.map(
        (key, value) => LocationValueConverter().parseEntry(key, value),
      ),
      freeBusyStatus: json['freeBusyStatus'] as String?,
      calendarIds:
          (json['calendarIds'] as Map<String, dynamic>?)?.map((key, value) {
        return MapEntry(key, value as bool);
      }),
      recurrenceOverrides:
          (json['recurrenceOverrides'] as Map<String, dynamic>?)?.map(
        (key, value) => MapEntry(key, value as Map<String, dynamic>),
      ),
      organizerCalendarAddress:
          json['organizerCalendarAddress'] as String?,
      useDefaultAlerts: json['useDefaultAlerts'] as bool?,
      mayInviteSelf: json['mayInviteSelf'] as bool?,
      mayInviteOthers: json['mayInviteOthers'] as bool?,
      hideAttendees: json['hideAttendees'] as bool?,
    );

Map<String, dynamic> _$CalendarEventToJson(CalendarEvent instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(
      'id', const CalendarEventIdNullableConverter().toJson(instance.id));
  writeNotNull(
      'baseEventId', const CalendarEventIdNullableConverter().toJson(instance.baseEventId));
  writeNotNull('isDraft', instance.isDraft);
  writeNotNull('isOrigin', instance.isOrigin);
  writeNotNull('@type', instance.type);
  writeNotNull('start', instance.start);
  writeNotNull('utcStart', instance.utcStart);
  writeNotNull('utcEnd', instance.utcEnd);
  writeNotNull('title', instance.title);
  writeNotNull('uid', instance.uid);
  writeNotNull('created', instance.created);
  writeNotNull('updated', instance.updated);
  writeNotNull('duration', instance.duration);
  writeNotNull('showWithoutTime', instance.showWithoutTime);
  writeNotNull(
    'alerts',
    instance.alerts?.map(
      (key, value) => AlertValueConverter().toJson(key, value),
    ),
  );
  writeNotNull(
    'participants',
    instance.participants?.map(
      (key, value) => ParticipantValueConverter().toJson(key, value),
    ),
  );
  writeNotNull('timeZone', instance.timeZone);
  writeNotNull('status', instance.status);
  writeNotNull('prodId', instance.prodId);
  writeNotNull('sequence', instance.sequence);
  writeNotNull('description', instance.description);
  writeNotNull('privacy', instance.privacy);
  writeNotNull('keywords', instance.keywords?.toJson());

  if (instance.recurrenceRule != null) {
    writeNotNull('recurrenceRule', instance.recurrenceRule!.toJson());
  } else if (instance.recurrenceRules != null &&
      instance.recurrenceRules!.isNotEmpty) {
    writeNotNull(
      'recurrenceRules',
      instance.recurrenceRules!.map((r) => r.toJson()).toList(),
    );
  }

  writeNotNull(
    'locations',
    instance.locations?.map(
      (key, value) => LocationValueConverter().toJson(key, value),
    ),
  );
  writeNotNull('freeBusyStatus', instance.freeBusyStatus);
  writeNotNull('calendarIds', instance.calendarIds);
  writeNotNull('recurrenceOverrides', instance.recurrenceOverrides);
  writeNotNull('organizerCalendarAddress', instance.organizerCalendarAddress);
  writeNotNull('useDefaultAlerts', instance.useDefaultAlerts);
  writeNotNull('mayInviteSelf', instance.mayInviteSelf);
  writeNotNull('mayInviteOthers', instance.mayInviteOthers);
  writeNotNull('hideAttendees', instance.hideAttendees);
  return val;
}


class CalendarEventId with EquatableMixin {
  final Id id;

  CalendarEventId(this.id);

  @override
  List<Object?> get props => [id];
}

class AlertId with EquatableMixin {
  final String value;

  AlertId(this.value);

  @override
  List<Object?> get props => [value];
}

class ParticipantId with EquatableMixin {
  final String value;

  ParticipantId(this.value);

  @override
  List<Object?> get props => [value];
}

class LocationId with EquatableMixin {
  final String value;

  LocationId(this.value);

  @override
  List<Object?> get props => [value];
}

