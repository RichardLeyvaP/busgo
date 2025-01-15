import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:go_router/go_router.dart';

//todo FACEBOOK
Map<String, dynamic>? _userData;
bool _checking = true;
AccessToken? _accessToken;

checkingIfLogget(setState, context) async {
  print('llegando a la _checkingIfLogget');
  final accessToken = await FacebookAuth.instance.accessToken;
  setState(() {
    _checking = false;
  });
  if (accessToken != null) {
    print('llegando a la if (accessToken != null)');
    print('accessToken= ${accessToken.toJson()}');
    final userData = await FacebookAuth.instance.getUserData();
    _accessToken = accessToken;
    setState(() {
      _userData = userData;
      //  goToHomeFb(userData, context);
      GoRouter.of(context).go(
        '/HomePrincipal'
      );
    });
  } else {
    print('llegando a la } else {');
    loginFb(setState, context);
  }
}

Future loginFb(setState, context) async {
  final LoginResult result = await FacebookAuth.instance.login();

  if (result.status == LoginStatus.success) {
    _accessToken = result.accessToken;
    final userData = await FacebookAuth.instance.getUserData();
    _userData = userData;
    // goToHomeFb(userData, context);
    GoRouter.of(context).go(
      '/HomePrincipal'
    );
  } else {
    print('result.status: ${result.status}');
    print('result.message: ${result.message}');
  }
  setState(() {
    _checking = false;
  });
}

logout(setState) async {
  await FacebookAuth.instance.logOut();
  _accessToken = null;
  _userData = null;
  setState(() {});
}
//todo FACEBOOK

/*goToHomeFb(Map<String, dynamic> userData, context) {
  final userCubit = context.read<RoutesCubit>();
  print('llegando a la pagina de _goToHomeFb');
  print('llegando a la pagina de _goToHomeFb-name:${userData['name']}');
  userCubit.goHomeFb(
    name: userData['name'],
    email: userData['email'],
    avatarUrl: userData['picture']['data']['url'],
  );
}*/
