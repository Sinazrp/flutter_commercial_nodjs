import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_commercial_nodjs/features/home/carousel_slider.dart';
import '../../logic/bloc_user/user_bloc.dart';
import 'home_widgets.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();

  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (
        context,
        userState,
      ) {
        return BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 14.0, right: 12, left: 12, bottom: 12),
                        child: SizedBox(
                          height: 50,
                          child: TextField(
                              onChanged: (String text) {
                                setState(() {
                                  isSearching = true;
                                });

                                if (searchController.text.isEmpty) {
                                  setState(() {
                                    isSearching = false;
                                  });
                                }
                              },
                              onTapOutside: (event) {
                                FocusManager.instance.primaryFocus!.unfocus();
                              },
                              controller: searchController,
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.all(5),
                                prefixIcon: Icon(Icons.search),
                                border: OutlineInputBorder(),
                                label: Text('Search'),
                              )),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.keyboard_voice),
                    )
                  ],
                ),
              ),
              body: isSearching
                  ? WillPopScope(
                      onWillPop: () async {
                        setState(() {
                          isSearching = false;
                        });

                        return false;
                      },
                      child: HomeScreenSearchWidget(
                          searchController: searchController),
                    )
                  : RefreshIndicator(
                      onRefresh: () async {
                        setState(() {});
                      },
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            AdressBar(state: state),
                            const Cataloge(),
                            const CarouselSliderImage(),
                            const DealOfDayText(),
                            const DealOfTheDayWidget(),
                          ],
                        ),
                      ),
                    ),
            );
          },
        );
      },
    );
  }
}
