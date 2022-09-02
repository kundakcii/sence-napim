import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sence/providers/auth_provider.dart';
import 'package:sence/services/question_service.dart';
import 'package:sence/views/widgets/custom_dvider.dart';

class GiveAnswersPage extends StatefulWidget {
  const GiveAnswersPage({super.key});

  @override
  State<GiveAnswersPage> createState() => _GiveAnswersPageState();
}

class _GiveAnswersPageState extends State<GiveAnswersPage> {
  QuestionService? _questionService;
  final _baseUrl = 'https://sence-napim.herokuapp.com/question';
  AuthProvider? _authProvider;
  Future? _future;
  Timer? timer;
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
  }

  setUpTimedFetch() {
    timer = Timer(
      Duration(milliseconds: milliseconds),
      () {
        if (mounted) {
          setState(() {
            milliseconds = milliseconds + 100;
            _future = _questionService?.fetchGetAskToYou(
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
                    Navigator.pushNamed(context, '/giveAnswersDetail',
                        arguments: snapshot.data[index]);
                  },
                  child: Column(
                    children: [
                      Column(
                        children: [
                          ListTile(
                            title: Text(
                              snapshot.data[index]['content'].toString(),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                          const CustomDvider()
                        ],
                      ),
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
