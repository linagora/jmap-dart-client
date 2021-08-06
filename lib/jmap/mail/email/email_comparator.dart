import 'package:jmap_dart_client/http/converter/collation_identifier_nullable_converter.dart';
import 'package:jmap_dart_client/http/converter/email_comparator_property_converter.dart';
import 'package:jmap_dart_client/http/converter/comparator_property_converter.dart';
import 'package:jmap_dart_client/jmap/core/sort/comparator.dart';
import 'package:jmap_dart_client/jmap/mail/email/email_comparator_property.dart';
import 'package:json_annotation/json_annotation.dart';

part 'email_comparator.g.dart';

@CollationIdentifierNullableConverter()
@ComparatorPropertyConverter()
@EmailComparatorPropertyConverter()
@JsonSerializable()
class EmailComparator extends Comparator {

  EmailComparator(EmailComparatorProperty property) : super(property);

  @override
  List<Object?> get props => [property, isAscending, collation];

  factory EmailComparator.fromJson(Map<String, dynamic> json) => _$EmailComparatorFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$EmailComparatorToJson(this);
}
