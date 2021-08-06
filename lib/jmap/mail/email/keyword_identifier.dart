import 'package:equatable/equatable.dart';

class KeyWordIdentifier with EquatableMixin {
  static final emailDraft = KeyWordIdentifier("\$draft");
  static final emailSeen = KeyWordIdentifier("\$seen");
  static final emailFlagged = KeyWordIdentifier("\$flagged");
  static final emailAnswered = KeyWordIdentifier("\$answered");
  static final emailForwarded = KeyWordIdentifier("\$forwarded");
  static final emailPhishing = KeyWordIdentifier("\$phishing");
  static final emailJunk = KeyWordIdentifier("\$junk");
  static final emailNotJunk = KeyWordIdentifier("\$notjunk");

  final String value;

  KeyWordIdentifier(this.value);

  @override
  List<Object> get props => [value];
}
