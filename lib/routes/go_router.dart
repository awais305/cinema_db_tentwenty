import 'package:cinema_db/screens/media_library_screen.dart';
import 'package:cinema_db/screens/more_screen.dart';
import 'package:cinema_db/screens/watch_list_screen/watch_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../screens/dashboard_screen.dart';
import '../screens/search_watch_screen/search_watch_screen.dart';
import '../screens/watch_detail_screen/trailer_screen.dart';
import '../screens/watch_detail_screen/watch_detail_screen.dart';
import 'app_routes.dart';
import 'base_navigation_route.dart';

final navigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

final router = GoRouter(
  navigatorKey: navigatorKey,
  initialLocation: AppRoutes.watch,

  // debugLogDiagnostics: true,
  routes: [
    bottomNavigationShell,

    GoRoute(
      path: AppRoutes.watchDetail,
      builder: (BuildContext context, GoRouterState state) =>
          WatchDetailScreen(),
    ),
    GoRoute(
      path: AppRoutes.trailer,
      builder: (BuildContext context, GoRouterState state) =>
          const TrailerScreen(),
    ),
  ],
);

final StatefulShellRoute bottomNavigationShell =
    StatefulShellRoute.indexedStack(
      builder:
          (
            BuildContext context,
            GoRouterState state,
            StatefulNavigationShell navigationShell,
          ) => BaseNavigationRoute(navigationShell: navigationShell),

      branches: <StatefulShellBranch>[
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: AppRoutes.dashboard,
              builder: (BuildContext context, GoRouterState state) =>
                  DashboardScreen(),
            ),
          ],
        ),

        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: AppRoutes.watch,
              builder: (BuildContext context, GoRouterState state) =>
                  WatchListScreen(),
              routes: [
                GoRoute(
                  path: AppRoutes.searchWatch,
                  builder: (BuildContext context, GoRouterState state) =>
                      SearchWatchScreen(),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: AppRoutes.mediaLibrary,
              builder: (BuildContext context, GoRouterState state) =>
                  MediaLibraryScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: AppRoutes.more,
              builder: (BuildContext context, GoRouterState state) =>
                  MoreScreen(),
            ),
          ],
        ),
      ],
    );
