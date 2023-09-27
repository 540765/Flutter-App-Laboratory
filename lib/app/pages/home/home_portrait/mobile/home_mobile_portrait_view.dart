import 'package:flutter/material.dart';
import 'package:laboratory/app_widget/app_laboratory_refresh/app_laboratory_refresh.dart';

class HomeMobilePortraitView extends StatelessWidget {
  const HomeMobilePortraitView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: AppLaboratoryRefresh(
        child: Container(
          color: Colors.white,
          child: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return const ListTile(
                title: Text('title'),
              );
            },
            itemCount: 20,
          ),
        ),
      ),
    );
  }
}
