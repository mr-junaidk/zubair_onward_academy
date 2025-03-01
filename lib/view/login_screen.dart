import 'package:zubair_onward_academy/res/components/round_button.dart';
import 'package:zubair_onward_academy/utils/routes/routes_name.dart';
import 'package:zubair_onward_academy/utils/utils.dart';
import 'package:zubair_onward_academy/res/color.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:zubair_onward_academy/viewmodel/auth_view_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final ValueNotifier<bool> _obsecurePassword = ValueNotifier<bool>(true);

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _obsecurePassword.dispose();
    _passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return Future.value(false);
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.scaffoldColor,
          body: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06, vertical: screenWidth * 0.06,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: SvgPicture.asset(
                        'assets/images/zoalogo.svg',
                        height: screenHeight * 0.15,
                        width: screenWidth * 0.15,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02,),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        'WELCOME BACK!',
                        style: TextStyle(
                          fontSize: screenWidth * 0.08,
                          fontFamily: 'Poppins Medium',
                          color: AppColors.blackColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.01,
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        'Use Credentials to access your account',
                        style: TextStyle(
                          fontSize: screenWidth * 0.04,
                          fontFamily: 'Poppins Regular',
                          color: AppColors.blackColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.04,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextFormField(
                          controller: _emailController,
                          obscureText: false,
                          keyboardType: TextInputType.emailAddress,
                          focusNode: emailFocusNode,
                          decoration: InputDecoration(
                            labelText: ' Email',
                            labelStyle: TextStyle(
                              fontFamily: 'Poppins Medium',
                              fontSize: screenWidth * 0.06,
                              color: AppColors.blackColor,
                            ),
                            hintText: ' abc@xyz.com',
                            hintStyle: TextStyle(
                              fontFamily: 'Poppins Regular',
                              fontSize: screenWidth * 0.04,
                              color: AppColors.subtitleColor,
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            fillColor: const Color(0xffFFFFFF),
                            filled: true,
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Color(0xffE4E7EB)),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Color(0xffE4E7EB)),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onFieldSubmitted: (value) {
                            Utils.fieldFocusChange(context, emailFocusNode, passwordFocusNode);
                          },
                        ),
                        SizedBox(
                          height: screenHeight * 0.025,
                        ),
                        ValueListenableBuilder(
                          valueListenable: _obsecurePassword,
                          builder: (context, value, child) {
                            return TextFormField(
                              controller: _passwordController,
                              obscureText: _obsecurePassword.value,
                              obscuringCharacter: '*',
                              focusNode: passwordFocusNode,
                              decoration: InputDecoration(
                                labelText: ' Password',
                                labelStyle: TextStyle(
                                  fontFamily: 'Poppins Medium',
                                  fontSize: screenWidth * 0.06,
                                  color: AppColors.blackColor,
                                ),
                                hintText: ' ********',
                                hintStyle: TextStyle(
                                  fontFamily: 'Poppins Regular',
                                  fontSize: screenWidth * 0.04,
                                  color: AppColors.subtitleColor,
                                ),
                                floatingLabelBehavior: FloatingLabelBehavior.always,
                                suffixIcon: InkWell(
                                  onTap: () {
                                    _obsecurePassword.value = !_obsecurePassword.value;
                                  },
                                  child: Icon(
                                    _obsecurePassword.value
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility,
                                  ),
                                ),
                                fillColor: const Color(0xffFFFFFF),
                                filled: true,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Color(0xffE4E7EB)),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Color(0xffE4E7EB)),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          height: screenHeight * 0.02,
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: InkWell(
                            onTap: () {},
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(
                                fontSize: screenWidth * 0.035,
                                fontFamily: 'Poppins Medium',
                                color: AppColors.blackColor,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 0.05,
                        ),
                        RoundButton(
                          title: 'Sign In',
                          buttonHeight: screenHeight * 0.06,
                          buttonColor: AppColors.buttonColor,
                          textColor: AppColors.scaffoldColor,
                          buttonWidth: screenWidth * 0.55,
                          buttonFont: screenWidth * 0.045,
                          loading: authViewModel.loading,
                          onPress: () {
                            Map data = {
                              'email': _emailController.text.toLowerCase(),
                              'password': _passwordController.text.toString(),
                            };
                            authViewModel.loginApi(data, context);
                          },
                          radius: 32,
                        ),
                        SizedBox(
                          height: screenHeight * 0.02,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an account?',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: screenWidth * 0.04,
                                fontFamily: 'Poppins Medium',
                                color: AppColors.blackColor,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, RoutesName.register);
                              },
                              child: Text(
                                ' Sign Up',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: screenWidth * 0.04,
                                  fontFamily: 'Poppins Medium',
                                  color: AppColors.blackColor,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
