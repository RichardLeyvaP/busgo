
  import 'package:flutter/material.dart';

BottomAppBar BottomAppBarWidget(int currentIndex, void Function(int) onItemTapped) {
    return BottomAppBar(
      color: Colors.grey[300], // Cambia el color de fondo del BottomAppBar
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          NavItem(
            icon: Icons.person,
            index: 0,
            isSelected: currentIndex == 0, // Se selecciona si el índice coincide
            onItemTapped: onItemTapped,
          ),
          NavItem(
            icon: Icons.list,
            index: 1,
            isSelected: currentIndex == 1,
            onItemTapped: onItemTapped,
          ),
          NavItem(
            icon: Icons.notifications,
            index: 2,
            isSelected: currentIndex == 2,
            onItemTapped: onItemTapped,
          ),
          NavItem(
            icon: Icons.bar_chart,
            index: 3,
            isSelected: currentIndex == 3,
            onItemTapped: onItemTapped,
          ),
          NavItem(
            icon: Icons.emoji_emotions,
            index: 4,
            isSelected: currentIndex == 4,
            onItemTapped: onItemTapped,
          ),
        ],
      ),
    );
  }


//COMPONENTE DEL NAVIGATION_BAR
class NavItem extends StatelessWidget {
  final IconData icon; // El ícono que se va a mostrar
  final int index; // El índice de la página a la que se debe navegar
  final bool isSelected; // Indica si el ícono está seleccionado
  final Function(int) onItemTapped; // La función para manejar el cambio de página

  const NavItem({
    Key? key,
    required this.icon,
    required this.index,
    required this.isSelected,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        icon,
        size: 30,
        color: isSelected ? Colors.blue : Colors.grey[500], // Cambia el color si está seleccionado
      ),
      onPressed: () => onItemTapped(index), // Navega a la página correspondiente
    );
  }
}

