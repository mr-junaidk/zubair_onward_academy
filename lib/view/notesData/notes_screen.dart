import 'package:zubair_onward_academy/res/components/pop_up_button.dart';
import 'package:zubair_onward_academy/view/notesData/note_details_screen.dart';
import 'package:zubair_onward_academy/viewmodel/books_view_model.dart';
import 'package:zubair_onward_academy/res/color.dart';
import 'package:zubair_onward_academy/viewmodel/notes_view_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';


class NotesScreen extends StatefulWidget {
  final String categoryId;

  const NotesScreen({super.key, required this.categoryId});

  @override
  _NotesScreenState createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {

  @override
  void initState() {
    super.initState();
    // Fetch books when the screen is initialized
    Provider.of<BooksViewModel>(context, listen: false).fetchBooks(widget.categoryId, context);
  }

  @override
  Widget build(BuildContext context) {
    final notesViewModel = Provider.of<NotesViewModel>(context);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.scaffoldColor,
        body: notesViewModel.notesLoading
            ? const Center(child: CircularProgressIndicator())
            : notesViewModel.notes.isEmpty
            ? const Center(child: Text("No notes found", style: TextStyle(fontSize: 56, fontFamily: 'Poppins Light', color: AppColors.subtitleColor),))
            : Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06, vertical: screenWidth * 0.06),
              child: Column(
                children: [
                  Row(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: PopUpButton(onPress: () {
                          Navigator.pop(context);
                        },),
                      ),
                      SizedBox(width: screenWidth * 0.04),
                      Text('NOTES LIBRARY', style: TextStyle(
                        fontSize: screenWidth * 0.06,
                        fontFamily: 'Poppins Bold',
                        color: AppColors.blackColor,
                      ))
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.04),
                  Expanded(
                    child: ListView.builder(
                      itemCount: notesViewModel.notes.length,
                      itemBuilder: (context, index) {
                        final note = notesViewModel.notes[index];
                        return Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02, vertical: screenWidth * 0.02),
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.scaffoldColor,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: const [
                                  BoxShadow(
                                    color: AppColors.shadowColor,
                                    blurRadius: 8,
                                  )
                                ],
                              ),
                              child: ListTile(
                                leading: note.imageUrl != null
                                    ? ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(note.imageUrl!))
                                    : const Icon(Icons.notes),
                                title: Text(note.title ?? '', style: TextStyle(fontSize: screenWidth * 0.045, fontFamily: 'Sofia Pro', color: AppColors.blackColor),),
                                subtitle: Text(note.category!.name ?? '', style: TextStyle(fontSize: screenWidth * 0.04, fontFamily: 'Sofia Pro', color: AppColors.subtitleColor),),
                                onTap: () {
                                  // Navigate to book details screen
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => NoteDetailsScreen(note: note),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
      ),
    );
  }
}
