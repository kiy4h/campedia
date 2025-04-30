import 'package:flutter/material.dart';
import '../pages/home.dart';
import '../Items/category.dart';
import '../shopPage/shoping.dart';
import '../pages/favorite.dart';
import '../profile/profile.dart';
import '../Items/allListItem.dart';

Widget buildBottomNavBar(
  BuildContext context, {
  required int currentIndex,
}) {
  return Container(
    height: 70,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 10,
          offset: const Offset(0, -5),
        ),
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildNavItem(context, Icons.home, 0, currentIndex),
        _buildNavItem(context, Icons.swap_horiz, 1, currentIndex),
        _buildNavItem(context, Icons.shopping_cart_outlined, 2, currentIndex, hasNotification: true),
        _buildNavItem(context, Icons.favorite_border, 3, currentIndex),
        _buildProfileNavItem(context, 4, currentIndex),
      ],
    ),
  );
}

Widget _buildNavItem(
  BuildContext context,
  IconData icon,
  int index,
  int currentIndex, {
  bool hasNotification = false,
}) {
  bool isSelected = currentIndex == index;
  return GestureDetector(
    onTap: () {
      if (currentIndex != index) {
        _navigateToPage(context, index);
      }
    },
    child: Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFFEAEAEA) : Colors.transparent,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            size: 28,
            color: isSelected ? Colors.black87 : Colors.grey,
          ),
        ),
        if (hasNotification)
          Positioned(
            top: 10,
            right: 10,
            child: Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: Colors.amber,
                shape: BoxShape.circle,
              ),
            ),
          ),
      ],
    ),
  );
}

Widget _buildProfileNavItem(BuildContext context, int index, int currentIndex) {
  bool isSelected = currentIndex == index;
  return GestureDetector(
    onTap: () {
      if (currentIndex != index) {
        _navigateToPage(context, index);
      }
    },
    child: Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected ? Colors.black87 : Colors.grey.shade300,
          width: 2,
        ),
        image: const DecorationImage(
          image: AssetImage('assets/profile_placeholder.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    ),
  );
}

void _navigateToPage(BuildContext context, int index) {
  switch (index) {
    case 0:
      Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
      break;
    case 1:
      Navigator.push(context, MaterialPageRoute(builder: (context) => AllItemList()));
      break;
    case 2:
      Navigator.push(context, MaterialPageRoute(builder: (context) => Shoping()));
      break;
    case 3:
      Navigator.push(context, MaterialPageRoute(builder: (context) => FavoritePage()));
      break;
    case 4:
      Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
      break;
  }
}
