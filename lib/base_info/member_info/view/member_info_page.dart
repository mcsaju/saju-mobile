import 'package:models/user/user_info.dart';
import 'package:repository/repository.dart';
import 'package:saju/config/config.dart';
import 'package:saju/base_info/member_detail/view/member_detail_page.dart';
import 'package:saju/base_info/member_info/bloc/member_info_bloc.dart';
import 'package:saju/themes/page_navigation_button_theme.dart';
import 'package:saju/widgets/page_back_button.dart';
import 'package:saju/widgets/custom_dropdown_button.dart';
import 'package:saju/widgets/page_info_text.dart';
import 'package:saju/widgets/page_navigation_button.dart';
import 'package:saju/themes/button_color.dart';
import 'package:saju/widgets/text_check_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'member_info_form.dart';

class UserInfoPage extends StatelessWidget {
  const UserInfoPage({super.key, required this.targetPage});

  final Widget targetPage;

  static Route<void> route({
    required Widget targetPage,
  }) {
    return MaterialPageRoute<void>(
      builder: (_) => UserInfoPage(
        targetPage: targetPage,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => UserInfoBloc(
          userInfoRepository: context.read<UserInfoRepository>(),
        )..add(const MemberInfoSubscriptionRequested()),
        child: OrientationBuilder(
          builder: (context, orientation) {
            if (orientation == Orientation.portrait) {
              return _PortraitLayout(targetPage: targetPage);
            } else {
              return _LandscapeLayout(targetPage: targetPage);
            }
          },
        ),
      ),
    );
  }
}

class _PortraitLayout extends StatelessWidget {
  final Widget targetPage;

  const _PortraitLayout({required this.targetPage});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: PageBackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: Config.verticalPagePadding,
        child: Column(
          spacing: Config.pageInfoTextSpacingVertical,
          children: [
            const PageInfoText(
                title: "정보를 입력해주세요", description: "당신의 운명을 알기 위한 첫 단계입니다."),
            UserInfoForm(),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: Config.bottomNavigationPadding,
        child: _NextPageNavigationButton(targetPage: targetPage),
      ),
    );
  }
}

class _LandscapeLayout extends StatelessWidget {
  final Widget targetPage;

  const _LandscapeLayout({required this.targetPage});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: PageBackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: Config.getLandScapeHorizontalPadding(context).copyWith(
            top: Config.horizontalPagePadding.top,
            bottom: Config.horizontalPagePadding.bottom,
          ),
          child: Column(
            spacing: Config.pageInfoTextSpacingHorizontal,
            children: [
              const PageInfoText(
                  title: "정보를 입력해주세요", description: "당신의 운명을 알기 위한 첫 단계입니다."),
              UserInfoForm(),
              _NextPageNavigationButton(targetPage: targetPage),
            ],
          ),
        ),
      ),
    );
  }
}

class _NextPageNavigationButton extends StatelessWidget {
  final Widget targetPage;

  const _NextPageNavigationButton({required this.targetPage});
  @override
  Widget build(BuildContext context) {
    return PageNavigationButton(
      theme: DarkPageNavigationButtonTheme(),
      page: UserDetailPage(targetPage: targetPage),
      text: "다음으로",
    );
  }
}
