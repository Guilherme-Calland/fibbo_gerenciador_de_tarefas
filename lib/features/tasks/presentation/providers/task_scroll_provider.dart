import 'package:flutter/widgets.dart';
import 'package:gerenciador_de_tarefas/features/tasks/presentation/providers/task_provider.dart';
import 'package:provider/provider.dart';

class TaskScrollProvider extends ChangeNotifier{
  bool _scrolling = false;
  bool get scrolling => _scrolling;

  final ScrollController _taskScrollController = ScrollController();
  ScrollController get taskScrollController => _taskScrollController;

  bool _lastPage = false;
  bool get lastPage => false;

  void addScrollListener(BuildContext context){
    _taskScrollController.addListener(()async{

      if(_scrolling || _lastPage){
        return;
      }

      bool endOfPage = _taskScrollController.position.pixels == _taskScrollController.position.maxScrollExtent;
      debugPrint("fibbo, endOfPage: $endOfPage");
      if(endOfPage){
        _scrolling = true;
        _updateWidgetOnScreen();

        _lastPage = await context.read<TaskProvider>().fetchNewTaskPage(context);
        _scrolling = false;
        
        _updateWidgetOnScreen();
      }
    });
  }

  void _updateWidgetOnScreen(){
    notifyListeners();
  }
}