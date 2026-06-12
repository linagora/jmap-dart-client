import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/http/converter/contact/context_map_converter.dart';
import 'package:jmap_dart_client/jmap/contact/context.dart';
import 'package:jmap_dart_client/util/util.dart';
import 'package:json_annotation/json_annotation.dart';

part 'scheduling_address.g.dart';

@JsonSerializable()
class SchedulingAddress with EquatableMixin {
  @JsonKey(includeIfNull: false, name: '@type')
  final String? type;
  final String? uri;
  @ContextsMapConverter()
  final Map<Context, bool>? contexts;
  @JsonKey(includeIfNull: false, fromJson: parseIntNullable)
  final int? pref;
  final String? label;

  SchedulingAddress({
    this.type = 'SchedulingAddress',
    this.uri,
    this.contexts,
    this.pref,
    this.label,
  });

  factory SchedulingAddress.fromJson(Map<String, dynamic> json) =>
      _$SchedulingAddressFromJson(json);

  Map<String, dynamic> toJson() => _$SchedulingAddressToJson(this);

  @override
  List<Object?> get props => [type, uri, contexts, pref, label];

  @override
  String toString() {
    return 'SchedulingAddress('
        'type: $type, '
        'uri: $uri, '
        'contexts: $contexts, '
        'pref: $pref, '
        'label: $label'
        ')';
  }
}
