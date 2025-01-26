import 'package:clean_arch/di.dart';
import 'package:clean_arch/domain/enteties/watch.dart';
import 'package:clean_arch/domain/usecases/watch_usecases/get_all_watchs_usecase.dart';
import 'package:clean_arch/domain/usecases/watch_usecases/get_sorted_watchs_by_cat_usecase.dart';
import 'package:clean_arch/domain/usecases/watch_usecases/get_sorted_watchs_by_creation_date_usecase.dart';
import 'package:clean_arch/domain/usecases/watch_usecases/get_sorted_watchs_by_sales_usecase.dart';
import 'package:clean_arch/domain/usecases/watch_usecases/get_watch_by_category_usecase.dart';
import 'package:clean_arch/domain/usecases/watch_usecases/get_watch_by_id_usecase.dart';
import 'package:get/get.dart';

class WatchController extends GetxController {
  List<Watch> allWatchs = [];
  List<Watch> allWatchsByCat = [];
  List<Watch> watchsList = [];
  List<Watch> watchsByCatList = [];
  List<Watch> sortedWatchs = [];

  Future<bool> getAllWatchs() async {
    final res = await GetAllWatchsUsecase(sl())();
    res.fold((l) => null, (r) {
      watchsList = r;
      return allWatchs = r;
    });
    return true;
  }

  Future<Watch?> getWatchById(String wId) async {
    Watch? result;
    final res = await GetWatchByIdUsecase(sl())(wID: wId);
    res.fold((l) => null, (r) {
      return result = r;
    });
  }

  Future<bool> getWatchByCategory(String cId) async {
    final res = await GetWatchByCategoryUsecase(sl())(wcat: cId);
    res.fold((l) => null, (r) {
      watchsByCatList = r;
      return allWatchsByCat = r;
    });
    return true;
  }

  Future<List<Watch>> getSortedWatchsByCat() async {
    if (sortedWatchs.isEmpty) {
      final res = await GetSortedWatchsByCatUsecase(sl())();
      res.fold((l) => null, (r) => sortedWatchs = r);
    }
    return sortedWatchs;
  }

  Future<List<Watch>> getSortedWatchsBySales() async {
    if (sortedWatchs.isEmpty) {
      final res = await GetSortedWatchsBySalesUsecase(sl())();
      res.fold((l) => null, (r) => sortedWatchs = r);
    }
    return sortedWatchs;
  }

  Future<List<Watch>> getSortedWatchsByCreationDate() async {
    if (sortedWatchs.isEmpty) {
      final res = await GetSortedWatchsByCreationDateUsecase(sl())();
      res.fold((l) => null, (r) => sortedWatchs = r);
    }
    return sortedWatchs;
  }
}
