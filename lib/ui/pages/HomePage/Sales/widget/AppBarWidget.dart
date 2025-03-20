import 'package:BusGo/ui/pages/HomePage/Sales/widget/OrigenDestinoCard.dart';
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
            const Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                OrigenDestinoCard(
                  origen: "Aereopuerto el Tepual",
                  destino: "Terminal Puerto Montt",
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
