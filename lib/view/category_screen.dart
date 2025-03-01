import 'package:flutter/services.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:zubair_onward_academy/res/components/container_button.dart';
import 'package:zubair_onward_academy/utils/utils.dart';
import 'package:zubair_onward_academy/viewmodel/category_view_model.dart';
import 'package:zubair_onward_academy/res/components/custom_drawer.dart';
import 'package:zubair_onward_academy/res/components/round_button.dart';
import 'package:zubair_onward_academy/viewmodel/books_view_model.dart';
import 'package:zubair_onward_academy/res/components/show_modal.dart';
import 'package:zubair_onward_academy/utils/routes/routes_name.dart';
import 'package:zubair_onward_academy/res/color.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zubair_onward_academy/viewmodel/lectures_view_model.dart';
import 'package:zubair_onward_academy/viewmodel/mcqs_view_model.dart';
import 'package:zubair_onward_academy/viewmodel/notes_view_model.dart';
import 'package:zubair_onward_academy/viewmodel/user_view_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  bool isLoading = false;
  final _advancedDrawerController = AdvancedDrawerController();

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
    Provider.of<CategoryViewModel>(context, listen: false).fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    final categoryViewModel = Provider.of<CategoryViewModel>(context);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return Future.value(false);
      },
      child: AdvancedDrawer(
          controller: _advancedDrawerController,
          animationCurve: Curves.linear,
          animationDuration: const Duration(milliseconds: 300),
          animateChildDecoration: false,
          rtlOpening: false,
          openScale: 1.0,
          disabledGestures: false,
          childDecoration: const BoxDecoration(
            borderRadius: BorderRadius.zero,
          ),
          drawer: const CustomDrawer(),
          child: Scaffold(
            backgroundColor: AppColors.scaffoldColor,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(screenHeight * 0.06),
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: const Color(0xffE3E5E8),
                      width: screenWidth * 0.0025,
                    ),
                  ),
                ),
                child: AppBar(
                  backgroundColor: AppColors.scaffoldColor,
                  leading: IconButton(
                    icon: SvgPicture.asset('assets/images/menu.svg',
                        width: screenWidth * 0.03, height: screenHeight * 0.03),
                    onPressed: () {
                      _advancedDrawerController.showDrawer();
                    },
                  ),
                  actions: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.015, vertical: screenHeight * 0.015),
                      child: VerticalDivider(
                          width: screenWidth * 0.0025, color: const Color(0xffE3E5E8)),
                    ),
                    IconButton(
                      icon: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/images/logout.svg',
                            height: screenHeight * 0.035,
                            width: screenWidth * 0.035,
                            color: AppColors.blackColor,
                          ),
                          SizedBox(
                            width: screenWidth * 0.02,
                          ),
                          Text(
                            'Logout',
                            style: TextStyle(
                                fontSize: screenWidth * 0.04,
                                fontFamily: 'Sofia Pro',
                                color: AppColors.blackColor),
                          )
                        ],
                      ),
                      onPressed: () async {
                        bool success = await Provider.of<UserViewModel>(context,
                                listen: false)
                            .removeUser();

                        if (success) {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            RoutesName.login,
                            (route) =>
                                false,
                          );
                        } else {
                          Utils.flushBarErrorMessage(
                              'Failed to logout', context);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            body: categoryViewModel.categoryLoading
                ? const Center(child: CircularProgressIndicator())
                : RefreshIndicator(
                    onRefresh: _refreshData,
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.06, vertical: screenWidth * 0.06),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Align(
                              alignment: Alignment.topCenter,
                              child: SvgPicture.asset(
                                'assets/images/zoalogo.svg',
                                height: screenHeight * 0.15,
                                width: screenWidth * 0.15,
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.02,),
                            Align(
                              alignment: Alignment.topCenter,
                              child: Text(
                                'CATEGORIES',
                                style: TextStyle(
                                    fontSize: screenWidth * 0.08,
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
                                  fontSize: screenWidth * 0.04,
                                  fontFamily: 'Poppins Regular',
                                  color: AppColors.blackColor),
                            ),
                            SizedBox(
                              height: screenHeight * 0.04,
                            ),
                            Expanded(
                              child: GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: screenWidth * 0.02,
                                  mainAxisSpacing: screenWidth * 0.02,
                                  childAspectRatio: 0.8,
                                ),
                                itemCount: categoryViewModel.categories.length,
                                itemBuilder: (context, index) {
                                  final category =
                                      categoryViewModel.categories[index];
                                  return Padding(
                                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02, vertical: screenWidth * 0.02),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: AppColors.whiteColor,
                                        borderRadius: BorderRadius.circular(16),
                                        boxShadow: [
                                          const BoxShadow(
                                            color: AppColors.shadowColor,
                                            blurRadius: 8,
                                          )
                                        ],
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            category.image != null
                                                ? ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    child: Image.network(
                                                      category.image!,
                                                      height: screenHeight * 0.085,
                                                      width: screenWidth * 0.19,
                                                    ))
                                                : const Icon(Icons.book),
                                            Text(
                                              category.name ?? 'Category',
                                              style: TextStyle(
                                                fontSize: screenWidth * 0.04,
                                                fontFamily: 'Sofia Pro',
                                                color: AppColors.blackColor,
                                              ),
                                            ),
                                            RoundButton(
                                              title: 'Select',
                                              buttonHeight: screenHeight * 0.045,
                                              buttonColor:
                                                  AppColors.buttonColor,
                                              textColor: AppColors.whiteColor,
                                              buttonWidth: screenWidth * 0.35,
                                              buttonFont: screenWidth * 0.04,
                                              onPress: () {
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return ShowModal(
                                                          children: [
                                                            ContainerButton(
                                                                containerImage:
                                                                    'assets/images/lectures.png',
                                                                containerText:
                                                                    'Lectures',
                                                              onPress:
                                                                  () async {
                                                                try {
                                                                  // Get the selected category ID
                                                                  final categoryId =
                                                                      category
                                                                          .id;
                                                                  final lecturesViewModel = Provider.of<
                                                                      LecturesViewModel>(
                                                                      context,
                                                                      listen:
                                                                      false);

                                                                  // Fetch books
                                                                  await lecturesViewModel
                                                                      .fetchLectures(
                                                                      categoryId ??
                                                                          '',
                                                                      context);

                                                                  // Check if lectures are available
                                                                  if (lecturesViewModel
                                                                      .lectures
                                                                      .isNotEmpty) {
                                                                    // Navigate to BooksScreen
                                                                    Navigator.pushNamed(
                                                                        context,
                                                                        RoutesName
                                                                            .lectures);
                                                                  } else {
                                                                    // Show a message if no books are available
                                                                    Utils.flushBarErrorMessage(
                                                                        'Access Denied!',
                                                                        context);
                                                                  }
                                                                } catch (error) {
                                                                  // Handle any errors
                                                                  Utils.flushBarErrorMessage(
                                                                      'Error! ${error.toString()}',
                                                                      context);
                                                                }
                                                              }),
                                                            ContainerButton(
                                                              containerImage:
                                                                  'assets/images/books.png',
                                                              containerText:
                                                                  'Books',
                                                              onPress:
                                                                  () async {
                                                                try {
                                                                  // Get the selected category ID
                                                                  final categoryId =
                                                                      category
                                                                          .id;
                                                                  final booksViewModel = Provider.of<
                                                                          BooksViewModel>(
                                                                      context,
                                                                      listen:
                                                                          false);

                                                                  // Fetch books
                                                                  await booksViewModel
                                                                      .fetchBooks(
                                                                          categoryId ??
                                                                              '',
                                                                          context);

                                                                  // Check if books are available
                                                                  if (booksViewModel
                                                                      .books
                                                                      .isNotEmpty) {
                                                                    // Navigate to BooksScreen
                                                                    Navigator.pushNamed(
                                                                        context,
                                                                        RoutesName
                                                                            .books);
                                                                  } else {
                                                                    // Show a message if user has no access
                                                                    Utils.flushBarErrorMessage(
                                                                        'Access Denied!',
                                                                        context);
                                                                  }
                                                                } catch (error) {
                                                                  // Handle any errors
                                                                  Utils.flushBarErrorMessage(
                                                                      'Error! ${error.toString()}',
                                                                      context);
                                                                }
                                                              },
                                                            ),
                                                            ContainerButton(
                                                              containerImage:
                                                                  'assets/images/notes.png',
                                                              containerText:
                                                                  'Notes',
                                                              onPress:
                                                                  () async {
                                                                try {
                                                                  // Get the selected category ID
                                                                  final categoryId =
                                                                      category
                                                                          .id;
                                                                  final notesViewModel = Provider.of<
                                                                          NotesViewModel>(
                                                                      context,
                                                                      listen:
                                                                          false);

                                                                  // Fetch books
                                                                  await notesViewModel
                                                                      .fetchNotes(
                                                                          categoryId ??
                                                                              '',
                                                                          context);

                                                                  // Check if books are available
                                                                  if (notesViewModel
                                                                      .notes
                                                                      .isNotEmpty) {
                                                                    // Navigate to BooksScreen
                                                                    Navigator.pushNamed(
                                                                        context,
                                                                        RoutesName
                                                                            .notes);
                                                                  } else {
                                                                    // Show a message if no books are available
                                                                    Utils.flushBarErrorMessage(
                                                                        'Access Denied!',
                                                                        context);
                                                                  }
                                                                } catch (error) {
                                                                  // Handle any errors
                                                                  Utils.flushBarErrorMessage(
                                                                      'Error! ${error.toString()}',
                                                                      context);
                                                                }
                                                              },
                                                            ),
                                                            ContainerButton(
                                                              containerImage:
                                                                  'assets/images/mcqs.png',
                                                              containerText:
                                                                  'Mcqs',
                                                              onPress:
                                                                  () async {
                                                                try {
                                                                  // Get the selected category ID
                                                                  final categoryId =
                                                                      category
                                                                          .id;
                                                                  final mcqsViewModel = Provider.of<
                                                                          McqsViewModel>(
                                                                      context,
                                                                      listen:
                                                                          false);

                                                                  // Fetch books
                                                                  await mcqsViewModel
                                                                      .fetchMcqs(
                                                                          categoryId ??
                                                                              '',
                                                                          context);

                                                                  // Check if books are available
                                                                  if (mcqsViewModel
                                                                      .mcqs
                                                                      .isNotEmpty) {
                                                                    // Navigate to BooksScreen
                                                                    Navigator.pushNamed(
                                                                        context,
                                                                        RoutesName
                                                                            .mcqs);
                                                                  } else {
                                                                    // Show a message if no books are available
                                                                    Utils.flushBarErrorMessage(
                                                                        'Access Denied!',
                                                                        context);
                                                                  }
                                                                } catch (error) {
                                                                  // Handle any errors
                                                                  Utils.flushBarErrorMessage(
                                                                      'Error! ${error.toString()}',
                                                                      context);
                                                                }
                                                              },
                                                            )
                                                          ]);
                                                    });
                                              },
                                              radius: 8,
                                            ),
                                          ],
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
          )),
    );
  }
}
