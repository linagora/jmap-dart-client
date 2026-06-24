import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/http/converter/email/email_body_value_converter.dart';
import 'package:jmap_dart_client/http/converter/email/email_keyword_identifier_converter.dart';
import 'package:jmap_dart_client/http/converter/email/email_mailbox_ids_converter.dart';
import 'package:jmap_dart_client/http/converter/email_id_nullable_converter.dart';
import 'package:jmap_dart_client/http/converter/id_nullable_converter.dart';
import 'package:jmap_dart_client/http/converter/message_ids_header_value_nullable_converter.dart';
import 'package:jmap_dart_client/http/converter/thread_id_nullable_converter.dart';
import 'package:jmap_dart_client/http/converter/unsigned_int_nullable_converter.dart';
import 'package:jmap_dart_client/http/converter/utc_date_nullable_converter.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/core/reference_id.dart';
import 'package:jmap_dart_client/jmap/core/unsigned_int.dart';
import 'package:jmap_dart_client/jmap/core/utc_date.dart';
import 'package:jmap_dart_client/jmap/mail/email/email_address.dart';
import 'package:jmap_dart_client/jmap/mail/email/email_body_part.dart';
import 'package:jmap_dart_client/jmap/mail/email/email_body_value.dart';
import 'package:jmap_dart_client/jmap/mail/email/email_header.dart';
import 'package:jmap_dart_client/jmap/mail/email/email_header_value.dart';
import 'package:jmap_dart_client/jmap/mail/email/individual_header_identifier.dart';
import 'package:jmap_dart_client/jmap/mail/email/keyword_identifier.dart';
import 'package:jmap_dart_client/jmap/mail/mailbox/mailbox.dart';

class Email with EquatableMixin {
  final EmailId? id;
  final Id? blobId;
  final ThreadId? threadId;
  final Map<MailboxId, bool>? mailboxIds;
  final Map<KeyWordIdentifier, bool>? keywords;
  final UnsignedInt? size;
  final UTCDate? receivedAt;
  final Set<EmailHeader>? headers;
  final MessageIdsHeaderValue? messageId;
  final MessageIdsHeaderValue? inReplyTo;
  final MessageIdsHeaderValue? references;
  final String? subject;
  final UTCDate? sentAt;
  final bool? hasAttachment;
  final String? preview;
  final Set<EmailAddress>? sender;
  final Set<EmailAddress>? from;
  final Set<EmailAddress>? to;
  final Set<EmailAddress>? cc;
  final Set<EmailAddress>? bcc;
  final Set<EmailAddress>? replyTo;
  final Set<EmailBodyPart>? textBody;
  final Set<EmailBodyPart>? htmlBody;
  final Set<EmailBodyPart>? attachments;
  final EmailBodyPart? bodyStructure;
  final Map<PartId, EmailBodyValue>? bodyValues;
  final Map<IndividualHeaderIdentifier, EmailHeaderValue> individualHeaders;

  Email({
    this.id,
    this.blobId,
    this.threadId,
    this.mailboxIds,
    this.keywords,
    this.size,
    this.receivedAt,
    this.headers,
    this.messageId,
    this.inReplyTo,
    this.references,
    this.subject,
    this.sentAt,
    this.hasAttachment,
    this.preview,
    this.sender,
    this.from,
    this.to,
    this.cc,
    this.bcc,
    this.replyTo,
    this.textBody,
    this.htmlBody,
    this.attachments,
    this.bodyStructure,
    this.bodyValues,
    this.individualHeaders = const {},
  });

  // Backward-compat getters for pre-existing individual headers
  TextHeaderValue? get headerUserAgent {
    final value = individualHeaders[IndividualHeaderIdentifier.headerUserAgent];
    return value is TextHeaderValue ? value : null;
  }

  TextHeaderValue? get headerMdn {
    final value = individualHeaders[IndividualHeaderIdentifier.headerMdn];
    return value is TextHeaderValue ? value : null;
  }

  TextHeaderValue? get headerReturnPath {
    final value = individualHeaders[IndividualHeaderIdentifier.headerReturnPath];
    return value is TextHeaderValue ? value : null;
  }

  TextHeaderValue? get headerCalendarEvent {
    final value =
        individualHeaders[IndividualHeaderIdentifier.headerCalendarEvent];
    return value is TextHeaderValue ? value : null;
  }

  TextHeaderValue? get sMimeStatusHeader {
    final value = individualHeaders[IndividualHeaderIdentifier.sMimeStatusHeader];
    return value is TextHeaderValue ? value : null;
  }

