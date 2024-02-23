import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tdd_tutorial_flutter/core/common/views/page_under_construction.dart';
import 'package:tdd_tutorial_flutter/core/extensions/context_extension.dart';
import 'package:tdd_tutorial_flutter/core/services/injection_container.dart';
import 'package:tdd_tutorial_flutter/src/auth/data/models/user_model.dart';
import 'package:tdd_tutorial_flutter/src/auth/presentation/bloc/auth_bloc.dart';
import 'package:tdd_tutorial_flutter/src/auth/presentation/views/sign_in_screen.dart';
import 'package:tdd_tutorial_flutter/src/auth/presentation/views/sign_up_screen.dart';
import 'package:tdd_tutorial_flutter/src/course/domain/entities/course.dart';
import 'package:tdd_tutorial_flutter/src/course/features/exams/domain/entities/exam.dart';
import 'package:tdd_tutorial_flutter/src/course/features/exams/domain/entities/user_exam.dart';
import 'package:tdd_tutorial_flutter/src/course/features/exams/presentation/app/cubit/exam_cubit.dart';
import 'package:tdd_tutorial_flutter/src/course/features/exams/presentation/app/providers/exam_controller.dart';
import 'package:tdd_tutorial_flutter/src/course/features/exams/presentation/views/add_exam_view.dart';
import 'package:tdd_tutorial_flutter/src/course/features/exams/presentation/views/course_exams_view.dart';
import 'package:tdd_tutorial_flutter/src/course/features/exams/presentation/views/exam_details_view.dart';
import 'package:tdd_tutorial_flutter/src/course/features/exams/presentation/views/exam_view.dart';
import 'package:tdd_tutorial_flutter/src/course/features/materials/presentation/app/cubit/material_cubit.dart';
import 'package:tdd_tutorial_flutter/src/course/features/materials/presentation/views/add_materials_view.dart';
import 'package:tdd_tutorial_flutter/src/course/features/materials/presentation/views/course_materials_view.dart';
import 'package:tdd_tutorial_flutter/src/course/features/videos/presentation/cubit/video_cubit.dart';
import 'package:tdd_tutorial_flutter/src/course/features/videos/presentation/views/add_video_view.dart';
import 'package:tdd_tutorial_flutter/src/course/features/videos/presentation/views/course_video_view.dart';
import 'package:tdd_tutorial_flutter/src/course/features/videos/presentation/views/video_player_view.dart';
import 'package:tdd_tutorial_flutter/src/course/presentation/cubit/course_cubit.dart';
import 'package:tdd_tutorial_flutter/src/course/presentation/views/course_details_screen.dart';
import 'package:tdd_tutorial_flutter/src/dashboard/presentation/views/dashboard.dart';
import 'package:tdd_tutorial_flutter/src/notifications/presentation/cubit/notification_cubit.dart';
import 'package:tdd_tutorial_flutter/src/on_boarding/data/datasources/on_boarding_local_data_source.dart';
import 'package:tdd_tutorial_flutter/src/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:tdd_tutorial_flutter/src/on_boarding/presentation/views/on_boarding_screen.dart';
import 'package:tdd_tutorial_flutter/src/quick_access/presentation/views/exam_history_details_screen.dart';
// import 'package:firebase_ui_auth/firebase_ui_auth.dart' as fui;
Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      final prefs = sl<SharedPreferences>();
      return _pageBuilder(
        (context) {
          if (prefs.getBool(kFirstTimerKey) ?? true) {
            return BlocProvider(
              create: (_) => sl<OnBoardingCubit>(),
              child: const OnBoardingScreen(),
            );
          } else if (sl<FirebaseAuth>().currentUser != null) {
            final user = sl<FirebaseAuth>().currentUser!;
            final localUser = LocalUserModel(
              uid: user.uid,
              email: user.email ?? '',
              points: 0,
              fullName: user.displayName ?? '',
            );
            context.userProvider.initUser(localUser);
            return const Dashboard();
          }
          return BlocProvider(
            create: (_) => sl<AuthBloc>(),
            child: const SignInScreen(),
          );
        },
        settings: settings,
      );
    case SignInScreen.routeName:
      return _pageBuilder(
        (_) => BlocProvider(
          create: (_) => sl<AuthBloc>(),
          child: const SignInScreen(),
        ),
        settings: settings,
      );
    case SignUpScreen.routeName:
      return _pageBuilder(
        (_) => BlocProvider(
          create: (_) => sl<AuthBloc>(),
          child: const SignUpScreen(),
        ),
        settings: settings,
      );
    case Dashboard.routeName:
      return _pageBuilder(
        (_) => const Dashboard(),
        settings: settings,
      );

    // case '/forgot-password':
    //   return _pageBuilder(
    //     (_) => const fui.ForgotPasswordScreen(),
    //     settings: settings,
    //   );
    case CourseDetailsScreen.routeName:
      return _pageBuilder(
        (_) => CourseDetailsScreen(settings.arguments! as Course),
        settings: settings,
      );
    case ExamDetailsView.routeName:
      return _pageBuilder(
        (_) => BlocProvider(
          create: (context) => sl<ExamCubit>(),
          child: ExamDetailsView(settings.arguments! as Exam),
        ),
        settings: settings,
      );
    case ExamHistoryDetailsScreen.routeName:
      return _pageBuilder(
        (_) => ExamHistoryDetailsScreen(settings.arguments! as UserExam),
        settings: settings,
      );
    case ExamView.routeName:
      return _pageBuilder(
        (_) => BlocProvider(
          create: (context) => sl<ExamCubit>(),
          child: ChangeNotifierProvider(
            create: (context) => ExamController(
              exam: settings.arguments! as Exam,
            ),
            child: const ExamView(),
          ),
        ),
        settings: settings,
      );
    case AddVideoView.routeName:
      return _pageBuilder(
        (_) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => sl<CourseCubit>()),
            BlocProvider(create: (_) => sl<VideoCubit>()),
            BlocProvider(create: (_) => sl<NotificationCubit>()),
          ],
          child: const AddVideoView(),
        ),
        settings: settings,
      );
    case AddMaterialsView.routeName:
      return _pageBuilder(
        (_) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => sl<CourseCubit>()),
            BlocProvider(create: (_) => sl<MaterialCubit>()),
            BlocProvider(create: (_) => sl<NotificationCubit>()),
          ],
          child: const AddMaterialsView(),
        ),
        settings: settings,
      );
    case AddExamView.routeName:
      return _pageBuilder(
        (_) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => sl<CourseCubit>()),
            BlocProvider(create: (_) => sl<ExamCubit>()),
            BlocProvider(create: (_) => sl<NotificationCubit>()),
          ],
          child: const AddExamView(),
        ),
        settings: settings,
      );
    case VideoPlayerView.routeName:
      return _pageBuilder(
        (_) => VideoPlayerView(videoURL: settings.arguments! as String),
        settings: settings,
      );
    case CourseVideosView.routeName:
      return _pageBuilder(
        (_) => BlocProvider(
          create: (_) => sl<VideoCubit>(),
          child: CourseVideosView(settings.arguments! as Course),
        ),
        settings: settings,
      );
    case CourseMaterialsView.routeName:
      return _pageBuilder(
        (_) => BlocProvider(
          create: (_) => sl<MaterialCubit>(),
          child: CourseMaterialsView(settings.arguments! as Course),
        ),
        settings: settings,
      );
    case CourseExamsView.routeName:
      return _pageBuilder(
        (_) => BlocProvider(
          create: (_) => sl<ExamCubit>(),
          child: CourseExamsView(settings.arguments! as Course),
        ),
        settings: settings,
      );
    default:
      return _pageBuilder(
        (_) => const PageUnderConstruction(),
        settings: settings,
      );
  }
}

PageRouteBuilder<dynamic> _pageBuilder(
  Widget Function(BuildContext) page, {
  required RouteSettings settings,
}) {
  return PageRouteBuilder(
    settings: settings,
    transitionsBuilder: (_, animation, __, child) => FadeTransition(
      opacity: animation,
      child: child,
    ),
    pageBuilder: (context, _, __) => page(context),
  );
}
