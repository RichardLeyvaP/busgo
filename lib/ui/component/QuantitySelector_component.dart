import 'package:BusGo/domain/signals/tickets_signals/tickets_signal.dart';
import 'package:BusGo/domain/signals/promotions_signals/promotions_signals.dart';
import 'package:BusGo/models/promotions/promotions_model.dart';
import 'package:BusGo/repository/promotions_repository.dart';
import 'package:BusGo/util/globalCallApi/apiService.dart';
import 'package:BusGo/ui/component/showCustomSnackBar_component.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class QuantitySelector extends StatefulWidget {
  final int initialQuantity;
  final String title;
  final ValueChanged<int> onQuantityChanged;
  final ValueChanged<Promotion?>? onPromotionApplied;

  const QuantitySelector({
    Key? key,
    required this.title,
    required this.initialQuantity,
    required this.onQuantityChanged,
    this.onPromotionApplied,
  }) : super(key: key);

  @override
  _QuantitySelectorState createState() => _QuantitySelectorState();
}

class _QuantitySelectorState extends State<QuantitySelector> {
  late int quantity;

  @override
  void initState() {
    super.initState();
    quantity = widget.initialQuantity;
    // Carga inicial de promociones
    PromotionsRepository(ApiService())
        .getAll()
        .then((lista) => promotionSignal.value = lista)
        .catchError((e) => debugPrint('Error al traer promociones: $e'));
  }

  Future<void> _showPromotionDialog() async {
    if (quantity <= 0) {
      showCustomSnackBar(
        context: context,
        title: 'Debe seleccionar al menos un asiento para aplicar promoción',
        backgroundColor: Colors.red,
      );
      return;
    }

    final promos = promotionSignal.value;
    if (promos == null) {
      showCustomSnackBar(
        context: context,
        title: 'Cargando promociones...',
        backgroundColor: Colors.orange,
      );
      return;
    }

    Promotion? selectedPromo = widget.title == 'Menores de Edad'
        ? promotionMenoresSignal.value
        : widget.title == 'Pasaje Normal'
            ? promotionNormalSignal.value
            : promotionAdultSignal.value;

    final result = await showDialog<Promotion?>(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx, setState) => Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                const Text(
                  'Aplicar Promoción',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                        title: Text(promo.name),
                        subtitle:
                            Text('${promo.percentage.toStringAsFixed(0)}%'),
                        selected: isSel,
                        trailing: isSel
                            ? const Icon(Icons.check_circle, color: Colors.blue)
                            : null,
                        onTap: () {
                          setState(() {
                            // toggle: si ya estaba seleccionado, lo quitamos
                            selectedPromo = isSel ? null : promo;
                          });
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red),
                      onPressed: () => context.pop(),
                      child: const Text('Cancelar'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(ctx).pop(selectedPromo);
                        if (widget.onPromotionApplied != null) {
                          widget.onPromotionApplied!(selectedPromo);
                        }
                      },
                      child: const Text('Aplicar'),
                    ),

                  ],
                ),
              ]),
            ),
          ),
        );
      },
    );

    if (result != null) {
      debugPrint(
          'Promo aplicada en ${widget.title}: ${result.name} (${result.percentage}%)');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Text('${widget.title}: ', style: const TextStyle(fontSize: 12)),
      IconButton(
        icon: const Icon(Icons.remove_circle_outline, size: 18),
        onPressed: quantity > 0
            ? () {
                setState(() => quantity--);
                widget.onQuantityChanged(quantity);

                // si llega a cero, quitamos la promo vinculada
                if (quantity == 0 && widget.onPromotionApplied != null) {
                  widget.onPromotionApplied!(null);
                }

                // actualizar signal de cantidad
                if (widget.title == 'Menores de Edad') {
                  quantityMenoresSignal.value = quantity;
                } else if (widget.title == 'Pasaje Normal') {
                  quantitySignal.value = quantity;
                } else if (widget.title == 'Adultos Mayores') {
                  quantityAdultsSignal.value = quantity;
                }
              }
            : null,
      ),
      Text('$quantity', style: const TextStyle(fontSize: 14)),
      IconButton(
        icon: const Icon(Icons.add_circle_outline, size: 18),
        onPressed: () {
          final totalSelected = quantityMenoresSignal.value +
              quantitySignal.value +
              quantityAdultsSignal.value;
          if (totalSelected >= availableSeatsSignal.value) {
            showCustomSnackBar(
              context: context,
              title: 'No hay asientos disponibles',
              backgroundColor: Colors.red,
            );
            return;
          }
          setState(() => quantity++);
          widget.onQuantityChanged(quantity);

          if (widget.title == 'Menores de Edad') {
            quantityMenoresSignal.value = quantity;
          } else if (widget.title == 'Pasaje Normal') {
            quantitySignal.value = quantity;
          } else if (widget.title == 'Adultos Mayores') {
            quantityAdultsSignal.value = quantity;
          }
        },
      ),
      IconButton(
        icon: const Icon(Icons.local_offer_outlined, color: Colors.black26),
        tooltip: 'Aplicar promoción',
        onPressed: () => _showPromotionDialog(),
      ),
      const Text('Promo',
          style: TextStyle(fontSize: 10, color: Colors.black26)),
    ]);
  }
}
