import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/http/converter/delivery_status_converter.dart';
import 'package:jmap_dart_client/http/converter/reference_email_id_nullable_converter.dart';
import 'package:jmap_dart_client/http/converter/email_submission_id_nullable_converter.dart';
import 'package:jmap_dart_client/http/converter/id_converter.dart';
import 'package:jmap_dart_client/http/converter/id_nullable_converter.dart';
import 'package:jmap_dart_client/http/converter/thread_id_nullable_converter.dart';
import 'package:jmap_dart_client/http/converter/undo_status_nullable_converter.dart';
import 'package:jmap_dart_client/http/converter/utc_date_nullable_converter.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/core/utc_date.dart';
import 'package:jmap_dart_client/jmap/mail/email/email.dart';
import 'package:jmap_dart_client/jmap/mail/email/submission/delivery_status.dart';
import 'package:jmap_dart_client/jmap/mail/email/submission/email_submission_id.dart';
import 'package:jmap_dart_client/jmap/mail/email/submission/envelope.dart';

class EmailSubmission with EquatableMixin {
  final EmailSubmissionId? id;
  final Id? identityId;
  final EmailId? emailId;
  final ThreadId? threadId;
  final Envelope? envelope;
  final UTCDate? sendAt;
  final UndoStatus? undoStatus;
  final Map<String, DeliveryStatus>? deliveryStatus;
  final Set<Id>? dsnBlobIds;
  final Set<Id>? mdnBlobIds;

  EmailSubmission({
    this.id,
    this.identityId,
    this.emailId,
    this.threadId,
    this.envelope,
    this.sendAt,
    this.undoStatus,
    this.deliveryStatus,
    this.dsnBlobIds,
    this.mdnBlobIds
  });

  factory EmailSubmission.fromJson(Map<String, dynamic> json) {
    return EmailSubmission(
      id: const EmailSubmissionIdNullableConverter().fromJson(json['id'] as String?),
      identityId: const IdNullableConverter().fromJson(json['identityId'] as String?),
      emailId: const ReferenceEmailIdNullableConverter().fromJson(json['emailId'] as String?),
      threadId: const ThreadIdNullableConverter().fromJson(json['threadId'] as String?),
      envelope: json['envelope'] == null
          ? null
          : Envelope.fromJson(json['envelope'] as Map<String, dynamic>),
      sendAt: const UTCDateNullableConverter().fromJson(json['sendAt'] as String?),
      undoStatus: const UndoStatusNullableConverter().fromJson(json['undoStatus'] as String?),
      deliveryStatus: (json['deliveryStatus'] as Map<String, dynamic>?)
          ?.map((key, value) => DeliveryStatusConverter().parseEntry(key, value)),
      dsnBlobIds: (json['dsnBlobIds'] as List<dynamic>?)
          ?.map((json) => const IdConverter().fromJson(json)).toSet(),
      mdnBlobIds: (json['mdnBlobIds'] as List<dynamic>?)
          ?.map((json) => const IdConverter().fromJson(json)).toSet()
    );
  }

  Map<String, dynamic> toJson() {
    final val = <String, dynamic>{};

    void writeNotNull(String key, dynamic value) {
      if (value != null) {
        val[key] = value;
      }
    }

    writeNotNull('id', const EmailSubmissionIdNullableConverter().toJson(id));
    writeNotNull('identityId', const IdNullableConverter().toJson(identityId));
    writeNotNull('emailId', const ReferenceEmailIdNullableConverter().toJson(emailId));
    writeNotNull('threadId', const ThreadIdNullableConverter().toJson(threadId));
    writeNotNull('envelope', envelope?.toJson());
    writeNotNull('sendAt', const UTCDateNullableConverter().toJson(sendAt));
    writeNotNull('undoStatus', const UndoStatusNullableConverter().toJson(undoStatus));
    writeNotNull('deliveryStatus', deliveryStatus?.map((key, value) => DeliveryStatusConverter().toJson(key, value)));
    writeNotNull('dsnBlobIds', dsnBlobIds?.map((id) => const IdConverter().toJson(id)).toList());
    writeNotNull('mdnBlobIds', mdnBlobIds?.map((id) => const IdConverter().toJson(id)).toList());
    return val;
  }

  @override
  List<Object?> get props => [
    id,
    identityId,
    emailId,
    threadId,
    envelope,
    sendAt,
    undoStatus,
    deliveryStatus,
    dsnBlobIds,
    mdnBlobIds
  ];
}

class UndoStatus with EquatableMixin {
  static final UndoStatus pendingStatus = UndoStatus('pending');
  static final UndoStatus finalStatus = UndoStatus('final');
  static final UndoStatus canceledStatus = UndoStatus('canceled');

  final String value;

  UndoStatus(this.value);

  @override
  List<Object?> get props => [value];
}