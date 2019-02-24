import 'package:flutter/foundation.dart';
import './Counter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'AppState.g.dart';

@JsonSerializable()
class AppState {
  final Counter counterState;

  AppState({@required this.counterState});

  AppState.initialState() : counterState = Counter(id: 0);

  static AppState fromJson(dynamic json) {
    if (json != null) {
      //return AppState(counterState: Counter.fromJson(json['counterState']));
      return _$AppStateFromJson(json);
    } else {
      return AppState.initialState();
    }
  }

  Map<String, dynamic> toJson() => _$AppStateToJson(this);
}
