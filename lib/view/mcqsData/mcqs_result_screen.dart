import 'package:flutter/material.dart';
import 'package:zubair_onward_academy/models/mcqs_model.dart';
import 'package:zubair_onward_academy/res/color.dart';
import 'package:zubair_onward_academy/res/components/pop_up_button.dart';
import 'package:zubair_onward_academy/res/components/round_button.dart';
import 'package:zubair_onward_academy/view/mcqsData/mcqs_solution_screen.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class McqsResultScreen extends StatefulWidget {
  final McqsModel mcq;
  final int correctAnswers;
  final int wrongAnswers;
  final int skippedQuestions;
  final int accuracyPercentage;

  const McqsResultScreen({
    super.key,
    required this.correctAnswers,
    required this.wrongAnswers,
    required this.skippedQuestions,
    required this.accuracyPercentage, required this.mcq,
  });

  @override
  _McqsResultScreenState createState() => _McqsResultScreenState();
}

class _McqsResultScreenState extends State<McqsResultScreen> {
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
                      'TEST RESULT',
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
              SizedBox(height: screenHeight * 0.03),
              Text('Score and Stats', style: TextStyle(fontSize: screenWidth * 0.06, fontFamily: 'Sofia Pro', color: AppColors.subtitleColor)),
              SizedBox(height: screenHeight * 0.01),
              // Row of three circular charts (Skipped, Incorrect, Correct)
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.whiteColor,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: screenWidth * 0.04),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildCircularGraph('Correct', widget.correctAnswers, Colors.green, '${widget.correctAnswers}'),
                      _buildCircularGraph('Incorrect', widget.wrongAnswers, Colors.red, '${widget.wrongAnswers}'),
                      _buildCircularGraph('Skipped', widget.skippedQuestions, Colors.yellow, '${widget.skippedQuestions}'),
                    ],
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Text('Accuracy', style: TextStyle(fontSize: screenWidth * 0.06, fontFamily: 'Sofia Pro', color: AppColors.subtitleColor)),
              SizedBox(height: screenHeight * 0.01),
              // Circular chart for accuracy
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.whiteColor,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04, vertical: screenWidth * 0.04),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildAccuracyGraph(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const CircleAvatar(
                                radius: 12,
                                backgroundColor: AppColors.zoaColor,
                              ),
                              SizedBox(width: screenWidth * 0.02),
                              Text('ATTEMPTED : ${widget.correctAnswers + widget.wrongAnswers}', style: const TextStyle(fontSize: 16, fontFamily: 'Sofia Pro', color: AppColors.blackColor)),
                            ],
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          Row(
                            children: [
                              const CircleAvatar(
                                radius: 12,
                                backgroundColor: Color(0xff4CAF50),
                              ),
                              SizedBox(width: screenWidth * 0.02),
                              Text('CORRECT : ${widget.correctAnswers}', style: const TextStyle(fontSize: 16, fontFamily: 'Sofia Pro', color: AppColors.blackColor)),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              RoundButton(
                title: 'View Solutions',
                buttonColor: AppColors.whiteColor,
                containerBorder: Border.all(color: AppColors.zoaColor, width: screenHeight * 0.0015),
                textColor: AppColors.blackColor,
                buttonFont: screenWidth * 0.04,
                onPress: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => McqsSolutionScreen(mcq: widget.mcq),
                    ),
                  );
                },
                radius: 56,
                buttonHeight: screenHeight * 0.07,
                buttonWidth: double.infinity,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to build the individual circular chart
  Widget _buildCircularGraph(String label, int value, Color color, String centerText) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        SizedBox(
          height: screenHeight * 0.13,
          width: screenWidth * 0.29,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SfCircularChart(
                series: <CircularSeries>[
                  DoughnutSeries<_ChartData, String>(
                    dataSource: [
                      _ChartData(label, value),
                      _ChartData('Other', (widget.correctAnswers + widget.wrongAnswers + widget.skippedQuestions) - value),
                    ],
                    xValueMapper: (_ChartData data, _) => data.label,
                    yValueMapper: (_ChartData data, _) => data.value,
                    pointColorMapper: (_ChartData data, _) =>
                    data.label == label ? color : AppColors.scaffoldColor,
                    innerRadius: '88%',
                    startAngle: 90,
                    endAngle: 450,
                  ),
                ],
                tooltipBehavior: TooltipBehavior(enable: true),
              ),
              Text(
                centerText,
                style: TextStyle(
                  fontSize: screenWidth * 0.06,
                  fontFamily: 'Poppins Bold',
                  color: AppColors.blackColor,
                ),
              ),
            ],
          ),
        ),
        Text(label, style: TextStyle(fontSize: screenWidth * 0.04, fontFamily: 'Poppins Bold', color: AppColors.subtitleColor)),
      ],
    );
  }

  // Function to build the accuracy circular chart
  Widget _buildAccuracyGraph() {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        SizedBox(
          height: screenHeight * 0.18,
          width: screenHeight * 0.19,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SfCircularChart(
                series: <CircularSeries>[
                  DoughnutSeries<_ChartData, String>(
                    dataSource: [
                      _ChartData('Attempted', widget.correctAnswers + widget.wrongAnswers),
                      _ChartData('Correct', widget.correctAnswers),
                    ],
                    xValueMapper: (_ChartData data, _) => data.label,
                    yValueMapper: (_ChartData data, _) => data.value,
                    pointColorMapper: (_ChartData data, _) =>
                    data.label == 'Correct' ? const Color(0xff4CAF50) : AppColors.zoaColor,
                    innerRadius: '88%',
                    startAngle: 90,
                    endAngle: 450,
                  ),
                ],
                tooltipBehavior: TooltipBehavior(enable: true),
              ),
              Text(
                '${widget.accuracyPercentage}%',
                style: TextStyle(
                  fontSize: screenWidth * 0.06,
                  fontFamily: 'Poppins Bold',
                  color: AppColors.blackColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ChartData {
  _ChartData(this.label, this.value);

  final String label;
  final int value;
}
