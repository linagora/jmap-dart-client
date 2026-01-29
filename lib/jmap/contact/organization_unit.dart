import 'package:equatable/equatable.dart';

class OrganizationUnit with EquatableMixin {
  final String? name;

  OrganizationUnit({this.name});

  factory OrganizationUnit.fromJson(Map<String, dynamic> json) {
    return OrganizationUnit(
      name: json['name'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (name != null) {
      map['name'] = name;
    }
    return map;
  }

  @override
  List<Object?> get props => [name];

  @override
  String toString() {
    return 'OrganizationUnit(name: $name)';
  }
}
