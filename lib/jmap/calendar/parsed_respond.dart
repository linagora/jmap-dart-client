import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';

import 'parse.dart';
import 'package:json_annotation/json_annotation.dart';

part 'parsed_respond.g.dart';

@JsonSerializable()
class ParsedRespond with EquatableMixin {
  final AccountId? accountId;
  final Parsed? parsed;

  ParsedRespond({this.accountId, this.parsed});

  factory ParsedRespond.fromJson(Map<String, dynamic> json) =>
      _$ParsedRespondFromJson(json);

  Map<String, dynamic> toJson() => _$ParsedRespondToJson(this);

  @override
  List<Object?> get props => [accountId, parsed];
}
