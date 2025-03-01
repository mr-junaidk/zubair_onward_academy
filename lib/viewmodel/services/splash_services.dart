import 'package:zubair_onward_academy/viewmodel/user_view_model.dart';
import 'package:zubair_onward_academy/utils/routes/routes_name.dart';
import 'package:zubair_onward_academy/models/user_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';


class SplashServices {
  Future<UserModel> getUserData(BuildContext context) async {
    final userViewModel = Provider.of<UserViewModel>(context, listen: false);
    return await userViewModel.getUser();
  }

  void checkAuthentication(BuildContext context) async {
    try {
      UserModel user = await getUserData(context);

      await Future.delayed(const Duration(seconds: 3));

      if (user.token == null || user.token!.isEmpty) {
        Navigator.pushReplacementNamed(context, RoutesName.login);
      } else {
        Navigator.pushReplacementNamed(context, RoutesName.category);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error in checkAuthentication: $e');
      }
    }
  }
}
