import 'package:flutter/material.dart';
import 'package:flutter_tv/domain/user.dart';

class UserProfileWidget extends StatelessWidget {
  final MoviesUser user;

  UserProfileWidget({
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(user.avatarURL),
          ),
          SizedBox(height: 30),
          Text(
            user.name,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 15),
          Text(
            user.admin ? 'Admininstrator' : 'Movies User',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
