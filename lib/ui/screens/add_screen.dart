import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tv/business/add_bloc.dart';
import 'package:flutter_tv/ui/widgets/add_movie.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AddBloc()..add(AddInitializeEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add Movie Screen'),
        ),
        body: BlocBuilder<AddBloc, AddState>(
          builder: (context, state) {
            if (state is AddUploadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is AddUploadedState) {
              if (state.success) {
                Navigator.of(context).pop();
              } else {
                return const Center(
                  child: Text('Movie added failed'),
                );
              }
            }
            return SingleChildScrollView(
              child: AddMovieWidget(),
            );
          },
        ),
      ),
    );
  }
}
