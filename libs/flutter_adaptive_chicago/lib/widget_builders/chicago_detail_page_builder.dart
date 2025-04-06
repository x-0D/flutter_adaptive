import 'package:flutter/material.dart';
import 'package:chicago/chicago.dart';
import 'package:flutter_adaptive_core/flutter_adaptive_core.dart';
import 'master_detail/master_detail_library.dart';

class ChicagoDetailPageBuilder
    extends AdaptiveWidgetBuilder<AdaptiveDetailPage> {
  @override
  Widget build(BuildContext context, AdaptiveDetailPage component) {
    return Scaffold(
      backgroundColor: component.backgroundColor,
      appBar: AppBar(
        title: component.appBarTitle,
        actions: component.appBarActions
            ?.map((action) => IconButton(
                  onPressed: action.onPressed,
                  icon: action.icon?.build(context) ?? const Icon(Icons.help),
                  tooltip:
                      action.title is Text ? (action.title as Text).data : null,
                ))
            .toList(),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: component.body ?? const SizedBox(),
    );
  }
}
