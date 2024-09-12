// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:etugal_flutter/core/common/widgets/custom_elevated_btn.dart';
import 'package:etugal_flutter/core/extensions/spacer_widget.dart';
import 'package:etugal_flutter/features/task/presentation/pages/body/task_detail/index.dart';
import 'package:etugal_flutter/gen/colors.gen.dart';
import 'package:flutter/material.dart';

import 'package:etugal_flutter/features/task/domain/entities/index.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TaskDetailPage extends StatefulWidget {
  const TaskDetailPage({
    super.key,
    required this.task,
  });

  final TaskEntity task;

  @override
  State<TaskDetailPage> createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends State<TaskDetailPage> {
  late TaskEntity task;
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    task = widget.task;
    _setMarker(LatLng(widget.task.latitude, widget.task.longitude));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: Container(
        width: double.infinity,
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(27),
        decoration: BoxDecoration(
          border: Border.all(color: ColorName.borderColor),
          borderRadius: BorderRadius.circular(5),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ProviderProfile(
                title: task.title,
                address: task.address,
                createdAt: task.createdAt,
                profilePhoto: task.provider.profilePhoto,
              ),
              const Divider(
                color: ColorName.borderColor,
              ),
              ProviderInfo(
                fullName: task.provider.user.getFullName!,
                gender: task.provider.gender,
                provider: task.provider,
              ),
              const Divider(
                color: ColorName.borderColor,
              ),
              TaskInfo(
                scheduleTime: task.scheduleTime,
                doneDate: task.doneDate,
                reward: task.reward,
                workType: task.workType,
                description: task.description,
                googleMapController: _controller,
                markers: _markers,
                initialCameraPosition: CameraPosition(
                  target: LatLng(task.latitude, task.longitude),
                  zoom: 14.4746,
                ),
              ),
            ].withSpaceBetween(height: 20),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          boxShadow: [
            // so here your custom shadow goes:
            BoxShadow(
              color: Colors.black
                  .withAlpha(20), // the color of a shadow, you can adjust it
              spreadRadius:
                  3, //also play with this two values to achieve your ideal result
              blurRadius: 7,
              offset: const Offset(0,
                  -7), // changes position of shadow, negative value on y-axis makes it appering only on the top of a container
            ),
          ],
        ),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 23,
            vertical: 20,
          ),
          color: Colors.white,
          child: Row(
            children: [
              Expanded(
                child: CustomElevatedBtn(
                  buttonType: ButtonType.outline,
                  onTap: () {},
                  title: 'Message',
                ),
              ),
              const SizedBox(width: 25),
              Expanded(
                child: CustomElevatedBtn(
                  onTap: () {},
                  title: 'Apply',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _setMarker(LatLng point) {
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId(point.toString()),
          position: point,
          infoWindow: InfoWindow(
            title: 'Selected Location',
            snippet: '${point.latitude}, ${point.longitude}',
          ),
        ),
      );
    });
  }
}
