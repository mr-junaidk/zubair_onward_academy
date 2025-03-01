import 'package:zubair_onward_academy/res/components/pop_up_button.dart';
import 'package:zubair_onward_academy/viewmodel/books_view_model.dart';
import 'package:zubair_onward_academy/view/booksData/book_details_screen.dart';
import 'package:zubair_onward_academy/res/color.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';


class BooksScreen extends StatefulWidget {
  final String categoryId;

  const BooksScreen({super.key, required this.categoryId});

  @override
  _BooksScreenState createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen> {
  bool isLoading = false;

  Future<void> _refreshData() async {
    setState(() {
      isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    // Fetch books when the screen is initialized
    Provider.of<BooksViewModel>(context, listen: false).fetchBooks(widget.categoryId, context);
  }

  @override
  Widget build(BuildContext context) {
    final booksViewModel = Provider.of<BooksViewModel>(context);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.scaffoldColor,
        body: booksViewModel.booksLoading
            ? const Center(child: CircularProgressIndicator())
            : booksViewModel.books.isEmpty
            ? const Center(child: Text("No books found", style: TextStyle(fontSize: 56, fontFamily: 'Poppins Light', color: AppColors.subtitleColor),))
            : RefreshIndicator(
              onRefresh: _refreshData,
              child: Padding(
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
                        Flexible(
                          child: Text('BOOKS LIBRARY', style: TextStyle(
                            fontSize: screenWidth * 0.06,
                            fontFamily: 'Poppins Bold',
                            color: AppColors.blackColor,
                          ),
                            overflow: TextOverflow.visible,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.04),
                    Expanded(
                      child: ListView.builder(
                        itemCount: booksViewModel.books.length,
                        itemBuilder: (context, index) {
                          final book = booksViewModel.books[index];
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
                                  leading: book.imageUrl != null
                                      ? ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(book.imageUrl!))
                                      : const Icon(Icons.book),
                                  title: Text(book.title ?? '', style: TextStyle(fontSize: screenWidth * 0.045, fontFamily: 'Sofia Pro', color: AppColors.blackColor),),
                                  subtitle: Text(book.category!.name ?? '', style: TextStyle(fontSize: screenWidth * 0.04, fontFamily: 'Sofia Pro', color: AppColors.subtitleColor),),
                                  onTap: () {
                                    // Navigate to book details screen
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => BookDetailsScreen(book: book),
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
      ),
    );
  }
}
