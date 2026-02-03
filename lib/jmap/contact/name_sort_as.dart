import 'package:equatable/equatable.dart';

class NameSortAs with EquatableMixin {
  final String? surname;
  final String? given;

  NameSortAs({this.surname, this.given});

  factory NameSortAs.fromJson(Map<String, dynamic> json) => NameSortAs(
        surname: json['surname'] as String?,
        given: json['given'] as String?,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (surname != null) map['surname'] = surname;
    if (given != null) map['given'] = given;
    return map;
  }

  @override
  List<Object?> get props => [surname, given];

  @override
  String toString() {
    return 'NameSortAs(surname: $surname, given: $given)';
  }
}
