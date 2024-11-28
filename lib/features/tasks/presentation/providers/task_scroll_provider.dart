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
        await _loadNewTaskPage(context);
      }
    });
  }

  Future<void> _loadNewTaskPage(BuildContext context) async {
    _scrolling = true;
    _updateWidgetOnScreen();
    
    _lastPage = await context.read<TaskProvider>().fetchNewTaskPage(context);
    _scrolling = false;
    
    _updateWidgetOnScreen();

    if(context.mounted){
      checkScrollExtent(context);
    }
  }

  void _updateWidgetOnScreen(){
    notifyListeners();
  }

  // check if item extent goes to end of the screen, if not, load more
  // items if there are items left to load
  void checkScrollExtent(BuildContext context) async{
    late bool scrollConnected = false;
    do{
      await Future.delayed(const Duration(milliseconds: 50));
      scrollConnected = taskScrollController.positions.isNotEmpty;
      if(scrollConnected){
        bool pageCanScroll = taskScrollController.position.maxScrollExtent > 0;
        if(!pageCanScroll){
          if(context.mounted){
            _loadNewTaskPage(context);
          }
        }
      }
    }while(!scrollConnected);
  }
}