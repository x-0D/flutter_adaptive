import 'package:flutter/material.dart';
import 'package:chicago/chicago.dart' as chicago;
import 'package:flutter_adaptive_core/flutter_adaptive_core.dart';
import 'package:flutter_adaptive_chicago/utils/colors.dart';

class ChicagoNavigationBuilder
    extends AdaptiveWidgetBuilder<AdaptiveNavigation> {
  @override
  Widget build(BuildContext context, AdaptiveNavigation component) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < FormFactor.tablet) {
          return ChicagoMobile(
            groupDestinations: component.groupDestinations,
            showNavigationDrawerOnMobile:
                component.showNavigationDrawerOnMobile,
            showBottomNavigationBarOnMobile:
                component.showBottomNavigationBarOnMobile,
          );
        } else if (constraints.maxWidth < FormFactor.desktop) {
          if (component.showOnlyModalNavigationDrawerOnTablet) {
            return ChicagoDrawer(
              groupDestinations: component.groupDestinations,
              isModal: true,
            );
          }
          return ChicagoDrawer(
            groupDestinations: component.groupDestinations,
            isModal: false,
          );
        } else {
          if (component.showOnlyModalNavigationDrawerOnDesktop) {
            return ChicagoDrawer(
              groupDestinations: component.groupDestinations,
              isModal: true,
            );
          }
          return ChicagoDrawer(
            groupDestinations: component.groupDestinations,
            isModal: false,
          );
        }
      },
    );
  }
}

class ChicagoMobile extends StatefulWidget {
  const ChicagoMobile({
    super.key,
    required this.groupDestinations,
    required this.showNavigationDrawerOnMobile,
    required this.showBottomNavigationBarOnMobile,
  }) : assert(
          showNavigationDrawerOnMobile == true ||
              showBottomNavigationBarOnMobile == true,
          "Set at least one navigation on mobile",
        );

  final List<AdaptiveGroupDestination> groupDestinations;
  final bool showNavigationDrawerOnMobile;
  final bool showBottomNavigationBarOnMobile;

  @override
  ChicagoMobileState createState() => ChicagoMobileState();
}

