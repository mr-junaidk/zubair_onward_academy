import 'package:zubair_onward_academy/res/color.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';


class ContainerButton extends StatelessWidget {
  final String containerImage;
  final String containerText;
  final VoidCallback onPress;

  const ContainerButton({super.key, required this.containerImage, required this.containerText, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: onPress,
        child: Container(
          height: 60,
          width: 180,
          decoration: BoxDecoration(
            color: const Color(0xffFFFFFF),
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [
              BoxShadow(
                color: AppColors.blackColor,
                blurRadius: 5,
              )
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Row(
              children: [
                containerImage.endsWith('.svg')?SvgPicture.asset(containerImage, height: 36, width: 32,):Image(height: 36, width: 32, image: AssetImage(containerImage)),
                const SizedBox(width: 10),
                Text(containerText, style: const TextStyle(fontSize: 20,
                    fontFamily: 'Sofia Pro',
                    color: AppColors.blackColor),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



