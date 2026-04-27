import 'package:flutter/material.dart';
import 'package:test_for_orb_it/features/home/domain/entities/business_entity.dart';

class BusinessCard extends StatelessWidget {
  final BusinessEntity business;

  const BusinessCard({super.key, required this.business});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            business.imageUrl,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => const Icon(Icons.business),
          ),
        ),
        title: Text(business.name),
        subtitle: Text(business.description),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          // Navigate to business details if needed
        },
      ),
    );
  }
}
