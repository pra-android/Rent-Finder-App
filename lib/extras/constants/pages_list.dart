import 'package:flutter/material.dart';
import 'package:rentfinderapp/screens/favourites/favourites.dart';
import 'package:rentfinderapp/screens/homepages/homepage.dart';
import 'package:rentfinderapp/screens/postrent/post_rent.dart';
import 'package:rentfinderapp/screens/profile/profile.dart';

class PagesList {
  static List<Widget> pagesList = [
    HomePage(),
    Favourites(),
    PostRent(),
    Profile(),
  ];
}
