//selccionador de cantidades

import 'package:BusGo/domain/signals/tickets_signals/tickets_signal.dart';
import 'package:BusGo/ui/component/showCustomSnackBar_component.dart';
import 'package:flutter/material.dart';

import '../../domain/signals/promotions_signals/promotions_signals.dart';
import '../../models/promotions/promotions_model.dart';
import '../../repository/promotions_repository.dart';
import '../../util/globalCallApi/apiService.dart';

class QuantitySelector extends StatefulWidget {
  final int initialQuantity;
  final String title;
  final ValueChanged<int> onQuantityChanged;
  final ValueChanged<Promotion>? onPromotionApplied;// Función callback

  const QuantitySelector({
    super.key,
    required this.title,
    required this.initialQuantity,
    required this.onQuantityChanged,
    this.onPromotionApplied,// Recibimos la función callback
  });

  @override
  _QuantitySelectorState createState() => _QuantitySelectorState();
}

class _QuantitySelectorState extends State<QuantitySelector> {
  late int quantity;
  @override
  void initState() {
    super.initState();
    quantity = widget.initialQuantity;
    final repo = PromotionsRepository(ApiService()); // <-- posicional
    repo.getAll()                                // <-- método getAll()
        .then((lista) {
      promotionSignal.value = lista;
    })
        .catchError((error) {
      // aquí tu manejo de error
      print('Error al traer promociones: $error');
    });
  }

  Future<void> _showPromotionDialog() async {
    final List<Promotion>? promos = promotionSignal.value;

    // Si todavía no llegó la data:
    if (promos == null) {
      showCustomSnackBar(
        context: context,
        title: 'Cargando promociones...',
        backgroundColor: Colors.orange,
      );
      return;
    }
    Promotion? selectedPromo;

    final Promotion? applied = await showDialog<Promotion>(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Aplicar Promoción',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 200,
                      child: ListView.separated(
                        itemCount: promos.length,
                        separatorBuilder: (_, __) => const Divider(height: 1),
                        itemBuilder: (_, i) {
                          final promo = promos[i];
                          final isSel = promo == selectedPromo;
                          return ListTile(
                            title: Text(
                              promo.name ?? 'Promo sin nombre',
                              style: TextStyle(
                                color: isSel ? Colors.blue : Colors.black,
                                fontWeight:
                                    isSel ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                            subtitle: Text(
                                '${promo.percentage?.toStringAsFixed(0)}%'),
                            trailing: isSel
                                ? const Icon(Icons.check_circle,
                                    color: Colors.blue)
                                : null,
                            selected: isSel,
                            onTap: () => setState(() => selectedPromo = promo),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    if (selectedPromo != null) {
                      // 1) Cerramos el diálogo retornando la promo seleccionada
                      Navigator.of(ctx).pop(selectedPromo);

                      // 2) Si el widget recibió un onPromotionApplied, lo invocamos
                      if (widget.onPromotionApplied != null) {
                        widget.onPromotionApplied!(selectedPromo!);
                      }

                    } else {
                      ScaffoldMessenger.of(ctx).showSnackBar(
                        const SnackBar(content: Text('Seleccione una promoción')),
                      );
                    }
                  },
                  child: const Text('Aplicar'),
                ),

                  ],
                ),
              ),
            );
          },
        );
      },
    );
    if (applied != null) {
      // aquí ya tienes la Promotion completa
      debugPrint(
          'Promoción aplicada: ${applied.name} (${applied.percentage}%)');
      // TODO: guarda la promo en un Signal o haz callback
    }
  }

  // @override
  // void initState() {
  //   super.initState();
  //   quantity = widget.initialQuantity;
  // }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('${widget.title}: ', style: const TextStyle(fontSize: 12)),
        IconButton(
          icon: const Icon(
            Icons.remove_circle_outline,
            size: 18,
          ),
          onPressed: quantity > 0
              ? () {
                  // decreaseQuantity();
                  if (widget.title == 'Menores de Edad') {
                    quantityMenoresSignal.value--;
                    setState(() {
                      quantity--;
                    });
                    widget.onQuantityChanged(
                        quantity); // Llamamos la función callback
                  } else if (widget.title == 'Pasaje Normal') {
                    quantitySignal.value--;
                    setState(() {
                      quantity--;
                    });
                    widget.onQuantityChanged(
                        quantity); // Llamamos la función callback
                  } else if (widget.title == 'Adultos Mayores') {
                    quantityAdultsSignal.value--;
                    setState(() {
                      quantity--;
                    });
                    widget.onQuantityChanged(quantity);
                  } else {
                    setState(() {
                      quantity--;
                    });
                    widget.onQuantityChanged(quantity);
                    _showPromotionDialog();
                    // Llamamos la función callback
                  }
                }
              : null,
        ),
        Text('$quantity', style: const TextStyle(fontSize: 14)),
        IconButton(
          icon: const Icon(
            Icons.add_circle_outline,
            size: 18,
          ),
          onPressed: () {
            // increaseQuantity();
            if (widget.title == 'Menores de Edad' ||
                widget.title == 'Pasaje Normal' ||
                widget.title == 'Adultos Mayores') {
              if ((quantityMenoresSignal.value +
                      quantitySignal.value +
                      quantityAdultsSignal.value) >=
                  availableSeatsSignal.value) {
                print('No puede seleccionar mas asientos');
                showCustomSnackBar(
                  context: context,
                  title: 'No hay asientos disponibles', // Obligatorio
                  titleColor: Colors.white, // Opcional
                  icon: Icons.check_circle, // Opcional
                  backgroundColor: Colors.red, // Opcional
                  duration: const Duration(seconds: 3), // Opcional
                );
              } else {
                setState(() {
                  quantity++;
                });
                widget.onQuantityChanged(
                    quantity); // Llamamos la función callback
              }
            } else {
              setState(() {
                quantity++;
              });
              widget.onQuantityChanged(quantity);
              // Llamamos la función callback
            }
          },
        ),
        IconButton(
          icon: const Icon(Icons.local_offer_outlined, color: Colors.black26,),
          tooltip: 'Aplicar promoción',
          onPressed: _showPromotionDialog,
        ),
        const Text(
          'Promo',
          style: TextStyle(fontSize: 10, color: Colors.black26),
        )
      ],
    );
  }
}

