part of 'member_detail_page.dart';

class UserDetailForm extends StatelessWidget {
  const UserDetailForm({super.key});

  static const double _fieldItemSpacing = 8;

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserDetailCubit,
        UserDetailState>(
      listener: (context, state) {},
      child: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: Config.formSpacing,
          children: <Widget>[
            Column(
              spacing: Config.formFieldSpacing,
              children: [
                _Label(text: '연애상태'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: _fieldItemSpacing,
                  children: [
                    _DatingStatusSelectionButton(
                        datingStatus: DatingStatus.single),
                    _DatingStatusSelectionButton(
                        datingStatus: DatingStatus.dating),
                    _DatingStatusSelectionButton(
                        datingStatus: DatingStatus.married),
                  ],
                ),
              ],
            ),
            Column(
              spacing: Config.formFieldSpacing,
              children: [
                _Label(text: '구직상태'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: _fieldItemSpacing,
                  children: [
                    _JobStatusSelectButton(jobStatus: JobStatus.student),
                    _JobStatusSelectButton(jobStatus: JobStatus.unemployed),
                    _JobStatusSelectButton(jobStatus: JobStatus.employed),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextCheckBox(
                      text: "이 정보를 항상 기억",
                      value: context.select(
                          (UserDetailCubit cubit) =>
                              cubit.state.saveInfo),
                      onChanged: (value) => context
                          .read<UserDetailCubit>()
                          .changeSaveInfo(value ?? false),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Label extends StatelessWidget {
  const _Label({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.normal,
            ),
          ),
        )
      ],
    );
  }
}

class _DatingStatusSelectionButton extends StatelessWidget {
  const _DatingStatusSelectionButton({required this.datingStatus});

  final DatingStatus datingStatus;
  static String getDatingStatusText(DatingStatus datingStatus) {
    switch (datingStatus) {
      case DatingStatus.single:
        return '솔로';
      case DatingStatus.dating:
        return '커플';
      case DatingStatus.married:
        return '결혼';
    }
  }

  @override
  Widget build(BuildContext context) {
    final String text = getDatingStatusText(datingStatus);
    return Expanded(
      child: ElevatedButton(
          onPressed: () => context
              .read<UserDetailCubit>()
              .changeDatingStatus(datingStatus),
          style: ElevatedButton.styleFrom(
            foregroundColor: context.select(
              (UserDetailCubit cubit) =>
                  cubit.state.datingStatus == datingStatus
                      ? ButtonColor.white
                      : ButtonColor.black,
            ),
            backgroundColor: context.select(
              (UserDetailCubit cubit) =>
                  cubit.state.datingStatus == datingStatus
                      ? ButtonColor.black
                      : ButtonColor.white,
            ),
          ),
          child: Text(text)),
    );
  }
}

class _JobStatusSelectButton extends StatelessWidget {
  const _JobStatusSelectButton({required this.jobStatus});

  final JobStatus jobStatus;

  static String getJobStatusText(JobStatus jobStatus) {
    switch (jobStatus) {
      case JobStatus.employed:
        return '직장인';
      case JobStatus.student:
        return '학생';
      case JobStatus.unemployed:
        return '쉬는중';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            foregroundColor: context.select(
                        (UserDetailCubit cubit) =>
                            cubit.state.jobStatus) ==
                    jobStatus
                ? ButtonColor.white
                : ButtonColor.black,
            backgroundColor: context.select(
                        (UserDetailCubit cubit) =>
                            cubit.state.jobStatus) ==
                    jobStatus
                ? ButtonColor.black
                : ButtonColor.white),
        onPressed: () => context
            .read<UserDetailCubit>()
            .changeJobStatus(jobStatus),
        child: Text(getJobStatusText(jobStatus)),
      ),
    );
  }
}
