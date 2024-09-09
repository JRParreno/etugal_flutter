import 'dart:async';

import 'package:etugal_flutter/core/enums/work_type.dart';
import 'package:etugal_flutter/features/task/presentation/blocs/add_task_category/add_task_category_bloc.dart';
import 'package:etugal_flutter/features/task/presentation/pages/body/index.dart';
import 'package:etugal_flutter/features/task/presentation/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_autocomplete_text_field/model/prediction.dart';

class AddPostTaskPage extends StatefulWidget {
  const AddPostTaskPage({super.key});

  @override
  State<AddPostTaskPage> createState() => _AddPostTaskPageState();
}

class _AddPostTaskPageState extends State<AddPostTaskPage> {
  int _index = 0;
  String? _selectedCategory;
  WorkType? _workType;
  final TextEditingController _describeController = TextEditingController();
  final TextEditingController _searchLocationCtrl = TextEditingController();

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _setMarker(const LatLng(13.2907648, 123.4908591));
    context.read<AddTaskCategoryBloc>().add(GetAddTaskCategoryEvent());
  }

  @override
  void dispose() {
    super.dispose();
    _describeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Post a task',
          style: textTheme.titleLarge,
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: _index > 0
            ? IconButton(
                onPressed: handleBack,
                icon: const Icon(
                  Icons.arrow_back,
                ),
              )
            : null,
        actions: [
          IconButton(
            onPressed: () {
              context.pop();
            },
            icon: const Icon(
              Icons.close,
            ),
          )
        ],
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FormSteps(
              currentStep: _index,
              numSteps: 4,
            ),
            Flexible(
              child: handleFormWidgets(),
            ),
          ],
        ),
      ),
    );
  }

  Widget handleFormWidgets() {
    switch (_index) {
      case 0:
        return FirstStepForm(
          selectedWorkType: _workType,
          selectedCategory: _selectedCategory,
          onSelectCategory: (value) =>
              setState(() => _selectedCategory = value),
          onSelectWorkType: (value) => setState(() => _workType = value),
          onNext: handleNext,
        );
      case 1:
        return SecondStepForm(
          controller: _describeController,
          googleMapController: _controller,
          initialCameraPosition: _kGooglePlex,
          searchLocationCtrl: _searchLocationCtrl,
          onNext: handleNext,
          onPrediction: (prediction) => _goToTheLocation(prediction),
          markers: _markers,
        );

      default:
        return const SizedBox();
    }
  }

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(13.2907648, 123.4908591),
    zoom: 14.4746,
  );

  Future<void> _goToTheLocation(Prediction prediction) async {
    if (prediction.lat != null && prediction.lng != null) {
      final latitude = double.parse(prediction.lat!);
      final longitude = double.parse(prediction.lng!);
      final latLng = LatLng(latitude, longitude);

      setState(() {
        _markers.add(
          Marker(
            markerId: MarkerId(latLng.toString()),
            position: latLng,
            infoWindow: InfoWindow(
              title: 'Selected Location',
              snippet: '${latLng.latitude}, ${latLng.longitude}',
            ),
          ),
        );
      });

      final GoogleMapController controller = await _controller.future;
      await controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: latLng,
            zoom: 14.4746,
          ),
        ),
      );
    }
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

  void handleNext() {
    if (_index >= 0 && _index < 4) {
      setState(() {
        _index += 1;
      });
    }
  }

  void handleBack() {
    if (_index >= 1 && _index < 4) {
      setState(() {
        _index -= 1;
      });
    }
  }
}
