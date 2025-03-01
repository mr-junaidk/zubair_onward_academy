import 'package:shared_preferences/shared_preferences.dart';
import 'package:zubair_onward_academy/models/user_model.dart';
import 'package:flutter/material.dart';


class UserViewModel with ChangeNotifier {

  // Save user data to SharedPreferences
  Future<bool> saveUser(UserModel user) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();

    await sp.setString('token', user.token ?? '');
    await sp.setString('name', user.name ?? '');
    await sp.setString('email', user.email ?? '');
    await sp.setString('customerId', user.customerId ?? '');
    await sp.setInt('role', user.role ?? 0);

    notifyListeners();
    return true;
  }

  // Get user data from SharedPreferences
  Future<UserModel> getUser() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();

    final String? token = sp.getString('token');
    final String? name = sp.getString('name');
    final String? email = sp.getString('email');
    final String? customerId = sp.getString('customerId');
    final int? role = sp.getInt('role');

    return UserModel(
      token: token,
      name: name,
      email: email,
      customerId: customerId,
      role: role,
    );
  }

  // Remove user data from SharedPreferences
  Future<bool> removeUser() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();

    await sp.remove('token');
    await sp.remove('name');
    await sp.remove('email');
    await sp.remove('customerId');
    await sp.remove('role');

    notifyListeners();
    return true;
  }
}

