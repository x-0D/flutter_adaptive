import 'package:flutter/material.dart';
import 'package:chicago/chicago.dart' as chicago;
import 'package:flutter_adaptive_core/flutter_adaptive_core.dart';

class ChicagoListTileBuilder extends AdaptiveWidgetBuilder<AdaptiveListTile> {
  @override
  Widget build(BuildContext context, AdaptiveListTile widget) {
    return ListTile(
      leading: widget.leading,
      title: widget.title,
      subtitle: widget.subtitle,
      trailing: widget.trailing,
      onTap: widget.onTap,
      selected: widget.selected,
      selectedColor: Theme.of(context).colorScheme.primary,
      selectedTileColor:
          Theme.of(context).colorScheme.primary.withOpacity(0.12),
    );
  }
}
