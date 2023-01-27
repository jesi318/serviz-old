import 'package:get/get.dart';
import 'package:serviz/screens/allprojects_panel.dart';
import 'package:serviz/screens/documentSubmissions.dart';
import 'package:serviz/screens/requestScreen.dart';
import 'package:serviz/screens/create_group.dart';
import 'package:serviz/screens/join_group_form.dart';
import 'package:serviz/screens/create_join_group.dart';
import 'package:serviz/screens/homepg.dart';
import 'package:serviz/screens/login.dart';
import 'package:serviz/screens/my_group_form.dart';
import 'package:serviz/screens/teachers_homepg.dart';
import 'package:serviz/screens/view_groups.dart';
import 'package:serviz/screens/week_form.dart';
import 'package:serviz/screens/welcome_screen.dart';
import 'screens/signup.dart';

appRoutes() => [
      GetPage(name: '/welcome', page: () => WelcomeScreen()),
      GetPage(
        name: '/createjoingroup',
        page: () => CreateJoinGroupScreen(),
        middlewares: [MyMiddelware()],
        transition: Transition.rightToLeftWithFade,
        transitionDuration: Duration(milliseconds: 500),
      ),
      GetPage(name: '/home', page: () => HomePage()),
      GetPage(name: '/joingroupform', page: () => JoinGroupForm()),
      GetPage(name: '/creategroupform', page: () => CreateGroupScreen()),
      GetPage(name: '/weekform', page: () => UploadWeekForm()),
      GetPage(name: '/login', page: () => LoginPage()),
      GetPage(name: '/signup', page: () => SignUpPage()),
      GetPage(name: '/mygroupform', page: () => MyGroupForm()),
      GetPage(name: '/teachershomepage', page: () => TeachersHomePage()),
      GetPage(name: '/viewgroupspage', page: () => ViewGroups()),
      GetPage(name: '/submitrequestspage', page: () => RequestScreen()),
      GetPage(name: '/allprojectspage', page: () => AllProjectsPanel()),
      GetPage(name: '/docsubmissionpage', page: () => DocSubmissionscreen()),
    ];

class MyMiddelware extends GetMiddleware {
  @override
  GetPage? onPageCalled(GetPage? page) {
    print(page?.name);
    return super.onPageCalled(page);
  }
}
