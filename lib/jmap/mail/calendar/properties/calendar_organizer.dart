
import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/http/converter/calendar/mail_address_nullable_converter.dart';
import 'package:jmap_dart_client/jmap/mail/calendar/properties/mail_address.dart';
import 'package:json_annotation/json_annotation.dart';

part 'calendar_organizer.g.dart';

@MailAddressNullableConverter()
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class CalendarOrganizer with EquatableMixin {

  final String? name;
  final MailAddress? mailto;

  CalendarOrganizer({this.name, this.mailto});

  factory CalendarOrganizer.fromJson(Map<String, dynamic> json) => _$CalendarOrganizerFromJson(json);

  Map<String, dynamic> toJson() => _$CalendarOrganizerToJson(this);

  @override
  List<Object?> get props => [name, mailto];
}