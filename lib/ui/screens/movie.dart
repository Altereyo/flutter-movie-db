import 'package:flutter/material.dart';
import 'package:flutter_movie_db/ui/theme/app_colors.dart';
import 'package:flutter_movie_db/data/models/movie.dart';

class MovieScreen extends StatelessWidget {
  const MovieScreen({Key? key, required this.movie, required this.onReturn}) : super(key: key);
  final Movie movie;
  final void Function() onReturn;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title!),
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
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
                      fit: BoxFit.fill,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      movie.fullTitle!,
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
