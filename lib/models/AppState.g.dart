// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AppState.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppState _$AppStateFromJson(Map<String, dynamic> json) {
  return AppState(
      counterState: json['counterState'] == null
          ? null
          : Counter.fromJson(json['counterState'] as Map<String, dynamic>));
}

Map<String, dynamic> _$AppStateToJson(AppState instance) =>
    <String, dynamic>{'counterState': instance.counterState};
