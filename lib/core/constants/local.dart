import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage{
  static const String _totalTasksKey = 'total_tasks';
  static SharedPreferences? sharedPreferences;

  static Future<void> storeTotalTasks(int totalTasks) async{
    sharedPreferences ??= await SharedPreferences.getInstance();
    await sharedPreferences!.setInt(_totalTasksKey, totalTasks);
  }

  static Future<int?> getTotalTasks() async{
    sharedPreferences ??= await SharedPreferences.getInstance();
    return sharedPreferences?.getInt(_totalTasksKey);
  }
}