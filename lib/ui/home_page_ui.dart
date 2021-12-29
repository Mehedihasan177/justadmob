import 'package:flutter_mobile_vision/flutter_mobile_vision.dart';

import 'package:justadmob/admob_services.dart';
import 'package:justadmob/consumable_storee.dart';



import '../app_parchuses.dart';
import 'read_page_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'package:translator/translator.dart';
import 'dart:io';


class HomePageUI extends StatefulWidget {
  const HomePageUI({Key key}) : super(key: key);

  @override
  _HomePageUIState createState() => _HomePageUIState();
}

String currentFontName = 'Roboto';
List<String> fontListNames = ['Roboto', 'Monospace', 'Courier',];

class _HomePageUIState extends State<HomePageUI> {

  final translator = GoogleTranslator();
  String input = "hello brother";





  List<String> allStringsI = [
    'Scan',
    'Upload',
    'Read',
    'words per minute',
    'Text Size',
    'Color',
    'Font Color',
    'Font Family',
    'Purchase Ad Free',
    'Select a color',
    'To start type or paste any text',
  ];
  List<String> allStrings = [
    'Scan',
    'Upload',
    'Read',
    'words per minute',
    'Text Size',
    'Color',
    'Font Color',
    'Font Family',
    'Purchase Ad Free',
    'Select a color',
    'To start type or paste any text',
  ];


  TextEditingController textFieldController = new TextEditingController(text: 'Hello');
  double wpmSvalue = 60;
  double sizeSvalue = 20;

  bool _scanning = false;
  String _extractText = '';
  File _pickedImage;

  bool sValue = false;
  bool stValue = false;

  List<String> _consumables = [];


  bool isInitilized = false;
  @override
  void initState() {
    FlutterMobileVision.start().then((value) {
      isInitilized = true;
    });
    fetchpurchased();
    super.initState();
  }

  _startScan() async {
    List<OcrText> list = List();

    try {
      // list = await FlutterMobileVision.read(
      //   waitTap: true,
      //   fps: 5,
      //   multiple: true,
      // );


      textFieldController.text = '';
      for (OcrText text in list) {
        print('valueis ${text.value}');
        setState(() {
          textFieldController.text += text.value+' ';
        });
      }
    } catch (e) {}
  }


