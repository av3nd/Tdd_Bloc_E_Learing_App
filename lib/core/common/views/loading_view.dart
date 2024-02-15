import 'package:flutter/material.dart';
import 'package:tdd_tutorial_flutter/core/extensions/context_extension.dart';

class LoadingView extends StatelessWidget{
  const LoadingView({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(
          context.theme.colorScheme.secondary,
        ),
      ),
    );
  }
}