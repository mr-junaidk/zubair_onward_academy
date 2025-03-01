import 'package:zubair_onward_academy/res/components/pop_up_button.dart';
import 'package:zubair_onward_academy/viewmodel/auth_view_model.dart';
import 'package:zubair_onward_academy/res/color.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';


class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    final height = MediaQuery.of(context).size.height * 1;

    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 24.0, left: 24.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: PopUpButton(onPress: () {

                  },),
                ),
              ),
              SizedBox(height: height * .1,),
              const Padding(
                padding: EdgeInsets.only(left: 24.0),
                child: Text('Verification Code', style: TextStyle(fontFamily: 'Poppins Medium', fontSize: 30, color: AppColors.whiteColor),),
              ),
              SizedBox(height: height * .03,),
              const Padding(
                padding: EdgeInsets.only(left: 24.0),
                child: Text('Please type the verification code sent to \n', style: TextStyle(fontFamily: 'Poppins Regular', fontSize: 14, color: AppColors.whiteColor),),
              ),
              Padding(
                padding: const EdgeInsets.all(24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 65,
                      width: 65,
                      child: TextFormField(
                        decoration: InputDecoration(
                          fillColor: const Color(0xffFFFFFF),
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Color(0xffE4E7EB)),
                              borderRadius: BorderRadius.circular(10)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Color(0xffE4E7EB)),
                              borderRadius: BorderRadius.circular(10)),
                        ),

                      ),

                    ),
                    SizedBox(
                      height: 65,
                      width: 65,
                      child: TextFormField(
                        decoration: InputDecoration(
                          fillColor: const Color(0xffFFFFFF),
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Color(0xffE4E7EB)),
                              borderRadius: BorderRadius.circular(10)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Color(0xffE4E7EB)),
                              borderRadius: BorderRadius.circular(10)),
                        ),


                      ),

                    ),
                    SizedBox(
                      height: 65,
                      width: 65,
                      child: TextFormField(
                        decoration: InputDecoration(
                          fillColor: const Color(0xffFFFFFF),
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Color(0xffE4E7EB)),
                              borderRadius: BorderRadius.circular(10)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Color(0xffE4E7EB)),
                              borderRadius: BorderRadius.circular(10)),
                        ),

                      ),

                    ),
                    SizedBox(
                      height: 65,
                      width: 65,
                      child: TextFormField(
                        decoration: InputDecoration(
                          fillColor: const Color(0xffFFFFFF),
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Color(0xffE4E7EB)),
                              borderRadius: BorderRadius.circular(10)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Color(0xffE4E7EB)),
                              borderRadius: BorderRadius.circular(10)),
                        ),

                      ),

                    ),
                  ],
                ),
              ),
              SizedBox(height: height * .03,),
              Padding(
                padding: const EdgeInsets.only(left: 24.0),
                child: Row(
                  children: [
                    const Text(
                      'I don\'t recieve a code!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Poppins Regular',
                          color: AppColors.whiteColor),
                    ),
                    InkWell(
                      onTap: (){
                      },
                      child: const Text(
                        ' Please resend',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Poppins regular',
                            color: AppColors.buttonColor,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
