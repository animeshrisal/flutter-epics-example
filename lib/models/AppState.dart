import 'package:flutter/foundation.dart';
import './Counter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'AppState.g.dart';

@JsonSerializable()
class AppState {
  final Counter counterState;

  AppState({@required this.counterState});

  AppState.initialState() : counterState = Counter(id: 0);

  factory AppState.fromJson(Map<String, dynamic> json) =>
      _$AppStateFromJson(json);

  Map<String, dynamic> toJson() => _$AppStateToJson(this);
}
