import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'package:capstone_mobile/src/blocs/authentication/authentication_bloc.dart';
import 'package:capstone_mobile/src/blocs/violation_filter/filter.dart';
import '../violation/violation_bloc.dart';
import 'package:capstone_mobile/src/data/models/violation/violation.dart';

part 'violation_filter_event.dart';
part 'violation_filter_state.dart';

class ViolationFilterBloc
    extends Bloc<ViolationFilterEvent, ViolationFilterState> {
  final ViolationBloc violationBloc;
  final AuthenticationBloc authenticationBloc;
  StreamSubscription violationSubscription;

  ViolationFilterBloc(
      {@required this.violationBloc, @required this.authenticationBloc})
      : super(
          violationBloc.state is ViolationLoadSuccess
              ? ViolationFilterSucess(
                  (violationBloc.state as ViolationLoadSuccess).violations,
                  ViolationFilter(),
                )
              : ViolationFilterInProgress(),
        ) {
    violationSubscription = violationBloc.listen((state) {
      if (state is ViolationLoadSuccess) {
        add(ViolationsUpdated(
            (violationBloc.state as ViolationLoadSuccess).violations));
      }
    });
  }

  @override
  Stream<ViolationFilterState> mapEventToState(
    ViolationFilterEvent event,
  ) async* {
    if (event is FilterUpdated) {
      yield* _mapUpdateFilterToState(event);
    } else if (event is ViolationsUpdated) {
      yield* _mapViolationsUpdatedToState(event);
    }
  }

  Stream<ViolationFilterState> _mapUpdateFilterToState(
    FilterUpdated event,
  ) async* {
    print('alo');
    if (violationBloc.state is ViolationLoadSuccess) {
      print('1alo');
      yield ViolationFilterSucess(
        _mapViolationsToFilteredViolation(
          (violationBloc.state as ViolationLoadSuccess).violations,
          event.filter,
        ),
        event.filter,
      );
    }
  }

  Stream<ViolationFilterState> _mapViolationsUpdatedToState(
    ViolationsUpdated event,
  ) async* {
    final visibilityFilter = state is ViolationFilterSucess
        ? (state as ViolationFilterSucess).activeFilter
        : ViolationFilter();
    yield ViolationFilterSucess(
      (violationBloc.state as ViolationLoadSuccess).violations,
      visibilityFilter,
    );
  }

  // List<Violation> _mapViolationsToFilteredViolation(
  //     List<Violation> violations, String filter) {
  //   return violations.where((violation) {
  //     if (filter == '') {
  //       return true;
  //     } else {
  //       return violation.branchName == filter;
  //     }
  //   }).toList();
  // }

  List<Violation> _mapViolationsToFilteredViolation(
      List<Violation> violations, ViolationFilter filter) {
    print('_mapViolationsToFilteredViolation');
    violationBloc.add(ViolationRequested(
      token: authenticationBloc.state.token,
      filter: filter,
    ));
    return violations;
  }

  @override
  Future<void> close() {
    violationSubscription.cancel();
    return super.close();
  }
}
