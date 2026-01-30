import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../theme_data/fonts.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key, required this.error});

  final String error;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 48, color: Colors.red),
          SizedBox(height: 16),
          Text(
            'Failed to load movie details',
            style: CustomFontStyle.mediumText,
          ),
          SizedBox(height: 8),
          Text(
            error,
            style: CustomFontStyle.regularText.copyWith(fontSize: 12),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => context.pop(),
            child: Text('Go Back'),
          ),
        ],
      ),
    );
  }
}
