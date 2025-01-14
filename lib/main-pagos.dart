// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:http/http.dart' as http;
// import 'package:sunmi_bluetooth_app/models/pagament.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: HomePage(),
//     );
//   }
// }



// class HomePage extends StatefulWidget {
//   @override
//   State<HomePage> createState() => _HomePageState();
// }


// class _HomePageState extends State<HomePage> {

  
//  // Método para obtener los encabezados
//   Future<Map<String, String>> _headers() async {
//     //final token = 'ghjhjhkjghjgjh'; //SIMULANDO UN TOKEN MAL
//     final token = '2|4gliF7SnWGIqvk1yDlFsPix6dDlibZaClmeTq5nJa278b423';//token de produccion
//     final headers = {
//       'Content-Type': 'application/json',
//     };
//     headers['Authorization'] = 'Bearer $token';
//     //print('mandando para el get-geader:${token}');
//     return headers;
//   }


// // endpoint = 'https://api.agende-me.risoftwar.com/api/payment/all-payments'
// //token     - 2|4gliF7SnWGIqvk1yDlFsPix6dDlibZaClmeTq5nJa278b423    


//   // Método GET
//   Future<dynamic> fetchPayments(String endpoint) async {
//     try {
      
//     final response = await http.get(
//       Uri.parse(endpoint),
//       headers: await _headers(),
//     );
//     print('mandando para el get-empoint:$endpoint');
    

//      if (response.statusCode == 200) {
//        setState(() {
//         isLoading = false;
      
       
//         paymentResponse = PaymentResponse.fromJson(jsonDecode(response.body) );
//   //       if(paymentResponse != null)
//   //       {
//   //          for (var payment in paymentResponse!.data) {
//   //   print('ID: ${payment.id}');
//   //   print('Charge ID: ${payment.stripeChargeId}');
//   //   print('Amount: ${payment.amount}');
//   //   print('Currency: ${payment.currency}');
//   //   print('Status: ${payment.paymentDetails.status}');
//   //   print('Description: ${payment.paymentDetails.description}');
//   //   print('Payment Method: ${payment.paymentDetails.paymentMethod}');
//   //   print('----------');
//   // }

//   //       }
       
//    });
//       }
     

  
  

    
      
//     } catch (e) {
//        print('Error: $e');
//        setState(() {
//         isLoading = false;
//       });
      
      
//     }finally{
      

//     }

    
//   }
 
//   bool isLoading = true; // Estado de carga
//   PaymentResponse? paymentResponse ; // Respuesta de la API

//   @override
//   void initState() {
//     super.initState();
//     fetchPayments('https://api.agende-me.risoftwar.com/api/payment/all-payments');
//     _codeController.text = '';
//   }

//   final TextEditingController _codeController = TextEditingController();



//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child:  RefreshIndicator(
//           onRefresh: () async {
//     await fetchPayments('https://api.agende-me.risoftwar.com/api/payment/all-payments');  // Ahora la función es compatible
//   },
//         child: Scaffold(
//           appBar: PreferredSize(
//             preferredSize: Size.fromHeight(120.0),
//             child: AppBar(
//               backgroundColor: Colors.deepPurple,
//               flexibleSpace:  Padding(
//                 padding: EdgeInsets.all(16.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Icon(
//                       Icons.mic,
//                       size: 40.0,
//                       color: Colors.white,
//                     ),
//                     SizedBox(width: 16.0),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         SizedBox(height: 10,),
//                         Text(
//                           ' Locutores e Vozes',
//                           style: TextStyle(
//                             fontSize: 26.0,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                           ),
//                         ),
//                       _codeController.text.isNotEmpty?   Row(
//                            children: [
//                             Icon(
//                       Icons.person,
//                       color: Colors.white,
//                     ),
//                              Text(
//                                 'Emerson Sávio',
//                                 style: TextStyle(
//                                   fontSize: 13.0,
//                                   color: Colors.white,
                                  
