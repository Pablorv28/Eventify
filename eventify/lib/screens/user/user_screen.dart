// ignore_for_file: deprecated_member_use

import 'package:eventify/config/app_colors.dart';
import 'package:eventify/domain/models/category.dart';
import 'package:eventify/providers/event_provider.dart';
import 'package:eventify/screens/user/events_screen.dart';
import 'package:eventify/screens/user/report_screen.dart';
import 'package:eventify/screens/user/user_events_screen.dart';
import 'package:eventify/screens/user/map_screen.dart';
import 'package:eventify/widgets/dialogs/_show_logout_confirmation_dialog.dart';
import 'package:eventify/widgets/expandable_fab_button.dart';
import 'package:eventify/widgets/filter_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:provider/provider.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  final List<Widget> screenList = [
    const EventsScreen(),
    const UserEventsScreen(),
    const ReportScreen(),
    const MapScreen()
  ];
  int currentScreenIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Only way to fix back button crash issue
    return WillPopScope(
      onWillPop: () async {
        showLogoutConfirmationDialog(context);
        return Future.value(false);
      },
      child: Scaffold(
          // AppBar
          appBar: AppBar(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(35), bottomRight: Radius.circular(35)),
            ),
            title: Padding(
              padding: const EdgeInsets.only(bottom: 18),
              child: Image.asset('assets/images/eventify-text.png', height: 50),
            ),
            elevation: 12.0,
            shadowColor: Colors.black.withOpacity(0.5),
            scrolledUnderElevation: 20,
            centerTitle: true,
            surfaceTintColor: Colors.transparent,
            actions: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10, right: 10),
                child: IconButton(
                  icon: const Icon(Icons.logout),
                  onPressed: () {
                    showLogoutConfirmationDialog(context);
                  },
                ),
              ),
            ],
          ),

          // Body properties
          extendBodyBehindAppBar: true,
          extendBody: true,
          backgroundColor: const Color.fromARGB(255, 240, 240, 240),

          // Body
          body: Stack(
            children: [
              // Background image
              Positioned.fill(
                child: Image.asset(
                  'assets/images/no-filter-events-background-image.jpg',
                  fit: BoxFit.cover,
                ),
              ),

              // PageView
              PageView(
                controller: _pageController,
                onPageChanged: _onPageChanged,
                children: screenList,
              ),
            ],
          ),

          // Bottom Navigation Bar
          bottomNavigationBar: Container(
            padding: const EdgeInsets.only(bottom: 5, right: 5, left: 5),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
              borderRadius: const BorderRadius.all(Radius.circular(12)),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              child: BottomNavigationBar(
                iconSize: 30,
                items: [
                  createNavigationBarItem('Upcoming Events', 0),
                  createNavigationBarItem('My Events', 1),
                  createNavigationBarItem('Report', 2),
                  createNavigationBarItem('Map', 3)
                ],
                currentIndex: currentScreenIndex,
                onTap: (index) {
                  _pageController.jumpToPage(index);
                },
                elevation: 20.0,
              ),
            ),
          ),

          // Floating action buttons
          floatingActionButtonLocation: currentScreenIndex == 0 ? ExpandableFab.location : null,
          floatingActionButton: currentScreenIndex == 0 ? buildFloatingActionButton(context) : null),
    );
  }

  BottomNavigationBarItem createNavigationBarItem(String title, int index) {
  return BottomNavigationBarItem(
    icon: Container(
      decoration: BoxDecoration(
        color: currentScreenIndex == index ? AppColors.deepOrange : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(8),
      child: Icon(
        getIcon(index),
        color: currentScreenIndex == index ? Colors.white : Colors.black,
      ),
    ),
    label: title,
  );
}

// Method to set the icon of the elements in the bottom navigation bar
IconData getIcon(int index) {
  switch (index) {
    case 0:
      return Icons.event;
    case 1:
      return Icons.event_available;
    case 2:
      return Icons.description;
    case 3:
      return Icons.map;
    default:
      return Icons.text_format;
  }
}

  FutureBuilder<List<Widget>> buildFloatingActionButton(BuildContext context) {
    return FutureBuilder<List<Widget>>(
      future: _fetchCategories(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return const Icon(Icons.error);
        } else {
          List<Widget> categoryButtons = snapshot.data ?? [];
          return FilterButton(categoryList: categoryButtons);
        }
      },
    );
  }

  Future<List<Widget>> _fetchCategories(BuildContext context) async {
    EventProvider eventProvider = context.read<EventProvider>();
    await eventProvider.fetchCategories();
    List<Category> categoryList = eventProvider.categoryList;
    return getExpandableFabButtons(categoryList);
  }

  void _onPageChanged(int index) {
    setState(() {
      currentScreenIndex = index;
    });
  }

  getExpandableFabButtons(List<Category> categoryList) {
    List<Widget> categoryButtons = [];

    for (Category category in categoryList) {
      categoryButtons.add(ExpandableFabButton(category_name: category.name));
    }

    categoryButtons.add(const ExpandableFabButton(category_name: 'Clear filter'));

    return categoryButtons;
  }
}
