// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clear_mailbox_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClearMailboxResponse _$ClearMailboxResponseFromJson(
        Map<String, dynamic> json) =>
    ClearMailboxResponse(
      const AccountIdConverter().fromJson(json['accountId'] as String),
      const UnsignedIntNullableConverter()
          .fromJson(json['totalDeletedMessagesCount'] as int?),
      json['notCleared'] == null
          ? null
          : SetError.fromJson(json['notCleared'] as Map<String, dynamic>),
    );
