import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage{
  static const String _totalTasksKey = 'total_tasks';
  static SharedPreferences? sharedPreferences;

  static Future<void> storeTotalTasks(int totalTasks) async{
    sharedPreferences ??= await SharedPreferences.getInstance();
    sharedPreferences!.setInt(_totalTasksKey, totalTasks);
  }
}