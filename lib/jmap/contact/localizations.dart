import 'package:equatable/equatable.dart';

class LocalizedAddress with EquatableMixin {
  final List<Map<String, String>>? components; 
  final String? defaultSeparator;
  final String? full;
  final bool? isOrdered;

  LocalizedAddress({
    this.components,
    this.defaultSeparator,
    this.full,
    this.isOrdered,
  });

  factory LocalizedAddress.fromJson(Map<String, dynamic> json) {
    return LocalizedAddress(
      components: (json['components'] as List<dynamic>?)
          ?.whereType<Map<String, dynamic>>()
          .map((e) => {
                'kind': e['kind'] as String? ?? '',
                'value': e['value'] as String? ?? '',
              })
          .toList(),
      defaultSeparator: json['defaultSeparator'] as String?,
      full: json['full'] as String?,
      isOrdered: json['isOrdered'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    void writeNotNull(String key, dynamic value) {
      if (value != null) map[key] = value;
    }

    writeNotNull('components', components);
    writeNotNull('defaultSeparator', defaultSeparator);
    writeNotNull('full', full);
    writeNotNull('isOrdered', isOrdered);
    return map;
  }

  @override
  List<Object?> get props => [components, defaultSeparator, full, isOrdered];

  @override
  String toString() {
    return 'LocalizedAddress('
        'components: $components, '
        'defaultSeparator: $defaultSeparator, '
        'full: $full, '
        'isOrdered: $isOrdered'
        ')';
  }
}

