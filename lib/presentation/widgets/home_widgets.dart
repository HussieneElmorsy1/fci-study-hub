import 'package:fci_app_new/data/models/side_menu_item.dart';
import 'package:flutter/material.dart';
import 'package:fci_app_new/presentation/widgets/custom_side_menu.dart';

class GroupSelection extends StatelessWidget {
  final String selectedGroup;
  final Function(BuildContext) showGroupMenu;

  const GroupSelection({
    super.key,
    required this.selectedGroup,
    required this.showGroupMenu,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              spreadRadius: 1,
              offset: Offset(0, 2))
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: Center(
                  child: Text(selectedGroup,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)))),
          GestureDetector(
            onTap: () => showGroupMenu(context),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(8)),
              child: const Icon(Icons.tune, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class SideMenu extends StatelessWidget {
  final List<SideMenuItem> items;
  final Function(int) onItemSelected;

  const SideMenu({
    Key? key,
    required this.items,
    required this.onItemSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomSideMenu(
      items: items,
      onItemSelected: onItemSelected,
    );
  }
}
