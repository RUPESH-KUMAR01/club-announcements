import 'package:club_announcements/blocs/authentication/authentication_bloc.dart';
import 'package:club_announcements/blocs/sign_up/sign_up_bloc.dart';
import 'package:club_announcements/blocs/signin/sign_in_bloc.dart';
import 'package:club_announcements/screens/user_authentication/sign_in.dart';
import 'package:club_announcements/screens/user_authentication/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController=TabController(initialIndex: 0,length: 2 ,vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Authentication Page'),),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                TabBar(
                  controller: tabController,
                  labelColor: Color.fromARGB(255, 0, 0, 0),
                  unselectedLabelColor: Color.fromARGB(255, 148, 148, 148),
                  tabs:[
                    Padding(padding: EdgeInsets.all(12),
                    child: Text(
                      'Sign In'
                      ,style: TextStyle(fontSize: 15),),
                    ),
                    Padding(padding: EdgeInsets.all(12),
                    child: Text(
                      'Sign Up'
                      ,style: TextStyle(fontSize: 15),),
                    ),
                  ] 
                ),
                Expanded(child: 
                  TabBarView(
                  controller: tabController,
                  children: [
                    BlocProvider<SignInBloc>
                    (
                      create: (context)=>
                      SignInBloc(userRepository: context.read<AuthenticationBloc>().userRepository),
                      child: SignInScreen(),
                      ),
                    BlocProvider<SignUpBloc>
                    (
                      create: (context)=>
                      SignUpBloc(userRepository: context.read<AuthenticationBloc>().userRepository),
                      child: SignUpScreen(),
                      ),
                ]))
              ],
            ),
          ),
        ),
      ),
    );
  }
}