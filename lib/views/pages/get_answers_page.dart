import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sence/providers/auth_provider.dart';
import 'package:sence/services/question_service.dart';
import 'package:sence/views/widgets/custom_dvider.dart';

class GetAnswersPage extends StatefulWidget {
  const GetAnswersPage({super.key});

  @override
  State<GetAnswersPage> createState() => _GetAnswersPageState();
}

class _GetAnswersPageState extends State<GetAnswersPage> {
  QuestionService? _questionService;
  final _baseUrl = 'https://sence-napim.herokuapp.com/question';
  Timer? timer;
  AuthProvider? _authProvider;
  Future? _future;
  int milliseconds = 500;
  @override
  void initState() {
    super.initState();
    final dio = Dio(BaseOptions(baseUrl: _baseUrl));
    _questionService = QuestionService(dio);
    _authProvider = Provider.of<AuthProvider>(context, listen: false);
    setUpTimedFetch();
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
    _future = null;
  }

  setUpTimedFetch() {
    timer = Timer(
      Duration(milliseconds: milliseconds),
      () {
        if (mounted) {
          setState(() {
            milliseconds = milliseconds + 100;
            _future = _questionService?.fetchGetQuestion(
                userId: _authProvider!.userId);
          });
        }
      },
    );
    return _future;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: setUpTimedFetch(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/getAnswersDetail',
                        arguments: snapshot.data[index]);
                  },
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                          snapshot.data[index]['content'].toString(),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const CustomDvider()
                    ],
                  ),
                );
              });
        } else if (snapshot.data == null) {
          return const Center(child: Text('Lütfen Bekleyiniz...'));
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
