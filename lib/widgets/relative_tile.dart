import 'package:astrotak/screens/new_relative.dart';
import 'package:flutter/material.dart';
import '../models/relative_model.dart';

class RelativeTile extends StatelessWidget {
  final Relative relative;
  final Function deleteF;
  final Function editRel;
  RelativeTile(this.relative, this.deleteF, this.editRel);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Card(
            child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "${relative.fullName}",
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
        Text(
            "${relative.birthDetails.dobDay}-${relative.birthDetails.dobMonth}-${relative.birthDetails.dobYear}"),
        Text(
            '${relative.birthDetails.tobHour}:${relative.birthDetails.tobMin}'),
        Text('${relative.relation}'),
        IconButton(
          onPressed: () {
            editRel(relative);
          },
          icon: Icon(
            Icons.edit,
            color: Colors.amber,
          ),
        ),
        IconButton(
          onPressed: () async {
            return showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                  title: Text("Do you really want to Delete ?"),
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Flexible(
                        flex: 1,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xffff944c),
                          ),
                          onPressed: () {
                            deleteF(relative.uuid);
                            Navigator.of(context).pop();
                          },
                          child: Text('YES'),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xffff944c),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('NO'),
                      ),
                    ],
                  )),
            );
          },
          icon: Icon(
            Icons.delete,
            color: Colors.red,
          ),
        ),
      ],
    )));
  }
}
