import 'package:etugal_flutter/core/enums/task_status_enum.dart';
import 'package:etugal_flutter/features/task/presentation/blocs/tasks/provider_task_list/provider_task_list_bloc.dart';
import 'package:etugal_flutter/features/task/presentation/pages/body/my_list_task/index.dart';
import 'package:etugal_flutter/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyTaskListPage extends StatefulWidget {
  const MyTaskListPage({super.key});

  @override
  State<MyTaskListPage> createState() => _MyTaskListPageState();
}

class _MyTaskListPageState extends State<MyTaskListPage>
    with TickerProviderStateMixin {
  late final TabController _mainTabCtrl;
  late final TabController _providerTabCtrl;
  late final TabController _performerTabCtrl;
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _mainTabCtrl = TabController(length: 2, vsync: this);
    _providerTabCtrl = TabController(length: 5, vsync: this);
    _performerTabCtrl = TabController(length: 5, vsync: this);
    handleProviderOnTapTab(0);
    handleEventScrollListener();
  }

  @override
  void dispose() {
    super.dispose();
    _mainTabCtrl.dispose();
    _providerTabCtrl.dispose();
    _performerTabCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tasks',
          style: textTheme.titleLarge,
        ),
        bottom: TabBar(
          controller: _mainTabCtrl,
          labelStyle: textTheme.bodyMedium?.copyWith(color: ColorName.primary),
          indicatorColor: ColorName.primary,
          dividerHeight: 0,
          tabs: const [
            Tab(
              child: Text(
                'Provider',
              ),
            ),
            Tab(
              child: Text(
                'Performer',
              ),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_outlined,
              size: 30,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: TabBarView(
          controller: _mainTabCtrl,
          children: <Widget>[
            ProviderTasks(
              controller: _providerTabCtrl,
              scrollController: scrollController,
              onTapTab: handleProviderOnTapTab,
            ),
            PerformerTasks(
              controller: _performerTabCtrl,
              scrollController: scrollController,
              onTapTab: handlePerformerOnTapTab,
            ),
          ],
        ),
      ),
    );
  }

  void handlePerformerOnTapTab(int index) {}
  void handleProviderOnTapTab(int index) {
    TaskStatusEnum taskStatusEnum = TaskStatusEnum.rejected;

    switch (index) {
      case 0:
        taskStatusEnum = TaskStatusEnum.pending;
        break;
      case 1:
        taskStatusEnum = TaskStatusEnum.inProgres;
        break;
      case 2:
        taskStatusEnum = TaskStatusEnum.competed;
        break;
      case 3:
        taskStatusEnum = TaskStatusEnum.canceled;
        break;
      case 4:
        taskStatusEnum = TaskStatusEnum.rejected;
        break;
      default:
    }

    context.read<ProviderTaskListBloc>().add(
          GetProviderTaskListTaskEvent(
            taskStatus: taskStatusEnum,
          ),
        );
  }

  void handleEventScrollListener() {
    scrollController.addListener(() {
      if (scrollController.position.pixels >
          (scrollController.position.pixels * 0.75)) {
        context.read<ProviderTaskListBloc>().add(
              GetProviderTaskListTaskPaginateEvent(),
            );
      }
    });
  }
}
