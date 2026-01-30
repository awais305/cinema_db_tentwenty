import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinema_db/models/movie_detail_model.dart';
import 'package:cinema_db/providers/watch_detail_provider.dart';
import 'package:cinema_db/utils/extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:go_router/go_router.dart';

class TrailerScreen extends StatefulWidget {
  const TrailerScreen({super.key});

  @override
  State<TrailerScreen> createState() => _TrailerScreenState();
}

class _TrailerScreenState extends State<TrailerScreen> {
  YoutubePlayerController? controller;
  MovieDetailModel? movie;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initMovie();
    });
  }

  void _initMovie() {
    final extra = GoRouter.of(context).state.extra;
    if (extra is MovieDetailModel) {
      movie = extra;
      context.read<WatchDetailProvider>().getMovieTrailers(movie!.id);
    } else {
      // Handle error or pop
      GoRouter.of(context).pop();
    }
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([]);
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: const SizedBox(),
        actions: [
          TextButton.icon(
            onPressed: () => GoRouter.of(context).pop(),
            style: const ButtonStyle().copyWith(
              minimumSize: const WidgetStatePropertyAll(Size(90, 40)),
              backgroundColor: const WidgetStatePropertyAll(Colors.transparent),
              side: const WidgetStatePropertyAll(BorderSide.none),
            ),
            label: const Text("Done"),
            icon: const Icon(CupertinoIcons.check_mark),
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: Consumer<WatchDetailProvider>(
        builder: (context, provider, _) {
          if (provider.isTrailerLoading) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }

          if (provider.trailerData != null &&
              provider.trailerData!.results.isNotEmpty) {
            final videos = provider.trailerData!.results;
            final trailer = videos.firstWhere(
              (v) => v.site == "YouTube" && v.type == "Trailer",
              orElse: () => videos.firstWhere(
                (v) => v.site == "YouTube",
                orElse: () => videos.first,
              ),
            );

            if (controller == null && trailer.site == "YouTube") {
              controller = YoutubePlayerController(
                initialVideoId: trailer.key,
                flags: const YoutubePlayerFlags(
                  autoPlay: true,
                  mute: false,
                  disableDragSeek: true,
                  loop: false,
                  isLive: false,
                  forceHD: false,
                  enableCaption: false,
                ),
              );
            }

            if (controller != null) {
              return Stack(
                children: [
                  if (movie?.backdropPath != null)
                    CachedNetworkImage(
                      imageUrl: movie!.backdropPath!.getMovieThumbnail(),
                      imageBuilder: (ctx, imageProvider) => Container(
                        height: MediaQuery.sizeOf(context).height,
                        width: MediaQuery.sizeOf(context).width,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: ClipRect(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(
                              sigmaX: 10.0,
                              sigmaY: 10.0,
                            ),
                            child: Container(
                              color: Colors.black.withValues(alpha: 0.3),
                            ),
                          ),
                        ),
                      ),
                      placeholder: (context, url) =>
                          Container(color: Colors.black),
                      errorWidget: (context, url, error) =>
                          Container(color: Colors.black),
                    )
                  else
                    Container(color: Colors.black),
                  Center(
                    child: YoutubePlayer(
                      controller: controller!,
                      showVideoProgressIndicator: true,
                      onEnded: (metaData) => GoRouter.of(context).pop(),
                    ),
                  ),
                ],
              );
            }
          }

          // Fallback or error state
          return Center(
            child: Text(
              "No Trailer Available",
              style: TextStyle(color: Colors.white),
            ),
          );
        },
      ),
    );
  }
}
