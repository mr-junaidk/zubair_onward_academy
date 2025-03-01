import 'dart:io';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:zubair_onward_academy/models/notes_model.dart';
import 'package:http/http.dart' as http;
import 'package:zubair_onward_academy/res/components/pop_up_button.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:zubair_onward_academy/res/color.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class NoteDetailsScreen extends StatefulWidget {
  final NotesModel note;

  const NoteDetailsScreen({super.key, required this.note});

  @override
  State<NoteDetailsScreen> createState() => _NoteDetailsScreenState();
}

class _NoteDetailsScreenState extends State<NoteDetailsScreen> {
  String? pdfPath;
  int? totalPages = 0;

  // Function to download PDF and save it to local storage
  Future<String> downloadPDF(String url) async {
    final response = await http.get(Uri.parse(url));
    final bytes = response.bodyBytes;
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/note.pdf');
    await file.writeAsBytes(bytes);
    return file.path;
  }

  @override
  void initState() {
    super.initState();
    if (widget.note.content != null && widget.note.content!.contains("pdf")) {
      // If content contains a PDF URL, download it and save to local storage
      downloadPDF(widget.note.content!).then((path) {
        setState(() {
          pdfPath = path;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.scaffoldColor,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06, vertical: screenWidth * 0.06),
          child: SingleChildScrollView(
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
                        widget.note.title ?? "",
                        style: TextStyle(
                          fontSize: screenWidth * 0.06,
                          fontFamily: 'Poppins Bold',
                          color: AppColors.blackColor,
                        ),
                        overflow: TextOverflow.visible,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.04),
                widget.note.imageUrl != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(widget.note.imageUrl!))
                    : const Icon(Icons.book, size: 100),
                SizedBox(height: screenHeight * 0.02),
                Text(
                  widget.note.title ?? "N/A",
                  style: TextStyle(
                    fontSize: screenWidth * 0.04,
                    fontFamily: 'Sofia Pro',
                    color: AppColors.blackColor,
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                Text(
                  widget.note.category!.name ?? "N/A",
                  style: TextStyle(
                    fontSize: screenWidth * 0.04,
                    fontFamily: 'Sofia Pro',
                    color: AppColors.subtitleColor,
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                widget.note.content != null
                    ? widget.note.content!.contains("pdf")
                    ? pdfPath != null
                    ? SizedBox(
                  height: screenHeight * 0.6,
                  child: PDFView(
                    filePath: pdfPath!,
                    onPageChanged: (int? current, int? total) {
                      setState(() {
                        totalPages = total;
                      });
                    },
                  ),
                )
                    : const Center(child: CircularProgressIndicator())
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Html(
                            data: widget.note.content ??
                                "<p>No content available</p>",
                            style: {
                              "p": Style(
                                fontSize: FontSize(screenWidth * 0.04),
                                fontFamily: 'Poppins Regular',
                                color: AppColors.subtitleColor,
                                textAlign: TextAlign.justify,
                              ),
                              "ul": Style(
                                padding: HtmlPaddings(left: HtmlPadding(screenWidth * 0.04)),
                              ),
                              "ol": Style(
                                padding: HtmlPaddings(left: HtmlPadding(screenWidth * 0.04)),
                              ),
                              "li": Style(
                                fontSize: FontSize(screenWidth * 0.04),
                                fontFamily: 'Poppins Regular',
                                color: AppColors.subtitleColor,
                              ),
                            },
                          ),
                        ],
                      )
                    : Center(
                        child: Text(
                        "No content available",
                        style: TextStyle(
                            fontSize: screenWidth * 0.06,
                            fontFamily: 'Poppins Bold',
                            color: AppColors.subtitleColor),
                      )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

