import 'package:zubair_onward_academy/repository/auth_repository.dart';
import 'package:zubair_onward_academy/viewmodel/user_view_model.dart';
import 'package:zubair_onward_academy/utils/routes/routes_name.dart';
import 'package:zubair_onward_academy/models/user_model.dart';
import 'package:zubair_onward_academy/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class AuthViewModel with ChangeNotifier {
  final AuthRepository _authRepo = AuthRepository();

  // Loading initialization for sign-in
  bool _loading = false;
  bool get loading => _loading;

  // Loading initialization for register
  bool _registerLoading = false;
  bool get registerLoading => _registerLoading;

  // Loading for sign-in
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  // Loading for register
  setRegisterLoading(bool value) {
    _registerLoading = value;
    notifyListeners();
  }

  // User Login
  Future<void> loginApi(dynamic data, BuildContext context) async {
    // Start loading
    setLoading(true);

    try {
      // Call the login API
      dynamic response = await _authRepo.loginApi(data);
      // Stop loading
      setLoading(false);

      if (response is Map<String, dynamic>) {
        print('Response received: $response');

        // Save user data
        Map<String, dynamic>? userData = response['data']?['payload'];
        if (userData != null) {
          UserModel user = UserModel.fromJson(userData);
          final userViewModel = Provider.of<UserViewModel>(context, listen: false);
          userViewModel.saveUser(user);
        }

        // If user is login shift to category screen
        Utils.flushBarErrorMessage('Login Successful', context);
        Navigator.pushNamed(context, RoutesName.category);
      } else {
        print('Invalid response format: ${response.runtimeType}');
      }
    } catch (e) {
      setLoading(false);
      Utils.flushBarErrorMessage(e.toString(), context);

      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  // User Registration
  Future<void> registerApi(dynamic data, BuildContext context) async {
    setRegisterLoading(true);

    try {
      await _authRepo.registerApi(data);
      // Stop loading
      setRegisterLoading(false);

      // If user is registered shift to login screen
      Utils.flushBarErrorMessage('Registration Successful', context);
      Navigator.pushNamed(context, RoutesName.login);
    } catch (e) {
      setRegisterLoading(false);
      Utils.flushBarErrorMessage(e.toString(), context);

      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
}

// Get Token Method
Future<String?> getToken(BuildContext context) async {
  try {
    final userViewModel = Provider.of<UserViewModel>(context, listen: false);
    UserModel user = await userViewModel.getUser();
    return user.token;
  } catch (e) {
    if (kDebugMode) {
      print('Error retrieving token: $e');
    }
    return null;
  }
}
