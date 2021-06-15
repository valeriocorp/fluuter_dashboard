part of './pages.dart';

abstract class Routes {
  //root
  static const ROOTROUTE = '/';
  //auth
  static const LOGINROUTE = '/auth/login';
  static const REGISTERROUTE = '/auth/register';
  //dashboard
  static const DASBOARDROUTE = '/dashboard';
  static const ICONSROUTE = '/dashboard/icons';
  static const BLANKROUTE = '/dashboard/blank';
  static const CATEGORIESROUTE = '/dashboard/categories';
  //users
  static const USERSROUTE = '/dashboard/users';
  static const USERROUTE = '/dashboard/users/:uid';
}
