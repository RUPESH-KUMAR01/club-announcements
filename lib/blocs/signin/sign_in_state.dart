part of 'sign_in_bloc.dart';

abstract class SignInState extends Equatable {
  const SignInState();
  
  @override
  List<Object> get props => [];
}


class SignInInitial extends SignInState{}

class SignInSuccess extends SignInState{}

class SignInFailure extends SignInState{
  final String? email;

  SignInFailure({this.email});

}

class SignInProcess extends  SignInState{}