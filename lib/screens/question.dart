import 'package:astrotak/bloc/question_bloc/questions_bloc.dart';
import 'package:astrotak/bloc/question_bloc/questions_event.dart';
import 'package:astrotak/bloc/question_bloc/questions_state.dart';
import 'package:astrotak/models/question_model.dart';
import 'package:astrotak/screens/relative.dart';
import 'package:astrotak/screens/relative_home.dart';
import 'package:astrotak/widgets/category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuestionScreen extends StatelessWidget {
  const QuestionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Question> questions = [];

    var questionBloc = BlocProvider.of<QuestionsBloc>(context);
    questionBloc.add(FetchAllQuestions());

    return BlocBuilder<QuestionsBloc, QuestionsState>(
      builder: (context, state) {
        if (state is FetchingQuestions) {
          return Center(
              child: CircularProgressIndicator(
            strokeWidth: 5,
          ));
        } else if (state is QuestionsLoaded) {
          questions = state.questions;
          return Scaffold(
            appBar: AppBar(
              title: Image.asset(
                "assets/images/icon.png",
                height: 60,
              ),
              leading: IconButton(
                icon: ImageIcon(
                  AssetImage("assets/images/hamburger.png"),
                  color: Colors.amber[800],
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              actions: [
                IconButton(
                  icon: ImageIcon(
                    AssetImage("assets/images/profile.png"),
                    color: Colors.amber[800],
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => RelativeHome(),
                      ),
                    );
                  },
                ),
              ],
              centerTitle: true,
              backgroundColor: Colors.white,
              elevation: 0.0,
            ),
            floatingActionButton: Padding(
              padding: const EdgeInsets.only(bottom: 50.0),
              child: FloatingActionButton(
                onPressed: () {},
                child: Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
                backgroundColor: Colors.amber[800],
              ),
            ),
            body: SafeArea(
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 60,
                      child: Container(
                        color: Color(0xff4b60bd),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Row(
                            children: [
                              Text(
                                "Wallet Balance: ₹0",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Spacer(),
                              TextButton(
                                onPressed: () {},
                                child: Text("Add Money"),
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  side: BorderSide(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Ask a Question",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          "Lorem ipsum dolor sit amet consectetur adipisicing elit. Maxime mollitia,molestiae quas vel sint commodi repudiandae consequuntur voluptatum laborumnumquam blanditiis harum quisquam eius sed odit fugiat iusto fuga praesentiumoptio, eaque rerum! Provident similique accusantium nemo autem. Veritatisobcaecati tenetur iure eius earum ut molestias architecto voluptate aliquamnihil, eveniet aliquid culpa officia aut! "),
                    ),
                    Expanded(
                      child: Category(questions),
                    ),
                    // Expanded(
                    //   child: SizedBox(
                    //     height: 100,
                    //     child: Container(
                    //       color: Colors.amber,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return Center(
            child: Text('QuestionScreen'),
          );
        }
      },
    );
  }
}
