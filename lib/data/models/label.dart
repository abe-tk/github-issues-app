import 'package:freezed_annotation/freezed_annotation.dart';

part 'label.freezed.dart';
part 'label.g.dart';

/// GitHubラベルモデル
@freezed
abstract class Label with _$Label {
  const factory Label({
    required int id,
    required String name,
    required String color,
    String? description,
  }) = _Label;

  factory Label.fromJson(Map<String, dynamic> json) => _$LabelFromJson(json);
}