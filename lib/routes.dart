import 'package:get/get.dart';
import 'package:serviz/screens/create_join_group.dart';
import 'package:serviz/screens/welcome_screen.dart';

appRoutes() => [
      GetPage(name: '/welcome', page: () => WelcomeScreen()),
      GetPage(
        name: '/createjoingroup',
        page: () => CreateJoinGroupScreen(),
        middlewares: [MyMiddelware()],
        transition: Transition.rightToLeftWithFade,
        transitionDuration: Duration(milliseconds: 500),
      ),
    ];

class MyMiddelware extends GetMiddleware {
  @override
  GetPage? onPageCalled(GetPage? page) {
    print(page?.name);
    return super.onPageCalled(page);
  }
}
