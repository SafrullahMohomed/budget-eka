import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomeLanding extends StatelessWidget {
  const HomeLanding({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: const [
              Text('block 11'),
              Text('block 12'),
            ],
          ),
          Row(
            children: const [
              Text('block 21'),
              Text('block 22'),
            ],
          ),
        ],
      ),
    );
    
  }
}