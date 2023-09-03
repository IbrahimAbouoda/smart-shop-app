

// import 'dart:convert';

// class AuthServices {
//   static Future<ResponseModel> login(
//       {required String password, required String email}) async {
//     final prefs = await SharedPreferences.getInstance();

//     var url = Uri.parse("$base_url/login");
//     var response =
//         await http.post(url, body: {'email': email, 'password': password});

//     if (response.statusCode == 200) {
//       var jsonResponse = jsonDecode(response.body);

//       var userInfo = UserModel.fromJson(jsonResponse);

//       // save user token

//       if (userInfo.token != null) {
//         prefs.setString('token', 'Bearer ${userInfo.token}');
//       }

//       return ResponseModel(data: userInfo, message: 'success');
//     } else {
//       return ResponseModel(message: 'invalid');
//     }
//   }

//   static Future<bool> logout() async {
//     final prefs = await SharedPreferences.getInstance();

//     String token = '';
//     if (prefs.getString('token') != null) {
//       token = prefs.getString('token')!;
//     }

//     var url = Uri.parse("$base_url/logout");
//     var response =
//         await http.post(url, headers: {HttpHeaders.authorizationHeader: token});
//     if (response.statusCode == 200) {
//       return true;
//     } else {
//       return true;
//     }
//   }

//   static Future<ResponseModel> register(
//       {required String name,
//       required String email,
//       required String password,
//       required String confirmPassword,
//       required BuildContext context}) async {
//     var url = Uri.parse("$base_url/register");
//     var response = await http.post(url, body: {
//       'name': name,
//       'email': email,
//       'password': password,
//       'password_confirmation': confirmPassword
//     });

//     if (response.statusCode == 200) {
//       var userResponse = jsonDecode(response.body);
//       var user = UserModel.fromJson(userResponse);
//       showSnackBar(context: context, message: "Created User successfully");
//       return ResponseModel(data: user, message: "Success");
//     } else {
//       showSnackBar(
//           context: context,
//           message: "Created User Failed!",
//           color: Colors.redAccent);
//       return ResponseModel(message: "Failed");
//     }
//   }
// }
