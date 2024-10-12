import 'dart:io';

import 'package:etugal_flutter/core/common/widgets/custom_elevated_btn.dart';
import 'package:etugal_flutter/core/common/widgets/loader.dart';
import 'package:etugal_flutter/dependency_injection_config.dart';
import 'package:etugal_flutter/features/chat/domain/repository/chat_repository.dart';
import 'package:etugal_flutter/features/chat/domain/usecases/index.dart';
import 'package:etugal_flutter/features/chat/presentation/blocs/chat_list/chat_list_bloc.dart';
import 'package:etugal_flutter/features/task/presentation/widgets/index.dart';
import 'package:etugal_flutter/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

enum ReportUserEnums { fraudulent, harrasment, spam, violation, other }

class ChatReportUserPage extends StatefulWidget {
  const ChatReportUserPage({
    super.key,
    required this.reportUserId,
  });

  final int reportUserId;

  @override
  State<ChatReportUserPage> createState() => _ChatReportUserPageState();
}

class _ChatReportUserPageState extends State<ChatReportUserPage> {
  ReportUserEnums? _selected;
  final TextEditingController controller = TextEditingController();

  List<XFile> images = [];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Report User',
          style: textTheme.titleLarge,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Reason for Report:',
                style: textTheme.labelLarge,
              ),
              const SizedBox(height: 5),
              Text('(Please select one of the following reasons)',
                  style: textTheme.bodySmall),
              const SizedBox(height: 10),
              RadioListTile<ReportUserEnums>(
                onChanged: handleOnChange,
                value: ReportUserEnums.fraudulent,
                groupValue: _selected,
                title: Text(
                  'Fraudulent Behavior: The user is engaging in dishonest activities or scams.',
                  style: textTheme.bodySmall,
                ),
              ),
              RadioListTile<ReportUserEnums>(
                onChanged: handleOnChange,
                value: ReportUserEnums.harrasment,
                groupValue: _selected,
                title: Text(
                  'Harassment or Abuse: The user is sending threatening, offensive, or abusive messages.',
                  style: textTheme.bodySmall,
                ),
              ),
              RadioListTile<ReportUserEnums>(
                onChanged: handleOnChange,
                value: ReportUserEnums.spam,
                groupValue: _selected,
                title: Text(
                  'Spam or Unsolicited Messages: The user is sending unwanted or repetitive messages.',
                  style: textTheme.bodySmall,
                ),
              ),
              RadioListTile<ReportUserEnums>(
                onChanged: handleOnChange,
                value: ReportUserEnums.violation,
                groupValue: _selected,
                title: Text(
                  'Violation of Terms and Conditions: The user is violating the platform’s rules or engaging in illegal activities.',
                  style: textTheme.bodySmall,
                ),
              ),
              RadioListTile<ReportUserEnums>(
                onChanged: handleOnChange,
                value: ReportUserEnums.other,
                groupValue: _selected,
                title: RichText(
                  text: TextSpan(
                    text: 'Other: ',
                    style: textTheme.bodySmall,
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Please specificy',
                        style: textTheme.bodySmall?.copyWith(
                          color: ColorName.greyFont,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text('Description of Issue:', style: textTheme.bodySmall),
              const SizedBox(height: 10),
              Text(
                '(Please provide a brief description of the issue. Include any relevant details or examples that can help us understand the situation better.)',
                style: textTheme.bodySmall,
              ),
              const SizedBox(height: 10),
              CustomTextFormField(
                keyboardType: TextInputType.multiline,
                hintText: 'Write here',
                controller: controller,
                minLines: 4,
                maxLines: 20,
                maxLength: 500,
                validator: (p0) => null,
              ),
              Text(
                'Attach images (optional)',
                style: textTheme.bodySmall,
              ),
              if (images.isNotEmpty) ...[
                const SizedBox(height: 10),
                SizedBox(
                  height: (MediaQuery.of(context).size.width / 3) + 20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: images
                        .map((value) => Stack(
                              children: [
                                SizedBox(
                                  width:
                                      (MediaQuery.of(context).size.width / 3) -
                                          15,
                                  height:
                                      (MediaQuery.of(context).size.width / 3) -
                                          15,
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Card(
                                      elevation: 4,
                                      child: Image.file(
                                        File(value.path),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: -13,
                                  top: -13,
                                  child: IconButton(
                                    color: Colors.white,
                                    icon: Container(
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(Icons.cancel_rounded,
                                          color: Colors.red),
                                    ),
                                    onPressed: () {
                                      images.remove(value);
                                      setState(() {
                                        images = images;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ))
                        .toList(),
                  ),
                ),
              ],
              const SizedBox(height: 10),
              if (images.length != 3) ...[
                CustomElevatedBtn(
                  onTap: images.length <= 3 ? handleImagePicker : null,
                  title: 'Add Images',
                ),
              ],
              const SizedBox(height: 10),
              const SizedBox(height: 40),
              CustomElevatedBtn(
                onTap: _selected != null ? handleSubmitForm : null,
                title: 'Submit',
              )
            ],
          ),
        ),
      ),
    );
  }

  void handleOnChange(ReportUserEnums? value) {
    setState(() {
      _selected = value;
    });
  }

  void handleImagePicker() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickImage =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 75);

    if (pickImage == null) return;

    setState(() {
      images.add(pickImage);
    });
  }

  void handleSubmitForm() async {
    LoadingScreen.instance().show(context: context);
    final response = await ChatReportUser(serviceLocator<ChatRepository>())
        .call(ChatReportUserParams(
      reportedUserId: widget.reportUserId,
      reason: getFromEnums(),
      additionalInfo: controller.value.text.trim().isNotEmpty
          ? controller.value.text
          : null,
      images: images,
    ));

    response.fold((l) {
      LoadingScreen.instance().hide();
    }, (r) {
      if (mounted) {
        context.read<ChatListBloc>().add(OnGetChatList());
      }
      LoadingScreen.instance().hide();

      Future.delayed(const Duration(seconds: 2), () {
        context.pop();
        context.pop();
      });
    });
  }

  String getFromEnums() {
    switch (_selected) {
      case ReportUserEnums.fraudulent:
        return 'Fraudulent Behavior: The user is engaging in dishonest activities or scams.';
      case ReportUserEnums.harrasment:
        return 'Harassment or Abuse: The user is sending threatening, offensive, or abusive messages.';
      case ReportUserEnums.other:
        return 'Other: Please specify';
      case ReportUserEnums.spam:
        return 'Spam or Unsolicited Messages: The user is sending unwanted or repetitive messages.';
      case ReportUserEnums.violation:
        return 'Violation of Terms and Conditions: The user is violating the platform’s rules or engaging in illegal activities.';
      default:
    }

    return '';
  }
}
