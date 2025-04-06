import 'package:flutter/material.dart';
import 'package:chicago/chicago.dart' as chicago;
import 'package:flutter_adaptive_core/flutter_adaptive_core.dart';
import './master_detail/master_detail_library.dart';
import 'package:flutter_adaptive_chicago/utils/colors.dart';

class ChicagoMasterDetailBuilder
    extends AdaptiveWidgetBuilder<AdaptiveMasterDetail> {
  @override
  Widget build(BuildContext context, AdaptiveMasterDetail component) {
    return ChicagoMasterDetailPage(
      length: component.length ?? 0,
      paneLayoutDelegate: component.paneLayoutDelegate,
      appBarTitle: component.appBarTitle,
      appBarActions: component.appBarActions,
      tileBuilder: component.tileBuilder,
      masterBuilder: component.masterBuilder,
      pageBuilder: component.pageBuilder,
      emptyBuilder: component.emptyBuilder,
      breakpoint: component.breakpoint,
      bottomBar: component.bottomBar,
      initialIndex: component.initialIndex,
      onSelected: component.onSelected,
      controller: component.controller,
      navigatorKey: component.navigatorKey,
      navigatorObservers: component.navigatorObservers,
      initialRoute: component.initialRoute,
      onGenerateRoute: component.onGenerateRoute,
      onUnknownRoute: component.onUnknownRoute,
    );
  }
}

class ChicagoMasterDetailPage extends StatefulWidget {
  const ChicagoMasterDetailPage({
    super.key,
    required this.length,
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

  final int length;
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
  State<ChicagoMasterDetailPage> createState() =>
      _ChicagoMasterDetailPageState();
}

class _ChicagoMasterDetailPageState extends State<ChicagoMasterDetailPage> {
  late AdaptiveMasterDetailPageController _controller;
  int _selectedIndex = -1;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ??
        AdaptiveMasterDetailPageController(
          length: widget.length,
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
    return LayoutBuilder(
      builder: (context, constraints) {
        final isLandscape = constraints.maxWidth >= (widget.breakpoint ?? 600);
        if (isLandscape) {
          return _buildLandscapeLayout(context);
        } else {
          return _buildPortraitLayout(context);
        }
      },
    );
  }

  Widget _buildLandscapeLayout(BuildContext context) {
    return Row(
      children: [
        Container(
          width: widget.paneLayoutDelegate.calculatePaneSize(
            availableSpace: MediaQuery.of(context).size.width,
            candidatePaneSize: 280,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              right: BorderSide(color: Colors.grey.shade400, width: 1.0),
            ),
          ),
          child: Column(
            children: [
              // Windows XP style header
              Container(
                height: 60,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      windowsXPLightBlue,
                      windowsXPDarkBlue,
                    ],
                  ),
                ),
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: widget.appBarTitle != null
                    ? DefaultTextStyle(
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        child: widget.appBarTitle!,
                      )
                    : Text(
                        'Items',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
              Expanded(
                child:
                    widget.masterBuilder?.call(context) ?? _buildMasterPane(),
              ),
            ],
          ),
        ),
        Expanded(
          child: _selectedIndex >= 0
              ? widget.pageBuilder(context, _selectedIndex)
              : widget.emptyBuilder?.call(context) ?? const SizedBox.shrink(),
        ),
      ],
    );
  }

  Widget _buildPortraitLayout(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.appBarTitle,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                windowsXPLightBlue,
                windowsXPDarkBlue,
              ],
            ),
          ),
        ),
        actions: widget.appBarActions
            ?.map((action) => IconButton(
                  onPressed: action.onPressed,
                  icon: action.icon ?? const SizedBox(),
                ))
            .toList(),
      ),
      body: _selectedIndex >= 0
          ? widget.pageBuilder(context, _selectedIndex)
          : widget.masterBuilder?.call(context) ?? _buildMasterPane(),
      bottomNavigationBar: widget.bottomBar,
    );
  }

  // Windows XP style colors
  final Color windowsXPBlue = Color(0xFF3B7CBD);
  final Color windowsXPLightBlue = Color(0xFF5A9AE1);
  final Color windowsXPDarkBlue = Color(0xFF2D6DBE);

  Widget _buildMasterPane() {
    return ListView.builder(
      itemCount: widget.length,
      itemBuilder: (context, index) {
        final isSelected = index == _selectedIndex;

        if (widget.tileBuilder != null) {
          return widget.tileBuilder!.call(
            context,
            index,
            isSelected,
            widget.paneLayoutDelegate.calculatePaneSize(
              availableSpace: MediaQuery.of(context).size.width,
              candidatePaneSize: 280,
            ),
          );
        }

        // Windows XP style list tile
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            gradient: isSelected
                ? LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      windowsXPLightBlue,
                      windowsXPDarkBlue,
                    ],
                  )
                : null,
            border: Border.all(
              color: isSelected ? windowsXPDarkBlue : Colors.transparent,
              width: 1,
            ),
          ),
          child: ListTile(
            title: Text(
              'Item $index',
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            onTap: () {
              _controller.index = index;
            },
          ),
        );
      },
    );
  }
}
