import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/jmap/core/patch_object.dart';

class KeyWordIdentifier with EquatableMixin {
  static final emailDraft = KeyWordIdentifier("\$draft");
  static final emailSeen = KeyWordIdentifier("\$seen");
  static final emailFlagged = KeyWordIdentifier("\$flagged");
  static final emailAnswered = KeyWordIdentifier("\$answered");
  static final emailForwarded = KeyWordIdentifier("\$forwarded");
  static final emailPhishing = KeyWordIdentifier("\$phishing");
  static final emailJunk = KeyWordIdentifier("\$junk");
  static final emailNotJunk = KeyWordIdentifier("\$notjunk");
  static final mdnSent = KeyWordIdentifier("\$mdnsent");

  final String value;

  KeyWordIdentifier(this.value);

  String toPatchObjectJson() {
    return '${PatchObject.keywordsProperty}/$value';
  }

  @override
  List<Object> get props => [value];
}
