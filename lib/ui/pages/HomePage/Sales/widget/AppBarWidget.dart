import 'package:BusGo/ui/pages/HomePage/Sales/widget/OrigenDestinoCard.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:signals/signals.dart';

class AppBarSalesWidget extends StatelessWidget {
  const AppBarSalesWidget({
    super.key,
    required this.origen,
  });
  final String origen;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 215,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.blue[400],
      ),
      child: Padding(
        padding:  const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                if (GoRouter.of(context).canPop()) {
                  GoRouter.of(context).pop();
                } else {
                  GoRouter.of(context).go('/DashboardPage');
                }

              },
              child: AppBar(
                backgroundColor: Colors.blue[400],
                elevation: 0,
                title: const Text('Viajes'),
                centerTitle: true,
                leading: IconButton(
                    icon:const Icon(Icons.arrow_back, color: Colors.white,),
                    onPressed:()=> GoRouter.of(context).go('/DashboardPage')
                ),

              ),

              ) ,


            Padding(
              padding: const EdgeInsets.fromLTRB(7, 5, 0, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  OrigenDestinoCard(
                    origen: origen,
                    destino: "Destino",
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
