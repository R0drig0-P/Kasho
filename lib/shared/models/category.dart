import 'package:flutter/material.dart';

class Category {
  final String id;
  final String name;
  final IconData icon;
  final Color color;

  const Category({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
  });
}

// Predefined categories
class DefaultCategories {
  static const List<Category> all = [
    Category(
      id: 'food',
      name: 'Comida & Bebidas',
      icon: Icons.restaurant,
      color: Color(0xFFFF6B35),
    ),
    Category(
      id: 'transport',
      name: 'Transporte',
      icon: Icons.directions_car,
      color: Color(0xFF3498DB),
    ),
    Category(
      id: 'shopping',
      name: 'Compras',
      icon: Icons.shopping_bag,
      color: Color(0xFFE74C3C),
    ),
    Category(
      id: 'entertainment',
      name: 'Entretenimento',
      icon: Icons.movie,
      color: Color(0xFF9B59B6),
    ),
    Category(
      id: 'health',
      name: 'Saúde',
      icon: Icons.local_hospital,
      color: Color(0xFF27AE60),
    ),
    Category(
      id: 'bills',
      name: 'Contas',
      icon: Icons.receipt_long,
      color: Color(0xFFF39C12),
    ),
    Category(
      id: 'education',
      name: 'Educação',
      icon: Icons.school,
      color: Color(0xFF6C5CE7),
    ),
    Category(
      id: 'other',
      name: 'Outros',
      icon: Icons.more_horiz,
      color: Color(0xFF95A5A6),
    ),
  ];

  static Category getById(String id) {
    return all.firstWhere(
      (category) => category.id == id,
      orElse: () => all.last, // Returns 'other' if not found
    );
  }
}
