
import 'package:BusGo/data/services/local_database_service.dart';
import 'package:BusGo/data/services/ticketSyncService.dart';
import 'package:BusGo/domain/signals/sales_signals/sales_services.dart';
import 'package:BusGo/domain/signals/sales_signals/sales_signals.dart';
import 'package:BusGo/ui/component/loadingDialog_component.dart';
import 'package:BusGo/ui/pages/HomePage/Home/widget/ModuleCard.dart';
import 'package:BusGo/ui/pages/HomePage/Home/widget/StatisticCard.dart';
import 'package:BusGo/util/util_class_sharedPreferences.dart';
import 'package:BusGo/util/util_class_translation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';



class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  Future<void> fetchSalesData() async {
  await getSales("", 'Negocio', "2025-02");
 
}

SharedPreferencesStorage sharedPreferencesStorage = SharedPreferencesStorage(); // Instancia de la base de datos
    int  sharedPrefStorage = 0 ;
  @override
  void initState() {
    // TODO: implement initState
      
    super.initState();
  }
 Color colorModuleTicket = Colors.lightGreen;
 
  @override
  Widget build(BuildContext context) {
     // Ejecuta el código después de que la página se haya renderizado
  WidgetsBinding.instance.addPostFrameCallback((_) async {
int sharedPrefLocal = await sharedPreferencesStorage.getCounter();
if(sharedPrefLocal>0){
   colorModuleTicket = Colors.amber[900]!;
}
else{
  colorModuleTicket = Colors.lightGreen;
}
if(sharedPrefLocal != sharedPrefStorage) {
   sharedPrefStorage = sharedPrefLocal;
  setState(()  {
   
  });
 
}
  });
    return 
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                const Text(
                  'Módulos',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                SizedBox(height: 10),
                // Modules Row
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ModuleCard(
                      color: Colors.blue,
                      icon: Icons.sell,
                      title: 'Venta',
                      description: 'Módulo de venta de pasajes',
                      route: '/SalesPage',
                    ),
                    ModuleCard(
                      color: Colors.orange,
                      icon: Icons.bar_chart,
                      title: 'Reportes',
                      description: 'Módulo de reportes y estadísticas',
                      
                      //route: '/PrinterPage',
                      route: '/ReportsPage',
                    ),
                  ],
                ),
                SizedBox(height: 20),
                // Statistics Title
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Estadísticas diarias',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    GestureDetector(
                      onTap: () {
                        GoRouter.of(context).push('/StatisticsPageAll');
                      },
                      child: Text(
                        'Ver todas',
                        style: TextStyle(fontSize: 16, color: Colors.blue),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                // Statistics Cards
                FutureBuilder<void>(
    future: fetchSalesData(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: CircularProgressIndicator()); // Cargando...
      }
      if (snapshot.hasError) {
        return Center(child: Text("Error: ${snapshot.error}"));
      }

      var sales = resultSalesSL.value?.sales ?? [];
  
      
      return 
      Column(
        children: [
          Column(
                    children: sales.map((sale) {
                      return Column(
                        children: [
                          StatisticCard(
                            color: Color(int.parse(sale.color!.substring(1), radix: 16) + 0xFF000000),
                            icon: getMdiIcon(sale.icon!),
                            title: sale.title!,
                            value: '${sale.value}', 
                            complement: '',
                          ),
                          SizedBox(height: 10),
                        ],
                      );
                    }).toList(),
                    
                  ),
                  InkWell(
                    onTap: () async {

                      
  int cantTicketSyncService = await sharedPreferencesStorage.getCounter();
  if (cantTicketSyncService != 0) {
    // Mostrar el modal de carga con el proceso
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false, // Esto previene que el modal se cierre con el botón atrás
          child: LoadingDialog(
            taskToExecute: () async {
              final ticketSyncService = TicketSyncService(
                dbHelper: DatabaseHelper(),
              );

              // Llamar la sincronización de tickets pendientes
              await ticketSyncService.syncPendingTickets();
                setState(()  {
   
  });
            },
          ),
        );
      },
    );

   

 

  } else {
    print('No hay tickets pendientes en la base de datos local.');
  }
},
                    child: StatisticCard(
                          color: colorModuleTicket,
                          icon: Icons.cloud_upload,
                          title:  'Sincronizar Tickets',	
                          value: '$sharedPrefStorage', 
                          complement: '',
                        ),
                  ),
        ],
      );
    },
  )
             
              ],
            ),
          ),
        ),
      );
      
    
  }
}








