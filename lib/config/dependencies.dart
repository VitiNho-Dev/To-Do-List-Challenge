import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../data/repositories/task_repository.dart';
import '../data/services/api_client.dart';
import '../ui/details/view_models/detail_viewmodel.dart';
import '../ui/home/view_models/home_viewmodel.dart';
import '../utils/http_client.dart';

GetIt getIt = GetIt.instance;

void initDependencies() {
  getIt.registerFactory<HttpClient>(() => DioHttp(dio: Dio()));
  getIt.registerFactory<ApiClient>(() => ApiClient(http: getIt()));
  getIt.registerSingleton<TaskRepository>(
    TaskRepositoryImpl(apiClient: getIt()),
  );
  getIt.registerSingleton<HomeViewmodel>(
    HomeViewmodel(taskRepository: getIt()),
  );
  getIt.registerSingleton<DetailViewmodel>(
    DetailViewmodel(taskRepository: getIt()),
  );
}
