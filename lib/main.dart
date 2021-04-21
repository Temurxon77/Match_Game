import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kids_game/pages/mainPage.dart';
import 'package:kids_game/utils/constants.dart';
import 'package:kids_game/widgets/imageWidget.dart';

import 'models/ItemModel.dart';
void main() {
  runApp(MyApp());
  
}

enum DragState {
  isMatch,
  NoMatch,
  isTile
}

class MyApp extends StatelessWidget {
  @override
  build(BuildContext context){
    return MaterialApp(
      title: "Pride Match",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity
      ),
      home:  MainPage()
    );
  }
}

class Drag extends StatelessWidget {
final bool isDragging;
final ItemModel item;
final Function update;

  const Drag({Key key, this.isDragging,this.item,this.update}) : super(key: key);

@override
  Widget build(BuildContext context) {
    return Draggable<ItemModel>(
          data: item,
          child: DragTarget<ItemModel>(
            onAccept: (ItemModel recievedItem) {
              //print(recievedItem.name);
              if(recievedItem.name == item.name && recievedItem.level == item.level){
                print("Match!");
                //print(recievedItem.name);
                update(recievedItem,item,DragState.isMatch);
              } else {
                update(recievedItem,item,DragState.NoMatch);
              }
              
            },
            onWillAccept: (recievedItem) {
              recievedItem.accepting = true;
              return true;
            },
            builder: (ctx,item1,item2) => DragItem(imageName: item.imageName)
          ),
          feedback:  DragItem(imageName: item.imageName),
          childWhenDragging: SizedBox()
        
    );
  }
}
class DragItem extends StatelessWidget {
  final imageName;

  const DragItem({Key key, this.imageName}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Image.asset(imageName,height: 100,width: 100);
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  static List<ItemModel> items;
  // List<List<int>> Matrix2D;
  
  int score;
  bool gameOver;
  int maxTiles;
  bool isDragging = false;
  int pushedCounter; 
  
    @override
    void initState() { 
      SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
      super.initState();
      initGame();
    }
    void initGame() async {
      maxTiles = 9;
      pushedCounter = 10;
      gameOver = false;
      score=0;
      items = [
        ItemModel(value: animalsName[0],name: animalsName[0],imageName: animalsImg[0],level: 0,accepting: false),
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null
      ];
    }
    void pushing() {
      if(pushedCounter > 0){
        setState(() { pushedCounter--; });
      }
    }

    void update(ItemModel recievedItem,ItemModel dragItem,DragState state) {
      try{
        switch(state){
          case DragState.isMatch:
            if(dragItem.level < 10){
              dragItem.level++;
            }
              //dragItem = ItemModel(accepting: false,name: animalsName[animalLevel],value: animalsName[animalLevel],imageName: animalsImg[animalLevel]);
                setState(() { 
                score+=10;
                
                //recievedItem = ItemModel(accepting: false,name: animalsName[animalLevel],value: animalsName[animalLevel],imageName: animalsImg[animalLevel]);
                items[items.indexOf(dragItem)] = ItemModel(accepting: false,name: animalsName[dragItem.level],value: animalsName[dragItem.level],imageName: animalsImg[dragItem.level],level: dragItem.level);
                //items[items.indexOf(dragItem)].imageName = animalsImg[animalLevel];
                items[items.indexOf(recievedItem)] = null;
                });
            break;
          case DragState.NoMatch:
              setState(() {
                score-=5;
                dragItem.accepting =false;
              });
            break;
          case DragState.isTile:
            break;
        }
      }catch(err){
        print(err);
      }
    }

    Widget getItem(int index) {
      if(items[index] != null) {
        return Drag(isDragging: isDragging,item: items[index],update: update);
      }else {
        return  DragTarget<ItemModel>(
          onAccept: (recievedItem) {
            
            items[items.indexOf(recievedItem)] = null;
            items[index] = recievedItem;
            setState(() { });
          },
          onWillAccept: (recievedItem) {
            return true;
          },
          builder: (ctx,item1,item2) => SizedBox());
      }
    }
    @override
    Widget build(BuildContext context) {
      return SafeArea(child: Scaffold(
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: SizedBox(
          height: 90,
          width: 90,
          child: Padding(
          padding: const EdgeInsets.only(bottom: 20),  
          child:FloatingActionButton(
          hoverColor: ScoretextColor,
          onPressed: (){
            pushing();
              if(pushedCounter <= 0){
                int randomNum = Random().nextInt(8);
                if(items[randomNum] != null) {
                  return;
                }else {
                  // animalLevel = 0;
                  items[randomNum] = ItemModel(name:animalsName[0], value:animalsName[0],imageName: animalsImg[0],level: 0);
                }
                setState(() { pushedCounter = 10; });
            }
          },
          child: Image.asset(menuImg[12]))
        )),
        body: Container(
          padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(menuImg[0]),fit: BoxFit.cover)
            ),
            child: Column(
            children: <Widget>[
              Expanded(flex: 1,child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: MediaQuery.of(context).size.width*0.1,child: Image.asset(menuImg[7],fit: BoxFit.fitHeight)),
                  SizedBox(width: MediaQuery.of(context).size.width*0.75,child: Image.asset(menuImg[8],fit: BoxFit.fitWidth)),
                  SizedBox(width: MediaQuery.of(context).size.width*0.1,child: Image.asset(menuImg[5],fit: BoxFit.fitHeight))
                ]
              )),
              Expanded(flex: 14,child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                SizedBox(height: MediaQuery.of(context).size.height,width: 2.5,child: Image.asset(menuImg[4],fit: BoxFit.fitHeight)),
              SizedBox(
                width: MediaQuery.of(context).size.width*0.9,
                height: double.infinity,
                child:Column(children: [ Text("Score: ",style: TextStyle(color: scoreColor,fontSize: 24)),
               SizedBox(height: 10),
              Expanded(child: ImageWidget(
                child: Center(child: Text("$score Push: $pushedCounter",style: TextStyle(color: ScoretextColor,fontSize: 24))),
                height: 100.0,
                imageAsset: menuImg[9],
                width: MediaQuery.of(context).size.width*0.8,
              ),flex: 1),
              SizedBox(height: 30),
              Expanded(
                flex: 9,
                child: GridView.count(crossAxisCount: 3,
                    children: List.generate(maxTiles, (index) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage(menuImg[13]))
                    ),
                    margin: const EdgeInsets.all(8.0),
                    child: getItem(index)),growable: false)
                    )
                )]
                
                )),
                 SizedBox(height: double.infinity,width: 2.5,child: Image.asset(menuImg[4],fit: BoxFit.fitHeight)),
                ])),
              // Center(
              //   child: RaisedButton(
              //     textColor: Colors.white,
              //     color: Colors.pink,
              //     child: Text("New Game"),
              //     onPressed: ()
              //     {
              //       initGame();
              //       setState(() {
                      
              //       });
              //     },
              //   )
              // )
              Expanded(
                flex: 1,
                child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(width: MediaQuery.of(context).size.width*0.1,child: Image.asset(menuImg[3],fit: BoxFit.fitHeight)),
                  SizedBox(width: MediaQuery.of(context).size.width*0.75,child: Image.asset(menuImg[8],fit: BoxFit.fitWidth)),
                  SizedBox(width: MediaQuery.of(context).size.width*0.1,child: Image.asset(menuImg[6],fit: BoxFit.fitHeight))
                ]
              ))
            ]
          )
        )
        )
      );
    }
    @override
    void dispose(){
      super.dispose();
    }
  }

