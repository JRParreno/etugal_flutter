// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:etugal_flutter/core/extensions/spacer_widget.dart';
import 'package:etugal_flutter/gen/colors.gen.dart';
import 'package:intl/intl.dart';

class TaskInfo extends StatelessWidget {
  const TaskInfo({
    super.key,
    required this.workType,
    required this.reward,
    required this.description,
    required this.doneDate,
    required this.googleMapController,
    required this.initialCameraPosition,
    required this.markers,
    required this.numWorker,
    this.scheduleTime,
  });

  final String workType;
  final double reward;
  final String description;
  final DateTime doneDate;
  final int numWorker;

  final String? scheduleTime;

  final Completer<GoogleMapController> googleMapController;
  final CameraPosition initialCameraPosition;
  final Set<Marker> markers;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Task Details",
          style: textTheme.titleSmall,
        ),
        rowInfoText(
          textTheme: textTheme,
          info: 'Deadline Date',
          text: DateFormat.yMMMMd('en_US').format(doneDate),
        ),
        if (scheduleTime != null)
          rowInfoText(
            textTheme: textTheme,
            info: 'Schedule Time',
            text: DateFormat('h:mm a')
                .format(DateFormat('HH:mm:ss').parse(scheduleTime!)),
          ),
        rowInfoText(
          textTheme: textTheme,
          info: 'Type',
          text: workType.toUpperCase().replaceAll('_', ' '),
        ),
        rowInfoText(
          textTheme: textTheme,
          info: 'Number of Worker (Need)',
          text: numWorker.toString(),
        ),
        rowInfoText(
          textTheme: textTheme,
          info: 'Reward',
          text: reward.toString(),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Problem',
              style: textTheme.bodySmall
                  ?.copyWith(color: ColorName.darkerGreyFont),
            ),
            Text(
              description,
              style: textTheme.bodySmall,
              textAlign: TextAlign.justify,
            ),
          ].withSpaceBetween(height: 11),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: ColorName.primary),
          ),
          height: MediaQuery.of(context).size.height * 0.35,
          child: GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: initialCameraPosition,
            onMapCreated: (GoogleMapController controller) {
              googleMapController.complete(controller);
            },
            markers: markers,
            mapToolbarEnabled: false,
            zoomControlsEnabled: false,
            zoomGesturesEnabled: false,
          ),
        ),
      ].withSpaceBetween(height: 11),
    );
  }

  Widget rowInfoText({
    required String info,
    required String text,
    required TextTheme textTheme,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          info,
          style: textTheme.bodySmall?.copyWith(color: ColorName.darkerGreyFont),
        ),
        Text(
          text,
          style: textTheme.bodySmall,
        ),
      ],
    );
  }
}
