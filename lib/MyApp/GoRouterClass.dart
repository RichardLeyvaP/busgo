
    // Configuración de rutas con GoRouter
  import 'package:BusGo/myApp/MyApp.dart';
import 'package:BusGo/ui/pages/FunPage.dart';
import 'package:BusGo/ui/pages/HomePage/Home/HomePage.dart';
import 'package:BusGo/ui/pages/HomePage/ReportPage.dart';
import 'package:BusGo/ui/pages/HomePage/Sales/SalesPage.dart';
import 'package:BusGo/ui/pages/HomePage/Ticket/TicketPage.dart';
import 'package:BusGo/ui/pages/ListPage.dart';
import 'package:BusGo/ui/pages/Login/loginPage.dart';
import 'package:BusGo/ui/pages/NotificationsPage.dart';
import 'package:BusGo/ui/pages/PrinterPage/PrinterPage.dart';
import 'package:BusGo/ui/pages/PrinterPage/reports/report1/report1Page.dart';
import 'package:BusGo/ui/pages/PrinterPage/reports/reportsPage.dart';
import 'package:BusGo/ui/pages/ProfilePage/ProfilePage.dart';
import 'package:BusGo/ui/pages/Statistics/StatisticsPage.dart';
import 'package:BusGo/ui/pages/Statistics/StatisticsPageAll.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        // redirect: (context, state) => '/DashboardPage',
         redirect: (context, state) => '/LoginFormPage',
        
      ),
      
      GoRoute(
        path: '/PrinterPage',
        builder: (context, state) => PrintTicketPage(),
      ),
      GoRoute(
        path: '/HomePage',
        builder: (context, state) => HomePage(),
      ),
      GoRoute(
        path: '/LoginFormPage',
        builder: (context, state) => LoginFormPage(),
      ),
      GoRoute(
        path: '/ListPage',
        builder: (context, state) =>  ListPage(),
      ),
      GoRoute(
        path: '/NotificationsPage',
        builder: (context, state) =>  NotificationsPage(),
      ),
      GoRoute(
        path: '/StatisticsPage',
        builder: (context, state) =>  StatisticsPage(),
      ),
      
      GoRoute(
        path: '/FunPage',
        builder: (context, state) =>  FunPage(),
      ),
      
      GoRoute(
        path: '/DashboardPage',
        builder: (context, state) =>  DashboardPage(),
      ),
      GoRoute(
  path: '/StatisticsPageAll',
  builder: (context, state) =>  StatisticsPageAll(),
),
      GoRoute(
  path: '/ReportPage',
  builder: (context, state) =>  ReportPage(),
),
GoRoute(
  path: '/SalesPage',
  builder: (context, state) =>  SalesPage(),
),
GoRoute(
  path: '/TicketPage',
  builder: (context, state) =>  TicketPage(),
),
      GoRoute(
  path: '/ProfilePage',
  builder: (context, state) =>  ProfilePage(),
),
      GoRoute(
  path: '/ReportsPage',
  builder: (context, state) =>  ReportsPage(),
),
      GoRoute(
  path: '/Report1Page',
  builder: (context, state) =>  Report1Page(),
),


//rutas de pagos



      
      // GoRoute(
      //   path: '/SplashScreen',
      //   builder: (context, state) => SplashScreen(),
      // ),
      // GoRoute(
      //   path: '/LoginFbPage',
      //   builder: (context, state) => LoginFbPage(),
      // ),
      // GoRoute(
      //   path: '/LoginFormPage',
      //   builder: (context, state) => const LoginFormPage(),
      // ),

      // Agrega más rutas según sea necesario
    ],
  );

