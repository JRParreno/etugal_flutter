import 'package:etugal_flutter/core/common/entities/user.dart';
import 'package:etugal_flutter/features/profile/presentation/widgets/index.dart';
import 'package:etugal_flutter/features/task/domain/entities/index.dart';
import 'package:etugal_flutter/features/task/presentation/blocs/tasks/task_applicant_review/task_applicant_review_bloc.dart';
import 'package:etugal_flutter/features/task/presentation/pages/body/task_applicant/index.dart';
import 'package:etugal_flutter/features/task/presentation/pages/body/task_detail/index.dart';
import 'package:etugal_flutter/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskApplicantDetailPage extends StatefulWidget {
  const TaskApplicantDetailPage({super.key, required this.userProfile});

  final TaskUserProfileEntity userProfile;

  @override
  State<TaskApplicantDetailPage> createState() =>
      _TaskApplicantDetailPageState();
}

class _TaskApplicantDetailPageState extends State<TaskApplicantDetailPage>
    with TickerProviderStateMixin {
  late TaskUserProfileEntity userProfile;
  late final TabController _mainTabCtrl;
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    userProfile = widget.userProfile;
    _mainTabCtrl = TabController(length: 2, vsync: this);
    context.read<TaskApplicantReviewBloc>().add(
          GetTaskApplicantReviewEvent(widget.userProfile.id),
        );
    handleEventScrollListener();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: mediaQuery.size.height,
              width: mediaQuery.size.width,
              margin: EdgeInsets.only(
                top: mediaQuery.size.height * 0.08,
              ),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(
                  color: ColorName.containerStroke,
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: Container(
                margin: EdgeInsets.only(top: mediaQuery.size.height * 0.14),
                child: Column(
                  children: [
                    TabBar(
                      controller: _mainTabCtrl,
                      labelStyle: textTheme.bodyMedium
                          ?.copyWith(color: ColorName.primary),
                      indicatorColor: ColorName.primary,
                      dividerHeight: 0,
                      tabs: const [
                        Tab(
                          child: Text(
                            'Reviews',
                          ),
                        ),
                        Tab(
                          child: Text(
                            'About',
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: _mainTabCtrl,
                        children: <Widget>[
                          PerformerReviewList(
                            controller: scrollController,
                          ),
                          Container(
                            padding: const EdgeInsets.all(25),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(color: ColorName.borderColor),
                            ),
                            child: PerformerInfo(
                              taskUserProfile: userProfile,
                              isHideHeader: true,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: ProfileAvatarDetail(
                user: User(
                  pk: userProfile.user.pk!.toString(),
                  username: userProfile.user.username!,
                  firstName: userProfile.user.firstName!,
                  lastName: userProfile.user.lastName!,
                  email: userProfile.user.email!,
                  profilePk: userProfile.id.toString(),
                  contactNumber: userProfile.contactNumber,
                  address: userProfile.address,
                  gender: userProfile.address,
                  verificationStatus: userProfile.verificationStatus,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void handleEventScrollListener() {
    scrollController.addListener(() {
      if (scrollController.position.pixels >
          (scrollController.position.pixels * 0.75)) {
        context.read<TaskApplicantReviewBloc>().add(
              PaginateTaskApplicantReviewEvent(userProfile.id),
            );
      }
    });
  }
}
