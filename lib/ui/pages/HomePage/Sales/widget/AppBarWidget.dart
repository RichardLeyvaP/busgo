import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AppBarSalesWidget extends StatelessWidget {
  const AppBarSalesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.blue[400],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                GoRouter.of(context).pop();
              },
              child: const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Icon(Icons.arrow_back, color: Colors.white),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  "",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Column(
                  children: [
                    Icon(MdiIcons.busMultiple, color: Colors.white, size: 60),
                    const SizedBox(
                      height: 6,
                    ),
                    const Text(
                      'Viajes',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ],
                ),
              ],
            ),
            const Text('      '),
          ],
        ),
      ),
    );
  }
}
