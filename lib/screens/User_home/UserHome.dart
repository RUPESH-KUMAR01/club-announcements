import 'package:club_announcements/blocs/MyUserBloc/my_user_bloc.dart';
import 'package:club_announcements/blocs/get_post_bloc/get_post_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:user_repository/user_repository.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetPostBloc, GetPostState>(
						builder: (context, state) {
							if(state is GetPostSuccess) {
								return ListView.builder(
									itemCount: state.posts.length,
									itemBuilder: (context, int i) {
										return Card(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              width: double.infinity,
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Container(
                                                          width: 50,
                                                          height: 50,
                                                          decoration: BoxDecoration(
                                                            color: Colors.grey,
                                                            shape: BoxShape.circle,
                                                            image: DecorationImage(
                                                              image: NetworkImage(
                                                                state.posts[i].myUser.picture!
                                                              ),
                                                              fit: BoxFit.cover
                                                            )
                                                          ),
                                                        ),
                                                        const SizedBox(width: 10,),
                                                        Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text(
                                                              state.posts[i].myUser.Club,
                                                              style: const TextStyle(
                                                                fontWeight: FontWeight.bold,
                                                                fontSize: 18
                                                              ),
                                                            ),
                                                            const SizedBox(height: 5),
                                                            Text(
                                                              DateFormat('yyyy-MM-dd').format(state.posts[i].createAt)
                                                            )
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                    const SizedBox(height: 10),
                                                    Column(
                                                      children: [
                                                      Image.network(state.posts[i].picture,loadingBuilder: (context, child, loadingProgress){
                                                                  if (loadingProgress == null) {
                                                                        return child;
                                                                      }
                                                                      return Center(
                                                                        child: CircularProgressIndicator(
                                                                          value: loadingProgress.expectedTotalBytes != null
                                                                              ? loadingProgress.cumulativeBytesLoaded /
                                                                                  loadingProgress.expectedTotalBytes!
                                                                              : null,
                                                                        ));
                                                      }),
                                                        Row(
                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                          children: [
                                                            Text(
                                                              state.posts[i].post,
                                                                                  style: TextStyle(fontSize: 25),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
									}
								);
							} else if(state is GetPostLoading) {
								return const Center(
									child: CircularProgressIndicator(),
								);
							} else {
								return const Center(
									child: Text("An error has occured"),
								);
							}
						});
  }
}