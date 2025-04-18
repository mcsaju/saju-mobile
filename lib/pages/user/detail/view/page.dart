import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:models/models.dart';
import 'package:repository/repository.dart';
import 'package:saju_mobile_v1/common/widgets/button/page_back_button.dart';
import 'package:saju_mobile_v1/common/widgets/button/primary_button.dart';
import 'package:saju_mobile_v1/common/widgets/layouts/adaptive_column.dart';
import 'package:saju_mobile_v1/common/widgets/layouts/page_description.dart';
import 'package:saju_mobile_v1/pages/user/detail/bloc/bloc.dart';
import 'package:saju_mobile_v1/pages/user/detail/bloc/event.dart';
import 'package:saju_mobile_v1/pages/user/detail/view/form.dart';

class UserInfoDetailPage extends StatelessWidget {
  const UserInfoDetailPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const UserInfoDetailPage());
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: PageBackButton(
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: BlocProvider(
          create:
              (context) => UserInfoDetailBloc(
                userRepository: context.read<UserRepository>(),
              )..add(const UserInfoDetailSubscriptionRequested()),
          child: const Center(
            child: AdaptiveColumn(
              forceSpaceBetween: true,
              children: [
                PageDiscription(
                  title: '정보를 입력해주세요.',
                  subtitle: '당신의 운명을 알기 위한 첫 단계입니다.',
                ),
                UserInfoDetailForm(),
                _NextPageButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NextPageButton extends StatelessWidget {
  const _NextPageButton();

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      width: double.infinity,
      onPressed: () async {
        context.read<UserInfoDetailBloc>().add(
          const UserInfoDetailFormSubmitted(),
        );
        final app = context.read<AppRepository>();
        await Navigator.of(context).pushNamed(app.getTargetRoute().toString());
      },
      child: const Text('다음으로'),
    );
  }
}
