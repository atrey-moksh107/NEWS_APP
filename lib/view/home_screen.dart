import 'package:api_project/models/news_channel_headlines_model.dart';
import 'package:api_project/view/categories_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart'; // Import the cached_network_image package

import '../models/categories_news_model.dart';
import '../view_model/news_view_model.dart';
import 'package:intl/intl.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}); // Fix the constructor syntax

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum FilterList { bbcNews, aryNews, independentNews, reutersNews,
  cnnNews, alJazeeraNews }

class _HomeScreenState extends State<HomeScreen> {

  NewsViewModel newsViewModel = NewsViewModel();

  FilterList? selectedMenu ;


  final format = DateFormat('MMMM dd, y'); // Use 'y' for the year

  String name = " " ;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width; // Use MediaQuery.of(context)
    final height = MediaQuery.of(context).size.height; // Use MediaQuery.of(context)

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => CategoriesScreen()) );
          },
          icon: Image.asset(
            'assets/images/cat.png',
            height: 30,
            width: 30,
          ),
        ),
        title: Center(
          child: Text(
              'News',
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.w700,color: Colors.black,
              ),
          ),
        ),
        actions: [
          PopupMenuButton<FilterList>(
            initialValue: selectedMenu,
              icon: Icon(Icons.more_vert, color: Colors.black,),
              onSelected: (FilterList item){
              if(FilterList.bbcNews.name ==item.name){
                name = 'bbc-news';
              }
              if(FilterList.aryNews.name ==item.name){
                name = 'Ary-news';
              }
              if(FilterList.independentNews.name ==item.name){
                name = 'independent-news';
              }
              if(FilterList.reutersNews.name ==item.name){
                name = 'reuters-news';
              }
              if(FilterList.cnnNews.name ==item.name){
                name = 'cnn-news';
              }
              if(FilterList.alJazeeraNews.name ==item.name){
                name = 'al-Jazeera-news';
              }

              setState(() {
             selectedMenu = item;
              });
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<FilterList>> [
                PopupMenuItem<FilterList>(
                  value: FilterList.bbcNews,
                  child: Text('BBC News'),
                ),
                PopupMenuItem<FilterList>(
                  value: FilterList.aryNews,
                  child: Text('ary News'),
                ),
                PopupMenuItem<FilterList>(
                  value: FilterList.independentNews,
                  child: Text('independent News'),
                ),
                PopupMenuItem<FilterList>(
                  value: FilterList.reutersNews,
                  child: Text('reuters News'),
                ),
                PopupMenuItem<FilterList>(
                  value: FilterList.cnnNews,
                  child: Text('cnn News'),
                ),
                PopupMenuItem<FilterList>(
                  value: FilterList.alJazeeraNews,
                  child: Text('Al-Jazeera News'),
                )
              ]
          )

        ],
      ),
      body: ListView(
        children: [
          SizedBox(
            height: height * .55,
            width: width,
            child: FutureBuilder<NewsChannelsHeadlinesModel>(
              future: newsViewModel.fetchNewsChannelHeadlinesApi(name),
              builder: (BuildContext context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: SpinKitCircle(
                      color: Colors.blue,
                      size: 50,
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.articlesList!.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {


                      DateTime dateTime = DateTime.parse(snapshot.data!.articlesList!
                          [index].publishedAt.toString());
                      return SizedBox(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              height: height * 0.6,
                              width: width * .9,
                              padding: EdgeInsets.symmetric(
                                horizontal: height * .02
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: CachedNetworkImage(
                                  imageUrl: snapshot.data!.articlesList![index].urlToImage.toString(),
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Container(
                                    child: spinKit2,
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error_outline, color: Colors.red),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 20,
                              child: Card(
                                elevation: 5,
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),

                                ),
                                child: Container(
                                  alignment: Alignment.bottomCenter,
                                  padding: EdgeInsets.all(15),
                                  height: height * 0.22,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: width * 0.7,
                                        child: Text(
                                          snapshot.data!.articlesList![index].title.toString()
                                          ,maxLines: 2,overflow: TextOverflow.ellipsis
                                          ,style:
                                        GoogleFonts.poppins(fontSize: 17 , fontWeight: FontWeight.w600),
                                        )
                                      ),
                                      Spacer(),
                                      Container(
                                        width: width * 0.7,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              snapshot.data!.articlesList![index].source!.name.toString()
                                              ,maxLines: 2,overflow: TextOverflow.ellipsis
                                              ,style:
                                            GoogleFonts.poppins(fontSize: 17 , fontWeight: FontWeight.w600),
                                            ),
                                            Text(
                                              format.format(dateTime)
                                              ,maxLines: 2,overflow: TextOverflow.ellipsis
                                              ,style:
                                            GoogleFonts.poppins(fontSize: 13 , fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                      )

                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: FutureBuilder<CategoriesNewsModel>(
              future: newsViewModel.fetchCategoriesNewsApi('General'),
              builder: (BuildContext context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: SpinKitCircle(
                      color: Colors.blue,
                      size: 50,
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.articles!.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {


                      DateTime dateTime = DateTime.parse(
                          snapshot.data!.articles!
                          [index].publishedAt.toString());
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: CachedNetworkImage(
                                imageUrl: snapshot.data!.articles![index].urlToImage.toString(),
                                fit: BoxFit.cover,
                                height: height * .18,
                                width: width * .3,
                                placeholder: (context, url) => Container(
                                  child: Center(
                                    child: SpinKitCircle(
                                      color: Colors.blue,
                                      size: 50,
                                    ),
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error_outline, color: Colors.red),
                              ),
                            ),
                            Expanded(
                                child: Container(
                                  height: height * .18,
                                  padding: EdgeInsets.only(left: 15),
                                  child: Column(
                                    children: [
                                      Text(snapshot.data!.articles![index].source!.name.toString(),
                                        maxLines: 3,
                                        style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w600
                                        ),
                                      ),
                                      Spacer(),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(format.format(dateTime),
                                            maxLines: 3,
                                            style: GoogleFonts.poppins(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ))
                          ],

                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      )

    );
  }
}

const spinKit2 = SpinKitCircle(
  color: Colors.amber,
  size: 50,
);
