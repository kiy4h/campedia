import 'package:flutter/material.dart';

Widget buildBottomNavBar() {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.home, true),
          _buildNavItem(Icons.swap_horiz, false),
          _buildNavItem(Icons.shopping_cart_outlined, false, hasNotification: true),
          _buildNavItem(Icons.favorite_border, false),
          _buildProfileNavItem(),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, bool isSelected, {bool hasNotification = false}) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isSelected ? Color(0xFFEAEAEA) : Colors.transparent,
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
              decoration: BoxDecoration(
                color: Colors.amber,
                shape: BoxShape.circle,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildProfileNavItem() {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey.shade300),
        image: DecorationImage(
          image: AssetImage('assets/profile_placeholder.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
