import 'package:json_annotation/json_annotation.dart';

enum SystemUserAction {
  @JsonValue('PROVISION')
  provision,
  @JsonValue('DESTROY')
  destroy,
}
