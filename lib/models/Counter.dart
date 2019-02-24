import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

class Counter {
  int id;

  Counter({@required this.id});

  Counter copyWith({int id}) {
    return Counter(id: id ?? this.id);
  }

  static Counter fromJson(dynamic json) => new Counter(id: json["id"] as int);

  dynamic toJson() => {'id': id};
}
