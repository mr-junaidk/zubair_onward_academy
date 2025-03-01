import 'package:zubair_onward_academy/res/components/pop_up_button.dart';
import 'package:zubair_onward_academy/res/components/round_button.dart';
import 'package:zubair_onward_academy/utils/routes/routes_name.dart';
import 'package:zubair_onward_academy/utils/utils.dart';
import 'package:zubair_onward_academy/res/color.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:zubair_onward_academy/viewmodel/auth_view_model.dart';


class RegisterScreen extends StatefulWidget {

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final ValueNotifier<bool> _obsecurePassword = ValueNotifier<bool>(true);
  final ValueNotifier<bool> _obsecureConfirmPassword = ValueNotifier<bool>(true);
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  FocusNode userNameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode confirmPasswordFocusNode = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _userNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _obsecurePassword.dispose();
    _obsecureConfirmPassword.dispose();

  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
          backgroundColor: AppColors.scaffoldColor,
          body: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06, vertical: screenWidth * 0.06),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: PopUpButton(
                        onPress: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Align(
                        alignment: Alignment.topCenter,
                        child: SvgPicture.asset(
                          'assets/images/zoalogo.svg',
                          height: screenHeight * 0.15,
                          width: screenWidth * 0.15,
                        )),
                    SizedBox(height: screenHeight * 0.02,),
                    Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          'REGISTER',
                          style: TextStyle(
                              fontSize: screenWidth * 0.08,
                              fontFamily: 'Poppins Medium',
                              color: AppColors.blackColor),
                        )),
                    SizedBox(
                      height: screenHeight * 0.01,
                    ),
                    Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          'Just Some Information and you are in',
                          style: TextStyle(
                              fontSize: screenWidth * 0.04,
                              fontFamily: 'Poppins Regular',
                              color: AppColors.blackColor),
                        )),
                    SizedBox(
                      height: screenHeight * 0.04,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextFormField(
                          controller: _userNameController,
                          obscureText: false,
                          keyboardType: TextInputType.text,
                          focusNode: userNameFocusNode,
                          decoration: InputDecoration(
                            labelText: ' User Name',
                            labelStyle: TextStyle(
                                fontFamily: 'Poppins Medium',
                                fontSize: screenWidth * 0.06,
                                color: AppColors.blackColor),
                            hintText: ' username',
                            hintStyle: TextStyle(
                                fontFamily: 'Poppins Regular',
                                fontSize: screenWidth * 0.04,
                                color: AppColors.subtitleColor),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            fillColor: const Color(0xffFFFFFF),
                            filled: true,
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Color(0xffE4E7EB)),
                                borderRadius: BorderRadius.circular(8)),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Color(0xffE4E7EB)),
                                borderRadius: BorderRadius.circular(8)),
                          ),
                          onFieldSubmitted: (value) {
                            Utils.fieldFocusChange(
                                context, userNameFocusNode, emailFocusNode);
                          },
                        ),
                        SizedBox(
                          height: screenHeight * 0.025,
                        ),
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
                                color: AppColors.blackColor),
                            hintText: ' abc@xyz.com',
                            hintStyle: TextStyle(
                                fontFamily: 'Poppins Regular',
                                fontSize: screenWidth * 0.04,
                                color: AppColors.subtitleColor),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            fillColor: const Color(0xffFFFFFF),
                            filled: true,
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Color(0xffE4E7EB)),
                                borderRadius: BorderRadius.circular(8)),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Color(0xffE4E7EB)),
                                borderRadius: BorderRadius.circular(8)),
                          ),
                          onFieldSubmitted: (value) {
                            Utils.fieldFocusChange(
                                context, emailFocusNode, passwordFocusNode);
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
                                      color: AppColors.blackColor),
                                  hintText: ' ********',
                                  hintStyle: TextStyle(
                                      fontFamily: 'Poppins Regular',
                                      fontSize: screenWidth * 0.04,
                                      color: AppColors.subtitleColor),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  suffixIcon: InkWell(
                                      onTap: () {
                                        _obsecurePassword.value =
                                            !_obsecurePassword.value;
                                      },
                                      child: Icon(_obsecurePassword.value
                                          ? Icons.visibility_off_outlined
                                          : Icons.visibility)),
                                  fillColor: const Color(0xffFFFFFF),
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Color(0xffE4E7EB)),
                                      borderRadius: BorderRadius.circular(8)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Color(0xffE4E7EB)),
                                      borderRadius: BorderRadius.circular(8)),
                                ),
                                onFieldSubmitted: (value) {
                                  Utils.fieldFocusChange(
                                      context,
                                      passwordFocusNode,
                                      confirmPasswordFocusNode);
                                },
                              );
                            }),
                        SizedBox(
                          height: screenHeight * 0.025,
                        ),
                        ValueListenableBuilder(
                            valueListenable: _obsecureConfirmPassword,
                            builder: (context, value, child) {
                              return TextFormField(
                                controller: _confirmPasswordController,
                                obscureText: _obsecureConfirmPassword.value,
                                obscuringCharacter: '*',
                                focusNode: confirmPasswordFocusNode,
                                decoration: InputDecoration(
                                  labelText: ' Confirm Password',
                                  labelStyle: TextStyle(
                                      fontFamily: 'Poppins Medium',
                                      fontSize: screenWidth * 0.06,
                                      color: AppColors.blackColor),
                                  hintText: ' ********',
                                  hintStyle: TextStyle(
                                      fontFamily: 'Poppins Regular',
                                      fontSize: screenWidth * 0.04,
                                      color: AppColors.subtitleColor),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  suffixIcon: InkWell(
                                      onTap: () {
                                        _obsecureConfirmPassword.value =
                                            !_obsecureConfirmPassword.value;
                                      },
                                      child: Icon(_obsecureConfirmPassword.value
                                          ? Icons.visibility_off_outlined
                                          : Icons.visibility)),
                                  fillColor: const Color(0xffFFFFFF),
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Color(0xffE4E7EB)),
                                      borderRadius: BorderRadius.circular(8)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Color(0xffE4E7EB)),
                                      borderRadius: BorderRadius.circular(8)),
                                ),
                              );
                            }),
                        SizedBox(
                          height: screenHeight * 0.07,
                        ),
                        RoundButton(
                          title: 'Sign Up',
                          buttonHeight: screenHeight * 0.06,
                          buttonColor: AppColors.buttonColor,
                          textColor: AppColors.scaffoldColor,
                          buttonWidth: screenWidth * 0.55,
                          buttonFont: screenWidth * 0.045,
                          loading: authViewModel.registerLoading,
                          onPress: () {
                            if (_passwordController.text.toString() !=
                                _confirmPasswordController.text.toString()) {
                              Utils.flushBarErrorMessage(
                                  'Password and Confirm Password must be equal',
                                  context);
                            } else {
                              Map data = {
                                'name': _userNameController.text.toString(),
                                'email': _emailController.text.toLowerCase(),
                                'password': _passwordController.text.toString(),
                                'confirmPassword':
                                    _confirmPasswordController.text.toString(),
                                'role': 2,
                              };
                              authViewModel.registerApi(data, context);
                            }
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
                              'Already have an account?',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: screenWidth * 0.04,
                                  fontFamily: 'Poppins Medium',
                                  color: AppColors.blackColor),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, RoutesName.login);
                              },
                              child: Text(
                                ' Sign In',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: screenWidth * 0.04,
                                    fontFamily: 'Poppins Medium',
                                    color: AppColors.blackColor,
                                    decoration: TextDecoration.underline),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
