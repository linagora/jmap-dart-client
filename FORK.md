# JMAP dart client Fork

* We have added support for a number of different jmap options, which get explained in their own sections below in greater detail.
  * For these JMAP objects, we support the `/get`, `/set` (create/update/delete), and `/changes` (useful to implement sync) methods.
  * We additionally added [utility functions](#jmap-methods-and-corresponding-utils) for each object/jmap-method that make building the request easier.
  * [AddressBook and Contacts](#addressbook-and-contacts) a given account can have multiple address books, and contacts belong to one or more address books.
  * [Calendar and CalendarEvents](#calendar-and-calendarevents) a given account can have multiple calendars, and events belong to one or more calendars.
  * [File Nodes and Blobs](#file-nodes-and-blobs)
* We have tested interaction with these JMAP objects against three JMAP server implementations, see [JMAP Servers](#jmap-servers) and [Notes on Testing](#notes-on-testing) for details.

## JMAP Servers
We have mainly tested against three JMAP server implementations:

* [OpenXPort Core](https://github.com/audriga/openxport-jmap/tree/main)-Enabled (modified) RoundCube and Nextcloud servers
  * Tested contacts and calendar-events
* [Cyrus](https://www.cyrusimap.org/3.6/imap/download/installation/http/jmap.html): Tested contacts and calendar-events
* [Stalwart](https://github.com/stalwartlabs/stalwart): Tested contacts, address books, calendar-events, calendars, file-nodes, and blobs

## JMAP Methods and Corresponding Utils

We created utility functions to more easily execute some common requests, for a combination of object type (`AddressBook`, `CalendarEvent`, ...) and JMAP method on said object.
For an object of type `T` the utility methods are found in `TUtil`.

For example `ContactUtil`.

### /get

A jmap `/get` request (in its simplest form) returns a list of all objects of the matching type in the current account.

Utility functions `getT(client, accountId)` execute a jmap get for object type `T`, Returning a `Future<GetResponse<T>>`, which in turn contains a `List<T>` of the found objects.

For example `CalendarEventUtil.getCalendarEvents(client, accountId)` can be used to retrieve all calendar events.
### /set

A jmap `/set` request can be used to create, update, and delete items all in one request 
(by taking a Map for the objects to create (maps initial id to the object), a map for the objects to update (maps id to patch-object), and a list of (ids of) the objects to delete).

We have added each (per object type) three utility functions to create, update, or delete a single object:

* `createT(client, accountId, T)`
* `updateT(client, accoundId, patchObject)`
* `deleteT(client, accountId, objectId)` 
all of these return a `Future<SetTResponse>`.

For example `AddressBookUtil.createAddressBook(client, accountId, addressBook)` can be used to create a single address book.

We additionally provide `setT(client, accountId, createMap, updateMap, deleteIdList)` utility functions.

### /changes

A jmap `/changes` request takes in a state-string (which is included in jmap responses for `/get`, `/set` and some other methods), and returns lists indicating which changes happened between the old (given) state and the new (current) state.
The response includes id lists for created, modified and deleted objects, as well as the old state-string, the new state-string, and a boolean indicating if there are more changes to be retrieved.

Utility functions `changesT(client, accountId, sinceState)` perform such a `T/changes` request, returning a `Future<ChangesTResponse>`, which contains three sets of ids for created, updated, and destroyed.

For example `FileNodeUtil.changesFileNodes(client, accountId, sinceState);`.

## AddressBook and Contacts
As mentioned in the overview: A given account can have multiple address books, and contacts belong to one or more address books.
Address Books and Contacts are two separate JMAP objects, where contacts have a map of address books, indicating to which they belong.

You are able to simply get all contacts (regardless to which address books they belong) however to create a contact, you need to specify at least one address book it should be included in.
### Contact API Versions
This section applies **only to JMAP Contacts/Card/ContactCard**.  

For historic reasons, there are three different spec versions (used by different server implementations) for contacts which this library supports.
As a default the spec from the IETF draft is used, and **in the future the other spec variants for contacts will be dropped**.
See [ContactAPIVersions.md](ContactAPIVersions.md) for details.

### Address Books

Hold [Contacts](#contacts). Main properties of address books are

* Name
* Description
* See also [Spec AddressBooks](https://jmap.io/spec-contacts.html#addressbooks)

Utility Methods:
```dart
// AddressBook/get
 final getResponse = await AddressBookUtil.getAddressBooks(client, accountId);
// AddressBook/set
final setResponse = await AddressBookUtil.setAddressBooks(client, accountId, createMap, updateMap, deleteIdList);
final setResponse = await AddressBookUtil.createAddressBook(client, accountId, addressBook);
final setResponse = await AddressBookUtil.updateAddressBook(client, accountId, patch);
final setResponse = await AddressBookUtil.deleteAddressBook(client, accountId, addressBookId);
// AddresBook/changes
final changesResponse = await AddressBookUtil.changesAddressBooks(client, accountId, sinceState);
```

### Contacts

[//]: # (todo: note that old contact servers also don't support addressbooks)
Main properties of a contact (contactCard) are

* Name (structured as name components)
* Emails
* Phones
* ...
* See also [Spec ContactCards](https://jmap.io/spec-contacts.html#contactcards)

Utility Methods:
```dart
// ContactCard/get
 final getResponse = await ContactUtil.getConctacts(client, accountId);
// Conctact/set
final setResponse = await ContactUtil.setConctacts(client, accountId, createMap, updateMap, deleteIdList);
final setResponse = await ContactUtil.createConctact(client, accountId, conctact);
final setResponse = await ContactUtil.updateConctact(client, accountId, patch);
final setResponse = await ContactUtil.deleteConctact(client, accountId, conctactId);
// AddresBook/changes
final changesResponse = await ContactUtil.changesConctacts(client, accountId, sinceState);
```

## Calendar and CalendarEvents

As mentioned in the overview: A given account can have multiple calendars, and calendar events belong to one or more calendars.
Calendars and CalendarEvents are two separate JMAP objects, where calendarEvents have a map of calendars, indicating to which they belong.

You are able to simply get all calendarEvents (regardless to which calendar they belong) however to create a calendarEvent, you need to specify at least one calendar it should be included in.

### Parallel CalendarEvent Implementations

The original repository also includes calendarEvents already (in the `jmap/mail` subfolder), which is used in the mail (iMIP/ iTIP) context.

* For our purposes of getting the full JMAP calendarEvents directly via the `CalendarEvents/get` JMAP method we would have needed some changes.
* In order to avoid breaking any existing usage of calendarEvents in TMail, we created a separate `CalendarEvent` class in the `jmap` folder.
* In future collaboration, these two variants can be unified.

### Calendars

Hold [CalendarEvents](#calendarevents). Main properties of calendars are:

* Name
* Description
* Color
* See also [spec Calendars](https://jmap.io/spec-calendars.html#calendars)

Utility Methods:
```dart
// Calendar/get
final getResponse = await CalendarUtil.getCalendars(client, accountId);
// Calendar/set
final setResponse = await CalendarUtil.setCalendars(client, accountId, createMap, updateMap, deleteIdList);
final setResponse = await CalendarUtil.createCalendar(client, accountId, calendar);
final setResponse = await CalendarUtil.updateCalendar(client, accountId, patch);
final setResponse = await CalendarUtil.deleteCalendar(client, accountId, calendarId);
// AddresBook/changes
final changesResponse = await CalendarUtil.changesCalendars(client, accountId, sinceState);
```

### CalendarEvents

Represent an Event.
Main properties of calendarEvents are:

* Title
* Start
* Duration
* ...
* See also [spec CalendarEvents](https://jmap.io/spec-calendars.html#calendar-events)

Utility Methods:
```dart
// CalendarEvent/get
final getResponse = await CalendarEventUtil.getCalendarEvents(client, accountId);
// CalendarEvent/set
final setResponse = await CalendarEventUtil.setCalendarEvents(client, accountId, createMap, updateMap, deleteIdList);
final setResponse = await CalendarEventUtil.createCalendarEvent(client, accountId, calendarEvent);
final setResponse = await CalendarEventUtil.updateCalendarEvent(client, accountId, patch);
final setResponse = await CalendarEventUtil.deleteCalendarEvent(client, accountId, calendarEventId);
// AddresBook/changes
final changesResponse = await CalendarEventUtil.changesCalendarEvents(client, accountId, sinceState);
```

## File Nodes and Blobs
A given file is represented via two JMAP Objects: A `Blob`, which is the actualy binary data, and a `FileNode`, which contains the name, metadata, and a reference to the corresponding blob.

### Blobs
Blobs are arbitrary binary data, they can be retrieved (`Blob/get`) and created (`Blob/upload`) however they cannot be manually deleted or changed. Rather the JMAP server is supposed to remove unreferenced blobs. For more info see [RFC 9404](https://www.rfc-editor.org/rfc/rfc9404.html).

We support `Blob/get` and `Blob/upload`, and have corresponding utility-functions:
```dart
// Blob/get
final blobData = await BlobUtil.getBlob(client, accountId, blobId);
// Blob/ create
final Map<Id, Blob> response = await BlobUtil.uploadMultipart(client, accountId, blobMap);
final Blob? response = await BlobUtil.uploadBlobFromFile(client, accountId, file);
final Blob? response = await BlobUtil.uploadBlobFromBytes(client, accountId, bytes);
final Blob? response = await BlobUtil.uploadBlobFromText(client, accountId, content);
```

### FileNodes
FileNodes are currently only defined as a draft, see [draft-ietf-jmap-filenode](https://datatracker.ietf.org/doc/draft-ietf-jmap-filenode/).
FileNodes are hierarchical (can have parents/ children). FileNodes representing files reference a blobId, fileNodes wihtout blobIds represent folders.

Main Properties of FileNodes :

* name
* size
* blobId
* created/ modified dates
* ...

Utility functions:
```dart
// FileNode/get
final GetFileNodeResponse getResponse = await FileNodeUtil.getFileNodes(client, accountId);
final List<FileNode> folders = await FileNodeUtil.listAllFolders(client, accountId);
final List<FileNode> folderContents = await FileNodeUtil.listFolder(client, accountId, path);
final FileNode? fileNode = await FileNodeUtil.getFileNodeById(client, accountId, fileNodeId);
final File file = await FileNodeUtil.downloadToLocal(client, accountId, jmapPath, localPath);
final contents = await FileNodeUtil.downloadFile(client, accountId, jmapPath);
// FileNode/set
final String id = await FileNodeUtil.uploadFileFromText(client, accountId, fileName, textContents);
final String id = await FileNodeUtil.uploadFileFromBytes(client, accountId, fileName, bytes);
final String id = await FileNodeUtil.uploadFileFromPath(client, accountId, fileName, localPath);
final String id = await FileNodeUtil.createFileNode(client, accountId, blobId);
final String id = await FileNodeUtil.createFolder(client, accountId, name, parentId);
final SetFileNodeResponse setResponse = await FileNodeUtil.updateFileNode(client, accountId, patch);
final setResponse = await FileNodeUtil.deleteFileNode(client, accountId, fileNodeId);
// AddresBook/changes
final ChangesFileNodeResponse changesResponse = await FileNodeUtil.changesFileNodes(client, accountId, sinceState);
```



## Notes on Testing

We include several "Live Tests" (integration tests) which test against a running JMAP server.
These require valid JMAP credentials.
Create a file at `test/jmap/credentials/auth_*.json` with your account details:

```json
{
  "username": "user@example.com",
  "password": "secret",
  "url": "https://example.com/jmap"
}
```

Without this file, only unit tests (and tests with mocked responses) will run.
