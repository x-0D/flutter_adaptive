import 'package:flutter/material.dart';
import 'package:chicago/chicago.dart' as chicago;
import 'package:flutter_adaptive_core/flutter_adaptive_core.dart';

class ChicagoListTileBuilder extends AdaptiveWidgetBuilder<AdaptiveListTile> {
  @override
  Widget build(BuildContext context, AdaptiveListTile component) {
    return ListTile(
      leading: component.leading,
      title: component.title,
      subtitle: component.subtitle,
      trailing: component.trailing,
      onTap: component.onTap,
      selected: component.selected,
      selectedColor: Theme.of(context).colorScheme.primary,
      selectedTileColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
    );
  }
}
