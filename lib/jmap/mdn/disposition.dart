import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'disposition.g.dart';

@JsonSerializable()
class Disposition with EquatableMixin {
  final ActionMode actionMode;
  final SendingMode sendingMode;
  final DispositionType type;

  Disposition({
    required this.actionMode,
    required this.sendingMode,
    required this.type,
  });

  @override
  List<Object?> get props => [actionMode, sendingMode, type];

  factory Disposition.fromJson(Map<String, dynamic> json) =>
      _$DispositionFromJson(json);

  Map<String, dynamic> toJson() => _$DispositionToJson(this);
}

enum ActionMode {
  manual('manual-action'),
  automatic('automatic-action');

  final String value;

  const ActionMode(this.value);

  String toJson() => value;

  static ActionMode fromJson(String json) {
    final parts = json.split('-');
    if (parts.isNotEmpty && values.contains(parts[0])) {
      return values.byName(parts[0]);
    }
    throw Exception('wrong parsed actionMode: $json');
  }
}

enum SendingMode {
  manually('mdn-sent-manually'),
  automatically('mdn-sent-automatically');

  final String value;

  const SendingMode(this.value);

  String toJson() => value;

  static SendingMode fromJson(String json) {
    final parts = json.split('-');
    if (parts.length >= 2 && values.contains(parts[2])) {
      return values.byName(parts[2]);
    }
    throw Exception('wrong parsed SendingMode: $json');
  }
}

enum DispositionType {
  deleted,
  dispatched,
  displayed,
  processed;

  String toJson() => name;

  static DispositionType fromJson(String json) {
    try {
      return values.byName(json);
    } catch (e) {
      throw Exception('wrong parsed type');
    }
  }
}
