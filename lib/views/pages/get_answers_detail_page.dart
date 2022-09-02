import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sence/providers/auth_provider.dart';
import 'package:sence/services/question_service.dart';
import 'package:sence/views/widgets/custom_dvider.dart';
import 'package:sence/views/widgets/custom_white_logo.dart';

class GetAnswerDetailPage extends StatefulWidget {
  const GetAnswerDetailPage({super.key});

  @override
  State<GetAnswerDetailPage> createState() => _GetAnswerDetailPageState();
}

class _GetAnswerDetailPageState extends State<GetAnswerDetailPage> {
  Future? _future;
  QuestionService? _questionService;
  AuthProvider? _authProvider;
  final _baseUrl = 'https://sence-napim.herokuapp.com/question';
  @override
  void initState() {
    super.initState();
    final dio = Dio(BaseOptions(baseUrl: _baseUrl));
    _questionService = QuestionService(dio);
    _authProvider = Provider.of<AuthProvider>(context, listen: false);
  }

  // setUpTimedFetch() {
  //   Timer.periodic(const Duration(milliseconds: 7000), (timer) {
  //     setState(() {
  //       _future =
  //           _questionService!.fetchGetQuestion(userId: _authProvider!.userId);
  //     });
  //   });
  //   return _future;
  // }

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    return Scaffold(
      appBar: AppBar(
        title: const CustomWhiteLogo(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Text(
                    arguments['content'].toString(),
                  ),
                  const CustomDvider()
                ],
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            arguments['answers'][index]['content'].toString(),
                            textAlign: TextAlign.left,
                          ),
                          const CustomDvider()
                        ],
                      ),
                    ),
                  );
                },
                childCount: arguments['answers'].length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
