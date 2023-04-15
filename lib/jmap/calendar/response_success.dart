import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';

import 'parse.dart';
import 'package:json_annotation/json_annotation.dart';

part 'response_success.g.dart';

@JsonSerializable()
class ResponseSuccess with EquatableMixin {
  final AccountId? accountId;
  final Parsed? parsed;

  ResponseSuccess({this.accountId, this.parsed});

  factory ResponseSuccess.fromJson(Map<String, dynamic> json) =>
      _$ResponseSuccessFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseSuccessToJson(this);

  @override
  List<Object?> get props => [accountId, parsed];
}
