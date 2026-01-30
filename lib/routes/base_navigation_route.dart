import 'package:cinema_db/utils/asset_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../theme_data/palette.dart';

class BaseNavigationRoute extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const BaseNavigationRoute({Key? key, required this.navigationShell})
    : super(key: key ?? const ValueKey('BaseNavigationRoute'));

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.paddingOf(context).bottom;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark, // For light background
        statusBarBrightness: Brightness.light, // For iOS light background
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        body: navigationShell,
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Palette.secondaryColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(27),
              topRight: Radius.circular(27),
            ),
          ),
          padding: EdgeInsets.only(
            left: 25,
            right: 25,
            top: 20,
            bottom: bottomInset < 20 ? 20 : bottomInset,
          ),
          child: Row(
            spacing: 8,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _navItem(
                index: 0,
                label: 'Dashboard',
                icon: AssetsIcons.dashboard,
                size: 16,
                space: 8,
                navigationShell: navigationShell,
              ),
              _navItem(
                index: 1,
                label: 'Watch',
                icon: AssetsIcons.watch,
                size: 18,
                space: 7,
                navigationShell: navigationShell,
              ),
              _navItem(
                index: 2,
                label: 'Library',
                size: 18,
                icon: AssetsIcons.mediaLibrary,
                space: 7,
                navigationShell: navigationShell,
              ),
              _navItem(
                index: 3,
                label: 'More',
                size: 24,
                icon: AssetsIcons.more,
                space: 4,
                navigationShell: navigationShell,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _navItem({
  required int index,
  required String label,
  required String icon,
  required double size,
  required double space,
  required StatefulNavigationShell navigationShell,
}) {
  final isSelected = navigationShell.currentIndex == index;

  return Expanded(
    child: GestureDetector(
      onTap: () => navigationShell.goBranch(index, initialLocation: true),
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: .min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            icon,
            height: size,
            color: isSelected ? Colors.white : Palette.greyColor,
          ),
          SizedBox(height: space),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              color: isSelected ? Colors.white : Palette.greyColor,
              fontFamily: '',
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}
