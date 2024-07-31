import 'package:ass2/favorit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'cubit.dart';
import 'distance.dart';
import 'states.dart';
import 'stores.dart';

class home_screen extends StatefulWidget {
  const home_screen({super.key});

  @override
  State<home_screen> createState() => _home_screenState();
}

class _home_screenState extends State<home_screen> {
  int x = 0;
  List<Widget> Screens = [stores(), favorite(), distance()];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<cubit_App, states_App>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            bottomNavigationBar: GNav(
              onTabChange: (index) {
                x = index;
              },
              selectedIndex: x,
              activeColor: Colors.deepPurple,
              tabs: [
                GButton(
                  onPressed: () {
                    cubit_App.get(context).Chang_nav();
                  },
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(
                  onPressed: () {
                    cubit_App.get(context).Chang_nav();
                  },
                  icon: Icons.favorite,
                  text: 'favorite',
                ),
                GButton(
                  onPressed: () {
                    cubit_App.get(context).chang_to_distance();
                  },
                  icon: Icons.social_distance,
                  text: 'Distance',
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  Expanded(child: Center(child: Screens[x]))
                ],
              ),
            ),
          );
        });
  }
}
