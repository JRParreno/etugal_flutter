// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:etugal_flutter/gen/colors.gen.dart';

class PerformerTasks extends StatelessWidget {
  const PerformerTasks({
    super.key,
    required this.controller,
    required this.scrollController,
    required this.onTapTab,
  });

  final TabController controller;
  final ScrollController scrollController;
  final Function(int index) onTapTab;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SingleChildScrollView(
      controller: scrollController,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 15),
            decoration: BoxDecoration(
              border: Border.all(color: ColorName.primary),
              borderRadius: BorderRadius.circular(5),
            ),
            child: TabBar(
              onTap: onTapTab,
              controller: controller,
              automaticIndicatorColorAdjustment: true,
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              indicator: BoxDecoration(
                color: ColorName.primary,
                borderRadius: BorderRadius.circular(5),
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              labelStyle: textTheme.labelSmall?.copyWith(color: Colors.white),
              unselectedLabelColor: ColorName.primary,
              indicatorColor: ColorName.primary,
              dividerHeight: 0,
              tabs: const [
                Tab(
                  child: Text(
                    'Pending',
                  ),
                ),
                Tab(
                  child: Text(
                    'In Progress',
                  ),
                ),
                Tab(
                  child: Text(
                    'Completed',
                  ),
                ),
                Tab(
                  child: Text(
                    'Cancelled',
                  ),
                ),
                Tab(
                  child: Text(
                    'History',
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
