import 'package:application_ellocation/models/my_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserCard extends StatefulWidget {
  final MyUser user;

  const UserCard({Key? key, required this.user}) : super(key: key);

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height,
        width = MediaQuery.of(context).size.width;
    return Card(
      margin: EdgeInsets.symmetric(horizontal: width * .04, vertical: 4),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        leading: CircleAvatar(
          child: Icon(CupertinoIcons.person_alt),
        ),
        title: Text(widget.user.name),
        subtitle: Text(
          widget.user.about,
          maxLines: 1,
        ),
        trailing: Text('12:45 am'),
      ),
    );
  }
}
