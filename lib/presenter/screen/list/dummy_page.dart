import 'package:driver/domain/repositories/dummy_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/dummy_bloc.dart';

class DummyPage extends StatelessWidget {
  const DummyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DummyBloc(
          repository: RepositoryProvider.of<DummyRepository>(context)),
      child: DummyWidget(),
    );
  }
}

class DummyWidget extends StatefulWidget {
  @override
  _DummyWidgetState createState() => _DummyWidgetState();
}

class _DummyWidgetState extends State<DummyWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Dummy",
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
