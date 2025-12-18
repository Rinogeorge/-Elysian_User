import 'package:elysian_user/features/home/domain/entities/category_entity.dart';
import 'package:elysian_user/presentation/screens/home/widgets/category_item.dart';
import 'package:flutter/material.dart';

class CategoriesSection extends StatelessWidget {
  final List<CategoryEntity> categories;

  const CategoriesSection({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1E5BB8),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              childAspectRatio: 0.9,
            ),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return CategoryItem(
                name: categories[index].name,
                iconName: categories[index].iconName,
              );
            },
          ),
          const SizedBox(height: 12),
          const Icon(Icons.keyboard_arrow_up, color: Colors.white, size: 24),
        ],
      ),
    );
  }
}
