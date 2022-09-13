import 'package:bizado/Services/post_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'Auth/auth_service.dart';

late final cityProvider;
late final cityNewPost;
late final jobType;
late final jobTypeNewPost;
late final currentUser;
late final postProvider;

setupRiverPod() {
  currentUser = StateProvider((ref) {
    return AuthService().user!.displayName.toString();
  });

  jobType = StateProvider<String>((ref) {
    return "Todos";
  });
  jobTypeNewPost = StateProvider<String>((ref) {
    return "";
  });

  cityNewPost = StateProvider<String>((ref) {
    return "";
  });

  cityProvider = StateProvider<String>((ref) {
    return "";
  });

  postProvider = FutureProvider((ref) async {
    final city = ref.watch(cityProvider);
    final jobT = ref.watch(jobType);
    return PostService().postFilter(city, jobT);
  });
}
