import 'package:application_ellocation/apis/apis.dart';
import 'package:application_ellocation/models/my_user.dart';
import 'package:application_ellocation/widgets/user_card.dart';
import 'package:flutter/material.dart';

class Users extends StatefulWidget {
  const Users({Key? key}) : super(key: key);

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
  List<MyUser> list = [];

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height,
        width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(),
        body: StreamBuilder(
          stream: APIs.firestore.collection('users').snapshots(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
              case ConnectionState.none:
                return Center(
                  child: CircularProgressIndicator(),
                );
              case ConnectionState.active:
              case ConnectionState.done:
                final data = snapshot.data?.docs;
                list =
                    data?.map((e) => MyUser.fromJson(e.data())).toList() ?? [];
                if (list.isNotEmpty) {
                  return ListView.builder(
                      padding: EdgeInsets.only(top: height * .01),
                      physics: BouncingScrollPhysics(),
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        return UserCard(
                          user: list[index],
                        );
                      });
                } else {
                  return Center(child: Text('No Users'));
                }
            }
          },
        ));
  }
}
