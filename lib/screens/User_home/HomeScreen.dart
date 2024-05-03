import 'package:club_announcements/blocs/MyUserBloc/my_user_bloc.dart';
import 'package:club_announcements/blocs/Update_user_info/update_user_info_bloc.dart';
import 'package:club_announcements/blocs/authentication/authentication_bloc.dart';
import 'package:club_announcements/blocs/signin/sign_in_bloc.dart';
import 'package:club_announcements/screens/User_home/UserHome.dart';
import 'package:club_announcements/screens/admin/AdminHome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateUserInfoBloc, UpdateUserInfoState>(
        listener: (context, state) {
          if (state is UploadPictureSuccess) {
            setState(() {
              context.read<MyUserBloc>().state.user!.picture = state.userImage;
            });
          }
        },
        child: Scaffold(
          appBar: AppBar(
            centerTitle: false,
            elevation: 0,
            backgroundColor: Colors.indigoAccent,
            title: BlocBuilder<MyUserBloc, MyUserState>(
              builder: (context, state) {
                if (state.status == MyUserStatus.success) {
                  return Row(
                    children: [
                      state.user!.picture == ""
                          ? GestureDetector(
                              onTap: () async {
                                final ImagePicker picker = ImagePicker();
                                final XFile? image = await picker.pickImage(
                                    source: ImageSource.gallery,
                                    maxHeight: 500,
                                    maxWidth: 500,
                                    imageQuality: 40);
                                if (image != null) {
                                  CroppedFile? croppedFile =
                                      await ImageCropper().cropImage(
                                    sourcePath: image.path,
                                    aspectRatio: const CropAspectRatio(
                                        ratioX: 1, ratioY: 1),
                                    aspectRatioPresets: [
                                      CropAspectRatioPreset.square
                                    ],
                                    uiSettings: [
                                      AndroidUiSettings(
                                          toolbarTitle: 'Cropper',
                                          toolbarColor: Colors.indigoAccent,
                                          toolbarWidgetColor: Colors.white,
                                          initAspectRatio:
                                              CropAspectRatioPreset.original,
                                          lockAspectRatio: false)
                                    ],
                                  );
                                  if (croppedFile != null) {
                                    setState(() {
                                      context.read<UpdateUserInfoBloc>().add(
                                          UploadPicture(
                                              croppedFile.path,
                                              context
                                                  .read<MyUserBloc>()
                                                  .state
                                                  .user!
                                                  .id));
                                    });
                                  }
                                }
                              },
                              child: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    shape: BoxShape.circle),
                                child: Icon(Icons.person,
                                    color: Colors.grey.shade400),
                              ),
                            )
                          : Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: NetworkImage(
                                        state.user!.picture!,
                                      ),
                                      fit: BoxFit.cover)),
                            ),
                      const SizedBox(width: 10),
                      Text("Welcome ${state.user!.name}")
                    ],
                  );
                } else {
                  return Container();
                }
              },
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    context.read<SignInBloc>().add(const SignOutRequired());
                  },
                  icon: Icon(
                    Icons.logout,
                    color: Theme.of(context).colorScheme.onBackground,
                  ))
            ],
          ),
          body: BlocProvider.value(
            value: context.read<MyUserBloc>(),
            child: UserScreen(),
          ),
        ));
  }
}
