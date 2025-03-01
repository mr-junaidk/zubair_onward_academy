import 'package:zubair_onward_academy/res/components/pop_up_button.dart';
import 'package:zubair_onward_academy/res/components/round_button.dart';
import 'package:zubair_onward_academy/models/mcqs_model.dart';
import 'package:zubair_onward_academy/res/color.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:zubair_onward_academy/view/mcqsData/mcqs_result_screen.dart';

class McqDetailsScreen extends StatefulWidget {
  final McqsModel mcq;

  const McqDetailsScreen({super.key, required this.mcq});

  @override
  State<McqDetailsScreen> createState() => _McqDetailsScreenState();
}

class _McqDetailsScreenState extends State<McqDetailsScreen> {
  int currentChapterIndex = 0;
  int selectedOption = -1;
  int correctAnswers = 0;
  int wrongAnswers = 0;
  bool isOptionSelected = false;
  bool isSidebarOpen = false;

  // Array to store attempted MCQs
  List<int?> attempted = [];

  @override
  void initState() {
    super.initState();
    // Initialize the attempted array with null values
    attempted = List<int?>.filled(widget.mcq.mcqsStatements?.length ?? 0, null);
  }

  void _toggleSidebar() {
    setState(() {
      isSidebarOpen = !isSidebarOpen;
    });
  }

