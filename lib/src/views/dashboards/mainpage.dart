import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:perfume/src/components/global_variable.dart';
import 'package:perfume/src/views/dashboards/home/index.dart';
import 'package:perfume/src/views/dashboards/settings/index.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          extendBody: true,
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Container(
            margin: const EdgeInsets.only(bottom: 5, left: 15, right: 15),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(30),
                boxShadow: const [
                  BoxShadow(
                      blurRadius: 10,
                      color: Colors.black26,
                      offset: Offset(0, 0)
                    )
                ]
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                  sigmaX: 10.0,
                  sigmaY: 10.0,
                ),
                  child: Opacity(
                    opacity: 0.8,
                    child: NavigationBar(
                      backgroundColor: GlobalVariables.buttonColorGreen,
                      elevation: 0,
                      height: 55,
                      surfaceTintColor: GlobalVariables.buttonColorGreen,
                      onDestinationSelected: (int index) {
                        setState(() {
                          currentPageIndex = index;
                        });
                      },
                      indicatorColor: Colors.transparent,
                      indicatorShape: const CircleBorder(
                        side: BorderSide(strokeAlign: BorderSide.strokeAlignOutside,
                          color: Colors.white54,
                          width: 3,
                          style: BorderStyle.solid
                        )
                      ),
                      selectedIndex: currentPageIndex,
                      labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
                      destinations: const <Widget>[
                        NavigationDestination(
                          icon: Icon(Iconsax.home_1_outline, color: Colors.white),
                          label: 'Home',
                        ),
                        NavigationDestination(
                          icon: Icon(Iconsax.task_square_outline, color: Colors.white),
                          label: 'Categories',
                        ),
                        NavigationDestination(
                          icon: Badge(child: Icon(Iconsax.clock_outline, color: Colors.white),
                          ),
                          label: 'Favorit',
                        ),
                        NavigationDestination(
                          icon: Icon(Iconsax.profile_circle_outline, color: Colors.white),
                          label: 'Profile',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          body: <Widget>[
            /// Home page
            const HomePage(),

            const Card(
              shadowColor: Colors.white,
              margin: EdgeInsets.all(8.0),
              child: SizedBox.expand(
                child: Center(
                  child: Text(
                    'Categories',
                    style: TextStyle()
                  ),
                ),
              ),
            ),
        
            const Card(
              shadowColor: Colors.white,
              margin: EdgeInsets.all(8.0),
              child: SizedBox.expand(
                child: Center(
                  child: Text(
                    'Shop',
                    style: TextStyle()
                  ),
                ),
              ),
            ),
            const ProfileTab()
          ][currentPageIndex],
        ),
      ],
    );
  }
}