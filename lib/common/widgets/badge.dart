import 'package:flutter/material.dart';
import 'package:task/common/constants/app_colors.dart';



class Badge extends StatelessWidget {
  final Color iconColor;
  final Color badgeColor;
  final Function? onClick;
  final IconData badgeIcon;
  final int counter;

  const Badge({
    this.iconColor:AppColors.white,
    this.badgeColor:AppColors.light_red,
    this.onClick,
    this.badgeIcon:Icons.shopping_cart,
    this.counter:0});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onClick!();
      },
      child: Stack(
        children: <Widget>[
          Icon(badgeIcon,color: iconColor,size: 32,),
          counter==0?
          SizedBox():
          Positioned(
            top: 3,
            right: 0,
            child: new Container(
              padding: EdgeInsets.all(1),
              decoration: new BoxDecoration(
                color: badgeColor,
                borderRadius: BorderRadius.circular(6),
              ),
              constraints: BoxConstraints(
                minWidth: 15,
                minHeight: 15,
              ),
              child: new Text(counter>30?"30+":counter.toString(),
                style: new TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          )
        ],
      ),
    );
  }
}
