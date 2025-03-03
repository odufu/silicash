// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:silicash_mobile/core/router/routes.dart';
// import '../di/injection.dart';
// import '../../features/authentication/provider/auth_provider.dart';
// import 'app_routes.dart';


// class RouterSetup {
//   static final router = GoRouter(
//     initialLocation: AppRoutes.splash,
//     debugLogDiagnostics: true,
//     routes: appRoutes,
//     redirect: (context, state) {
//       final authGuard = AuthGuard(
//         authProvider: inject<AuthProvider>(),
//       );
//       return authGuard.redirect(state);
//     },
//   );

//   static RouterConfig get config => RouterConfig(router: router, routerDelegate: null);
// }
