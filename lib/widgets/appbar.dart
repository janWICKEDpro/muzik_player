import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:marquee/marquee.dart';
import 'package:muzik_player/providers/songs_provider.dart';
import 'package:muzik_player/themes/colors.dart';
import 'package:muzik_player/themes/text_theme.dart';
import 'package:provider/provider.dart';

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
          floatingActionButton:
              Consumer<SongsModel>(builder: (context, provider, child) {
            return provider.currentAudio == null
                ? const SizedBox()
                : GestureDetector(
                    onTap: () {
                      context.go('/playing');
                    },
                    child: Container(
                      height: 70,
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          color: AppColors.primaryGrey,
                          borderRadius: BorderRadius.circular(100)),
                      child: LayoutBuilder(builder: (context, constraints) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Hero(
                              tag: '12',
                              child: Container(
                                height: constraints.maxWidth * 0.1,
                                width: constraints.maxWidth * 0.1,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: provider
                                                .currentAudio!.pictures.isEmpty
                                            ? const AssetImage(
                                                    'assets/images/album.png')
                                                as ImageProvider<Object>
                                            : MemoryImage(provider.currentAudio!
                                                    .pictures.first.bytes)
                                                as ImageProvider<Object>)),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    spacing: 0,
                                    children: [
                                      SizedBox(
                                        height: 20,
                                        width: constraints.maxWidth * 0.35,
                                        child: Marquee(
                                          text:
                                              "${provider.currentAudio!.title}",
                                          scrollAxis: Axis.horizontal,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          velocity: 20,
                                          startAfter:
                                              const Duration(seconds: 3),
                                        ),
                                      ),
                                      IconButton(
                                        padding: EdgeInsets.zero,
                                        onPressed: () {
                                          provider.previousSong();
                                        },
                                        icon: HugeIcon(
                                          icon:
                                              HugeIcons.strokeRoundedBackward02,
                                          color: AppColors.primaryWhitishGrey,
                                        ),
                                      ),
                                      IconButton(
                                        padding: EdgeInsets.zero,
                                        onPressed: () {
                                          provider.pauseOrPlay();
                                        },
                                        icon: provider.playerState ==
                                                PlayerState.playing
                                            ? HugeIcon(
                                                icon: HugeIcons
                                                    .strokeRoundedPause,
                                                color: AppColors
                                                    .primaryWhitishGrey,
                                              )
                                            : HugeIcon(
                                                icon:
                                                    HugeIcons.strokeRoundedPlay,
                                                color: AppColors
                                                    .primaryWhitishGrey,
                                              ),
                                      ),
                                      IconButton(
                                        padding: EdgeInsets.zero,
                                        onPressed: () {
                                          provider.nextSong();
                                        },
                                        icon: HugeIcon(
                                          icon:
                                              HugeIcons.strokeRoundedForward02,
                                          color: AppColors.primaryWhitishGrey,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: constraints.maxWidth * 0.8,
                                    child: Slider(
                                      padding: EdgeInsets.zero,
                                      value: provider.currentDuration?.inSeconds
                                              .toDouble() ??
                                          0,
                                      max: provider
                                              .currentAudio!.duration?.inSeconds
                                              .toDouble() ??
                                          0,
                                      min: 0,
                                      onChanged: (val) {
                                        provider.currentDuration =
                                            Duration(seconds: val.toInt());
                                        provider.seekSong(val);
                                      },
                                      activeColor: AppColors.primaryWhitishGrey,
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        );
                      }),
                    ),
                  );
          }),
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
                      context.go('/albums');
                      break;
                    case 2:
                      _selectedIndex = value;
                      setState(() {});
                      context.go('/artists');
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
                        context.go('/albums');
                        break;
                      case 2:
                        context.go('/artists');
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
