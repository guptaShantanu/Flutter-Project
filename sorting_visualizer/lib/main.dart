import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_beep/flutter_beep.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  List stickData = [];
  List snapShots=[];
  List colorSnapshot = [];
  int stop = 0;
  int algoIndex=0;


  void swapStick(int a, int b){
    setState(() {
      var temp = stickData[a];
      stickData[a]=stickData[b];
      stickData[b]=temp;
      stickData[a]['color']=1;
      stickData[b]['color']=1;
    });
    Future.delayed(Duration(milliseconds: 200),(){
      setState(() {
        stickData[a]['color']=0;
        stickData[b]['color']=0;
      });
    });
  }



  void changeColor(int target)async{
    setState(() {
      stickData[target]['color']=1;
    });
//    FlutterBeep.beep();
    Future.delayed(Duration(milliseconds: 10),(){
      setState(() {
        stickData[target]['color']=0;
      });
    });
  }

//    Inserion sort algorithm
  void insertionSort()async{
      for(int i=1;i<stickData.length;i++){
        double key = stickData[i]['value'];
        int j=i-1;
        while(j>=0 && stickData[j]['value']>key){
          stickData[j+1]['value']=stickData[j]['value'];
          changeColor(j+1);
//          changeColor(j);
          await Future.delayed(Duration(milliseconds: 10),(){stop=1;});

          j=j-1;
        }
        stickData[j+1]['value']=key;
      }
  }

//    Bubble sort algorithm
  void bubbleSort()async{
    for(int i=0;i<stickData.length;i++){
      for(int j=0;j<stickData.length-i-1;j++){
        changeColor(j);
//        await Future.delayed(Duration(milliseconds: 5),(){stop=1;});
        if(stickData[j]['value']>stickData[j+1]['value']){
          setState(() {
            var temp = stickData[j];
            stickData[j]=stickData[j+1];
            stickData[j+1]=temp;
          });
          changeColor(j);
          changeColor(j+1);
          await Future.delayed(Duration(milliseconds:10 ),(){stop=1;});
        }
      }
    }
  }

//  Selection sort algorithm
  void selectionSort()async{
      for(int i =0 ;i<stickData.length;i++){
        double min = stickData[i]['value'];
        int loc = i;
        for(int j=i+1;j<stickData.length;j++){
          changeColor(j);
          await Future.delayed(Duration(milliseconds: 10),(){stop=1;});
          if(stickData[j]['value']<min){
            min = stickData[j]['value'];
            loc=j;
          }
        }
        if (loc!=i) {
          var temp = stickData[i];
          stickData[i]=stickData[loc];
          stickData[loc]=temp;
//          changeColor(i);
//          changeColor(loc);
//
//          await Future.delayed(Duration(milliseconds: 10),(){stop=1;});
        }
      }
  }

// Mergesort algorithm
  void mergeSort(int low,int high)async{
    int mid;
    if(low<high){
      mid = ((low + high)/2).toInt();
      mergeSort(low, mid);
      mergeSort(mid+1, high);
      merge(low,mid,high);

    }

  }


  void merge(int low,int mid,int high)async{
    print("data $low $mid $high");
    List leftList=[],rightList=[];
    int left,right,k=0;
    left = mid-low+1;
    right = high-mid;
    int count=0;

    for(int i=low;i<=mid;i++){
      leftList.add(stickData[i]);
    }
    for(int i=mid+1;i<=high;i++){
      rightList.add(stickData[i]);
    }
//    print(rightList);
    int i=0,j=0;
    k=low;

    while(i<left && j<right){

      if(leftList[i]['value']<rightList[j]['value']){
        stickData[k]=leftList[i];
        i+=1;
        k+=1;
      }else{
        stickData[k]=rightList[j];
        j+=1;
        k+=1;
      }
      snapShots.add(new List.from(stickData));
      colorSnapshot.add(k-1);

    }
    while(i<left){
      stickData[k]=leftList[i];
      i+=1;
      k+=1;
      snapShots.add(new List.from(stickData));
      colorSnapshot.add(k-1);


    }
    while(j<right){
      stickData[k]=rightList[j];
      j+=1;
      k+=1;
      snapShots.add(new List.from(stickData));
      colorSnapshot.add(k-1);
    }

  }


