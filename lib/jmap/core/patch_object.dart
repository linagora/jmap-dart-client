import 'package:equatable/equatable.dart';

class PatchObject with EquatableMixin {

  static final mailboxIdsProperty = 'mailboxIds';
  static final keywordsProperty = 'keywords';

  PatchObject(this.patches);

  final Map<String, dynamic> patches;

  Map<String, dynamic> toJson() => patches;

  @override
  List<Object?> get props => [patches];
}