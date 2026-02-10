import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'keywords.g.dart';

@JsonSerializable()
class Keyword with EquatableMixin {
  @JsonKey(includeIfNull: false)
  final bool? anniversary;

  @JsonKey(includeIfNull: false)
  final bool? appointment;

  @JsonKey(includeIfNull: false)
  final bool? business;

  @JsonKey(includeIfNull: false)
  final bool? education;

  @JsonKey(includeIfNull: false)
  final bool? holiday;

  @JsonKey(includeIfNull: false)
  final bool? meeting;

  @JsonKey(includeIfNull: false)
  final bool? miscellaneous;

  @JsonKey(includeIfNull: false)
  final bool? nonWorkingHrs;

  @JsonKey(includeIfNull: false)
  final bool? notInOffice;

  @JsonKey(includeIfNull: false)
  final bool? personal;

  @JsonKey(includeIfNull: false)
  final bool? phoneCall;

  @JsonKey(includeIfNull: false)
  final bool? sickDay;

  @JsonKey(includeIfNull: false)
  final bool? specialOccasion;

  @JsonKey(includeIfNull: false)
  final bool? travel;

  @JsonKey(includeIfNull: false)
  final bool? vacation;

  Keyword({
    this.anniversary,
    this.appointment,
    this.business,
    this.education,
    this.holiday,
    this.meeting,
    this.miscellaneous,
    this.nonWorkingHrs,
    this.notInOffice,
    this.personal,
    this.phoneCall,
    this.sickDay,
    this.specialOccasion,
    this.travel,
    this.vacation,
  });

  factory Keyword.fromJson(Map<String, dynamic> json) =>
      _$KeywordFromJson(json);

  Map<String, dynamic> toJson() => _$KeywordToJson(this);

  @override
  List<Object?> get props => [
        anniversary,
        appointment,
        business,
        education,
        holiday,
        meeting,
        miscellaneous,
        nonWorkingHrs,
        notInOffice,
        personal,
        phoneCall,
        sickDay,
        specialOccasion,
        travel,
        vacation,
      ];

  @override
  String toString() {
    return 'Keyword('
        'anniversary: $anniversary, '
        'appointment: $appointment, '
        'business: $business, '
        'education: $education, '
        'holiday: $holiday, '
        'meeting: $meeting, '
        'miscellaneous: $miscellaneous, '
        'nonWorkingHrs: $nonWorkingHrs, '
        'notInOffice: $notInOffice, '
        'personal: $personal, '
        'phoneCall: $phoneCall, '
        'sickDay: $sickDay, '
        'specialOccasion: $specialOccasion, '
        'travel: $travel, '
        'vacation: $vacation'
        ')';
  }
}
