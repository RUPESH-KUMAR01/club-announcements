import 'dart:io';

import 'package:club_announcements/blocs/create_post_bloc/create_post_bloc.dart';
import 'package:club_announcements/components/textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:post_repository/post_repository.dart';
import 'package:user_repository/user_repository.dart';

class PostScreen extends StatefulWidget {
  final MyUser myUser;
  const PostScreen(this.myUser,{super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  late Post post;
  XFile? file;
  bool _selected=false;
  bool _state=false;
	final TextEditingController _controller = TextEditingController();
  final TextEditingController _titleController=TextEditingController();

  @override
  void initState() {
    post = Post.empty;
		post.myUser = widget.myUser;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          floatingActionButton: FloatingActionButton(
                                onPressed: () {
                                  if(_controller.text.length != 0) {
                                    setState(() {
                                      post.desc = _controller.text;
                                    });
                                    if(_selected && _titleController.text.length!=0){
                                      post.post=_titleController.text;
                                      context.read<CreatePostBloc>().add(CreatePost(post,file!.path));
                                    }
                                  }
                                },
                                child: const Icon(Icons.add),
                              ),
      appBar: AppBar(title: Text('Create Post'),),
      body:BlocListener<CreatePostBloc, CreatePostState>(
            listener: (context, state) {
              if(state is CreatePostSuccess) {
                Navigator.pop(context);
              }else if(state is CreatePostLoading){
                _state=true;
              }else if(state is CreatePostFailure){
                _state=false;
              }
            },
              child: _state? Center(child: CircularProgressIndicator()) : SingleChildScrollView(
                child: Column(
                  children: [
                    Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height*0.7,
                        child: !_selected ? Center(
                          child: GestureDetector(
                            child: Text('Select'),
                            onTap: () async {
                              final ImagePicker picker =ImagePicker();
                              file= await picker.pickImage(
                                source: ImageSource.gallery,
                                maxWidth: 500); 
                              if(file !=null){
                                setState(() {
                                  _selected=true;
                                });
                              }
                            },
                          ),
                        ) : GestureDetector(
                          child: Image.file(File(file!.path)),
                          onDoubleTap: () {
                            setState(() {
                              _selected=false;
                            });
                          },
                        )
                      ),
                    ),
                    MyTextField(controller: _titleController
                    , hintText: 'Event Title',
                     obscureText: false,
                      keyboardType: TextInputType.name),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height*0.5,
                      child: GestureDetector(
                          onTap: () => FocusScope.of(context).unfocus(),
                          child:SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextField(
                                    controller: _controller,
                                    maxLines: 10,
                                    maxLength: 500,
                                    decoration: InputDecoration(
                                      hintText: "Description",
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(color: Colors.grey)
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(color: Theme.of(context).colorScheme.primary)
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ),
                  ],
                ),
              ),
            ),
    );
  }
}