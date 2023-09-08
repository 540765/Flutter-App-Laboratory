import 'package:go_router/go_router.dart';
import 'package:laboratory/app_router/routes/public_route.dart';

// GoRouter configuration
class RouterLaboratory {
  static GoRouter router = GoRouter(
    ///默認路由
    initialLocation: '/',

    ///路由重定向--返回null説明不攔截
    redirect: (context, state){
      return null;
    },
    
    ///路由配置
    routes: [
      ...PublicRoute.route,
    ],
  );
}
