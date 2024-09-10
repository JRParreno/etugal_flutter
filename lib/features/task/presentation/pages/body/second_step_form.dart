// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:etugal_flutter/core/extensions/spacer_widget.dart';
import 'package:etugal_flutter/gen/colors.gen.dart';
import 'package:flutter/material.dart';

import 'package:etugal_flutter/features/task/presentation/widgets/index.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_autocomplete_text_field/google_places_autocomplete_text_field.dart';
import 'package:google_places_autocomplete_text_field/model/prediction.dart';

class SecondStepForm extends StatelessWidget {
  const SecondStepForm({
    super.key,
    required this.onNext,
    required this.controller,
    required this.googleMapController,
    required this.initialCameraPosition,
    required this.searchLocationCtrl,
    required this.onPrediction,
    required this.markers,
    required this.titleController,
  });

  final TextEditingController controller;
  final TextEditingController titleController;

  final Completer<GoogleMapController> googleMapController;
  final CameraPosition initialCameraPosition;
  final TextEditingController searchLocationCtrl;
  final Function(Prediction prediction) onPrediction;
  final VoidCallback onNext;
  final Set<Marker> markers;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Flexible(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Task Title',
                        style: textTheme.bodyLarge,
                      ),
                      CustomTextFormField(
                        hintText: 'Enter task title',
                        controller: titleController,
                      ),
                    ].withSpaceBetween(height: 10),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Describe your problem',
                        style: textTheme.bodyLarge,
                      ),
                      CustomTextFormField(
                        keyboardType: TextInputType.multiline,
                        hintText: 'Write a short description of your task',
                        controller: controller,
                        minLines: 6,
                        maxLines: 20,
                        maxLength: 500,
                      ),
                    ].withSpaceBetween(height: 10),
                  ),
                  Text(
                    'Tell us where',
                    style: textTheme.bodyLarge,
                  ),
                  GooglePlacesAutoCompleteTextFormField(
                    textEditingController: searchLocationCtrl,
                    googleAPIKey: "AIzaSyCgOvOhTtXuxLlFAlTV0tEEQNzXx0ALONs",
                    countries: const ["Ph"],
                    maxLines: 1,
                    decoration: const InputDecoration(
                      hintText: 'Pick a location',
                      prefixIcon: Icon(
                        Icons.location_on_outlined,
                        color: ColorName.darkerGreyFont,
                      ),
                    ),
                    isLatLngRequired:
                        true, // if you require the coordinates from the place details
                    getPlaceDetailWithLatLng: (prediction) {
                      onPrediction(prediction);
                    },
                    itmClick: (Prediction prediction) =>
                        searchLocationCtrl.text = prediction.description!,
                    overlayContainer: (child) => Material(
                      elevation: 1.0,
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      child: child,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: ColorName.primary),
                    ),
                    height: MediaQuery.of(context).size.height * 0.5,
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
                ].withSpaceBetween(height: 20),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        NextButton(
          onNext: onNext,
          isEnabled: controller.value.text.isNotEmpty &&
              searchLocationCtrl.value.text.isNotEmpty,
        ),
      ],
    );
  }
}