  @override
  Widget build(BuildContext context) {

    print("consumables are:   ");
    print(_consumables);
    print(_consumables.length);
    return Scaffold(
      endDrawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              onTap: (){
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(allStrings[9]),
                      content: SingleChildScrollView(
                        child: BlockPicker(
                          pickerColor: currentColor,
                          onColorChanged: changeColor,
                        ),
                      ),
                    );
                  },
                );
              },
              leading:Icon(Icons.color_lens_outlined,color: currentColor,),
              title: Text(allStrings[5],style: TextStyle(color: currentColor,fontFamily: currentFontName),),
              trailing: Icon(Icons.circle,color: currentColor,),
            ),
            Divider(color: currentColor,height: 2,),

            ListTile(
              onTap: (){
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(allStrings[9]),
                      content: SingleChildScrollView(
                        child: ColorPicker(
                          pickerColor: currentColorF,
                          onColorChanged: changeColorF,
                          colorPickerWidth: 300.0,
                          pickerAreaHeightPercent: 0.7,
                          enableAlpha: true,
                          displayThumbColor: true,
                          showLabel: true,
                          paletteType: PaletteType.hsv,
                          pickerAreaBorderRadius: const BorderRadius.only(
                            topLeft: const Radius.circular(2.0),
                            topRight: const Radius.circular(2.0),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
              leading:Icon(Icons.color_lens_outlined,color: currentColor,),
              title: Text(allStrings[6],style: TextStyle(color: currentColor,fontFamily: currentFontName),),
              trailing: Icon(Icons.circle,color: currentColorF,),
            ),
            Divider(color: currentColor,height: 2,),

            ListTile(
              onTap: (){

              },
              leading:Icon(Icons.font_download_outlined,color: currentColor,),
              title: Text(allStrings[7],style: TextStyle(color: currentColor,fontFamily: currentFontName),),
              trailing: DropdownButton<String>(
                hint: Text(currentFontName,style: TextStyle(color: currentColor,fontFamily: currentFontName),),
                items: fontListNames.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value,style: TextStyle(color: currentColor),),
                  );
                }).toList(),
                onChanged: (_) {
                  setState(() {
                    currentFontName = _;
                  });
                },
              ),
            ),
            Divider(color: currentColor,height: 2,),

            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("English",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,fontFamily: currentFontName,color: currentColorF),),
                  Switch(value: stValue, onChanged: onChangedSwitchSt, activeColor: currentColor,),
                  Text("Dutch",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,fontFamily: currentFontName,color: currentColorF),),
                ],
              ),
            ),


            Divider(color: currentColor,height: 2,),

            ListTile(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AppPurchuses()),
                );
              },
              leading:Icon(Icons.done_all,color: currentColor,),

              title: Text(allStrings[8],style: TextStyle(color: currentColor,fontFamily: currentFontName),),

            ),
            Divider(color: currentColor,height: 2,),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Scready',style: TextStyle(fontFamily: currentFontName),),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  // const Color(0xFF52C6F5),
                  // const Color(0xFF5FB5CE),
                  currentColor.withOpacity(1),
                  currentColor.withOpacity(0.8),
                  // const Color(0xFFE8F7F8),
                ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
        ),
        actions: [

        ],
      ),
      body: homePageWidgets(),
    );
  }

  Widget homePageWidgets() {
    return Container(
      child: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(15),
            // color: Color(0xfff5f5f5),
            height: 200,
            // width: 500,
            child: TextFormField(
              style: TextStyle(fontFamily: currentFontName),
              keyboardType: TextInputType.multiline,
              maxLines: null,
              expands: true,
              controller: textFieldController,
              textAlignVertical: TextAlignVertical.top,
              decoration: InputDecoration(
                labelText: allStrings[10],
                alignLabelWithHint: true,
                labelStyle: TextStyle(
                  fontSize: 15,
                  color: Colors.black.withOpacity(0.6),
                ),
                border: OutlineInputBorder(
                  borderSide:
                  BorderSide(color: Colors.black, width: 2.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),

                focusedBorder: OutlineInputBorder(
                  borderSide:
                  BorderSide(color: Colors.black, width: 2.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),

          ),

          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("English",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,fontFamily: currentFontName,color: currentColorF),),
                Switch(value: sValue, onChanged: onChangedSwitch, activeColor: currentColor,),
                Text("Dutch",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,fontFamily: currentFontName,color: currentColorF),),
              ],
            ),
          ),

          Row(
            children: [
              SizedBox(width: 5,),
              Expanded(
                child: MaterialButton(
                  onPressed: _startScan,
                  color: Colors.white,
                  padding: EdgeInsets.all(10.0),
                  child: Column( // Replace with a Row for horizontal icon + text
                    children: <Widget>[
                      Icon(Icons.camera_alt_outlined),
                      Text(allStrings[0],style: TextStyle(fontFamily: currentFontName),)
                    ],
                  ),
                ),
              ),
              SizedBox(width: 5,),
              // Expanded(
              //   child: MaterialButton(
              //     onPressed: () async {
              //       setState(() {
              //         _scanning = true;
              //       });
              //       // _pickedImage =
              //       //     (await ImagePicker.pickImage(source: ImageSource.gallery)) as File;
              //       // _extractText =
              //       //     await TesseractOcr.extractText(_pickedImage.path).then((value) {
              //       //       setState(() {
              //       //         textFieldController.text = value;
              //       //       });
              //       //     });
              //       setState(() {
              //         _scanning = false;
              //       });
              //     },
              //     color: Colors.white,
              //     padding: EdgeInsets.all(10.0),
              //     child: Column( // Replace with a Row for horizontal icon + text
              //       children: <Widget>[
              //         Icon(Icons.cloud_upload_outlined),
              //         Text(allStrings[1],style: TextStyle(fontFamily: currentFontName))
              //       ],
              //     ),
              //   ),
              // ),
              SizedBox(width: 5,),
              Expanded(
                child: MaterialButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ReadPageUI(
                        string: textFieldController.text,wpmSvalue: wpmSvalue.toInt(),textSize: sizeSvalue,currentColor:currentColor,currentColorF:currentColorF,cfn: currentFontName,
                    )), );
                  },
                  color: Colors.white,
                  padding: EdgeInsets.all(10.0),
                  child: Column( // Replace with a Row for horizontal icon + text
                    children: <Widget>[
                      Icon(Icons.view_carousel_outlined),
                      Text(allStrings[2],style: TextStyle(fontFamily: currentFontName))
                    ],
                  ),
                ),
              ),
              SizedBox(width: 5,),
            ],
          ),

          SizedBox(height: 20,),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 20),
            child: Text(
              "${wpmSvalue.round().toString()} ${allStrings[3]}".replaceAll('.0', ''),
              style: TextStyle(fontSize: 15,fontFamily: currentFontName,color: currentColorF),
            ),
          ),

          // SizedBox(height: 10,),
          SliderTheme(
            data: SliderThemeData(
                trackHeight: 0.1
            ),
            child: Slider(
              value: wpmSvalue,
              min: 20,
              max: 400,
              inactiveColor: Colors.grey,
              activeColor: Colors.black,
              divisions: 60,
              label: wpmSvalue.round().toString(),
              onChanged: (wpmSvalue) =>
                  setState(() => this.wpmSvalue = wpmSvalue),
            ),
          ),



          SizedBox(height: 0,),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 20),
            child: Text(
              "${allStrings[4]} ${sizeSvalue.round().toString()}".replaceAll('.0', ''),
              style: TextStyle(fontSize: 15,fontFamily: currentFontName,color: currentColorF),
            ),
          ),

          // SizedBox(height: 10,),
          SliderTheme(
            data: SliderThemeData(
                trackHeight: 0.1
            ),
            child: Slider(
              value: sizeSvalue,
              min: 10,
              max: 100,
              inactiveColor: Colors.grey,
              activeColor: Colors.black,
              divisions: 6,
              label: sizeSvalue.round().toString(),
              onChanged: (sizeSvalue) =>
                  setState(() => this.sizeSvalue = sizeSvalue),
            ),
          ),

          _pickedImage == null
              ? Container(
          ):
          Container(
            child: Image.file(_pickedImage),
          ),

              _consumables.length != 0 ? Container() : Container(
                height: 100,
                color: Colors.red,
                child: AdmobServices(),
              ),
          Container(
            // height: 30,
            // width: 30,
            child: Image.asset("assets/scready/2.png"),
          ),
        ],
      ),
    );
  }
  bool lightTheme = true;
  Color currentColor = Colors.blueAccent;
  Color currentColorF = Colors.black;
  void changeColor(Color color) => setState(() => currentColor = color);
  void changeColorF(Color color) => setState(() => currentColorF = color);
  void changeColors(List<Color> colors) =>
      setState(() => currentColors = colors);
  List<Color> currentColors = [Colors.blueAccent, Colors.blue];

  Future<void> onChangedSwitchSt(bool value) async {


      input = textFieldController.text;
      print(input);
      stValue = !stValue;



      if(stValue==false){
        print('English is selected');


        for(int i=0; i<allStringsI.length; i++){
          setState(() {
            allStrings[i] = allStringsI[i];
          });
        }


      }else{
        print("Dutch is selected");

        for(int i=0; i<allStrings.length; i++){
          var translation2 = await translator
              .translate(allStrings[i], from: 'en', to: 'nl').then((value) {
            setState(() {
              print(value);
              allStrings[i] = value.text;
            });
          });
        }

      }

  }


  Future<void> onChangedSwitch(bool value) async {


    input = textFieldController.text;
    print(input);
    sValue = !sValue;



    if(sValue==false){
      print('English is selected');
      var translation = await translator
          .translate(input, from: 'nl', to: 'en').then((value) {
        setState(() {
          print(value);
          textFieldController.text = value.text;
          textFieldController.selection = TextSelection.fromPosition(TextPosition(offset: textFieldController.text.length));
        });
      });




    }else{
      print("Dutch is selected");
      var translation = await translator
          .translate(input, from: 'en', to: 'nl').then((value) {
        setState(() {
          print(value);
          textFieldController.text = value.text;
          textFieldController.selection = TextSelection.fromPosition(TextPosition(offset: textFieldController.text.length));
        });
      });
      print(translation);



    }

  }


  void fetchpurchased() async{
    final List<String> consumables = await ConsumableStore.load();
    setState(() {
      _consumables = consumables;
      print("hello");
    });
  }
}
