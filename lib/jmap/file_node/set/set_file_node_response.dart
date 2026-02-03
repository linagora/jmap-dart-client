import 'package:jmap_dart_client/http/converter/account_id_converter.dart';
import 'package:jmap_dart_client/http/converter/id_converter.dart';
import 'package:jmap_dart_client/http/converter/state_nullable_converter.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/core/error/set_error.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/core/method/response/set_response.dart';
import 'package:jmap_dart_client/jmap/core/state.dart';
import 'package:jmap_dart_client/jmap/file_node/file_node.dart';

class SetFileNodeResponse extends SetResponse<FileNode> {
  SetFileNodeResponse(
    AccountId accountId, {
    State? newState,
    State? oldState,
    Map<Id, FileNode>? created,
    Map<Id, FileNode?>? updated,
    Set<Id>? destroyed,
    Map<Id, SetError>? notCreated,
    Map<Id, SetError>? notUpdated,
    Map<Id, SetError>? notDestroyed,
  }) : super(
          accountId,
          newState: newState,
          oldState: oldState,
          created: created,
          updated: updated,
          destroyed: destroyed,
          notCreated: notCreated,
          notUpdated: notUpdated,
          notDestroyed: notDestroyed,
        );

  static SetFileNodeResponse deserialize(Map<String, dynamic> json) {
    const idConverter = IdConverter();

    FileNode? parseNode(dynamic data) =>
        data is Map<String, dynamic> ? FileNode.fromJson(data) : null;

    Map<Id, FileNode>? mapNodes(Map<String, dynamic>? source) {
      if (source == null) return null;

      final result = <Id, FileNode>{};
      for (final entry in source.entries) {
        final node = parseNode(entry.value);
        if (node != null) {
          result[idConverter.fromJson(entry.key)] = node;
        }
      }
      return result.isNotEmpty ? result : null;
    }

    return SetFileNodeResponse(
      const AccountIdConverter().fromJson(json['accountId'] as String),

      newState:
          const StateNullableConverter().fromJson(json['newState'] as String?),

      oldState:
          const StateNullableConverter().fromJson(json['oldState'] as String?),

      created: mapNodes(json['created'] as Map<String, dynamic>?),
      updated: mapNodes(json['updated'] as Map<String, dynamic>?),

      destroyed: (json['destroyed'] as List<dynamic>?)
          ?.map((id) => const IdConverter().fromJson(id))
          .toSet(),

      notCreated: (json['notCreated'] as Map<String, dynamic>?)?.map(
        (key, value) => MapEntry(
          idConverter.fromJson(key),
          SetError.fromJson(value),
        ),
      ),

      notUpdated: (json['notUpdated'] as Map<String, dynamic>?)?.map(
        (key, value) => MapEntry(
          idConverter.fromJson(key),
          SetError.fromJson(value),
        ),
      ),

      notDestroyed: (json['notDestroyed'] as Map<String, dynamic>?)?.map(
        (key, value) => MapEntry(
          idConverter.fromJson(key),
          SetError.fromJson(value),
        ),
      ),
    );
  }

  @override
  List<Object?> get props => [
        oldState,
        newState,
        created,
        updated,
        destroyed,
        notCreated,
        notUpdated,
        notDestroyed,
      ];
}
