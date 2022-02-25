import 'package:astrotak/models/question_model.dart';
import 'package:astrotak/services/logger.dart';
import 'package:flutter/material.dart';

class Category extends StatefulWidget {
  final List<Question> categories;

  Category(this.categories);

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  late Question dropdownValue;

  @override
  void initState() {
    super.initState();
    dropdownValue = widget.categories[0];
    logger.i(dropdownValue.suggestions.length);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Choose Category",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 4.0),
                      child: DropdownButton(
                        value: dropdownValue,
                        // icon: Padding(
                        //   //Icon at tail, arrow bottom is default icon
                        //   padding: EdgeInsets.only(left: 20),
                        //   child: Icon(Icons.arrow_circle_down_sharp),
                        // ),
                        isExpanded: true,
                        underline: Container(),
                        items: widget.categories.map((e) {
                          return DropdownMenuItem(
                            child: Text(e.name),
                            value: e,
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            dropdownValue = value as Question;
                          });
                          logger.i(dropdownValue);
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Type a question here',
                    ),
                    maxLines: 5,
                    maxLength: 150,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    "Ideas what to Ask (Select Any)",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: dropdownValue.suggestions.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          ListTile(
                            leading: Icon(
                              Icons.check_circle_outline,
                              color: Colors.amber,
                            ),
                            title: Text(dropdownValue.suggestions[index]),
                            // subtitle: Text(dropdownValue.suggestions[index].price.toString()),
                          ),
                          Divider(
                            color: Colors.grey,
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 10.0),
                  child: Text(
                    "Seeking accurate Lorem ipsum dolor sit amet consectetur adipisicing elit. Maxime mollitia,molestiae quas vel sint commodi repudiandae consequuntur voluptatum laborumnumquam blanditiis harum quisquam eius sed odit fugiat iusto fuga praesentiumoptio, eaque rerum!",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 100.0),
                  child: Container(
                    color: Color(0xfffff1e8),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        " • Seeking accurate Lorem ipsum dolor sit amet consectetur adipisicing elit. \n • Maxime mollitia,molestiae quas vel sint commodi repudiandae consequuntur voluptatum laborumnumquam blanditiis. \n • harum quisquam eius sed odit fugiat iusto fuga praesentiumoptio, eaque rerum! \n • Seeking accurate Lorem ipsum dolor sit amet consectetur adipisicing elit. \n • Maxime mollitia,molestiae quas vel sint commodi repudiandae consequuntur voluptatum laborumnumquam blanditiis.",
                        style:
                            TextStyle(fontSize: 16, color: Color(0xffff944c)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 60,
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xff4b60bd),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  Text(
                    "${dropdownValue.price} (1 Question on ${dropdownValue.name})",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: () {},
                    child: Text("Ask Now"),
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
      ],
    );
  }
}
