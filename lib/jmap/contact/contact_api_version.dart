/// Defines which JMAP Contacts API version to use.
/// 
/// - [jscontact]: older "Card/get" version used by Nextcloud and Roundcube as per custom JMAP specification.
/// - [cyrus]: newer "Contact/get" version used by Cyrus JMAP as per custom Cyrus JMAP specification.
/// - [ietf]: latest "ContactCard/get" version as per IETF JMAP Contacts specification.
enum ContactApiVersion {
  jscontact,
  cyrus,
  ietf,
}