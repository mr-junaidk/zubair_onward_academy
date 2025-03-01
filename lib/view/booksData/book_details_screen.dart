import 'package:zubair_onward_academy/res/components/pop_up_button.dart';
import 'package:zubair_onward_academy/res/components/round_button.dart';
import 'package:zubair_onward_academy/models/books_model.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:zubair_onward_academy/res/color.dart';
import 'package:flutter/material.dart';


class BookDetailsScreen extends StatefulWidget {
  final BooksModel book;

  const BookDetailsScreen({super.key, required this.book});

  @override
  State<BookDetailsScreen> createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen> {
  bool isLoading = false;
  int currentChapterIndex = 0;

  Future<void> _refreshData() async {
    setState(() {
      isLoading = true;
    });

    await Future.delayed(Duration(seconds: 2));

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final currentChapter = widget.book.chapters != null &&
        widget.book.chapters!.isNotEmpty
        ? widget.book.chapters![currentChapterIndex]
        : null;

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.scaffoldColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: PopUpButton(
                      onPress: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.04),
                  Text(
                    widget.book.title ?? "",
                    style: TextStyle(
                      fontSize: screenWidth * 0.06,
                      fontFamily: 'Poppins Bold',
                      color: AppColors.blackColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.04),
              widget.book.imageUrl != null
                  ? ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(widget.book.imageUrl!))
                  : const Icon(Icons.book, size: 100),
              SizedBox(height: screenHeight * 0.02),
              Text(widget.book.title ?? "N/A",
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  fontFamily: 'Sofia Pro',
                  color: AppColors.blackColor,
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Text(widget.book.category!.name ?? "N/A",
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  fontFamily: 'Sofia Pro',
                  color: AppColors.subtitleColor,
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Text(
                "CHAPTERS",
                style: TextStyle(
                  fontSize: screenWidth * 0.06,
                  fontFamily: 'Sofia Pro',
                  color: AppColors.blackColor,
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Prev Button
                  RoundButton(
                    title: "Prev",
                    buttonHeight: screenHeight * 0.08,
                    buttonWidth: screenWidth * 0.3,
                    buttonFont: screenWidth * 0.04,
                    buttonColor: AppColors.buttonColor,
                    textColor: AppColors.whiteColor,
                    radius: 10,
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
                    title: "Next",
                    buttonHeight: screenHeight * 0.08,
                    buttonWidth: screenWidth * 0.3,
                    buttonFont: screenWidth * 0.04,
                    buttonColor: AppColors.buttonColor,
                    textColor: AppColors.whiteColor,
                    radius: 10,
                    loading: false,
                    onPress: () {
                      if (currentChapterIndex <
                          (widget.book.chapters!.length - 1)) {
                        setState(() {
                          currentChapterIndex++;
                        });
                      }
                    },
                  ),
                ],
              ),

              currentChapter != null
                  ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    currentChapter.title ?? '',
                    style: TextStyle(
                      fontSize: screenWidth * 0.06,
                      fontFamily: 'Poppins Medium',
                      color: AppColors.blackColor,
                    ),
                  ),

                  Html(
                    data: currentChapter.content ??
                        "<p>No content available</p>",
                    style: {
                      "p": Style(
                        fontSize: FontSize(screenWidth * 0.04),
                        fontFamily: 'Poppins Regular',
                        color: AppColors.subtitleColor,
                        textAlign: TextAlign.justify,
                      ),
                      "ul": Style(
                        padding: HtmlPaddings(left: HtmlPadding(screenWidth * 0.05)),
                      ),
                      "ol": Style(
                        padding: HtmlPaddings(left: HtmlPadding(screenWidth * 0.05)),
                      ),
                      "li": Style(
                        fontSize: FontSize(screenWidth * 0.04),
                        fontFamily: 'Poppins Regular',
                        color: AppColors.subtitleColor,
                      ),
                    },
                  ),
                ],
              ): Center(child: Text("No chapters available", style: TextStyle(fontSize: screenWidth * 0.06, fontFamily: 'Poppins Light', color: AppColors.subtitleColor),)),
            ],
          ),
        ),
      ),
    );
  }
}
