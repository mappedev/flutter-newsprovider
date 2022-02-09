import 'package:flutter/material.dart';
import 'package:news_provider/config/theme.dart' show myTheme;
import 'package:news_provider/models/models.dart' show Article;

class ListNews extends StatelessWidget {
  const ListNews(this.listNews, {Key? key}) : super(key: key);

  final List<Article> listNews;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: listNews.length,
      itemBuilder: (BuildContext context, int index) {
        return _News(news: listNews[index], index: index);
      },
    );
  }
}

class _News extends StatelessWidget {
  const _News({
    required this.news,
    required this.index,
    Key? key,
  }) : super(key: key);

  final Article news;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        _CardTopBar(sourceName: news.source.name, index: index),
        const SizedBox(height: 10),
        _CardTitle(news.title),
        const SizedBox(height: 10),
        _CardImage(news.urlToImage ?? ''),
        const SizedBox(height: 10),
        _CardBody(news.description ?? ''),
        const SizedBox(height: 10),
        const _CardButtons(),
        const SizedBox(height: 20),
        const Divider(),
      ],
    );
  }
}

class _CardTopBar extends StatelessWidget {
  const _CardTopBar({
    required this.sourceName,
    required this.index,
    Key? key,
  }) : super(key: key);

  final String sourceName;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Text(
            '${index + 1}. ',
            style: TextStyle(
              color: myTheme.colorScheme.secondary,
              fontSize: 16,
            ),
          ),
          Text(
            '$sourceName. ',
            style: const TextStyle(fontSize: 16),
          )
        ],
      ),
    );
  }
}

class _CardTitle extends StatelessWidget {
  const _CardTitle(this.title, {Key? key}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _CardImage extends StatelessWidget {
  const _CardImage(this.newsUrlImage, {Key? key}) : super(key: key);

  final String newsUrlImage;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(50),
        bottomRight: Radius.circular(50),
      ),
      child: (newsUrlImage.isNotEmpty)
          ? FadeInImage.assetNetwork(
              placeholder: 'assets/img/giphy.gif',
              image: newsUrlImage,
              width: double.infinity,
              fit: BoxFit.cover,
            )
          : Image.asset('assets/img/no-image.png'),
    );
  }
}

class _CardBody extends StatelessWidget {
  const _CardBody(this.description, {Key? key}) : super(key: key);

  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Text(description),
    );
  }
}

class _CardButtons extends StatelessWidget {
  const _CardButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RawMaterialButton(
          onPressed: () {},
          fillColor: myTheme.colorScheme.secondary,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: const Icon(Icons.star_border),
        ),
        const SizedBox(width: 10),
        RawMaterialButton(
          onPressed: () {},
          fillColor: Colors.blue,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: const Icon(Icons.more),
        )
      ],
    );
  }
}
