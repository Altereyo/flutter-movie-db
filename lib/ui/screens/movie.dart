import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_movie_db/ui/theme/app_colors.dart';
import 'package:flutter_movie_db/data/models/movie.dart';
import 'package:get/get.dart';

class MovieScreen extends StatelessWidget {
  MovieScreen({Key? key}) : super(key: key);
  final Movie movie = Get.arguments.movie;
  final void Function() onReturn = Get.arguments.onReturn;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title!),
        leading: GestureDetector(
          onTap: onReturn,
          child: Center(
            child: Icon(
              Icons.arrow_back_ios,
              color: AppColors.textColor,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Image.network(
                      movie.image!,
                      fit: BoxFit.fitHeight,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      movie.description!,
                      style: TextStyle(
                        color: AppColors.textColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: RichText(
                text: const TextSpan(
                  text: 'Read more about this article on ',
                  style: TextStyle(fontSize: 12),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'example-url.com',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
