import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final String name;
  final String iconName;

  const CategoryItem({super.key, required this.name, required this.iconName});

  IconData _getIconData() {
    switch (iconName.toLowerCase()) {
      case 'group':
        return Icons.group;
      case 'honeymoon':
        return Icons.favorite;
      case 'solo':
        return Icons.person;
      case 'mountain':
        return Icons.landscape;
      case 'beaches':
        return Icons.beach_access;
      case 'wild':
        return Icons.pets;
      default:
        return Icons.place;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: const BoxDecoration(
            color: Color(0xFFFFD700),
            shape: BoxShape.circle,
          ),
          child: Icon(_getIconData(), color: Colors.white, size: 28),
        ),
        const SizedBox(height: 8),
        Text(
          name,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
