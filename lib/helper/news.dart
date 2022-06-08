import 'dart:convert';

import 'package:news_app/models/article_model.dart';
import 'package:http/http.dart' as http;

class News{

  List<ArticleModel> news = [];

  Future<void> getNews() async{
    String url = "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=21cb8f5b70db45fcabaf50127b05d540";
    var response = await http.get(Uri.parse(url));

    var jsonData = jsonDecode(response.body);

    if(jsonData['status'] == "ok")
      {
        jsonData["articles"].forEach((element){

          String author, urlToImage, title, description, url, content;

          if(element['urlToImage'] == null)
            {
              urlToImage = "unknown";
            }
          else{
            urlToImage = element['urlToImage'];
          }

          if(element['author'] == null)
            {
              author = "Unknown";

            }
          else{
              author = element['author'];
          }

          if(element['title'] == null)
            {
              title = "Unknown";

            }
          else{
            title = element['title'];
          }

          if(element['description'] == null)
            {
              description = "Empty";
            }
          else
            {
              description = element['description'];
            }

          if(element['url'] == null)
          {
            url = "null";
          }
          else{
            url = element['url'];
          }

          if(element['content'] == null)
            {
              content = "Empty";
            }
          else{
            content = element["content"];
          }




              ArticleModel articleModel = ArticleModel(
                  author: author,
                title: title,
                description: description,
                url: url,
                urlToImage: urlToImage,
                container: content
              );

              news.add(articleModel);

        });
      }
  }


}

class CategoryNewsClass{

  List<ArticleModel> news = [];

  Future<void> getNews(String category) async{
    String url = "https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=21cb8f5b70db45fcabaf50127b05d540";
    var response = await http.get(Uri.parse(url));

    var jsonData = jsonDecode(response.body);

    if(jsonData['status'] == "ok")
    {
      jsonData["articles"].forEach((element){

        String author, urlToImage, title, description, url, content;

        if(element['urlToImage'] == null)
        {
          urlToImage = "unknown";
        }
        else{
          urlToImage = element['urlToImage'];
        }

        if(element['author'] == null)
        {
          author = "Unknown";

        }
        else{
          author = element['author'];
        }

        if(element['title'] == null)
        {
          title = "Unknown";

        }
        else{
          title = element['title'];
        }

        if(element['description'] == null)
        {
          description = "Empty";
        }
        else
        {
          description = element['description'];
        }

        if(element['url'] == null)
        {
          url = "null";
        }
        else{
          url = element['url'];
        }

        if(element['content'] == null)
        {
          content = "Empty";
        }
        else{
          content = element["content"];
        }


        ArticleModel articleModel = ArticleModel(
            author: author,
            title: title,
            description: description,
            url: url,
            urlToImage: urlToImage,
            container: content
        );

          news.add(articleModel);
        });
    }
  }


}