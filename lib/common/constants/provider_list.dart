import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:task/common/providers/local_changer.dart';

class ProviderList {
  static final List<SingleChildWidget> providerList = [
    ChangeNotifierProvider<LocalChanger>(
        lazy: false, create: (context) => LocalChanger())
  ];
}
