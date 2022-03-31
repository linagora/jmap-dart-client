
import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/http/converter/type_state_converter.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/push/type_state.dart';

class StateChange with EquatableMixin {

  final String type;
  final Map<AccountId, TypeState> changed;

  StateChange(this.type, this.changed);

  factory StateChange.fromJson(Map<String, dynamic> json, {TypeStateConverter? converter}) {
    if (converter == null) {
      converter = TypeStateConverter.defaultConverter;
    }
    return StateChange(
        json['@type'] as String,
        (json['changed'] as Map<String, dynamic>).map((key, value) => converter!.convert(key, value)),
    );
  }

  @override
  List<Object?> get props => [type, changed];
}