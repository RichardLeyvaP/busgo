import 'package:BusGo/ui/pages/HomePage/Sales/widget/OrigenDestinoCard.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppBarSalesWidget extends StatelessWidget {
  const AppBarSalesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 215,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.blue[400],
      ),
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {

                GoRouter.of(context).pop();
              },
              child: const Padding(
                padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                child: Icon(Icons.arrow_back, color: Colors.white),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(7, 25, 0, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  OrigenDestinoCard(
                    origen: "Aereopuerto el Tepual",
                    destino: "Terminal Puerto Montt",
                  ),
                ],
              ),
            ),
            const Text('      '),
          ],
        ),
      ),
    );
  }
}
