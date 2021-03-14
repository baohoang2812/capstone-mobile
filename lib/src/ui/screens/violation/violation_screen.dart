import 'package:capstone_mobile/src/blocs/localization/localization_bloc.dart';
import 'package:capstone_mobile/src/ui/constants/constant.dart';
import 'package:capstone_mobile/src/ui/screens/filter/filter_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:capstone_mobile/src/blocs/blocs.dart';
import 'package:capstone_mobile/src/blocs/violation/violation_bloc.dart';
import 'package:capstone_mobile/src/data/models/violation/violation.dart';
import 'package:capstone_mobile/src/ui/screens/violation/violation_create_screen.dart';
import 'package:capstone_mobile/src/ui/screens/violation/violation_detail_screen.dart';
import 'package:capstone_mobile/src/ui/utils/image_picker.dart';
import 'package:capstone_mobile/src/ui/utils/skeleton_loading.dart';
import 'package:capstone_mobile/generated/l10n.dart';
import 'package:capstone_mobile/src/ui/utils/bottom_loader.dart';
import 'package:intl/intl.dart';

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
                // Expanded(
                //     child: Container(
                //   height: 24,
                //   child: TextField(
                //     decoration: InputDecoration(
                //       border: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(24),
                //       ),
                //       contentPadding: const EdgeInsets.symmetric(
                //           vertical: 2.0, horizontal: 8),
                //       hintText: 'Search by regulation',
                //       hintStyle: TextStyle(fontSize: 12),
                //       suffixIcon: Icon(Icons.search),
                //     ),
                //     onSubmitted: (text) {
                //       BlocProvider.of<ViolationBloc>(context).add(
                //         FilterChanged(
                //           token: BlocProvider.of<AuthenticationBloc>(context)
                //               .state
                //               .token,
                //           filter: (BlocProvider.of<ViolationBloc>(context).state
                //                   as ViolationLoadSuccess)
                //               .activeFilter
                //               .copyWith(regulationId: 1),
                //         ),
                //       );
                //     },
                //   ),
                // )),
                // FilterButton(
                //   visible: true,
                // ),
                Container(),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, FilterScreen.route());
                  },
                  child: Container(
                    height: 40,
                    child: Row(
                      children: [
                        BlocBuilder<ViolationBloc, ViolationState>(
                          builder: (context, state) {
                            if (state is ViolationLoadSuccess) {
                              return Icon(
                                Icons.filter_alt_outlined,
                                color: Colors.grey,
                              );
                            }
                            return Container();
                          },
                        ),
                        Container(
                          child: Text(
                            'Filter',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Color(0xff828282),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
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
  ViolationBloc _violationBloc;

  @override
  void initState() {
    super.initState();
    _violationBloc = BlocProvider.of<ViolationBloc>(context);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ViolationBloc, ViolationState>(
        builder: (context, state) {
      if (state is ViolationLoadInProgress) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state is ViolationLoadFailure) {
        return Center(
          child: Column(
            children: [
              Text(S.of(context).VIOLATION_SCREEN_FETCH_FAIL),
              ElevatedButton(
                onPressed: () {
                  _violationBloc.add(ViolationRequested(
                    token: BlocProvider.of<AuthenticationBloc>(context)
                        .state
                        .token,
                  ));
                },
                child: Text(S.of(context).VIOLATION_SCREEN_RELOAD),
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey[200],
                  onPrimary: Colors.black,
                ),
              ),
            ],
          ),
        );
      }

      if (state is ViolationLoadSuccess) {
        if (state.violations.isEmpty) {
          return Center(
            child: Text(S.of(context).VIOLATION_SCREEN_NO_VIOLATIONS),
          );
        }

        List<Violation> violations = state.violations;

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
                  filter: state.activeFilter,
                ));
              } else {
                _violationBloc.add(
                  ViolationRequested(
                    token: BlocProvider.of<AuthenticationBloc>(context)
                        .state
                        .token,
                    filter: state.activeFilter,
                  ),
                );
              }
            }
            return true;
          },
          child: ListView.builder(
              itemCount:
                  (_violationBloc.state as ViolationLoadSuccess).hasReachedMax
                      ? state.violations.length
                      : state.violations.length + 1,
              controller: _scrollController,
              itemBuilder: (context, index) {
                return index >= state.violations.length
                    ? BottomLoader()
                    : ViolationCard(violation: violations[index]);
              }),
        ));
      }
      return Container(
        child: Center(
          child: SkeletonLoading(
            item: 4,
          ),
        ),
      );
    });
  }
}

class ViolationCard extends StatelessWidget {
  ViolationCard({
    Key key,
    @required this.violation,
  }) : super(key: key);

  final Violation violation;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          Navigator.push(
            context,
            ViolationDetailScreen.route(
              violation: violation,
              id: violation?.id,
            ),
          );
        },
        child: ClipPath(
          clipper: ShapeBorderClipper(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          child: Container(
            height: 100,
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(
                    color: Constant.violationStatusColors[violation.status] ??
                        Colors.green,
                    width: 5),
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
                      Text(
                        "${violation?.branchName ?? "branch name"}",
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "${violation?.status ?? "Status"}",
                        style: TextStyle(
                          color:
                              Constant.violationStatusColors[violation.status],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "${violation.regulationName ?? 'Regulation name'}",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(""),
                      Text(
                        S.of(context).CREATED_ON +
                            ": ${DateFormat.yMMMd(BlocProvider.of<LocalizationBloc>(context).state).format(violation.createdAt) ?? "date time"}",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[400],
                          fontWeight: FontWeight.w400,
                        ),
                      ),
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
