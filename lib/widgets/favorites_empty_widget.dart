import 'package:flutter/material.dart';

class FavoritesEmptyWidget extends StatelessWidget {
  const FavoritesEmptyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      height: MediaQuery.of(context).size.height / 3,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: Colors.black54),
      child: const Center(
        child: Text(
            "You favorite list is empty. You can start discovering movies!"),
      ),
    );
  }
}
