import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:news_app/helper/data.dart';
import 'package:news_app/helper/news.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/models/categori_model.dart';
import 'package:news_app/views/category_news.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter/material.dart';

import 'article_view.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}
class _HomeState extends State<Home>{


  final BannerAd myBanner = BannerAd(
    adUnitId: 'ca-app-pub-2281074336539826/5432366170',
    size: AdSize.banner,
    request: AdRequest(),
    listener: BannerAdListener(),
  );

  final BannerAd myBanner1 = BannerAd(
    adUnitId: 'ca-app-pub-2281074336539826/2772551422',
    size: AdSize.banner,
    request: AdRequest(),
    listener: BannerAdListener(),
  );

  List<CategoryModel> categories = [];
  List<ArticleModel> articles = [];
  bool _loading = false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myBanner.load();
    myBanner1.load();
    categories = getCategories();
    getNews();
  }

  getNews() async{
    News newsClass = News();
    await newsClass.getNews();
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }


  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Day"),
            Text("News", style: TextStyle(
              color: Colors.blue
            ),)
          ],
        ),
        centerTitle: true,
        elevation: 0.0,
      ),

      body: _loading ? Center(
        child: Container(
          child: CircularProgressIndicator(),
        ),
      ) : SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: <Widget>[

              Container(

                height: 70,
                child : ListView.builder(
                    itemCount: categories.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index){
                      return CategoryTile(
                        imageUrl: categories[index].imageUrl,
                        categoryName: categories[index].categoryName,
                      );
                    }),
              ),

              Container(height: 50,
                  width: 320,
                  child: AdWidget(ad: myBanner1)),

              Container(
                padding: EdgeInsets.only(top: 16),
                child: ListView.builder(itemCount: articles.length, shrinkWrap: true, physics: ClampingScrollPhysics() ,itemBuilder: (context, index){
                  return BlogTile(
                    imageUrl: articles[index].urlToImage,
                    title: articles[index].title,
                    desc: articles[index].description,
                    url: articles[index].url,
                  );
                })
              ),
              Container(height: 50,
                width: 320,
                child: AdWidget(ad: myBanner))
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final String imageUrl, categoryName;

  CategoryTile({required this.imageUrl, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryNews(
          newsCategory: categoryName.toLowerCase(),
        )));

      },
      child: Container(
        margin: EdgeInsets.only(right: 16),
        child: Stack(
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: CachedNetworkImage(imageUrl: imageUrl, width: 120, height: 60, fit: BoxFit.cover,)),
            Container(
              alignment: Alignment.center,
              width: 120, height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.black26
                ),
              child: Text(categoryName, style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500
              ),),
            )

          ]
        ),
      ),
    );
  }
}

class BlogTile extends StatelessWidget {

  final String imageUrl, title, desc, url;
  BlogTile({required this.imageUrl, required this.title, required this.desc, required this.url});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => ArticleView(
            blogUrl: url
          )
        ));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        child: Column(
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.network(imageUrl)),
            SizedBox(height: 8,),
            Text(title, style: TextStyle(fontSize: 18, color: Colors.black87, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 8,),
            Text(desc, style: TextStyle(color: Colors.black54),)
          ],
        ),
      ),
    );
  }
}

