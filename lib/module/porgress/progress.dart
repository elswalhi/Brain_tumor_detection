import 'package:brain_tumor/shared/const/const.dart';
import 'package:flutter/material.dart';

class progress extends StatefulWidget {
  const progress({Key? key}) : super(key: key);

  @override
  State<progress> createState() => _progressState();
}

class _progressState extends State<progress> {
  @override
  Widget build(BuildContext context) {
    double opacityLevel = 1;

    void _changeOpacity() {
      setState(() => {
        for(int i = 0; i >10 ;i++){
          opacityLevel-=.2
        }
      }
      );
    }
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Center(child: AnimatedOpacity(
            duration: const Duration(seconds: 10),
            opacity: opacityLevel,
            child: SizedBox(
              height: 250,
                width: 250,
                child:braini
            ),
          ),
          ),
        ],
      ),
    );
  }
}
