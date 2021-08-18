# JMAP Dart client

A [JMAP](https://jmap.io/) client library to make JMAP method calls and process the responses.

We most notably use it to write the [TMail Flutter application](https://github.com/linagora/tmail-flutter) but you might reuse this library to write your own JMAP application.

We do welcome all contributions, given decent test coverage and acceptable code quality.

Please report any problem, any feature request, or discuss how you plan to use this lib in the repository [issues](https://github.com/linagora/jmap-dart-client/issues).

## Code samples

#### GetSession:
```dart
// create instance of httpClient with Dio
// using BasicAuth to config Dio
final httpClient = HttpClient(Dio());

final getSessionBuilder = GetSessionBuilder(httpClient);
final session = await getSessionBuilder.build().execute();
```

#### Fetching mailboxes
```dart
final processingInvocation = ProcessingInvocation();
final jmapRequestBuilder = JmapRequestBuilder(httpClient, processingInvocation);

final getMailboxMethod = GetMailboxMethod(accountId)
  ..addProperties(Properties({'role', 'name'}));

final queryInvocation = jmapRequestBuilder.invocation(getMailboxMethod);

final responseObject = await (jmapRequestBuilder
    ..usings(getMailboxCreated.requiredCapabilities))
  .build()
  .execute();

final getMailboxResponse = responseObject.parse<GetMailboxResponse>(
  queryInvocation.methodCallId,
  GetMailboxResponse.deserialize);
```

#### Get emails in Mailbox
```dart
final processingInvocation = ProcessingInvocation();

final jmapRequestBuilder = JmapRequestBuilder(httpClient, processingInvocation);

final queryEmailMethod = QueryEmailMethod(accountId)
  ..addPosition(0)
  ..addLimit(UnsignedInt(20))
  ..addSorts({EmailComparator(EmailComparatorProperty.sentAt)..setIsAscending(false)})
  ..addFilters(EmailFilterCondition(inMailbox: inBoxId));

final queryEmailInvocation = jmapRequestBuilder.invocation(queryEmailMethod);

final getEmailMethod = GetEmailMethod(accountId)
  ..addProperties(Properties({'id', 'subject','from', 'keywords', 'sentAt', 'preview', 'hasAttachment'}))
  ..addReferenceIds(processingInvocation.createResultReference(
    queryEmailInvocation.methodCallId,
    ReferencePath.idsPath));

final getEmailInvocation = jmapRequestBuilder.invocation(getEmailMethod);

final responseObject = await (jmapRequestBuilder
    ..usings(getEmailMethod.requiredCapabilities))
  .build()
  .execute();

final getEmailResponse = responseObject.parse<GetEmailResponse>(
    getEmailInvocation.methodCallId, 
    GetEmailResponse.deserialize);
```
