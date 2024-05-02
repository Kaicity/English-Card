import 'dart:math';

import 'package:english_card_app/models/english_today.dart';
import 'package:english_card_app/packages/quote/qoute_model.dart';
import 'package:english_card_app/packages/quote/quote.dart';
import 'package:english_card_app/values/app_assets.dart';
import 'package:english_card_app/values/app_colors.dart';
import 'package:english_card_app/values/app_styles.dart';
import 'package:english_card_app/widgets/app_button.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Tao 2 gia tri de khi vuot template giua thi indicator chay theo
  int _currentIndex = 0;
  late PageController _pageController;

  //Mot gia tri toan cuc random cho quotes
  String quoteStatus = Quotes().getRandom().content!;

  //Data English luu vao danh sach
  List<EnglishToday> words = [];

  //Tao function random cac gia tri data trong List khong duoc trung nhau
  List<int>  fixedListRandom({int len = 1, int max = 120, int min = 1}){
    if(len > max || len < min)
      return [];

    List<int> newList = [];
    Random random = Random();
    int count  = 1;

    while(count <= len){
      int val = random.nextInt(max);
      if(newList.contains(val)){
        continue;
      }
      else{
        newList.add(val);
        count++;
      }
    }

    return newList;
  }

  //Lay cac tri ra tai vi tri index trong package
  getEnglishToday(){
    List<String> newList = [];
    List<int> rans = fixedListRandom(len: 5, max: nouns.length);
    rans.forEach((index) {
      newList.add(nouns[index]);
    });

    words = newList.map((e) => getQuote(e)).toList();
  }

  EnglishToday getQuote(String noun){
    Quote? quote;
    quote = Quotes().getByWord(noun);

    return EnglishToday(
      noun: noun,
      quote: quote?.content,
      id: quote?.id
    );
  }

  final GlobalKey<ScaffoldState> _scaffoldKey  = new GlobalKey<ScaffoldState>();

  //Khi ung dung start thi ham initState se thay doi va do du lieu vao widget
  @override
  void initState() {
    // TODO: implement initState
    _pageController = PageController(viewportFraction: 0.9);
    getEnglishToday();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //Canh chinh cac kich thuoc widget body
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.secondColor,
      appBar: AppBar(
        backgroundColor: AppColors.secondColor,
        elevation: 0,
        title: Text(
          'English today',
          style: AppStyle.h3.copyWith(color: AppColors.textColor, fontSize: 36),
        ),
        leading: InkWell(
          onTap: () {
            _scaffoldKey.currentState?.openDrawer();
          },
          child: Image.asset(AppAssets.menu),
        ),
      ),

      body: Container(
        width: double.infinity, 
        child: Column(
          children: [
            Container(
                height: size.height * 1 / 10,
                padding: const EdgeInsets.symmetric(horizontal:  24),
                alignment: Alignment.centerLeft,
                child: Text(
                  '"$quoteStatus"',
                  style: AppStyle.h5
                      .copyWith(color: AppColors.textColor, fontSize: 12),
                )),
            Container(
              height: size.height * 2 / 3,
              child: PageView.builder(
                  //Xu ly su kien khi vuot page thi Indicator chuyen dong theo
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  itemCount: words.length,
                  itemBuilder: (context, index) {

                    //Lay ra ky tu dau tien cua word
                    String firstLetter = words[index].noun != null ? words[index].noun! : '';
                    firstLetter = firstLetter.substring(0, 1);

                    //Lay ra ky tu con lai sau ky tu dau tien cua word
                    String rightLetter = words[index].noun != null ? words[index].noun! : '';
                    rightLetter = rightLetter.substring(1, rightLetter.length);

                    //Lay ra cau quote cua word
                    String wordDefauld =  'Think of on the beauty still left around you and be happy'; //Mac dinh

                    //Lay ra qoute neu co
                    String quote = words[index].quote != null ? words[index].quote! : wordDefauld;


                    //Render view qua lai
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                offset: Offset(3, 6),
                                blurRadius: 6
                              )
                            ],
                            borderRadius: BorderRadius.all(Radius.circular(24))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              alignment: Alignment.centerRight,
                              child: Image.asset(AppAssets.heart),
                            ),
                            Container(
                              child: RichText(
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.start,
                                  text: TextSpan(
                                      text: firstLetter, // ki tu dau tien
                                      style: TextStyle(
                                        fontFamily: FontFamily.sen,
                                        fontSize: 82,
                                        fontWeight: FontWeight.bold,
                                        shadows: [
                                          BoxShadow(
                                              color: Colors.black38,
                                              offset: Offset(3, 6),
                                              blurRadius: 6)
                                        ],
                                      ),
                                      children: [
                                        TextSpan(
                                          text: rightLetter, // ki tu sau cung ki tu dau tien
                                          style: TextStyle(
                                              fontFamily: FontFamily.sen,
                                              fontSize: 50,
                                              fontWeight: FontWeight.bold,
                                              shadows: [
                                                BoxShadow(
                                                    color: Colors.black38,
                                                    offset: Offset(3, 6),
                                                    blurRadius: 6)
                                              ]),
                                        )
                                      ])),
                              padding: EdgeInsets.all(8),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                              '"$quote"',
                                style: AppStyle.h4.copyWith(letterSpacing: 1, color: AppColors.textColor),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            ),

            //Ve Indicator cho thanh keo cac widget voi nhau
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SizedBox(
                  height: size.height * 1 / 13,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    alignment: Alignment.center,
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics() ,
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return buildIndicator(index == _currentIndex, size);
                      },
                    ),
                  )),
            )
          ],
        ),
      ),


      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        onPressed: () {
          setState(() {
            //Reload word
            getEnglishToday();
          });
        },
        child: Image.asset(AppAssets.exchange),
      ),

      //Thiet ke mot draw menu control ben trai khi nguoi dung click action Inwell
      drawer: Drawer(
        child: Container(
          color: AppColors.lighBlue,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 24, left: 16),
                child: Text('Your mind', style: AppStyle.h3.copyWith(color: AppColors.textColor),),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: AppButton(label: 'Favorites', onTap: () {
                  print('Your select Favorites');
                }),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: AppButton(label: 'Your control', onTap: () {
                  print('Your select Your control');
                }),
              )
            ],
          ),
        ),
      ),

    );
  }

  Widget buildIndicator(bool isActive, Size size) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      height: 12,
      //Dieu kien neu isActive = true
      width: isActive ? size.width * 1 / 5 : 24,
      decoration: BoxDecoration(
          color: isActive
              ? AppColors.lighBlue
              : AppColors.lightGrey, //Neu la isActive thi mau lighBlue ( if/ else)
          borderRadius: BorderRadius.all(Radius.circular(12)),
          boxShadow: [
            BoxShadow(
                color: Colors.black38, offset: Offset(2, 3), blurRadius: 3)
          ]),
    );
  }

}
