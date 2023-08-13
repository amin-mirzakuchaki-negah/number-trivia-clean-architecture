import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';
import '../../domain/entities/number_trivia.dart';
import '../bloc/number_trivia_bloc.dart';
import '../widgets/bottomhalf/bottom_half.dart';
import '../widgets/loading_widget.dart';
import '../widgets/message_display.dart';
import '../widgets/trivia_display.dart';

class NumberTriviaPage extends StatelessWidget {
  const NumberTriviaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Number Trivia'),
        ),
        body: BlocProvider(
          create: (_) => getIt<NumberTriviaBloc>(),
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: [
                SizedBox(height: 10),
                //Top Half
                BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
                  builder: (context, state) {
                    if (state is NumberTriviaInitial) {
                      return const MessageDisplay(message: 'Start Searching!');
                    } //
                    else if(state is NumberTriviaLoadingState) {
                      return const LoadingWidget();
                    } //
                    else if(state is InputFailureState) {
                      return MessageDisplay(message: state.message ?? "Something went wrong");
                    }
                    else if(state is NumberTriviaSuccessState) {
                      return TriviaDisplay(numberTrivia: state.response);
                    }
                  },
                ),
                const SizedBox(height: 20),
                //Bottom Half
                const BottomHalf(),
              ],
            ),
          ),
        ));
  }
}





