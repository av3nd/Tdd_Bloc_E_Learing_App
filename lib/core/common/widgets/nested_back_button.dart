import 'package:flutter/material.dart';
import 'package:tdd_tutorial_flutter/core/extensions/context_extension.dart';

class NestedBackButton extends StatelessWidget{
  const NestedBackButton({super.key});
  
  @override
  Widget build(BuildContext context) {
   return WillPopScope(
    onWillPop: () async{
      try {
        context.pop();
        return false;
      } catch (e) {
        return true;
      }
    },
     child: IconButton(
      onPressed: (){
        try {
          context.pop();
        } catch (e) {
          Navigator.of(context).pop();
        }
     },icon: Theme.of(context).platform == TargetPlatform.android
            ? const Icon(Icons.arrow_back_ios_new)
            : const Icon(Icons.arrow_back),
            ),
   );
  }

  
}