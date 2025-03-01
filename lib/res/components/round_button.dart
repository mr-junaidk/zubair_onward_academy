import 'package:flutter_svg/svg.dart';
import 'package:zubair_onward_academy/res/color.dart';
import 'package:flutter/material.dart';


class RoundButton extends StatelessWidget {

  final String title;
  final double? buttonHeight;
  final double? buttonWidth;
  final double buttonFont;
  final Color buttonColor;
  final Alignment? containerAlignment;
  final Color textColor;
  final bool loading;
  final double radius;
  final Border? containerBorder;
  final VoidCallback onPress;
  final String? leftSvg;
  final String? rightSvg;
  final Color? leftSvgColor;
  final Color? rightSvgColor;

  const RoundButton({super.key, required this.title, this.loading = false, this.buttonHeight, required this.buttonColor, required this.textColor, this.buttonWidth, required this.buttonFont, required this.onPress, required this.radius, this.leftSvg, this.rightSvg, this.rightSvgColor, this.leftSvgColor, this.containerAlignment, this.containerBorder});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: onPress,
      child: Container(
        alignment: containerAlignment,
        height: buttonHeight,
        width: buttonWidth,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(radius),
          border: containerBorder
        ),
        child: Center(
          child: loading? const CircularProgressIndicator(color: AppColors.whiteColor,) : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if(leftSvg != null)
                SvgPicture.asset(leftSvg!, color: leftSvgColor!, height: screenWidth * 0.04, width: screenWidth * 0.04),
              SizedBox(width: screenWidth * 0.02,),
              Text(title,
                style: TextStyle(
                    fontSize: buttonFont,
                    fontFamily: 'Sofia Pro',
                    color: textColor),
              ),
              SizedBox(width: screenWidth * 0.02,),
              if(rightSvg != null)
                SvgPicture.asset(rightSvg!, color: rightSvgColor!, height: screenWidth * 0.04, width: screenWidth * 0.04),
            ],
          ),
        ),
      ),
    );
  }
}
