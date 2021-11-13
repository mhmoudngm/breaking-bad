import 'package:bloc_app/data/web_services/characters_web_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class characters_details_screen extends StatefulWidget {
  const characters_details_screen({Key? key}) : super(key: key);

  @override
  State<characters_details_screen> createState() =>
      _characters_details_screenState();
}

class _characters_details_screenState extends State<characters_details_screen> {
  Key centerKey = ValueKey<String>('bottom-sliver-list');
  var st = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.italic,
      fontSize: 20);
  @override
  Widget build(BuildContext context) {
    var argroute =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    var index = argroute["index"];
    return Scaffold(
      backgroundColor:  Colors.grey,
      body: CustomScrollView(
        
        slivers: <Widget>[
          SliverAppBar(
              stretch: true,
              pinned: true,
              expandedHeight: 500,
              backgroundColor: Colors.grey,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  Provider.of<characters_web_services>(context)
                      .allcharacters[index]
                      .nickname,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontStyle: FontStyle.italic),
                  textAlign: TextAlign.center,
                ),
                background: Hero(
                  tag: index,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image(
                        width: double.infinity,
                        height: double.infinity,
                        image: NetworkImage(
                            Provider.of<characters_web_services>(context)
                                .allcharacters[index]
                                .img),
                        fit: BoxFit.cover),
                  ),
                ),
              )),
          SliverList(
              delegate: SliverChildListDelegate([
            Container(
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.fromLTRB(14, 14, 14, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Job : ${Provider.of<characters_web_services>(context).allcharacters[index].occupation.join('/')}",style: st,
                  overflow: TextOverflow.ellipsis,),
                  Divider(
                    thickness: 2,
                    color: Colors.red,
                  ),
                  Text("Birthday : ${Provider.of<characters_web_services>(context).allcharacters[index].birthday}",style: st,
                  overflow: TextOverflow.ellipsis,),
                  Divider(
                     thickness: 2,
                    color: Colors.red,
                  ),
                  Text("Appeared In : ${Provider.of<characters_web_services>(context).allcharacters[index].category}",style: st,
                  overflow: TextOverflow.ellipsis,),
                  Divider(
                     thickness: 2,
                    color: Colors.red,
                  ),
                  Text("Seasons  : ${Provider.of<characters_web_services>(context).allcharacters[index].appearance}",style: st,
                  overflow: TextOverflow.ellipsis,),
                  Divider(
                   thickness: 2,
                    color: Colors.red,
                  ),

                  Text("Status  : ${Provider.of<characters_web_services>(context).allcharacters[index].status}",style: st,
                  overflow: TextOverflow.ellipsis,),
                  Divider(
                    thickness: 2,
                    color: Colors.red,
                  )

                  ,
                  Text("Acror/Actress  : ${Provider.of<characters_web_services>(context).allcharacters[index].portrayed}",style: st,
                  overflow: TextOverflow.ellipsis,),
                  Divider(
                     thickness: 2,
                    color: Colors.red,
                  )
                ],
              ),
            ),
            SizedBox(height: 700,)
          ]))
        ],
      ),
    );
  }
}
