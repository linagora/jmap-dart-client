import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/jmap/contact/contact_card.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/contact/contact_ids.dart';
import 'package:jmap_dart_client/jmap/contact/address_values.dart';
import 'package:jmap_dart_client/jmap/contact/organization_values.dart';
import 'package:jmap_dart_client/jmap/contact/phone_values.dart';
import 'package:jmap_dart_client/jmap/contact/email_values.dart';
import 'package:jmap_dart_client/jmap/contact/title_values.dart';
import 'package:jmap_dart_client/jmap/contact/related_to_values.dart';
import 'package:jmap_dart_client/jmap/contact/anniversary_values.dart';
import 'contact_api_version.dart';
import 'card.dart';

/// Base class for ALL contact formats:
/// - JSContact 
/// - IETF ContactCard
/// - Cyrus legacy 
abstract class Contact with EquatableMixin {
  final Id? id;
  final String? created;
  final String? updated;

  /// Shared fields across all specifications
  final Map<EmailId, EmailValue>? emails;
  final Map<PhoneId, PhoneValue>? phones;
  final Map<AddressId, AddressValue>? addresses;
  final Map<OrganizationName, OrganizationValue>? organizations;
  final Map<RelatedToName, RelatedToValue>? relatedTo;
  final Map<TitleId, TitleValue>? titles;
  final Map<AnniversaryId, AnniversaryValue>? anniversaries;

  Contact({
    this.id,
    this.created,
    this.updated,
    this.emails,
    this.phones,
    this.addresses,
    this.organizations,
    this.relatedTo,
    this.titles,
    this.anniversaries,
  });

  /// Creates a Contact using the correct parser based on the API version.
  factory Contact.fromJson(
    Map<String, dynamic> json, {
    ContactApiVersion? apiVersion,
  }) {
    switch (apiVersion) {
      case ContactApiVersion.ietf:
        return ContactCard.fromJson(json);

      case ContactApiVersion.cyrus:
        // Cyrus contact JSON
        return Card.fromCyrusJson(json);

      case ContactApiVersion.jscontact:
      default:
        // Default to IETF ContactCard parsing
        return Card.fromJson(json, apiVersion: ContactApiVersion.ietf);
    }
  }

  /// Subclasses must export JSON using their own rules
  Map<String, dynamic> toJson();

  @override
  List<Object?> get props => [
        id,
        created,
        updated,
        emails,
        phones,
        addresses,
        organizations,
        relatedTo,
        titles,
        anniversaries,
      ];
}
