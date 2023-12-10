import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:muzik_player/themes/colors.dart';
import 'package:muzik_player/themes/text_theme.dart';

class AppTabBar extends StatefulWidget {
  const AppTabBar({super.key, required this.child});
  final Widget child;
  @override
  State<AppTabBar> createState() => _AppTabBarState();
}

class _AppTabBarState extends State<AppTabBar> with TickerProviderStateMixin {
  int _selectedIndex = 0;

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        initialIndex: _selectedIndex,
        child: Scaffold(
          drawer: Drawer(
            child: Container(),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: InkWell(
            onTap: () {
              log('clicked');
              context.push('/playing');
            },
            child: Container(
              height: 100,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: const BoxDecoration(
                  color: AppColors.primaryGrey,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15))),
              child: Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Hero(
                      tag: '12',
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage('assets/images/album.png'))),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Gap(20),
                            Text('Never The same'),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.fast_rewind_sharp)),
                            IconButton(
                                onPressed: () {}, icon: Icon(Icons.pause)),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.fast_forward))
                          ],
                        ),
                        SizedBox(
                          width: 290,
                          child: Slider(
                            value: 24,
                            max: 100,
                            min: 0,
                            onChanged: (val) {},
                            activeColor: AppColors.primaryWhitishGrey,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          appBar: AppBar(
            backgroundColor: AppColors.primaryBlack,
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.search,
                    size: 30,
                    color: AppColors.primaryWhitishGrey.withOpacity(0.6),
                  ))
            ],
            bottom: TabBar(
                controller: _tabController,
                onTap: (value) {
                  switch (value) {
                    case 0:
                      _selectedIndex = value;
                      setState(() {});
                      context.go('/');
                      break;
                    case 1:
                      _selectedIndex = value;
                      setState(() {});
                      context.go('/artists');
                      break;
                    case 2:
                      _selectedIndex = value;
                      setState(() {});
                      context.go('/albums');
                      break;
                    case 3:
                      _selectedIndex = value;
                      setState(() {});
                      context.go('/playlists');
                      break;
                  }
                },
                indicatorPadding: const EdgeInsets.only(top: 23),
                indicatorWeight: 3,
                indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: AppColors.primaryWhitishGrey),
                indicatorColor: AppColors.primaryWhitishGrey,
                indicatorSize: TabBarIndicatorSize.label,
                splashBorderRadius: BorderRadius.circular(5),
                splashFactory: NoSplash.splashFactory,
                unselectedLabelColor:
                    AppColors.primaryWhitishGrey.withOpacity(0.6),
                labelColor: AppColors.primaryWhitishGrey,
                labelStyle: MuzikPlayerTextTheme.tabBarStyle,
                tabs: const [
                  Text('Songs'),
                  Text('Albums'),
                  Text('Artists'),
                  Text('Playlist'),
                ]),
          ),
          body: GestureDetector(
              onHorizontalDragEnd: (details) {
                if (details.primaryVelocity! > 0) {
                  // Swiped to the right
                  setState(() {
                    _selectedIndex = (_selectedIndex - 1).clamp(0, 3);
                    _tabController.animateTo(_selectedIndex);
                    switch (_selectedIndex) {
                      case 0:
                        context.go('/');
                        break;
                      case 1:
                        context.go('/artists');
                        break;
                      case 2:
                        context.go('/albums');
                        break;
                      case 3:
                        context.go('/playlists');
                        break;
                    }
                  });
                } else if (details.primaryVelocity! < 0) {
                  // Swiped to the left
                  setState(() {
                    _selectedIndex = (_selectedIndex + 1).clamp(0, 3);
                    _tabController.animateTo(_selectedIndex);
                    switch (_selectedIndex) {
                      case 0:
                        context.go('/');
                        break;
                      case 1:
                        context.go('/artists');
                        break;
                      case 2:
                        context.go('/albums');
                        break;
                      case 3:
                        context.go('/playlists');
                        break;
                    }
                  });
                }
              },
              child: widget.child),
        ));
  }
}
