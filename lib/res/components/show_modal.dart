import 'package:zubair_onward_academy/res/color.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';


class ShowModal extends StatelessWidget {
  final List<Widget> children;

  const ShowModal({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenWidth * 0.05),
      child: AlertDialog(
        backgroundColor: AppColors.scaffoldColor,
        content: SizedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/images/zoalogo.svg', height: screenWidth * 0.25, width: screenWidth * 0.25),
              SizedBox(height: screenWidth * 0.04,),
              Text(
                'Your Resources, Your Choice',
                style: TextStyle(
                    fontSize: screenWidth * 0.04, fontFamily: 'Poppins Regular', color: AppColors.blackColor),
              ),
              SizedBox(height: screenHeight * 0.025),
              Column(
                children: children,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