  TextHeaderValue? get identityHeader {
    final value = individualHeaders[IndividualHeaderIdentifier.identityHeader];
    return value is TextHeaderValue ? value : null;
  }

  TextHeaderValue? get xPriorityHeader {
    final value = individualHeaders[IndividualHeaderIdentifier.xPriorityHeader];
    return value is TextHeaderValue ? value : null;
  }

  TextHeaderValue? get importanceHeader {
    final value = individualHeaders[IndividualHeaderIdentifier.importanceHeader];
    return value is TextHeaderValue ? value : null;
  }

  TextHeaderValue? get priorityHeader {
    final value = individualHeaders[IndividualHeaderIdentifier.priorityHeader];
    return value is TextHeaderValue ? value : null;
  }

  TextHeaderValue? get listPostHeader {
    final value = individualHeaders[IndividualHeaderIdentifier.listPostHeader];
    return value is TextHeaderValue ? value : null;
  }

  TextHeaderValue? get listUnsubscribeHeader {
    final value =
        individualHeaders[IndividualHeaderIdentifier.listUnsubscribeHeader];
    return value is TextHeaderValue ? value : null;
  }

  factory Email.fromJson(Map<String, dynamic> json) {
    return Email(
      id: const EmailIdNullableConverter().fromJson(json['id'] as String?),
      blobId: const IdNullableConverter().fromJson(json['blobId'] as String?),
      threadId: const ThreadIdNullableConverter().fromJson(json['threadId'] as String?),
      mailboxIds: (json['mailboxIds'] as Map<String, dynamic>?)?.map((key, value) => EmailMailboxIdsConverter().parseEntry(key, value)),
      keywords: (json['keywords'] as Map<String, dynamic>?)?.map((key, value) => EmailKeywordIdentifierConverter().parseEntry(key, value)),
      size: const UnsignedIntNullableConverter().fromJson(json['size'] as int?),
      receivedAt: const UTCDateNullableConverter().fromJson(json['receivedAt'] as String?),
      headers: (json['headers'] as List<dynamic>?)
          ?.map((item) {
            try {
              return EmailHeader.fromJson(item);
            } catch (_) {
              return null;
            }
          })
          .whereType<EmailHeader>()
          .toSet(),
      messageId: const MessageIdsHeaderValueNullableConverter().fromJson((json['messageId'] as List<dynamic>?)),
      inReplyTo: const MessageIdsHeaderValueNullableConverter().fromJson((json['inReplyTo'] as List<dynamic>?)),
      references: const MessageIdsHeaderValueNullableConverter().fromJson((json['references'] as List<dynamic>?)),
      subject: json['subject'] as String?,
      sentAt: const UTCDateNullableConverter().fromJson(json['sentAt'] as String?),
      hasAttachment: json['hasAttachment'] as bool?,
      preview: json['preview'] as String?,
      sender: (json['sender'] as List<dynamic>?)?.map((json) => EmailAddress.fromJson(json)).toSet(),
      from: (json['from'] as List<dynamic>?)?.map((json) => EmailAddress.fromJson(json)).toSet(),
      to: (json['to'] as List<dynamic>?)?.map((json) => EmailAddress.fromJson(json)).toSet(),
      cc: (json['cc'] as List<dynamic>?)?.map((json) => EmailAddress.fromJson(json)).toSet(),
      bcc: (json['bcc'] as List<dynamic>?)?.map((json) => EmailAddress.fromJson(json)).toSet(),
      replyTo: (json['replyTo'] as List<dynamic>?)?.map((json) => EmailAddress.fromJson(json)).toSet(),
      textBody: (json['textBody'] as List<dynamic>?)?.map((json) => EmailBodyPart.fromJson(json)).toSet(),
      htmlBody: (json['htmlBody'] as List<dynamic>?)?.map((json) => EmailBodyPart.fromJson(json)).toSet(),
      attachments: (json['attachments'] as List<dynamic>?)?.map((json) => EmailBodyPart.fromJson(json)).toSet(),
      bodyStructure: json['bodyStructure'] == null
        ? null
        : EmailBodyPart.fromJson(json['bodyStructure'] as Map<String, dynamic>),
      bodyValues: () {
        final raw = json['bodyValues'] as Map<String, dynamic>?;
        if (raw == null) return null;
        final result = <PartId, EmailBodyValue>{};
        for (final entry in raw.entries) {
          try {
            final parsed = EmailBodyValueConverter().parseEntry(entry.key, entry.value);
            result[parsed.key] = parsed.value;
          } catch (_) {}
        }
        return result.isEmpty ? null : result;
      }(),
      individualHeaders: () {
        final result = <IndividualHeaderIdentifier, EmailHeaderValue>{};
        for (final e in json.entries.where((e) => e.key.startsWith('header:'))) {
          try {
            result[IndividualHeaderIdentifier(e.key)] = EmailHeaderValue.fromJson(e.key, e.value);
          } catch (_) {
            result[IndividualHeaderIdentifier(e.key)] = RawHeaderValue(e.value?.toString());
          }
        }
        return result;
      }(),
    );
  }

