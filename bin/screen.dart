import 'dart:io';
import 'package:args/args.dart';

String viewCode = """

class SampleScreen extends StatefulWidget {
  const SampleScreen({Key? key}) : super(key: key);

  @override
  _SampleScreenState createState() => _SampleScreenState();
}

class _SampleScreenState extends State<SampleScreen> {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SampleViewmodel>(
      create: (BuildContext context) => SampleViewmodel(),
      child: Consumer<SampleViewmodel>(builder: (context, viewModel, child) {
       
           }),
    );
  }
}
""";

String viewModelCode = """
class SampleViewmodel extends ChangeNotifier {
  bool loading = false;
}
""";

void main(List<String> arguments) async {
  final parser = ArgParser()..addFlag('lineNumber', negatable: false, abbr: 'n');
  var argResults = parser.parse(arguments);
  try {
    String name = argResults.arguments[1].toLowerCase();
    await createDirAndFiles(name);
  } catch (e) {
    print('No name provided');
  }
}

Future<void> createDirAndFiles(String name) async {
  var dir = Directory('./lib/screens');
  var viewName = name + '_screen';
  var viewCompileName = capitalize(viewName);
  var viewModelName = name + '_viewmodel';
  var viewModelCompileName = capitalize(viewModelName);

  var view = await File(dir.path + '/' + viewName + '/$viewName.dart').create(recursive: true);
  await view.writeAsString(
    viewCode
        .replaceAll(
          'SampleScreen',
          viewCompileName,
        )
        .replaceAll('SampleViewmodel', viewCompileName),
  );
  var viewModel = await File(dir.path + '/' + viewName + '/$viewModelName.dart').create(recursive: true);
  await viewModel.writeAsString(
    viewModelCode.replaceAll('SampleViewmodel', viewModelCompileName),
  );
}

String capitalize(String name) {
  var explodedString = name.split('_');
  var result = "";
  for (String str in explodedString) {
    result += str[0].toUpperCase() + str.substring(1);
  }
  return result;
}
