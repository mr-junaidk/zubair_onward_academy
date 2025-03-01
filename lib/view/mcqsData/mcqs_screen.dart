import 'package:zubair_onward_academy/res/components/pop_up_button.dart';
import 'package:zubair_onward_academy/view/mcqsData/mcqs_interface_screen.dart';
import 'package:zubair_onward_academy/viewmodel/mcqs_view_model.dart';
import 'package:zubair_onward_academy/res/color.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';


class McqsScreen extends StatefulWidget {
  final String categoryId;

  const McqsScreen({super.key, required this.categoryId});

  @override
  _McqsScreenState createState() => _McqsScreenState();
}

class _McqsScreenState extends State<McqsScreen> {
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
    Provider.of<McqsViewModel>(context, listen: false).fetchMcqs(widget.categoryId, context);
  }

  @override
  Widget build(BuildContext context) {
    final mcqsViewModel = Provider.of<McqsViewModel>(context);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.scaffoldColor,
        body: mcqsViewModel.mcqsLoading
            ? const Center(child: CircularProgressIndicator())
            : mcqsViewModel.mcqs.isEmpty
            ? Center(child: Text("No Notes Found", style: TextStyle(fontSize: screenWidth * 0.05, fontFamily: 'Poppins Light', color: AppColors.subtitleColor),))
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
                          child: Text('MCQS LIBRARY', style: TextStyle(
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
                        itemCount: mcqsViewModel.mcqs.length,
                        itemBuilder: (context, index) {
                          final mcq = mcqsViewModel.mcqs[index];
                          return Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02, vertical: screenWidth * 0.02),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.whiteColor,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: AppColors.shadowColor,
                                      blurRadius: 8,
                                    )
                                  ],
                                ),
                                child: ListTile(
                                  leading: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: const Image(image: AssetImage('assets/images/mcqs.png'))),
                                  title: Text(mcq.title ?? '', style: TextStyle(fontSize: screenWidth * 0.045, fontFamily: 'Sofia Pro', color: AppColors.blackColor),),
                                  subtitle: Text(mcq.category!.name ?? '', style: TextStyle(fontSize: screenWidth * 0.04, fontFamily: 'Sofia Pro', color: AppColors.subtitleColor),),
                                  onTap: () {
                            
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => McqInterfaceScreen(mcq: mcq)
                            
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
