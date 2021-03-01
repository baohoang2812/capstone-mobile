import 'package:capstone_mobile/src/blocs/violation_filter/violation_filter_bloc.dart';
import 'package:capstone_mobile/src/ui/widgets/violation/filter_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:capstone_mobile/src/blocs/blocs.dart';
import 'package:capstone_mobile/src/blocs/violation/violation_bloc.dart';
import 'package:capstone_mobile/src/data/models/violation/violation.dart';
import 'package:capstone_mobile/src/ui/screens/violation/violation_create_screen.dart';
import 'package:capstone_mobile/src/ui/screens/violation/violation_detail_screen.dart';
import 'package:capstone_mobile/src/ui/utils/image_picker.dart';
import 'package:capstone_mobile/src/ui/utils/skeleton_loading.dart';

class ViolationScreen extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(
        settings: RouteSettings(name: "/ViolationScreen"),
        builder: (_) => ViolationScreen());
  }

  @override
  _ViolationScreenState createState() => _ViolationScreenState();
}

class _ViolationScreenState extends State<ViolationScreen> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: theme.scaffoldBackgroundColor,
        title: FlutterLogo(),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                ViolationCreateScreen.route(),
              );
            },
            child: Container(
              width: 156,
              height: 32,
              decoration: BoxDecoration(
                color: theme.primaryColor,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                child: Text(
                  "CREATE NEW +",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        'Violation',
                        style: TextStyle(
                            color: theme.primaryColor,
                            fontSize: theme.textTheme.headline1.fontSize),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            'List',
                            style: TextStyle(
                                color: theme.primaryColor,
                                fontSize: theme.textTheme.headline1.fontSize),
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Column(
                          children: [
                            Container(
                              height:
                                  (theme.textTheme.headline1.fontSize + 15) / 2,
                              width: 46,
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom:
                                      BorderSide(color: Colors.black, width: 2),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                ),
                ImagePickerButton(),
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(),
                FilterButton(
                  visible: true,
                ),
              ],
            ),
            _ViolationList(),
          ],
        ),
      ),
    );
  }
}

class ViolationTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: Container(
                  height: 25,
                  child: TextField(
                    // TextStyle(fontSize: 12.0, height: 2.0, color: Colors.black),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 2.0, horizontal: 8),
                        hintText: 'Search',
                        suffixIcon: Icon(Icons.search)),
                  ),
                )),
                FilterButton(
                  visible: true,
                ),
              ],
            ),
            _ViolationList(),
          ],
        ),
      ),
    );
  }
}

class _ViolationList extends StatefulWidget {
  const _ViolationList({
    Key key,
  }) : super(key: key);

  @override
  __ViolationListState createState() => __ViolationListState();
}

class __ViolationListState extends State<_ViolationList> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  ViolationBloc _violationBloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _violationBloc = BlocProvider.of<ViolationBloc>(context);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _violationBloc.add(
        ViolationRequested(
            token: BlocProvider.of<AuthenticationBloc>(context).state.token),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ViolationFilterBloc, ViolationFilterState>(
        builder: (context, state) {
      // if (state is ViolationLoadInProgress) {
      //   return const Center(
      //     child: CircularProgressIndicator(),
      //   );
      // }
      // if (state is ViolationLoadFailure) {
      //   return Center(
      //     child: Text('Fail to fetch violations'),
      //   );
      // }
      if (state is ViolationFilterInProgress) {
        return Center(
            child: SkeletonLoading(
          item: 4,
        ));
      }

      if (state is ViolationFilterSucess) {
        if (state.filteredViolations.isEmpty) {
          Center(
            child: Text('There is no violations'),
          );
        }

        List<Violation> violations = state.filteredViolations;

        return Expanded(
            child: NotificationListener<ScrollEndNotification>(
          onNotification: (scrollEnd) {
            var metrics = scrollEnd.metrics;
            if (metrics.atEdge) {
              if (metrics.pixels == 0) {
                _violationBloc.add(ViolationRequested(
                  token:
                      BlocProvider.of<AuthenticationBloc>(context).state.token,
                  isRefresh: true,
                ));
              } else {
                _violationBloc.add(
                  ViolationRequested(
                      token: BlocProvider.of<AuthenticationBloc>(context)
                          .state
                          .token),
                );
              }
            }
            return true;
          },
          child: ListView.builder(
              itemCount: state.filteredViolations.length + 1,
              controller: _scrollController,
              itemBuilder: (context, index) {
                return index >= state.filteredViolations.length
                    ? BottomLoader()
                    : ViolationCard(violation: violations[index]);
              }),
        ));
      }
      return Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    });
  }
}

class ViolationCard extends StatelessWidget {
  const ViolationCard({
    Key key,
    @required this.violation,
  }) : super(key: key);

  final Violation violation;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shadowColor: Colors.purple[300],
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          Navigator.push(
            context,
            ViolationDetailScreen.route(
              violation: violation,
              id: violation.id,
            ),
          );
        },
        child: ClipPath(
          clipper: ShapeBorderClipper(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          child: Container(
            height: 100,
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(color: Colors.green, width: 5),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${violation.branchName ?? "branch name"}"),
                      Text(
                        "${violation.status ?? "Status"}",
                        style: TextStyle(
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text("${"violation name"}"),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("5 mistakes"),
                      Text("${violation.createdAt ?? "date time"}"),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BottomLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Center(
        child: SizedBox(
          width: 33,
          height: 33,
          child: CircularProgressIndicator(
            strokeWidth: 1.5,
          ),
        ),
      ),
    );
  }
}