//                                 ),
//                               ),
//                            ],
//                          ):Container()
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               actions: _codeController.text.isNotEmpty?[
//                 IconButton(
//                   icon: Icon(
//                     Icons.notifications,
//                     size: 28.0,
//                     color: Colors.white,
//                   ),
//                   onPressed: () {
//                     // Ação de notificações
//                   },
//                 ),
//                 IconButton(
//                   icon: Icon(
//                     Icons.logout,
//                     size: 28.0,
//                     color: Colors.white,
//                   ),
//                   onPressed: () {
//                      setState(() {
//                   _codeController.clear(); // Limpia el texto
                
//                                 });
//                     // Ação para sair
//                   },
//                 ),
//               ]:null
//             ),
//           ),
//           body: 
//            isLoading // Si está cargando, muestra un indicador
//               ? Center(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       CircularProgressIndicator(),
//                       Text('Carregando dados'),
//                     ],
//                   ), // Indicador de carga centrado
//                 )
//               : paymentResponse == null
//                   ? Center(child: Text('Erro ao carregar dados'))
//                   : 
//           _codeController.text.isEmpty?
//            Center(
//              child: Padding(
//                padding: const EdgeInsets.all(12.0),
//                child: CodeInputField(
//                          controller: _codeController,
//                          onSubmit: () {
//                 if( _codeController.text == '234567')
//                 {
//                   setState(() {
//                     _codeController.text == '234567';
                  
//                 });
               
//                 }
                
//                 print('Código digitado: ${_codeController.text}');
//                          },
//                        ),
//              ),
//            )

//           :
//           Column(
//             children: [
//               Expanded(
//                 flex: 2,
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     children: [
//                       Text(
//                         'Distribuição de Locutores',
//                         style: TextStyle(
//                           fontSize: 20.0,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       SizedBox(height: 16.0),
//                       Expanded(
//                         child: PieChart(
//                           PieChartData(
//                             sections: [
//                               PieChartSectionData(
//                                 value: 25,
//                                 title: '25%',
//                                 color: Colors.blue,
//                                 radius: 50,
//                                 titleStyle: TextStyle(
//                                   fontSize: 16.0,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                               PieChartSectionData(
//                                 value: 35,
//                                 title: '35%',
//                                 color: Colors.orange,
//                                 radius: 50,
//                                 titleStyle: TextStyle(
//                                   fontSize: 16.0,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                               PieChartSectionData(
//                                 value: 40,
//                                 title: '40%',
//                                 color: Colors.green,
//                                 radius: 50,
//                                 titleStyle: TextStyle(
//                                   fontSize: 16.0,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ],
//                             sectionsSpace: 2,
//                             centerSpaceRadius: 40,
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: 16.0),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: [
//                           _buildLegend('Inglês', Colors.blue),
//                           _buildLegend('Espanhol', Colors.orange),
//                           _buildLegend('Português', Colors.green),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Expanded(
//                 flex: 3,
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: GridView.count(
//                     crossAxisCount: 2,
//                     crossAxisSpacing: 16.0,
//                     mainAxisSpacing: 16.0,
//                     children: [
//                       _buildCard(
//                         context,
//                         'Procurar Locutores',
//                         Icons.record_voice_over,
//                         Colors.blue,
//                         () {
//                           // Ação para procurar locutores
//                         },
//                       ),
//                       _buildCard(
//                         context,
//                         'Criar Anúncio',
//                         Icons.campaign,
//                         Colors.green,
//                         () {
//                           // Ação para criar anúncio
//                         },
//                       ),
//                       _buildCard(
//                         context,
//                         'Ver Pagamentos',
//                         Icons.payment,
//                         Colors.orange,
//                         () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => PaymentsPage(payments: paymentResponse!.data)
//           ,
//                             ),
//                           );
//                         },
//                       ),
//                       _buildCard(
//                         context,
//                         'Suporte',
//                         Icons.support_agent,
//                         Colors.red,
//                         () {
//                           // Ação para suporte
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildLegend(String title, Color color) {
//     return Row(
//       children: [
//         Container(
//           width: 16.0,
//           height: 16.0,
//           color: color,
//         ),
//         SizedBox(width: 8.0),
//         Text(
//           title,
//           style: TextStyle(
//             fontSize: 14.0,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildCard(BuildContext context, String title, IconData icon, Color color, VoidCallback onTap) {
//     return Card(
//       elevation: 4.0,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12.0),
//       ),
//       child: InkWell(
//         onTap: onTap,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               icon,
//               size: 48.0,
//               color: color,
//             ),
//             SizedBox(height: 16.0),
//             Text(
//               title,
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: 16.0,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



// class PaymentsPage extends StatelessWidget {
//   final List<PaymentData> payments;

//   // Constructor que recibe los datos dinámicos
//   PaymentsPage({required this.payments});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Detalhes de Pagamentos'),
//         backgroundColor: Colors.transparent,
//         elevation: 2,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: payments.isNotEmpty
//             ? ListView.builder(
//                 itemCount: payments.length,
//                 itemBuilder: (context, index) {
//                   final payment = payments[index];
//                   return Card(
//                     elevation: 4.0,
//                     margin: EdgeInsets.symmetric(vertical: 8.0),
//                     child: ListTile(
//                       leading: Icon(
//                         Icons.payment,
//                         color: Colors.deepPurple,
//                       ),
//                       title: Text('Pagamento #${payment.id}'),
//                       subtitle: Text('Valor: R\$ ${(payment.amount).toStringAsFixed(2)}'),
//                       trailing: Icon(Icons.arrow_forward_ios),
//                       onTap: () {
//                         showModalBottomSheet(
//                           context: context,
//                           builder: (context) {
//                             return Padding(
//                               padding: const EdgeInsets.all(16.0),
//                               child: Column(
//                                 mainAxisSize: MainAxisSize.min,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     'Detalhes do Pagamento',
//                                     style: TextStyle(
//                                       fontSize: 18.0,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                   SizedBox(height: 8.0),
//                                   Text('ID: ${payment.id}'),
//                                   Text('Valor: R\$ ${(payment.amount).toStringAsFixed(2)}'),
//                                   Text('Moeda: ${payment.paymentDetails.currency}'),
//                                   Text('Status: ${payment.paymentDetails.status}'),
//                                  Text('Descrição: ${payment.paymentDetails.description}'),
//                                   //Text('Método: ${payment.paymentDetails.paymentMethod}'),
//                                   SizedBox(height: 8.0),
//                                 ],
//                               ),
//                             );
//                           },
//                         );
//                       },
//                     ),
//                   );
//                 },
//               )
//             : Center(
//                 child: Text(
//                   'Nenhum pagamento encontrado.',
//                   style: TextStyle(fontSize: 16.0),
//                 ),
//               ),
//       ),
//     );
//   }
// }




// class CodeInputField extends StatelessWidget {
//   final TextEditingController controller;
//   final VoidCallback? onSubmit;

//   CodeInputField({Key? key, required this.controller, this.onSubmit}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         Container(
//           padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(12.0),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black12,
//                 blurRadius: 6,
//                 offset: Offset(0, 3),
//               ),
//             ],
//           ),
//           child: TextField(
//             controller: controller,
//             keyboardType: TextInputType.number,
//             style: TextStyle(fontSize: 16.0, color: Colors.black87),
//             decoration: InputDecoration(
//               hintText: 'Digite o código',
//               hintStyle: TextStyle(color: Colors.black45, fontWeight: FontWeight.w500),
//               border: InputBorder.none,
//               prefixIcon: Icon(Icons.key, color: Colors.deepPurple),
//             ),
//             onSubmitted: (_) => onSubmit?.call(),
//           ),
//         ),
//         SizedBox(height: 12.0),
//         ElevatedButton(
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Colors.deepPurple,
//             padding: EdgeInsets.symmetric(vertical: 12.0),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12.0),
//             ),
//           ),
//           onPressed: onSubmit,
//           child: Text(
//             'Aceitar',
//             style: TextStyle(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.bold),
//           ),
//         ),
//       ],
//     );
//   }
// }