//  Quick sort algorithm
  void quickSort(int low, int high)async{
    if(low<high){
      int p =await  partition(low,high);
      quickSort(low, p-1);
      quickSort(p+1, high);
    }
  }

  Future<int> partition(int low, int high) async {
    double pivot = stickData[high]['value'];
    int i = low-1;
    for(int j=low;j<=high;j++){
      changeColor(j);
      await Future.delayed(Duration(milliseconds: 20));
      if(stickData[j]['value']<pivot){
        i++;
        var temp = stickData[i];
        stickData[i]=stickData[j];
        stickData[j]=temp;

      }
    }
    var temp = stickData[i+1];
    stickData[i+1]=stickData[high];
    stickData[high]=temp;

    return i+1;

  }




  void prepareSticks(){
    for(int i=0;i<=50;i++){
      stickData.add({'value':Random().nextInt(200).toDouble(),'color':0});
    }
  }

  void resetList(){
    stickData=[];
    for(int i=0;i<=50;i++){
      stickData.add({'value':Random().nextInt(200).toDouble(),'color':0});
    }
    setState(() {
      stickData=stickData;
    });
  }

  List<Widget> getSticks(stickData_){
    List<Widget>  stickList = [];
    for(int i=0;i<stickData_.length;i++){
      stickList.add(Expanded(
        flex: 1,
        child: Container(
          height: stickData_[i]['value'],
          margin: EdgeInsets.all(2.0),
          color: stickData_[i]['color']==0?Colors.blueGrey:Colors.red,
        ),
      ));
    }
    return stickList;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    prepareSticks();

  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  height: 150.0,
                  width: double.infinity,

                  decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    boxShadow: [BoxShadow(blurRadius: 5.0,color: Colors.blueGrey.shade700,offset: Offset(-3,3))]
                  ),
                  alignment: Alignment.center,
                  child: Text('Sorting Visualizer',textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 50.0),),
                ),
                Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: getSticks(stickData)
                  ),
                ),
                SizedBox(height: 50.0,),
                Container(
                  height: 100.0,
                  width: 200.0,
                  child: CupertinoPicker(
                    itemExtent: 40,
                    children: <Widget>[
                      Text('Selection Sort',style: TextStyle(fontWeight: FontWeight.w900),),
                      Text('Insertion Sort',style: TextStyle(fontWeight: FontWeight.w900),),
                      Text('Bubble Sort',style: TextStyle(fontWeight: FontWeight.w900),),
                      Text('Merge Sort',style: TextStyle(fontWeight: FontWeight.w900),),
                      Text('Quick Sort',style: TextStyle(fontWeight: FontWeight.w900),),
                    ],
                    onSelectedItemChanged: (sfad){
                      algoIndex = sfad;
                      print(sfad);
                    },
                  ),
                ),
                SizedBox(height: 50.0,),
                RaisedButton(
                  color: Colors.blueGrey,
                  child: Text('Start',style: TextStyle(color: Colors.white),),
                  onPressed: ()async{
                    if(algoIndex==0){
                      await selectionSort();
                    }else if(algoIndex==1){
                      await insertionSort();
                    }else if(algoIndex==2){
                      await bubbleSort();
                    }else if(algoIndex==3){
                      mergeSort(0,50);
//                    snapShots[snapShots.length-1][6]['color']=1;
                      for(int i=0;i<snapShots.length;i++){

//                    print(colorSnapshot[i]);
                        await Future.delayed(Duration(milliseconds: 20),(){
                          setState(() {
                            stickData = snapShots[i];
                            stickData[colorSnapshot[i]]['color']=1;
                          });
                        });
                      }
                      snapShots = [];
                    }else if(algoIndex==4){
                      quickSort(0,50);
                      await Future.delayed(Duration(seconds: 1),(){
                        setState(() {
                          stickData=stickData;
                        });
                      });
                    }

                  },
                ),
                RaisedButton(
                  color: Colors.blueGrey,
                  child: Text('Reset',style: TextStyle(color: Colors.white),),
                  onPressed: (){
                     resetList();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
