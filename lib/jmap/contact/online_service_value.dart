import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/http/converter/contact/context_map_converter.dart';
import 'package:jmap_dart_client/jmap/contact/context.dart';
import 'package:json_annotation/json_annotation.dart';

part 'online_service_value.g.dart';

@ContextsMapConverter()
@JsonSerializable()
class OnlineServiceValue with EquatableMixin {
  @JsonKey(includeIfNull: false, name: '@type')
  final String? type;
  final String? service;
  final String? uri;
  final String? user;
  final String? label;
  final Map<Context, bool>? contexts;

  OnlineServiceValue({
    this.type = 'OnlineService',
    this.service,
    this.uri,
    this.user,
    this.label,
    this.contexts,
  });

  factory OnlineServiceValue.fromJson(Map<String, dynamic> json) =>
      _$OnlineServiceValueFromJson(json);

  Map<String, dynamic> toJson() => _$OnlineServiceValueToJson(this);

  @override
  List<Object?> get props => [type, service, uri, user, label, contexts];

  @override
  String toString() {
    return 'OnlineServiceValue('
        'type: $type, '
        'service: $service, '
        'uri: $uri, '
        'user: $user, '
        'label: $label, '
        'contexts: $contexts'
        ')';
  }
}
