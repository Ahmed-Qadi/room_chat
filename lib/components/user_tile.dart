import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {

  void Function()? onTap;
  String text;
   UserTile({super.key,required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(15),
        margin: EdgeInsets.symmetric(horizontal: 20,vertical: 12),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            //icon
            Icon(Icons.person),

            SizedBox(width: 10,),
            //user name
            Text(text,maxLines: 1,overflow: TextOverflow.ellipsis),

          ],
        ),
      ),
    );
  }
}
