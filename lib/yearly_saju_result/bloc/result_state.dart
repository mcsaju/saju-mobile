part of 'result_bloc.dart';

enum YearlySajuResultStatus { initial, loading, success, failed }

final class YearlySajuResultState extends Equatable {
  const YearlySajuResultState(
      {this.status = YearlySajuResultStatus.initial, this.yearlySajuResult});

  final YearlySajuResultStatus status;
  final YearlySajuResponse? yearlySajuResult;

  YearlySajuResultState copyWith({
    YearlySajuResultStatus? status,
    YearlySajuResponse? result,
  }) {
    return YearlySajuResultState(
        status: status ?? this.status,
        yearlySajuResult: result ?? yearlySajuResult);
  }

  @override
  List<Object?> get props => [status, yearlySajuResult];
}
