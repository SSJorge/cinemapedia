import 'package:cinemapedia/presentation/screens/screens.dart';
import 'package:cinemapedia/presentation/views/views.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/movie/:id',
      name: MovieScreen.name,
      builder: (context, state) {
        final movieId = state.pathParameters['id'] ?? 'no-id';
        return MovieScreen(movieId: movieId);
      },
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, child) {
        return HomeScreen(childView: child);
      },
      branches: [
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: '/',
              builder: (context, state) {
                return HomeView();
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: '/favorites',
              builder: (context, state) {
                return FavoritesView();
              },
            ),
          ],
        ),
      ],
    ),

    // Rutas padre/hijo
    // GoRoute(
    //   path: '/',
    //   name: HomeScreen.name,
    //   builder: (context, state) => HomeScreen(childView: HomeView(),),
    //   routes: [
    //     GoRoute(
    //       path: 'movie/:id',
    //       name: MovieScreen.name,
    //       builder: (context, state) {
    //         final movieId = state.pathParameters['id'] ?? 'no-id';
    //         return MovieScreen(movieId: int.parse(movieId));
    //       },
    //     ),
    //   ],
    // ),
  ],
);
