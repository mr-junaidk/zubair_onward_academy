import 'package:zubair_onward_academy/res/components/pop_up_button.dart';
import 'package:zubair_onward_academy/res/components/round_button.dart';
import 'package:zubair_onward_academy/models/mcqs_model.dart';
import 'package:zubair_onward_academy/res/color.dart';
import 'package:flutter/material.dart';

class McqsSolutionScreen extends StatefulWidget {
  final McqsModel mcq;

  const McqsSolutionScreen({super.key, required this.mcq});

  @override
  State<McqsSolutionScreen> createState() => _McqsSolutionScreenState();
}

class _McqsSolutionScreenState extends State<McqsSolutionScreen> {
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
                    widget.mcq.category!.name ?? "",
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
              const Divider(color: AppColors.greyColor),
              SizedBox(height: screenHeight * 0.01),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    const CircleAvatar(
                      radius: 24,
                      backgroundColor: Color(0xff64ACBB),
                      child: Center(
                          child: Icon(Icons.event_note_sharp,
                              color: AppColors.whiteColor, size: 32)),
                    ),
                    SizedBox(width: screenWidth * 0.02),
                    Text(
                        widget.mcq.mcqsStatements!.length.toString() +
                            (widget.mcq.mcqsStatements!.length == 1
                                ? '\nQuestion'
                                : '\nQuestions'),
                        style: TextStyle(
                            fontSize: screenWidth * 0.04,
                            fontFamily: 'Sofia Pro',
                            color: AppColors.subtitleColor))
                  ]),
                  Row(children: [
                    const CircleAvatar(
                      radius: 24,
                      backgroundColor: AppColors.zoaColor,
                      child: Center(
                          child: Icon(Icons.timer_outlined,
                              color: AppColors.whiteColor, size: 32)),
                    ),
                    SizedBox(width: screenWidth * 0.02),
                    Text('${widget.mcq.mcqsStatements!.length}\nQuestions',
                        style: TextStyle(
                            fontSize: screenWidth * 0.04,
                            fontFamily: 'Sofia Pro',
                            color: AppColors.subtitleColor))
                  ])
                ],
              ),
              SizedBox(height: screenHeight * 0.01),
              const Divider(color: AppColors.greyColor),
              SizedBox(height: screenHeight * 0.02),
              if (widget.mcq.mcqsStatements != null &&
                  widget.mcq.mcqsStatements!.isNotEmpty)
                Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundColor: AppColors.zoaColor,
                          radius: 16,
                          child: Text((currentChapterIndex + 1).toString(),
                              style: TextStyle(
                                  fontSize: screenWidth * 0.04,
                                  fontFamily: 'Sofia Pro',
                                  color: AppColors.whiteColor)),
                        ),
                        SizedBox(width: screenWidth * 0.04),
                        Flexible(
                          child: Text(
                            widget.mcq.mcqsStatements![currentChapterIndex]
                                .statement ??
                                '',
                            style: TextStyle(
                              fontSize: screenWidth * 0.04,
                              fontFamily: 'Poppins Medium',
                              color: AppColors.blackColor,
                            ),
                            textAlign: TextAlign.justify,
                            overflow: TextOverflow.visible,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: screenHeight * 0.025,
                    ),
                    ...List.generate(
                      widget.mcq.mcqsStatements![currentChapterIndex]
                          .options!.length,
                          (index) => GestureDetector(
                        onTap: () {

                        },
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: screenWidth * 0.12, bottom: screenWidth * 0.025),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: AppColors.whiteColor,
                              boxShadow: const [
                                BoxShadow(
                                  color: AppColors.shadowColor,
                                  blurRadius: 2,
                                )
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: screenWidth * 0.02, vertical: screenWidth * 0.02),
                              child: Row(
                                children: [
                                  Container(
                                    width: screenWidth * 0.08,
                                    height: screenWidth * 0.08,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      borderRadius:
                                      BorderRadius.circular(8),
                                      border: Border.all(
                                        color: AppColors.greyColor,
                                        width: screenWidth * 0.002,
                                      ),
                                      color: (index + 1 == widget.mcq.mcqsStatements![currentChapterIndex].correctOption)
                                          ? const Color(0xff4CAF50) // Green for correct option
                                          : AppColors.scaffoldColor,
                                    ),
                                    child: Center(
                                      child: Text(
                                        String.fromCharCode(65 + index),
                                        style: TextStyle(
                                          fontSize: screenWidth * 0.04,
                                          fontFamily: 'Sofia Pro',
                                          color: (index + 1 == widget.mcq.mcqsStatements![currentChapterIndex].correctOption)
                                              ? AppColors.whiteColor // White text for correct option
                                              : AppColors.subtitleColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: screenWidth * 0.02),
                                  Flexible(
                                    child: Text(
                                      widget
                                          .mcq
                                          .mcqsStatements![
                                      currentChapterIndex]
                                          .options![index],
                                      style: TextStyle(
                                        fontSize: screenWidth * 0.035,
                                        fontFamily: 'Poppins Medium',
                                        color: (index + 1 == widget.mcq.mcqsStatements![currentChapterIndex].correctOption)
                                            ? const Color(0xff4CAF50)
                                            : AppColors.subtitleColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              else
                Center(
                    child: Text(
                      'No MCQs Available',
                      style: TextStyle(
                          fontSize: screenWidth * 0.06,
                          fontFamily: 'Poppins Bold',
                          color: AppColors.subtitleColor),
                    )),
              const Spacer(),
              currentChapterIndex == 0
                  ? Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  RoundButton(
                    containerAlignment: Alignment.centerRight,
                    rightSvg: 'assets/images/doubleArrowRight.svg',
                    rightSvgColor: const Color(0xff4CAF50),
                    title: 'Next',
                    buttonHeight: null,
                    buttonWidth: null,
                    buttonFont: screenWidth * 0.04,
                    buttonColor: AppColors.scaffoldColor,
                    textColor: AppColors.subtitleColor,
                    radius: 16,
                    loading: false,
                    onPress: () {
                      if (currentChapterIndex <
                          (widget.mcq.mcqsStatements?.length ?? 0) -
                              1) {
                        setState(() {
                          currentChapterIndex++;
                        });
                      }
                    },
                  ),
                ],
              )
                  : currentChapterIndex == widget.mcq.mcqsStatements!.length - 1
                  ? Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  RoundButton(
                    containerAlignment: Alignment.centerLeft,
                    leftSvg: 'assets/images/doubleArrowLeft.svg',
                    leftSvgColor: const Color(0xff4CAF50),
                    title: 'Previous',
                    buttonHeight: null,
                    buttonWidth: null,
                    buttonFont: screenWidth * 0.04,
                    buttonColor: AppColors.scaffoldColor,
                    textColor: AppColors.subtitleColor,
                    radius: 16,
                    loading: false,
                    onPress: () {
                      if (currentChapterIndex > 0) {
                        setState(() {
                          currentChapterIndex--;
                        });
                      }
                    },
                  ),
                ],
              )
                  : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RoundButton(
                    leftSvg: 'assets/images/doubleArrowLeft.svg',
                    leftSvgColor: const Color(0xff4CAF50),
                    title: 'Previous',
                    buttonHeight: null,
                    buttonWidth: null,
                    buttonFont: screenWidth * 0.04,
                    buttonColor: AppColors.scaffoldColor,
                    textColor: AppColors.subtitleColor,
                    radius: 16,
                    loading: false,
                    onPress: () {
                      if (currentChapterIndex > 0) {
                        setState(() {
                          currentChapterIndex--;
                        });
                      }
                    },
                  ),
                  RoundButton(
                    rightSvg:
                    'assets/images/doubleArrowRight.svg',
                    rightSvgColor: const Color(0xff4CAF50),
                    title: 'Next',
                    buttonHeight: null,
                    buttonWidth: null,
                    buttonFont: screenWidth * 0.04,
                    buttonColor: AppColors.scaffoldColor,
                    textColor: AppColors.subtitleColor,
                    radius: 16,
                    loading: false,
                    onPress: () {
                      if (currentChapterIndex <
                          (widget.mcq.mcqsStatements?.length ??
                              0) -
                              1) {
                        setState(() {
                          currentChapterIndex++;
                        });
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
