import 'package:zubair_onward_academy/res/components/pop_up_button.dart';
import 'package:zubair_onward_academy/res/components/round_button.dart';
import 'package:zubair_onward_academy/models/mcqs_model.dart';
import 'package:zubair_onward_academy/res/color.dart';
import 'package:flutter/material.dart';
import 'package:zubair_onward_academy/view/mcqsData/mcq_details_screen.dart';


class McqInterfaceScreen extends StatefulWidget {
  final McqsModel mcq;

  const McqInterfaceScreen({super.key, required this.mcq});

  @override
  State<McqInterfaceScreen> createState() => _McqInterfaceScreenState();
}

class _McqInterfaceScreenState extends State<McqInterfaceScreen> {
  int currentChapterIndex = 0;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.scaffoldColor,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06, vertical: screenWidth * 0.06),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  PopUpButton(
                    onPress: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(width: screenWidth * 0.04),
                  Flexible(
                    child: Text(
                      widget.mcq.title ?? "",
                      style: TextStyle(
                        fontSize: screenWidth * 0.06,
                        fontFamily: 'Sofia Pro',
                        color: AppColors.blackColor,
                      ),
                      overflow: TextOverflow.visible,
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.01),
              Padding(
                padding: EdgeInsets.only(left: screenWidth * 0.15),
                child: Flexible(
                  child: Text(
                    widget.mcq.category!.name ?? "N/A",
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      fontFamily: 'Sofia Pro',
                      color: AppColors.subtitleColor,
                    ),
                    overflow: TextOverflow.visible,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              const Divider(color: AppColors.greyColor,),
              SizedBox(height: screenHeight * 0.01),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    const CircleAvatar(
                      radius: 32,
                      backgroundColor: Color(0xff64ACBB),
                      child: Center(child: Icon(Icons.event_note_sharp, color: AppColors.whiteColor, size: 32,)),
                    ),
                    SizedBox(width: screenWidth * 0.02),
                    Text(widget.mcq.mcqsStatements!.length.toString() + (widget.mcq.mcqsStatements!.length == 1?'\nQuestion':'\nQuestions'), style: TextStyle(fontSize: screenWidth * 0.04, fontFamily: 'Sofia Pro', color: AppColors.subtitleColor),)
                  ],),
                  Row(children: [
                    const CircleAvatar(
                      radius: 32,
                      backgroundColor: AppColors.zoaColor,
                      child: Center(child: Icon(Icons.timer_outlined, color: AppColors.whiteColor, size: 32,)),
                    ),
                    SizedBox(width: screenWidth * 0.02),
                    Text('${widget.mcq.mcqsStatements!.length}\nQuestions', style: TextStyle(fontSize: screenWidth * 0.04, fontFamily: 'Sofia Pro', color: AppColors.subtitleColor),)
                  ],)
                ],
              ),
              SizedBox(height: screenHeight * 0.01),
              const Divider(color: AppColors.greyColor,),
              SizedBox(height: screenHeight * 0.02),
              Text('Instructions', style: TextStyle(fontSize: screenWidth * 0.06, fontFamily: 'Sofia Pro', color: AppColors.blackColor),),
              SizedBox(height: screenHeight * 0.01),
              Text(widget.mcq.desc.toString(), style: TextStyle(fontSize: screenWidth * 0.04, fontFamily: 'Sofia Pro', color: AppColors.subtitleColor),),
              const Spacer(),
              Align(
                alignment: Alignment.bottomCenter,
                child: RoundButton(
                  title: 'START TEST',
                  buttonHeight: screenHeight * 0.055,
                  buttonWidth: double.infinity,
                  buttonFont: screenWidth * 0.04,
                  buttonColor: AppColors.blackColor,
                  textColor: AppColors.whiteColor,
                  radius: 56,
                  loading: false,
                  onPress: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => McqDetailsScreen(mcq: widget.mcq), // Close the builder method properly
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}





