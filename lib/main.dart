import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:volt/core/di/service_locator.dart';
import 'package:volt/volt_app.dart';

void main() async {
  // debugRepaintRainbowEnabled = true;
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: 'env');
  await setupServiceLocator();
  runApp(const VoltApp());
}
