import 'package:capstone_mobile/src/ui/screens/filter/report_filter_screen.dart';
import 'package:capstone_mobile/src/ui/widgets/report/report_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:capstone_mobile/src/data/models/report/report.dart';
import 'package:capstone_mobile/src/ui/utils/bottom_loader.dart';
import 'package:capstone_mobile/src/blocs/report/report_bloc.dart';
import 'package:capstone_mobile/generated/l10n.dart';

class ReportsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(),
              BlocBuilder<ReportBloc, ReportState>(
                builder: (context, state) {
                  if (state is ReportLoadSuccess) {
                    return IconButton(
                      icon: Icon(
                        Icons.filter_alt_outlined,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        Navigator.push(context, ReportFilterScreen.route());
                      },
                    );
                  }
                  return Container();
                },
              ),
            ],
          ),
          ReportList(),
        ],
      ),
    );
  }
}

class ReportList extends StatelessWidget {
  const ReportList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportBloc, ReportState>(
      builder: (context, state) {
        if (state is ReportLoadInProgress) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ReportLoadFailure) {
          return Center(
            child: Column(
              children: [
                Text(S.of(context).VIOLATION_SCREEN_FETCH_FAIL),
                ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<ReportBloc>(context).add(ReportRequested());
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
        } else if (state is ReportLoadSuccess) {
          if (state.reports.isEmpty) {
            return Center(
              child: Text(S.of(context).REPORT_SCREEN_NO_REPORTS),
            );
          }
          List<Report> reports = state.reports;

          return Expanded(
            child: NotificationListener<ScrollEndNotification>(
              onNotification: (scrollEnd) {
                var metrics = scrollEnd.metrics;
                if (metrics.atEdge) {
                  if (metrics.pixels == 0) {
                    BlocProvider.of<ReportBloc>(context).add(ReportRequested(
                      isRefresh: true,
                      filter: state.activeFilter,
                    ));
                  } else {
                    BlocProvider.of<ReportBloc>(context).add(ReportRequested(
                      filter: state.activeFilter,
                    ));
                  }
                }
                return true;
              },
              child: ListView.builder(
                itemCount: (BlocProvider.of<ReportBloc>(context).state
                            as ReportLoadSuccess)
                        .hasReachedMax
                    ? state.reports.length
                    : state.reports.length + 1,
                itemBuilder: (context, index) {
                  return index >= state.reports.length
                      ? BottomLoader()
                      : ReportCard(
                          report: reports[index],
                        );
                },
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}