class ChicagoMobileState extends State<ChicagoMobile> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bottomBarDestinations = widget.groupDestinations
        .expand((group) => group.destinations)
        .where((destination) => destination.showOnBottomAppBar == true)
        .toList();

    // Use Windows XP style colors from ChicagoColors
    final Color windowsXPBlue = ChicagoColors.windowsXPBlue;
    final Color windowsXPLightBlue = ChicagoColors.windowsXPLightBlue;
    final Color windowsXPDarkBlue = ChicagoColors.windowsXPDarkBlue;

    return Scaffold(
      body: bottomBarDestinations[_selectedIndex].page,
      bottomNavigationBar: widget.showBottomNavigationBarOnMobile
          ? Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.grey.shade400, width: 1.0),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    windowsXPLightBlue,
                    windowsXPDarkBlue,
                  ],
                ),
              ),
              child: NavigationBar(
                backgroundColor: Colors.transparent,
                selectedIndex: _selectedIndex,
                onDestinationSelected: _onItemTapped,
                destinations: bottomBarDestinations
                    .map((destination) => NavigationDestination(
                          icon: destination.icon,
                          label: destination.label,
                          selectedIcon: ShaderMask(
                            shaderCallback: (Rect bounds) {
                              return LinearGradient(
                                colors: [Colors.white, Colors.white70],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ).createShader(bounds);
                            },
                            child: destination.icon,
                          ),
                        ))
                    .toList(),
                labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
                height: 56,
                indicatorColor: Colors.white.withOpacity(0.3),
              ),
            )
          : null,
      drawer: widget.showNavigationDrawerOnMobile
          ? _buildWindowsXPDrawer(context, widget.groupDestinations)
          : null,
    );
  }

  Widget _buildWindowsXPDrawer(
      BuildContext context, List<AdaptiveGroupDestination> groupDestinations) {
    // Use Windows XP style colors from ChicagoColors
    final Color windowsXPBlue = ChicagoColors.windowsXPBlue;
    final Color windowsXPLightBlue = ChicagoColors.windowsXPLightBlue;
    final Color windowsXPDarkBlue = ChicagoColors.windowsXPDarkBlue;

    return Drawer(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Container(
              height: 80,
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
              child: Center(
                child: Text(
                  'Navigation',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 8),
                children: groupDestinations
                    .expand((group) => [
                          if (group.name.isNotEmpty)
                            Container(
                              width: double.infinity,
                              margin: const EdgeInsets.fromLTRB(8, 16, 8, 8),
                              padding: const EdgeInsets.fromLTRB(8, 6, 8, 6),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    windowsXPLightBlue,
                                    windowsXPDarkBlue,
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(2),
                                border: Border.all(
                                  color: windowsXPDarkBlue,
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                group.name,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ...group.destinations
                              .where((destination) =>
                                  destination.showOnDrawerSidebar)
                              .map((destination) => _buildWindowsXPListTile(
                                    context,
                                    destination,
                                    onTap: () {
                                      final index = widget.groupDestinations
                                          .expand((group) => group.destinations)
                                          .toList()
                                          .indexOf(destination);
                                      _onItemTapped(index);
                                      Navigator.pop(context);
                                    },
                                    isSelected: widget.groupDestinations
                                            .expand(
                                                (group) => group.destinations)
                                            .toList()
                                            .indexOf(destination) ==
                                        _selectedIndex,
                                  )),
                        ])
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWindowsXPListTile(
      BuildContext context, AdaptiveDestination destination,
      {required VoidCallback onTap, required bool isSelected}) {
    // Use Windows XP style colors from ChicagoColors
    final Color windowsXPBlue = ChicagoColors.windowsXPBlue;
    final Color windowsXPLightBlue = ChicagoColors.windowsXPLightBlue;
    final Color windowsXPDarkBlue = ChicagoColors.windowsXPDarkBlue;

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
        borderRadius: BorderRadius.circular(3),
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: windowsXPDarkBlue.withOpacity(0.3),
                  blurRadius: 2,
                  offset: Offset(1, 1),
                )
              ]
            : null,
      ),
      child: ListTile(
        leading: isSelected
            ? ShaderMask(
                shaderCallback: (Rect bounds) {
                  return LinearGradient(
                    colors: [Colors.white, Colors.white70],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ).createShader(bounds);
                },
                child: destination.icon,
              )
            : destination.icon,
        title: Text(
          destination.label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}

class ChicagoDrawer extends StatefulWidget {
  const ChicagoDrawer({
    super.key,
    required this.groupDestinations,
    required this.isModal,
  });

  final List<AdaptiveGroupDestination> groupDestinations;
  final bool isModal;

  @override
  State<ChicagoDrawer> createState() => _ChicagoDrawerState();
}

class _ChicagoDrawerState extends State<ChicagoDrawer> {
  int _selectedIndex = 0;
  int _selectedGroupIndex = 0;

  void _onItemTapped(int groupIndex, int index) {
    setState(() {
      _selectedGroupIndex = groupIndex;
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Use Windows XP style colors from ChicagoColors
    final Color windowsXPBlue = ChicagoColors.windowsXPBlue;
    final Color windowsXPLightBlue = ChicagoColors.windowsXPLightBlue;
    final Color windowsXPDarkBlue = ChicagoColors.windowsXPDarkBlue;

    final filteredGroupDestinations =
        drawerSidebarGroupDestinations(widget.groupDestinations);

    if (widget.isModal) {
      return Scaffold(
        drawer: _buildWindowsXPSidebar(context, filteredGroupDestinations),
        body: _buildBody(),
      );
    }

    return Row(
      children: [
        SizedBox(
          width: 240,
          child: _buildWindowsXPSidebar(context, filteredGroupDestinations),
        ),
        VerticalDivider(
          width: 1,
          thickness: 1,
          color: Colors.grey.shade400,
        ),
        Expanded(child: _buildBody()),
      ],
    );
  }

  Widget _buildWindowsXPSidebar(
      BuildContext context, List<AdaptiveGroupDestination> groupDestinations) {
    // Use Windows XP style colors from ChicagoColors
    final Color windowsXPBlue = ChicagoColors.windowsXPBlue;
    final Color windowsXPLightBlue = ChicagoColors.windowsXPLightBlue;
    final Color windowsXPDarkBlue = ChicagoColors.windowsXPDarkBlue;

    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: groupDestinations.length,
              itemBuilder: (context, groupIndex) {
                final group = groupDestinations[groupIndex];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (group.name.isNotEmpty)
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.fromLTRB(8, 16, 8, 8),
                        padding: const EdgeInsets.fromLTRB(8, 6, 8, 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              windowsXPLightBlue,
                              windowsXPDarkBlue,
                            ],
                          ),
                        ),
                        child: Text(
                          group.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ...List.generate(
                      group.destinations.length,
                      (index) {
                        final destination = group.destinations[index];
                        final isSelected = groupIndex == _selectedGroupIndex &&
                            index == _selectedIndex;

                        return Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 2),
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
                              color: isSelected
                                  ? windowsXPDarkBlue
                                  : Colors.transparent,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(3),
                            boxShadow: isSelected
                                ? [
                                    BoxShadow(
                                      color: windowsXPDarkBlue.withOpacity(0.3),
                                      blurRadius: 2,
                                      offset: Offset(1, 1),
                                    )
                                  ]
                                : null,
                          ),
                          child: ListTile(
                            leading: isSelected
                                ? ShaderMask(
                                    shaderCallback: (Rect bounds) {
                                      return LinearGradient(
                                        colors: [Colors.white, Colors.white70],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                      ).createShader(bounds);
                                    },
                                    child: destination.icon,
                                  )
                                : destination.icon,
                            title: Text(
                              destination.label,
                              style: TextStyle(
                                color: isSelected ? Colors.white : Colors.black,
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                            onTap: () => _onItemTapped(groupIndex, index),
                          ),
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    if (_selectedGroupIndex < widget.groupDestinations.length &&
        _selectedIndex <
            widget.groupDestinations[_selectedGroupIndex].destinations.length) {
      return widget.groupDestinations[_selectedGroupIndex]
          .destinations[_selectedIndex].page;
    }
    return const SizedBox.shrink();
  }
}
