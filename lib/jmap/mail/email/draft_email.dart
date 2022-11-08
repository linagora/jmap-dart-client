import 'package:jmap_dart_client/jmap/mail/email/keyword_identifier.dart';

import 'email.dart';

class DraftEmail extends Email {
  DraftEmail(super.id) {
    this.keywords = {
      KeyWordIdentifier.emailDraft: true, 
      KeyWordIdentifier.emailSeen: true
    };
  }
}