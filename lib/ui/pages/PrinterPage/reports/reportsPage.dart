import 'package:BusGo/ui/pages/PrinterPage/reports/report1/report1Page.dart';
import 'package:BusGo/ui/pages/PrinterPage/reports/report2/report2Page.dart';
//import 'package:BusGo/ui/pages/PrinterPage/reports/report3/report3Page.dart';
import 'package:BusGo/ui/pages/PrinterPage/widget/classUtilsPrinterTicket.dart';
import 'package:flutter/material.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({super.key});

  @override
  _ReportsPageState createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final PageController _pageController = PageController();
UtilsPrinterTicket utilsPrinterTicket = UtilsPrinterTicket();
bool _isButtonEnabled = true; // El botón está habilitado por defecto
// Método para habilitar el botón
  void _enableButton() {
    setState(() {
      _isButtonEnabled = true;
    });
  }

  // Método para deshabilitar el botón
  void _disableButton() {
    setState(() {
      _isButtonEnabled = false;
    });
  }
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        _pageController.jumpToPage(_tabController.index);
      }
    });
  }

  // Métodos para cada pestaña
  Future<void> _printReportForTab0(BuildContext context) async {
    // Lógica para imprimir en el Tab 0
    print("Método de impresión para Resumen Diario");
    _disableButton();
    print("Método de impresión para Resumen Diario-desabilitado");
  await  utilsPrinterTicket.printReporte1();
  _enableButton();
    print("Método de impresión para Resumen Diario-abilitado");

  }

  Future<void> _printReportForTab1(BuildContext context) async {
    // Lógica para imprimir en el Tab 1
    print("Método de impresión para Resumen de Viajes");
    print("Método de impresión para Resumen Diario-desabilitado");
  await  utilsPrinterTicket.printReporte2();
  _enableButton();
    print("Método de impresión para Resumen Diario-abilitado");
  }

  void _printReportForTab2(BuildContext context) {
    // Lógica para imprimir en el Tab 2
    print("Método de impresión para Resumen Total");
  }

  // Método para manejar el FloatingActionButton según la pestaña activa
  void _handlePrint(BuildContext context) {
    if (_tabController.index == 0) {
      _printReportForTab0(context);
    } else if (_tabController.index == 1) {
      _printReportForTab1(context);
    } else if (_tabController.index == 2) {
      _printReportForTab2(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text(
          "Reportes",
          style: TextStyle(color: Colors.black),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 1),
            child: Container(
              color: Colors.orange,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: TabBar(
                    controller: _tabController,
                    isScrollable: true,
                    tabAlignment: TabAlignment.start,
                    indicator: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.black,
                    labelPadding: const EdgeInsets.symmetric(horizontal: 6),
                    tabs: [
                      _buildTab("Resumen Diario"),
                      _buildTab("Resumen de Viajes"),
                     // _buildTab("Resumen Total"),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Report1Page(),
          Report2Page(),
         // Report3Page(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
         onPressed: _isButtonEnabled ? () => _handlePrint(context) : null, // El botón solo se activa si _isButtonEnabled es true
        child: const Icon(Icons.print),
      ),
    );
  }

  Widget _buildTab(String title) {
    return Tab(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }
}
