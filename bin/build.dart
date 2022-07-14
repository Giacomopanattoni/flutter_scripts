import 'package:process_run/shell.dart';

void main(List<String> arguments) async {
  print('Build IOS...');
  var shell = Shell();

  await shell.run('''

# Display some text
flutter build ipa

''');
}
