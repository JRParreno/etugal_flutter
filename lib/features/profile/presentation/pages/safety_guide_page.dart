import 'package:etugal_flutter/core/env/env.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SafetyGuidePage extends StatefulWidget {
  const SafetyGuidePage({super.key});

  @override
  State<SafetyGuidePage> createState() => _SafetyGuidePageState();
}

class _SafetyGuidePageState extends State<SafetyGuidePage> {
  late WebViewController controller;
  final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers = {
    Factory(() => EagerGestureRecognizer())
  };

  final UniqueKey _key = UniqueKey();

  @override
  void initState() {
    super.initState();
    const baseUrl = Env.apiURL;

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse('$baseUrl/safety_guide/'));
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Safety Guide',
          style: textTheme.titleLarge,
        ),
        centerTitle: true,
      ),
      body: WebViewWidget(
        key: _key,
        gestureRecognizers: gestureRecognizers,
        controller: controller,
      ),
    );
  }
}