  Map<String, dynamic> toJson() {
    final val = <String, dynamic>{};

    void writeNotNull(String key, dynamic value) {
      if (value != null) {
        val[key] = value;
      }
    }

    writeNotNull('id', const EmailIdNullableConverter().toJson(id));
    writeNotNull('blobId', const IdNullableConverter().toJson(blobId));
    writeNotNull('threadId', const ThreadIdNullableConverter().toJson(threadId));
    writeNotNull('mailboxIds', mailboxIds?.map((key, value) => EmailMailboxIdsConverter().toJson(key, value)));
    writeNotNull('keywords', keywords?.map((key, value) => EmailKeywordIdentifierConverter().toJson(key, value)));
    writeNotNull('size', const UnsignedIntNullableConverter().toJson(size));
    writeNotNull('receivedAt', const UTCDateNullableConverter().toJson(receivedAt));
    writeNotNull('headers', headers?.map((header) => header.toJson()).toList());
    writeNotNull('messageId', const MessageIdsHeaderValueNullableConverter().toJson(messageId));
    writeNotNull('inReplyTo', const MessageIdsHeaderValueNullableConverter().toJson(inReplyTo));
    writeNotNull('references', const MessageIdsHeaderValueNullableConverter().toJson(references));
    writeNotNull('subject', subject);
    writeNotNull('sentAt', const UTCDateNullableConverter().toJson(sentAt));
    writeNotNull('hasAttachment', hasAttachment);
    writeNotNull('preview', preview);
    writeNotNull('sender', sender?.map((sender) => sender.toJson()).toList());
    writeNotNull('from', from?.map((from) => from.toJson()).toList());
    writeNotNull('to', to?.map((to) => to.toJson()).toList());
    writeNotNull('cc', cc?.map((cc) => cc.toJson()).toList());
    writeNotNull('bcc', bcc?.map((bcc) => bcc.toJson()).toList());
    writeNotNull('replyTo', replyTo?.map((replyTo) => replyTo.toJson()).toList());
    writeNotNull('textBody', textBody?.map((text) => text.toJson()).toList());
    writeNotNull('htmlBody', htmlBody?.map((html) => html.toJson()).toList());
    writeNotNull('attachments', attachments?.map((attachment) => attachment.toJson()).toList());
    writeNotNull('bodyStructure', bodyStructure?.toJson());
    writeNotNull('bodyValues', bodyValues?.map((key, value) => EmailBodyValueConverter().toJson(key, value)));
    individualHeaders.forEach((id, value) {
      try {
        final serialized = value.toJson();
        if (serialized == null) return;
        val[id.value] = serialized;
      } catch (_) {}
    });

    return val;
  }

  @override
  List<Object?> get props => [
    id,
    blobId,
    threadId,
    mailboxIds,
    keywords,
    size,
    receivedAt,
    headers,
    messageId,
    inReplyTo,
    references,
    subject,
    sentAt,
    hasAttachment,
    preview,
    sender,
    from,
    to,
    cc,
    bcc,
    replyTo,
    textBody,
    htmlBody,
    attachments,
    bodyStructure,
    bodyValues,
    // treat null and empty map as equal — both mean "no individual headers present"
    individualHeaders.isEmpty == true ? null : individualHeaders,
  ];
}

class EmailId with EquatableMixin {
  final Id id;

  EmailId(this.id);

  @override
  String toString() {
    if (id is ReferenceId) {
      return '${(id as ReferenceId).prefix.value}${(id as ReferenceId).id.value}';
    }
    return super.toString();
  }

  @override
  List<Object?> get props => [id];
}

class ThreadId with EquatableMixin {
  final Id id;

  ThreadId(this.id);

  @override
  List<Object?> get props => [id];
}

class MessageIdsHeaderValue with EquatableMixin {
  final Set<String> ids;

  MessageIdsHeaderValue(this.ids);

  @override
  List<Object?> get props => [ids];
}