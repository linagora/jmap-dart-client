import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';

// Identifier classes

class ContactId with EquatableMixin {
  final Id id;
  ContactId(this.id);

  String get value => id.value;

  @override
  List<Object?> get props => [id];

  @override
  String toString() => 'ContactId($value)';
}

class EmailId with EquatableMixin {
  final String value;
  EmailId(this.value);

  @override
  List<Object?> get props => [value];

  @override
  String toString() => 'EmailId($value)';
}

class PhoneId with EquatableMixin {
  final String value;
  PhoneId(this.value);

  @override
  List<Object?> get props => [value];

  @override
  String toString() => 'PhoneId($value)';
}

class AddressId with EquatableMixin {
  final String value;
  AddressId(this.value);

  @override
  List<Object?> get props => [value];

  @override
  String toString() => 'AddressId($value)';
}

class OrganizationName with EquatableMixin {
  final String value;
  OrganizationName(this.value);

  @override
  List<Object?> get props => [value];

  @override
  String toString() => 'OrganizationName($value)';
}

class RelatedToName with EquatableMixin {
  final String value;
  RelatedToName(this.value);

  @override
  List<Object?> get props => [value];

  @override
  String toString() => 'RelatedToName($value)';
}

class TitleId with EquatableMixin {
  final String value;
  TitleId(this.value);

  @override
  List<Object?> get props => [value];

  @override
  String toString() => 'TitleId($value)';
}

class AnniversaryId with EquatableMixin {
  final String value;
  AnniversaryId(this.value);

  @override
  List<Object?> get props => [value];

  @override
  String toString() => 'AnniversaryId($value)';
}
