import 'package:bottom_bar_matu/bottom_bar/bottom_bar_bubble.dart';
import 'package:bottom_bar_matu/bottom_bar_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:skin_care/common/colors/app_colors.dart';
import 'package:skin_care/data/data.dart';
import 'package:skin_care/views/home_view.dart';
import 'package:skin_care/views/profile_view.dart';

/*

  github- @unique-gautam-yadav
  insta- @flutter.demon

*/

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.fromSize(
        size: MediaQuery.sizeOf(context),
        child: Stack(
          children: [
            [
              const Home(),
              const LikedPage(),
              const CalendarView(),
            ].elementAt(_index),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.elliptical(50, 30)),
                child: Column(
                  children: [
                    BottomBarBubble(
                      color: Colors.white,
                      backgroundColor: AppColors.black,
                      selectedIndex: _index,
                      items: [
                        BottomBarItem(
                          label: "Home",
                          iconBuilder: (color) => Icon(
                            Iconsax.home,
                            color: color,
                            size: 30,
                          ),
                        ),
                        BottomBarItem(
                          label: "Liked",
                          iconBuilder: (color) => Icon(
                            Iconsax.heart,
                            color: color,
                            size: 30,
                          ),
                        ),
                        BottomBarItem(
                          label: "Calendar",
                          iconBuilder: (color) => Icon(
                            Iconsax.calendar,
                            color: color,
                            size: 30,
                          ),
                        ),
                        BottomBarItem(
                          label: "Profile",
                          iconBuilder: (color) => Icon(
                            Iconsax.profile_2user,
                            color: color,
                            size: 30,
                          ),
                        ),
                      ],
                      onSelect: (index) {
                        if (index == 3) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ProfileView(),
                              ));
                          return;
                        }
                        setState(() {
                          _index = index;
                        });
                      },
                    ),
                    Container(
                      color: AppColors.black,
                      height: 40,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LikedPage extends StatelessWidget {
  const LikedPage({super.key});

  @override
  Widget build(BuildContext context) {
    if (ItemsData().savedItems.isEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              'assets/images/Makeup artist.png',
              height: 200,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            "You've not liked any product!!",
            style: TextStyle(
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      );
    }
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 80),
          CupertinoButton(
            onPressed: () {},
            child: Icon(
              Icons.keyboard_backspace_rounded,
              color: AppColors.black,
            ),
          ),
          const Text(
            "Liked",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w300,
            ),
          ),
          Builder(builder: (context) {
            var l = ItemsData().savedItems;

            l.shuffle();
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: l.length,
              itemBuilder: (context, index) {
                return ItemTile(m: l[index]);
              },
            );
          }),
          const SizedBox(height: 140),
        ],
      ),
    );
  }
}

class CalendarView extends StatelessWidget {
  const CalendarView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Hello this is Calendar page"));
  }
}
