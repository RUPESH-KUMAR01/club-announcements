import 'package:club_announcements/blocs/MyUserBloc/my_user_bloc.dart';
import 'package:club_announcements/screens/admin/AdminHome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyUserBloc, MyUserState>(
      builder: (context, state) {
        if(state.status == MyUserStatus.success){
      if(context.read<MyUserBloc>().state.user!.isAdmin){
        return AdminScreen();
      }else{
        return Container();
      }
        }else{
          return CircularProgressIndicator();
        }
      },
    );
  }
}