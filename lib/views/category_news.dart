import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/helper/news.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'article_view.dart';

class CategoryNews extends StatefulWidget {


  final String newsCategory;

  CategoryNews({required this.newsCategory});

  @override
  _CategoryNewsState createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {

  var newslist = [];
  bool _loading = false;

  @override
  void initState() {
    getNews();
    // TODO: implement initState
    super.initState();
  }

  void getNews() async {
    CategoryNewsClass news = CategoryNewsClass();
    await news.getNews(widget.newsCategory);
    newslist = news.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Day",
                style:
                TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
              ),
              Text(
                "News",
                style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
              )
            ],
          ),
          actions: <Widget>[
            Opacity(
              opacity: 0,
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Icon(Icons.share,)),
            )
          ],
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
      body: _loading ? Center(
        child: CircularProgressIndicator(),
      ) : SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            margin: EdgeInsets.only(top: 16),
            child: ListView.builder(
                itemCount: newslist.length,
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemBuilder: (context, index) {
                  return BlogTile(
                    imageUrl: newslist[index].urlToImage,
                    title: newslist[index].title,
                    desc: newslist[index].description,
                    url: newslist[index].url,
                  );
                }),
          ),
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
