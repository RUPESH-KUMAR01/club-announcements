import 'package:club_announcements/blocs/MyUserBloc/my_user_bloc.dart';
import 'package:club_announcements/blocs/Update_user_info/update_user_info_bloc.dart';
import 'package:club_announcements/blocs/authentication/authentication_bloc.dart';
import 'package:club_announcements/screens/User_home/HomeScreen.dart';
import 'package:club_announcements/screens/user_authentication/welcomescreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mess Management',
      theme: ThemeData.light(),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state.status == AuthenticationStatus.authenticated) {
            return MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => UpdateUserInfoBloc(
                      userRepository: FirebaseUserRepository()),
                ),
                BlocProvider(
                  create: (context) => MyUserBloc(myUserRepository: context.read<AuthenticationBloc>().userRepository)..add(GetMyUser(
											myUserId: context.read<AuthenticationBloc>().state.user!.uid
										)),
                ),
              ],
              child: HomeScreen(),
            );
          } else {
            return WelcomeScreen();
          }
        },
      ),
    );
  }
}
