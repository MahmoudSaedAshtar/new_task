import 'package:flutter/widgets.dart';

import '../network_base.dart';

class ApiParameters {
  BuildContext? context;
  String apiCode;
  Map<String, dynamic> formData;
  bool silentProgress;
  bool showError;

  ApiParameters(
      {
        this.context,
        required this.apiCode,
        this.formData:const {},
        this.silentProgress:false,
        this.showError:true,
      });
}