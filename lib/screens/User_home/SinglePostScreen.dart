import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:post_repository/post_repository.dart';

class SinglePostScreen extends StatefulWidget {
  Post post;
  SinglePostScreen(this.post,{super.key});

  @override
  State<SinglePostScreen> createState() => _SinglePostScreenState();
}

class _SinglePostScreenState extends State<SinglePostScreen> {
  @override
  Widget build(BuildContext context) {
    Post post=widget.post;
    return Scaffold(
      appBar: AppBar(title: Text('Event'),),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
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
                                post.myUser.picture!
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
                              post.myUser.Club,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              DateFormat('yyyy-MM-dd').format(post.createAt)
                            )
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    Column(
                      children: [
                      Image.network(post.picture,loadingBuilder: (context, child, loadingProgress){
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
                                post.post,
                                style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),
                                softWrap: true, // Allow text to wrap to the next line
                                overflow: TextOverflow.visible, // Remove any overflow behavior
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Flexible(
                              child: Text(
                                post.desc,
                                style: TextStyle(fontSize:15),
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
          ],
        ),
      ),
    );
  }
}