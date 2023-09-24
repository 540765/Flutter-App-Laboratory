import 'package:flutter/material.dart';

class HomeMobilePortraitView extends StatelessWidget {
  const HomeMobilePortraitView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.white,
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return const ListTile(
              title: Text('title'),
            );
          },
          itemCount: 20,
        ),
      ),
    );
  }
}
