import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'Counter.g.dart';

class Counter {
  int id;

  Counter({@required this.id});

  Counter copyWith({int id}) {
    return Counter(id: id ?? this.id);
  }

  factory Counter.fromJson(Map<String, dynamic> json) =>
      _$CounterFromJson(json);

  Map<String, dynamic> toJson() => _$CounterToJson(this);
}