  void _navigateToMcq(int index) {
    setState(() {
      currentChapterIndex = index;
      selectedOption = attempted[currentChapterIndex] ?? -1;
      isOptionSelected = attempted[currentChapterIndex] != null;
      // Close sidebar after navigation
      isSidebarOpen = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    void submitTestSheet() {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return Stack(
            children: [
              // Blurred background
              GestureDetector(
                onTap: () => Navigator.pop(context),
              ),
              // Bottom Sheet
              DraggableScrollableSheet(
                initialChildSize: 0.2,
                maxChildSize: 0.2,
                minChildSize: 0.2,
                builder: (_, controller) {
                  return Container(
                    decoration: const BoxDecoration(
                      color: AppColors.scaffoldColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: screenWidth * 0.06),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Want to submit?',
                            style: TextStyle(
                                fontSize: screenWidth * 0.04,
                                fontFamily: 'Sofia Pro',
                                color: AppColors.blackColor),
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RoundButton(
                                title: 'Submit',
                                buttonHeight: screenHeight * 0.055,
                                buttonColor: AppColors.buttonColor,
                                textColor: AppColors.whiteColor,
                                buttonWidth: screenWidth * 0.4,
                                buttonFont: screenWidth * 0.04,
                                onPress: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => McqsResultScreen(
                                        mcq: widget.mcq,
                                        correctAnswers: correctAnswers,
                                        wrongAnswers: wrongAnswers,
                                        skippedQuestions: widget.mcq.mcqsStatements!.length - attempted.where((a) => a != null).length,
                                        accuracyPercentage: ((correctAnswers / (widget.mcq.mcqsStatements?.length ?? 1)) * 100).toInt(),
                                      ),
                                    ),
                                  );
                                },
                                radius: 56,
                              ),
                              SizedBox(width: screenWidth * 0.02),
                              RoundButton(
                                title: 'Cancel',
                                buttonHeight: screenHeight * 0.055,
                                buttonColor: AppColors.buttonColor,
                                textColor: AppColors.whiteColor,
                                buttonWidth: screenWidth * 0.4,
                                buttonFont: screenWidth * 0.04,
                                onPress: () => Navigator.pop(context),
                                radius: 56,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        },
      );
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.scaffoldColor,
        body: Stack(
          children: [
            Padding(
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
                                      fontSize: screenWidth * 0.045,
                                      fontFamily: 'Sofia Pro',
                                      color: AppColors.whiteColor)),
                            ),
                            SizedBox(width: screenWidth * 0.04,),
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
                              if (!isOptionSelected) {
                                setState(() {
                                  selectedOption = index + 1;
                                  isOptionSelected = true;

                                  attempted[currentChapterIndex] =
                                      selectedOption;

                                  if (selectedOption ==
                                      widget
                                          .mcq
                                          .mcqsStatements![currentChapterIndex]
                                          .correctOption) {
                                    correctAnswers++;
                                  } else {
                                    wrongAnswers++;
                                  } if (attempted.every((element) => element != null)) {
                                    submitTestSheet();
                                  }
                                });
                              }
                            },
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: screenWidth * 0.12, bottom: screenWidth * 0.025),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: AppColors.whiteColor,
                                  boxShadow: [
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
                                          color: index + 1 == selectedOption
                                              ? const Color(0xff4CAF50)
                                              : AppColors.scaffoldColor,
                                        ),
                                        child: Center(
                                          child: Text(
                                            String.fromCharCode(65 + index),
                                            style: TextStyle(
                                              fontSize: screenWidth * 0.04,
                                              fontFamily: 'Sofia Pro',
                                              color: index + 1 == selectedOption
                                                  ? AppColors.whiteColor
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
                                            color: AppColors.subtitleColor,
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
                  currentChapterIndex == 0 && currentChapterIndex != widget.mcq.mcqsStatements!.length - 1
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
                                    selectedOption =
                                        attempted[currentChapterIndex] ?? -1;
                                    isOptionSelected =
                                        attempted[currentChapterIndex] != null;
                                  });
                                }
                              },
                            ),
                          ],
                        )
                      : currentChapterIndex == widget.mcq.mcqsStatements!.length - 1
                          ? Row(
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
                                        selectedOption =
                                            attempted[currentChapterIndex] ??
                                                -1;
                                        isOptionSelected =
                                            attempted[currentChapterIndex] !=
                                                null;
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
                                    return submitTestSheet();
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
                                        selectedOption =
                                            attempted[currentChapterIndex] ??
                                                -1;
                                        isOptionSelected =
                                            attempted[currentChapterIndex] !=
                                                null;
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
                                        selectedOption =
                                            attempted[currentChapterIndex] ??
                                                -1;
                                        isOptionSelected =
                                            attempted[currentChapterIndex] !=
                                                null;
                                      });
                                    }
                                  },
                                ),
                              ],
                            ),
                ],
              ),
            ),
            Positioned(
              left: screenWidth * 0.02,
              top: MediaQuery.of(context).size.height / 2 - screenWidth * 0.06,
              child: GestureDetector(
                onTap: _toggleSidebar,
                child: Container(
                  padding: EdgeInsets.all(screenWidth * 0.02),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                  ),
                  child: SvgPicture.asset(
                    'assets/images/doubleArrowRight.svg',
                    height: screenWidth * 0.06,
                    width: screenWidth * 0.06,
                    color: const Color(0xff4CAF50),
                  ),
                ),
              ),
            ),
            if (isSidebarOpen)
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.25),
                  child: Container(
                    width: screenWidth * 0.2,
                    decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(16),
                            bottomRight: Radius.circular(16))),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: screenWidth * 0.08),
                      child: ListView.builder(
                        itemCount: widget.mcq.mcqsStatements?.length ?? 0,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () => _navigateToMcq(index),
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: screenWidth * 0.02),
                              child: Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: AppColors.zoaColor, width: 3)),
                                child: CircleAvatar(
                                  backgroundColor: AppColors.whiteColor,
                                  radius: 16,
                                  child: Text(
                                    (index + 1).toString(),
                                    style: TextStyle(
                                      fontSize: screenWidth * 0.04,
                                      fontFamily: 'Sofia Pro',
                                      color: AppColors.zoaColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            if (isSidebarOpen)
              Positioned(
                left: screenWidth * 0.2,
                top: MediaQuery.of(context).size.height / 2 - screenWidth * 0.06,
                child: GestureDetector(
                  onTap: _toggleSidebar,
                  child: Container(
                    padding: EdgeInsets.all(screenWidth * 0.02),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                    ),
                    child: SvgPicture.asset(
                      'assets/images/doubleArrowLeft.svg',
                      height: screenWidth * 0.06,
                      width: screenWidth * 0.06,
                      color: const Color(0xff4CAF50),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
