import 'package:flutter/material.dart';
import 'package:news_app/model/NewsResponse/Articles.dart';
import 'package:news_app/shared/components.dart';
import 'package:news_app/shared/web_view.dart';

class NewsDetailsScreen extends StatelessWidget {
  Articles article;
  NewsDetailsScreen(this.article , {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.fill,
          ),
        ),
        child:  Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      article.urlToImage??"",
                      width: double.infinity,
                      height: 250,
                      fit: BoxFit.fill,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    article.author??'',
                    style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 10),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    article.title??'',
                    style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        article.publishedAt??'',
                        style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 13),
                      ),
                    ],
                  ),
                  SizedBox(
                    height:
                    20,
                  ),
                  Text(
                    article.description??'',
                    style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(onPressed: (){
                        navigateTo(context, WebViewScreen(article.url));
                      }, child: Text(
                          'view full article' ,
                        style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 13),
                      )),
                    ],
                  )
                ],
          ),
        ),
      ),
    );;
  }
}
