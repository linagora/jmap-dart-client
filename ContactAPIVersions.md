* Before there existed an official IETF spec for contacts, both we (in OpenXPort) and Cyrus (see [Servers](#jmap-servers) section above) started developing our own object model for JMAP contacts.
    * Since our version (in OpenXPort) was based on JSContacts, we retroactively named it the "JSContact version".
* At a later point the IETF JMAP spec draft was extended to also include contacts. This is the "official IETF version"([draft-ietf-jmap-contacts](https://datatracker.ietf.org/doc/draft-ietf-jmap-contacts/10/)).
    * The naming also changed, from `Card` to `ContactCard`.
* This library _currently_ supports all three versions, chosen via the `ContactApiVersion` enum.
    * **In the future we plan on dropping the two other two API versions and just maintain the IETF version.**


| Version             | Enum Value  | Class         | Implementing Servers                           | Description                                                                                                                       |
|---------------------|-------------|---------------|------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------|
| **JsContact**       | `jscontact` | `Card`        | OpenXPort ((modified) Nextcloud and Roundcube) | Compatible with older JSContact based custom spec currently available in Nextcloud and Roundcube using structured `Card` objects. |
| **Cyrus**           | `cyrus`     | `Card`        | Cyrus                                          | Legacy JMAP Contacts format used by Cyrus JMAP using structured `Card` objects.                                                   |
| **IETF (RFC 9553)** | `ietf`      | `ContactCard` | Stalwart                                       | Official JMAP Contacts standard  using structured `ContactCard` objects.                                                          |

Select the API version when building a request:

```dart
final method = SetCardMethod(
  accountId,
  apiVersion: ContactApiVersion.ietf, // or ContactApiVersion.cyrus or ContactApiVersion.jscontact
);
```

Further notes, the older spec implementations did not consider addressBooks yet, thus a signle, global, addressBook can be assumed, which does not need to be (and cannot be) specified upon contact creation.