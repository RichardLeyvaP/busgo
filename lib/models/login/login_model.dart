import 'package:freezed_annotation/freezed_annotation.dart';
part 'login_model.freezed.dart';
part 'login_model.g.dart';



@freezed
class Login with _$Login {
  const factory Login({
    required int id,
    required String userName,
    required String email,
    required String token,
    required String name,
    required int workerId,
    required String image,
    required int roleId,
    required String nameRole,
    required Branch branch,
  }) = _Login;

  factory Login.fromJson(Map<String, dynamic> json) => _$LoginFromJson(json);
}

@freezed
class Branch with _$Branch {
  const factory Branch({
    required int id,
    @JsonKey(name: 'company_id') required int companyId,
    required String name,
    required String image,
    required String rut,
    required String address,
    required String phone,
    required DateTime createdAt,
    required DateTime updatedAt,
    required Company company, // Cambié de Branch a Company
  }) = _Branch;

  factory Branch.fromJson(Map<String, dynamic> json) => _$BranchFromJson(json);
}

@freezed
class Company with _$Company {
  const factory Company({
    required int id,
    @JsonKey(name: 'user_id') required int userId,
    required String name,
    required String image,
    required String rut,
    required String address,
    required String phone,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Company;

  factory Company.fromJson(Map<String, dynamic> json) => _$CompanyFromJson(json);
}






// import 'package:freezed_annotation/freezed_annotation.dart';
// part 'login_model.freezed.dart';
// part 'login_model.g.dart';


// // Login loginFromJson(String str) => Login.fromJson(json.decode(str));

// // String loginToJson(Login data) => json.encode(data.toJson());
// @freezed
// class Login with _$Login {
//   const factory Login({
//     required int id,
//     required String userName,
//     required String email,
//     required String token,
//     required String name,
//     required int workerId,
//     required String image,
//     required int roleId,
//     required String nameRole,
//     required Branch branch,
//   }) = _Login;

//   factory Login.fromJson(Map<String, dynamic> json) => _$LoginFromJson(json);
// }

// @freezed
// class Branch with _$Branch {
//   const factory Branch({
//     required int id,
//     required int companyId,
//     required String name,
//     required String image,
//     required String rut,
//     required String address,
//     required String phone,
//     required DateTime createdAt,
//     required DateTime updatedAt,
//     required Branch company,
//     required int userId,
//   }) = _Branch;

//   factory Branch.fromJson(Map<String, dynamic> json) => _$BranchFromJson(json);
// }

//tirsoorlandopereztarrau@gmail.com