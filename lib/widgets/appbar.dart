import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:marquee/marquee.dart';
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
    final width = MediaQuery.sizeOf(context).width;
    return DefaultTabController(
        length: 4,
        initialIndex: _selectedIndex,
        child: Scaffold(
          drawer: Drawer(
            child: Container(),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: GestureDetector(
            onTap: () {
              context.push('/playing');
            },
            child: Container(
              height: 100,
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  color: AppColors.primaryGrey,
                  borderRadius: BorderRadius.circular(100)),
              child: Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Hero(
                      tag: '12',
                      child: Container(
                        height: 25,
                        width: 25,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            image: const DecorationImage(
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
                            const Gap(20),
                            SizedBox(
                              height: 50,
                              width: 80,
                              child: Marquee(
                                text: "Never the same today and forever",
                                scrollAxis: Axis.horizontal,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                velocity: 20,
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: HugeIcon(
                                icon: HugeIcons.strokeRoundedBackward02,
                                color: AppColors.primaryWhitishGrey,
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: HugeIcon(
                                icon: HugeIcons.strokeRoundedPause,
                                color: AppColors.primaryWhitishGrey,
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: HugeIcon(
                                icon: HugeIcons.strokeRoundedForward02,
                                color: AppColors.primaryWhitishGrey,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: width * 0.8,
                          child: Slider(
                            padding: EdgeInsets.zero,
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
            toolbarHeight: 40,
            backgroundColor: AppColors.primaryBlack,
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.search,
                    size: 30,
                    color: AppColors.primaryWhitishGrey.withValues(alpha: 0.6),
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
                indicator: UnderlineTabIndicator(
                    insets: const EdgeInsets.only(top: 10),
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(
                        width: 5, color: AppColors.primaryWhitishGrey)),
                indicatorSize: TabBarIndicatorSize.label,
                splashBorderRadius: BorderRadius.circular(5),
                splashFactory: NoSplash.splashFactory,
                unselectedLabelColor:
                    AppColors.primaryWhitishGrey.withValues(alpha: 0.6),
                labelColor: AppColors.primaryWhitishGrey,
                labelStyle: MuzikPlayerTextTheme.tabBarStyle,
                labelPadding: const EdgeInsets.symmetric(vertical: 8),
                tabs: const [
                  Text(
                    'Songs',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    'Albums',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    'Artists',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    'Playlist',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
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
