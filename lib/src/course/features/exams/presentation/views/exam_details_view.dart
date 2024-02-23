
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tdd_tutorial_flutter/core/common/widgets/course_info_tile.dart';
import 'package:tdd_tutorial_flutter/core/common/widgets/rounded_button.dart';
import 'package:tdd_tutorial_flutter/core/extensions/context_extension.dart';
import 'package:tdd_tutorial_flutter/core/extensions/int_extension.dart';
import 'package:tdd_tutorial_flutter/core/res/colors.dart';
import 'package:tdd_tutorial_flutter/core/res/media_res.dart';
import 'package:tdd_tutorial_flutter/core/utils/core_utils.dart';
import 'package:tdd_tutorial_flutter/core/widgets/gradient_background.dart';
import 'package:tdd_tutorial_flutter/src/course/features/exams/data/models/exam_model.dart';
import 'package:tdd_tutorial_flutter/src/course/features/exams/domain/entities/exam.dart';
import 'package:tdd_tutorial_flutter/src/course/features/exams/presentation/app/cubit/exam_cubit.dart';
import 'package:tdd_tutorial_flutter/src/course/features/exams/presentation/views/exam_view.dart';

class ExamDetailsView extends StatefulWidget {
  const ExamDetailsView(this.exam, {super.key});

  static const routeName = '/exam-details';

  final Exam exam;

  @override
  State<ExamDetailsView> createState() => _ExamDetailsViewState();
}

class _ExamDetailsViewState extends State<ExamDetailsView> {
  late Exam completeExam;

  void getQuestions() {
    context.read<ExamCubit>().getExamQuestions(widget.exam);
  }

  @override
  void initState() {
    completeExam = widget.exam;
    super.initState();
    getQuestions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(title: Text(widget.exam.title)),
      body: GradientBackground(
        image: MediaRes.onBoardingBackground,
        child: BlocConsumer<ExamCubit, ExamState>(
          listener: (_, state) {
            if (state is ExamError) {
              CoreUtils.showSnackBar(context, state.message);
            } else if (state is ExamQuestionsLoaded) {
              completeExam = (completeExam as ExamModel).copyWith(
                questions: state.questions,
              );
            }
          },
          builder: (context, state) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView(
                        children: [
                          Center(
                            child: Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colours.physicsTileColour,
                              ),
                              child: Center(
                                child: completeExam.imageUrl != null
                                    ? Image.network(
                                        completeExam.imageUrl!,
                                        width: 60,
                                        height: 60,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.asset(
                                        MediaRes.test,
                                        width: 60,
                                        height: 60,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            completeExam.title,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            completeExam.description,
                            style: const TextStyle(
                              color: Colours.neutralTextColour,
                            ),
                          ),
                          const SizedBox(height: 20),
                          CourseInfoTile(
                            image: MediaRes.exam_time,
                            title:
                                '${completeExam.timeLimit.displayDurationLong}'
                                ' for the test.',
                            subtitle: 'Complete the test in '
                                '${completeExam.timeLimit.displayDurationLong}',
                          ),
                          if (state is ExamQuestionsLoaded) ...[
                            const SizedBox(height: 10),
                            CourseInfoTile(
                              image: MediaRes.questions_document,
                              title: '${completeExam.questions?.length} '
                                  'Questions',
                              subtitle: 'This test consists of '
                                  '${completeExam.questions?.length} questions',
                            ),
                          ],
                        ],
                      ),
                    ),
                    if (state is GettingExamQuestions)
                      const Center(child: LinearProgressIndicator())
                    else if (state is ExamQuestionsLoaded)
                      Rounded_Button(
                        label: 'Start Exam',
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            ExamView.routeName,
                            arguments: completeExam,
                          );
                        },
                      )
                    else
                      Text(
                        'No Questions for this exam',
                        style: context.theme.textTheme.titleLarge,
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
