import 'package:equatable/equatable.dart';

class Nickname with EquatableMixin {
  final String? name;

  Nickname({this.name});

  factory Nickname.fromJson(Map<String, dynamic> json) =>
      Nickname(name: json['name'] as String?);

  Map<String, dynamic> toJson() => {
        if (name != null) 'name': name,
      };

  @override
  List<Object?> get props => [name];

  @override
  String toString() => 'Nickname(name: $name)';
}
