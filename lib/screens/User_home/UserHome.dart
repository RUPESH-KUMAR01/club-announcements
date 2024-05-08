import 'package:club_announcements/blocs/get_post_bloc/get_post_bloc.dart';
import 'package:club_announcements/screens/User_home/SinglePostScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:post_repository/post_repository.dart';

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
								return LiquidPullToRefresh(
                                  onRefresh: (){
                                    context.read<GetPostBloc>().add(GetPosts());
                                    return Future.delayed(Duration(seconds: 2));
                                  },
                                  child: ListView.builder(
                                    itemCount: state.posts.length,
                                    itemBuilder: (context, int i) {
                                      return GestureDetector(
                                                        onTap: (){
                                                          Navigator.push(context, MaterialPageRoute(builder: (context) => SinglePostScreen(state.posts[i])));
                                                        },
                                                child: Card(
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
                                                                                    Flexible(
                                                                                      child: Text(
                                                                                        state.posts[i].post,
                                                                                        style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),
                                                                                        softWrap: true, // Allow text to wrap to the next line
                                                                                        overflow: TextOverflow.visible, // Remove any overflow behavior
                                                                                      ),
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
                                                                                                    ),
                                                                          );
                                    }
                                  ),
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