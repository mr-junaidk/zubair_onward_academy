import 'package:zubair_onward_academy/res/color.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';


class PopUpButton extends StatelessWidget {
  final VoidCallback onPress;


  const PopUpButton({super.key, required this.onPress});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: onPress,
      child: CircleAvatar(
        radius: 24,
        backgroundColor: const Color(0xffCB1818),
        child: Center(child: SvgPicture.asset('assets/images/arrow.svg', color: AppColors.whiteColor, height: screenWidth * 0.04, width: screenWidth * 0.04,)),
      ),
    );
  }
}
