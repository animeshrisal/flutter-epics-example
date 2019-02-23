import 'package:flutter/foundation.dart';

class Counter {
  final int id;

  Counter({@required this.id});

  Counter copyWith({int id}) {
    return Counter(id: id ?? this.id);
  }
}
