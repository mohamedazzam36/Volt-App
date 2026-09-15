import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:volt/core/bloc_observer/my_bloc_observer.dart';
import 'package:volt/core/di/service_locator.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:volt/volt_app.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  
  Bloc.observer = MyBlocObserver();
  await dotenv.load();
  await setupServiceLocator();
  runApp(const VoltApp());
}
