import 'package:flutter/material.dart';

const cards = <Map<String, dynamic>>[
  {'elevation': 1.0, 'label': 'Trabajador 1'},
  {'elevation': 2.0, 'label': 'Trabajador 2'},
];

class ListPage extends StatelessWidget {
  const ListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.blue,
            height: MediaQuery.of(context).size.height * 0.10,
            width: MediaQuery.of(context).size.width * 100,
            child: const Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              // InkWell(
              //   onTap: () {
              //     GoRouter.of(context).pop();
              //   },
              //   child: const Padding(
              //     padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
              //     child: Icon(Icons.arrow_back, color: Colors.white),
              //   ),
              // ),
              VerticalDivider(width: 12, color: Colors.transparent,),
              Center(
                widthFactor: 1.7,
                child: Text('Listado de Trabajadores',
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.bold
                ),
                ),
              )
            ]),
          ),
          const _CardsView(),
        ],
      ),
    );
  }
}

class _CardsView extends StatelessWidget {
  const _CardsView();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ...cards.map(
            (card) =>
                _CardType1(elevation: card['elevation'], label: card['label']),
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}

class _CardType1 extends StatelessWidget {
  const _CardType1({required this.label, required this.elevation});
  final String label;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation,
      color: Colors.white38,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(Icons.more_vert_outlined),
                onPressed: () {},
              ),
            ),
            Align(alignment: Alignment.centerLeft, child: Text(label)),
          ],
        ),
      ),
    );
  }
}
