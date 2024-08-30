// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:etugal_flutter/core/common/widgets/shimmer_loading.dart';
import 'package:etugal_flutter/features/home/presentation/blocs/home_task/home_task_bloc.dart';

class TaskList extends StatelessWidget {
  const TaskList({
    super.key,
    required this.controller,
  });

  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<HomeTaskBloc, HomeTaskState>(
        builder: (context, state) {
          if (state is HomeTaskLoading) {
            return ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return const ShimmerLoading(
                  width: double.infinity,
                  height: 124,
                );
              },
              separatorBuilder: (context, index) => const SizedBox(
                height: 15,
              ),
              itemCount: 5,
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
