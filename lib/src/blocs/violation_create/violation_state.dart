part of 'violation_bloc.dart';

class ViolationCreateState extends Equatable {
  const ViolationCreateState({
    this.violationDescription = const ViolationDescription.pure(),
    this.violationRegulation = const ViolationRegulation.pure(),
    this.violationBranch = const ViolationBranch.pure(),
    this.status = FormzStatus.pure,
    this.createdDate = '01-01-2000',
    this.name = 'create violation',
  });

  final FormzStatus status;
  final ViolationDescription violationDescription;
  final ViolationRegulation violationRegulation;
  final ViolationBranch violationBranch;
  final String createdDate;
  final String name;

  ViolationCreateState copyWith({
    FormzStatus status,
    ViolationDescription violationDescription,
    String createdDate,
    String name,
    ViolationRegulation violationRegulation,
    ViolationBranch violationBranch,
  }) {
    return ViolationCreateState(
      status: status ?? this.status,
      violationDescription: violationDescription ?? this.violationDescription,
      createdDate: createdDate ?? this.createdDate,
      name: name ?? this.name,
      violationRegulation: violationRegulation ?? this.violationRegulation,
      violationBranch: violationBranch ?? this.violationBranch,
    );
  }

  @override
  List<Object> get props => [
        status,
        violationDescription,
        violationRegulation,
        name,
        createdDate,
        violationBranch
      ];
}
