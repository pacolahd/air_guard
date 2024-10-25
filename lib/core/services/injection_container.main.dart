part of 'injection_container.dart';

// This is the main file for the dependency injection container.
// when the GetIt.instance is called, the app will look for the import in the injection_container.dart file
// and then execute the code in the file thereby importing all the dependencies in the file.

// In other files, we import only the injection_container.dart file and not the injection_container.main.dart file

final sl = GetIt.instance;

Future<void> init() async {
  sl
    ..registerLazySingleton(() => Connectivity())
    ..registerLazySingleton(() => FirebaseAuth.instance)
    ..registerLazySingleton(() => FirebaseFirestore.instance)
    ..registerLazySingleton(() => FirebaseStorage.instance);

  await _initOnBoarding();
  await _initAuth();
}

Future<void> _initOnBoarding() async {
  // We await for the shared prefs to load before we inject any other dependencies.
  // We want only 1 shared prefs instance to be created and used throughout the app
  final prefs = await SharedPreferences.getInstance();
  // Feature --> OnBoarding
  // Business Logic

  sl
    ..registerFactory(
      () => OnBoardingCubit(
        cacheFirstTimer: sl(),
        checkIfUserIsFirstTimer: sl(),
      ),
    )
    ..registerLazySingleton(() => CacheFirstTimer(sl()))
    ..registerLazySingleton(() => CheckIfUserIsFirstTimer(sl()))
    ..registerLazySingleton<OnBoardingRepo>(() => OnBoardingRepoImpl(sl()))
    ..registerLazySingleton<OnBoardingLocalDataSource>(
        () => OnBoardingLocalDataSrcImpl(sl()))
    ..registerLazySingleton(() => prefs);
}

Future<void> _initAuth() async {
  sl
    ..registerFactory(
      () => AuthBloc(
        signIn: sl(),
        signUp: sl(),
        forgotPassword: sl(),
        updateUser: sl(),
      ),
    )
    ..registerLazySingleton(() => SignIn(sl()))
    ..registerLazySingleton(() => SignUp(sl()))
    ..registerLazySingleton(() => ForgotPassword(sl()))
    ..registerLazySingleton(() => UpdateUser(sl()))
    ..registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()))
    ..registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        connectivity: sl(),
        authClient: sl(),
        firestoreClient: sl(),
        storageClient: sl(),
      ),
    );
}

// Future<void> _initCourse() async {
//   sl
//     ..registerFactory(
//       () => CourseCubit(
//         addCourse: sl(),
//         getCourses: sl(),
//       ),
//     )
//     ..registerLazySingleton(() => AddCourse(sl()))
//     ..registerLazySingleton(() => GetCourses(sl()))
//     ..registerLazySingleton<CourseRepo>(() => CourseRepoImpl(sl()))
//     ..registerLazySingleton<CourseRemoteDataSrc>(
//       () => CourseRemoteDataSrcImpl(
//         auth: sl(),
//         firestore: sl(),
//         storage: sl(),
//         connectivity: sl(),
//       ),
//     );
// }
//
// Future<void> _initQuiz() async {
//   sl
//     ..registerFactory(
//       () => QuizCubit(
//         getQuizQuestions: sl(),
//         getQuizzes: sl(),
//         submitQuiz: sl(),
//         updateQuiz: sl(),
//         uploadQuiz: sl(),
//         getUserCourseQuizzes: sl(),
//         getUserQuizzes: sl(),
//         getQuizzesUsingMaterial: sl(),
//       ),
//     )
//     ..registerLazySingleton(() => GetQuizQuestions(sl()))
//     ..registerLazySingleton(() => GetQuizzes(sl()))
//     ..registerLazySingleton(() => SubmitQuiz(sl()))
//     ..registerLazySingleton(() => UpdateQuiz(sl()))
//     ..registerLazySingleton(() => UploadQuiz(sl()))
//     ..registerLazySingleton(() => GetUserCourseQuizzes(sl()))
//     ..registerLazySingleton(() => GetUserQuizzes(sl()))
//     ..registerLazySingleton(() => GetQuizzesUsingMaterial(sl()))
//     ..registerLazySingleton<QuizRepo>(() => QuizRepoImpl(sl()))
//     ..registerLazySingleton<QuizRemoteDataSrc>(
//       () => QuizRemoteDataSrcImpl(
//         auth: sl(),
//         firestore: sl(),
//         connectivity: sl(),
//       ),
//     );
// }
//
// Future<void> _initMaterial() async {
//   sl
//     ..registerFactory(
//       () => MaterialCubit(
//         addMaterial: sl(),
//         getMaterials: sl(),
//         // updateMaterial: sl(),
//         // deleteMaterial: sl(),
//         getMaterialsForQuiz: sl(),
//       ),
//     )
//     ..registerLazySingleton(() => AddMaterial(sl()))
//     ..registerLazySingleton(() => GetMaterials(sl()))
//     // ..registerLazySingleton(() => UpdateMaterial(sl()))
//     // ..registerLazySingleton(() => DeleteMaterial(sl()))
//     ..registerLazySingleton(() => GetMaterialsForQuiz(sl()))
//     ..registerLazySingleton<MaterialRepo>(() => MaterialRepoImpl(sl()))
//     ..registerLazySingleton<MaterialRemoteDataSrc>(
//       () => MaterialRemoteDataSrcImpl(
//         auth: sl(),
//         firestore: sl(),
//         storage: sl(),
//         connectivity: sl(),
//       ),
//     ) ..registerFactory(() => ResourceController(storage: sl(), prefs: sl()));
// }
