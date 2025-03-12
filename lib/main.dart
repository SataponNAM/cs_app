import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:permission_handler/permission_handler.dart';

// import page
import 'package:cs_app/widgets/main_wrapper.dart';
import 'package:cs_app/logic/bottom_nav_cubit.dart';
import 'package:cs_app/logic/NavigatorInBody/drawer_bloc.dart';
import 'package:cs_app/pages/personnel/about_page.dart';

import 'package:cs_app/pages/personnel/department_structure.dart';
import 'package:cs_app/pages/personnel/professor_page.dart';

import 'package:cs_app/pages/auth_page/login_page.dart';
import 'package:cs_app/pages/auth_page/sign_up_page.dart';

import 'package:cs_app/pages/personnel/support_personnel.dart';
import 'package:cs_app/pages/csb/csb_page.dart';

import 'package:cs_app/pages/download/download_page.dart';
import 'package:cs_app/pages/download/staff_download_page.dart';
import 'package:cs_app/pages/download/student_download_page.dart';

import './pages/news/pages.dart';
import './pages/rule/pages.dart';
import './pages/service/pages.dart';
import './pages/coursePrograms/pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await FlutterDownloader.initialize(
      debug: true, // optional: set to false to disable printing logs to console (default: true)
      ignoreSsl : true // option: set to false to disable working with http links (default: false)
  );

  // Request notification permission
  await Permission.notification.request();

  await initializeDateFormatting('th', null);
  
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => BottomNavCubit()),
        BlocProvider(create: (_) => DrawerBloc()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CS App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => MainWrapper(),
        '/login': (context) => LoginPage(),
        '/signUp': (context) => SignUpPage(),

        '/aboutCs': (context) => AboutPage(),
        '/supportPers': (context) => SupportPersonnel(),
        '/professor': (context) => ProfessorPage(),
        '/departmentStruct': (context) => DepartmentStructure(),

        '/newsMenu': (context) => NewsPage(),
        '/departmentNews': (context) => DepartmentNewsPage(),
        '/uniNews': (context) => UniversityNews(),
        '/scholarshipNews': (context) => ScholarshipsNews(),
        '/rescruitmentNews': (contsxt) => RecruitmentNewsPage(),

        '/csb': (context) => CsbPage(),

        '/downloadMenu': (context) => DownloadPage(),
        '/downloadStudent': (context) => StudentDownloadPage(),
        '/downloadStaff': (context) => StaffDownloadPage(),

        '/servicesMenu': (context) => ServicePage(),
        '/advisor': (context) => AdvisorPage(),
        '/handbook': (context) => HandbookPage(),
        '/courseProcession': (context) => CourseProcessionPage(),

        '/rule': (context) => RulePage(),
        '/finance': (context) => FinancePage(),
        '/academic': (context) => AcademicPage(),
        '/graduateStd': (context) => GraduateStudentPage(),
        '/stdAffair': (context) => StudentAffairsPage(),

        '/bachelorNormal': (context) => BachelorNormalPage(),
        '/bachelorCsb': (context) => BachelorCsbPage(),
        '/masterCs': (context) => MasterCsPage(),
        '/masterSe': (context) => MasterSePage(),
        '/phd': (context) => PhdPage(),

      },
      //home: MainWrapper(),
    );
  }
}