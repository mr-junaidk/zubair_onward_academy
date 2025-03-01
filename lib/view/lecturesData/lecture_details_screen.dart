import 'package:flutter/material.dart';
import 'package:zubair_onward_academy/models/lectures_model.dart';

class LectureDetailsScreen extends StatefulWidget {
  final LecturesModel lecture;

  const LectureDetailsScreen({super.key, required this.lecture});

  @override
  State<LectureDetailsScreen> createState() => _LectureDetailsScreenState();
}

class _LectureDetailsScreenState extends State<LectureDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
