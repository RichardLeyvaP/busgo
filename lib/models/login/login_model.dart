import 'package:freezed_annotation/freezed_annotation.dart';
part 'login_model.freezed.dart';
part 'login_model.g.dart';
//  factory Login.fromJson(Map<String, Object?> json) => _$LoginFromJson(json);

@freezed
class Login with _$Login {
  const factory Login({
    required int id,
    required String userName,
    required String email,
    required String token,
  }) = _Login;

  factory Login.fromJson(Map<String, Object?> json) => _$LoginFromJson(json);
}