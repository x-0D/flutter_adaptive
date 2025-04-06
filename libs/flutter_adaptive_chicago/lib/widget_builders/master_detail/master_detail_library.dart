import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show Divider, VerticalDivider;
import 'package:flutter_adaptive_core/flutter_adaptive_core.dart';

class CupertinoMasterDetailPage extends StatefulWidget {
  const CupertinoMasterDetailPage({
    super.key,
    this.length,
    this.paneLayoutDelegate = const FixedPaneDelegate(
      paneSize: 280,
      paneSide: PaneSide.start,
    ),
    this.appBarTitle,
    this.appBarActions,
    this.tileBuilder,
    this.masterBuilder,
    required this.pageBuilder,
    this.emptyBuilder,
    this.breakpoint,
    this.bottomBar,
    this.initialIndex,
    this.onSelected,
    this.controller,
    this.navigatorKey,
    this.navigatorObservers = const <NavigatorObserver>[],
    this.initialRoute,
    this.onGenerateRoute,
    this.onUnknownRoute,
  });

  final int? length;
  final PanedViewLayoutDelegate paneLayoutDelegate;
  final Widget? appBarTitle;
  final List<MasterDetailAppBarActionsItem>? appBarActions;
  final MasterTileBuilder? tileBuilder;
  final WidgetBuilder? masterBuilder;
  final IndexedWidgetBuilder pageBuilder;
  final WidgetBuilder? emptyBuilder;
  final double? breakpoint;
  final Widget? bottomBar;
  final int? initialIndex;
  final ValueChanged<int?>? onSelected;
  final AdaptiveMasterDetailPageController? controller;
  final GlobalKey<NavigatorState>? navigatorKey;
  final List<NavigatorObserver> navigatorObservers;
  final String? initialRoute;
  final RouteFactory? onGenerateRoute;
  final RouteFactory? onUnknownRoute;

  @override
  State<CupertinoMasterDetailPage> createState() =>
      _CupertinoMasterDetailPageState();
}

class _CupertinoMasterDetailPageState extends State<CupertinoMasterDetailPage> {
  late AdaptiveMasterDetailPageController _controller;
  int _selectedIndex = -1;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ??
        AdaptiveMasterDetailPageController(
          length: widget.length ?? 0,
          initialIndex: widget.initialIndex ?? -1,
        );
    _selectedIndex = _controller.index;
    _controller.addListener(_handleControllerUpdate);
  }

  @override
  void dispose() {
    _controller.removeListener(_handleControllerUpdate);
    super.dispose();
  }

  void _handleControllerUpdate() {
    if (_selectedIndex != _controller.index) {
      setState(() {
        _selectedIndex = _controller.index;
      });
      widget.onSelected?.call(_selectedIndex);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Row(
        children: [
          SizedBox(
            width: widget.paneLayoutDelegate.calculatePaneSize(
              availableSpace: MediaQuery.of(context).size.width,
              candidatePaneSize: 280,
            ),
            child: widget.masterBuilder?.call(context) ?? _buildMasterPane(),
          ),
          const VerticalDivider(width: 1),
          Expanded(
            child: _selectedIndex >= 0
                ? widget.pageBuilder(context, _selectedIndex)
                : widget.emptyBuilder?.call(context) ?? const SizedBox(),
          ),
        ],
      ),
    );
  }

  Widget _buildMasterPane() {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: widget.appBarTitle,
        trailing: widget.appBarActions != null
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: widget.appBarActions!
                    .map((action) => CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: action.onPressed,
                          child:
                              action.icon?.build(context) ?? Text(action.title),
                        ))
                    .toList(),
              )
            : null,
      ),
      child: widget.tileBuilder != null
          ? ListView.builder(
              itemCount: widget.length ?? 0,
              itemBuilder: (context, index) => widget.tileBuilder!(
                context,
                index,
                index == _selectedIndex,
                widget.paneLayoutDelegate.calculatePaneSize(
                  availableSpace: MediaQuery.of(context).size.width,
                  candidatePaneSize: 280,
                ),
              ),
            )
          : const SizedBox(),
    );
  }
}
