import 'package:zubair_onward_academy/res/components/container_button.dart';
import 'package:zubair_onward_academy/utils/utils.dart';
import 'package:zubair_onward_academy/viewmodel/category_view_model.dart';
import 'package:zubair_onward_academy/viewmodel/books_view_model.dart';
import 'package:zubair_onward_academy/res/components/show_modal.dart';
import 'package:zubair_onward_academy/utils/routes/routes_name.dart';
import 'package:zubair_onward_academy/res/color.dart';
import 'package:zubair_onward_academy/viewmodel/mcqs_view_model.dart';
import 'package:zubair_onward_academy/viewmodel/notes_view_model.dart';
import 'package:zubair_onward_academy/viewmodel/user_view_model.dart';
import 'package:provider/provider.dart';
import 'package:hovering/hovering.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  String _selectedMenuItem = '';

  @override
  Widget build(BuildContext context) {
    final categoryViewModel = Provider.of<CategoryViewModel>(context);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      decoration: const BoxDecoration(
        border: Border(
          right: BorderSide(
            color: Color(0xffE3E5E8),
            width: 1,
          ),
        ),
      ),
      child: Drawer(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        backgroundColor: AppColors.scaffoldColor,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06, vertical: screenWidth * 0.06),
          child: Column(
            children: [
              SizedBox(height: screenHeight * .05),
              Align(
                alignment: Alignment.topCenter,
                child: SvgPicture.asset(
                  'assets/images/zoalogo.svg',
                  height: screenHeight * 0.125,
                  width: screenWidth * 0.125,
                ),
              ),
              SizedBox(height: screenHeight * 0.02,),
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  'CATEGORIES',
                  style: TextStyle(
                      fontSize: screenWidth * 0.07,
                      fontFamily: 'Poppins Medium',
                      color: AppColors.blackColor),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              Text(
                'Select the best fit for your needs',
                style: TextStyle(
                    fontSize: screenWidth * 0.035,
                    fontFamily: 'Poppins Regular',
                    color: AppColors.blackColor),
              ),
              SizedBox(
                height: screenHeight * 0.04,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: categoryViewModel.categories.length,
                  itemBuilder: (context, index) {
                    final category = categoryViewModel.categories[index];
                    final isSelected = _selectedMenuItem == (category.name ?? '');

                    return HoverContainer(
                      hoverDecoration: BoxDecoration(
                        color: const Color(0xffE0E0E0),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xff1A8EFF).withOpacity(0.1)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: ListTile(
                        leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(category.image!, height: screenHeight * 0.1, width: screenWidth * 0.1,)),
                        title: Text(
                          category.name ?? 'Category',
                          style: TextStyle(
                            fontSize: screenWidth * 0.04,
                            fontFamily: 'Sofia Pro',
                            color: AppColors.blackColor,
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            _selectedMenuItem = category.name ?? '';
                          });
                          showDialog(context: context, builder: (BuildContext context){
                            return ShowModal(children: [
                              ContainerButton(containerImage: 'assets/images/lectures.png', containerText: 'Lectures',
                                  onPress: (){

                                  }),
                              ContainerButton(containerImage: 'assets/images/books.png', containerText: 'Books',
                                onPress: () async{
                                  try {
                                    final categoryId = category.id; // Get the selected category ID
                                    final booksViewModel = Provider.of<BooksViewModel>(context, listen: false);

                                    // Fetch books
                                    await booksViewModel.fetchBooks(categoryId ?? '', context);

                                    // Check if books are available
                                    if (booksViewModel.books.isNotEmpty) {
                                      Navigator.pushNamed(context, RoutesName.books); // Navigate to BooksScreen
                                    } else {
                                      // Show a message if user has no access
                                      Utils.flushBarErrorMessage('Access Denied!', context);
                                    }
                                  } catch (error) {
                                    // Handle any errors
                                    Utils.flushBarErrorMessage('Error! ${error.toString()}', context);
                                  }
                                },),
                              ContainerButton(containerImage: 'assets/images/notes.png', containerText: 'Notes',
                                onPress: () async{
                                  try {
                                    final categoryId = category.id; // Get the selected category ID
                                    final notesViewModel = Provider.of<NotesViewModel>(context, listen: false);

                                    // Fetch books
                                    await notesViewModel.fetchNotes(categoryId ?? '', context);

                                    // Check if books are available
                                    if (notesViewModel.notes.isNotEmpty) {
                                      Navigator.pushNamed(context, RoutesName.notes); // Navigate to BooksScreen
                                    } else {
                                      // Show a message if no books are available
                                      Utils.flushBarErrorMessage('Access Denied!', context);
                                    }
                                  } catch (error) {
                                    // Handle any errors
                                    Utils.flushBarErrorMessage('Error! ${error.toString()}', context);
                                  }
                                },),
                              ContainerButton(containerImage: 'assets/images/mcqs.png', containerText: 'Mcqs',
                                  onPress: () async{
                                    try {
                                      final categoryId = category.id; // Get the selected category ID
                                      final mcqsViewModel = Provider.of<McqsViewModel>(context, listen: false);

                                      // Fetch books
                                      await mcqsViewModel.fetchMcqs(categoryId ?? '', context);

                                      // Check if books are available
                                      if (mcqsViewModel.mcqs.isNotEmpty) {
                                        Navigator.pushNamed(context, RoutesName.mcqs); // Navigate to BooksScreen
                                      } else {
                                        // Show a message if no books are available
                                        Utils.flushBarErrorMessage('Access Denied!', context);
                                      }
                                    } catch (error) {
                                      // Handle any errors
                                      Utils.flushBarErrorMessage('Error! ${error.toString()}', context);
                                    }
                                  },)
                            ]);
                          });
                          // Add desired action here on menu item click
                        },
                      ),
                    );
                  },
                ),
              ),
              HoverContainer(
                hoverDecoration: BoxDecoration(
                  color: const Color(0xffE0E0E0),
                  borderRadius: BorderRadius.circular(8),
                ),
                decoration: BoxDecoration(
                  color: _selectedMenuItem == 'Logout'
                      ? const Color(0xff1A8EFF).withOpacity(0.1)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ListTile(
                  leading: SvgPicture.asset('assets/images/logout.svg', color: AppColors.blackColor, height: 32, width: 32),
                  title: Text(
                    'Logout',
                    style: TextStyle(
                      fontSize: screenWidth * 0.05,
                      fontFamily: 'Sofia Pro',
                      color: AppColors.blackColor,
                    ),
                  ),
                  onTap: () async{
                    setState(() {
                      _selectedMenuItem = 'Logout';
                    });

                    // Remove user data from SharedPreferences
                    bool success = await Provider.of<UserViewModel>(context, listen: false).removeUser();

                    if (success) {
                      // Navigate to login screen after successful logout
                      Navigator.pushNamedAndRemoveUntil(context, RoutesName.login, (route) => false,  // This ensures that the login screen is the only one in the stack
                      );
                    } else {
                      // Handle failure case (if needed)
                      Utils.flushBarErrorMessage('Failed to logout', context);
                    }

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



