import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moviemot/API/api.dart';
import 'package:moviemot/model/movies.dart';
import 'package:moviemot/screens/movie_details.dart';
import 'package:moviemot/theme/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String firstCategory = "Streaming";
  String secondCategory = "Movie";
  late Future<List<Movies>> upComingMovies;
  late Future<List<Movies>> popularMovies;
  late Future<List<Movies>> topRatedMovies;
  Future<List<Movies>>? searchResults;
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    upComingMovies = Api().getUpComingMovies();
    popularMovies = Api().getPopularMovies();
    topRatedMovies = Api().getTopRatedMovies();
  }

  TextEditingController searchController = TextEditingController();

  void performSearch(String query) {
    setState(() {
      if (query.isNotEmpty) {
        isSearching = true;
        searchResults = Api().searchMovies(query);
      } else {
        isSearching = false;
        searchResults = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        body: Padding(
          padding: EdgeInsets.only(top: 20.h, left: 16.w, right: 16.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Hello  ",
                          style: textTheme.bodyLarge,
                        ),
                        Image.asset('assets/mdi_hand-wave.png'),
                      ],
                    ),
                    Container(
                      height: 40.h,
                      width: 40.w,
                      decoration: BoxDecoration(
                        color: KColors.white,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Icon(
                        Icons.person_rounded,
                        color: Colors.blue,
                        size: 30.sp,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.0.h, bottom: 16.h),
                  child: Text(
                    "Millions of movies, TV shows to\nexplore now.",
                    style: textTheme.bodyLarge,
                  ),
                ),
                TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    filled: true,
                    contentPadding: EdgeInsets.all(6.w),
                    fillColor: Colors.grey[200],
                    hintText: "Search for movies, tv shows...",
                    prefixIcon: Icon(
                      Icons.search_outlined,
                      color: Colors.grey[400],
                      size: 35.sp,
                    ),
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.r),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.r),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onChanged: performSearch,
                ),
                SizedBox(height: 20.h),
                isSearching
                    ? FutureBuilder<List<Movies>>(
                        future: searchResults,
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          final movies = snapshot.data!;
                          if (movies.isEmpty) {
                            return Center(
                              child: Text(
                                'No results found.',
                                style: textTheme.bodyMedium,
                              ),
                            );
                          }
                          return SizedBox(
                            height: 300.h,
                            child: ListView.separated(
                              separatorBuilder: (context, index) => SizedBox(
                                width: 8.w,
                              ),
                              scrollDirection: Axis.horizontal,
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemCount: movies.length,
                              itemBuilder: (context, index) {
                                final movie = movies[index];
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            MovieDetails(movi: movie),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    width: 168.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Stack(
                                          alignment: Alignment.topRight,
                                          children: [
                                            SizedBox(
                                              height: 230.h,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(15.r),
                                                child: Image.network(
                                                  fit: BoxFit.cover,
                                                  width: double.infinity,
                                                  "https://image.tmdb.org/t/p/original/${movie.backDropPath}",
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: 8.0.h, right: 8.w),
                                              child: Icon(
                                                Icons.favorite_outline,
                                                color: KColors.white,
                                                size: 30.sp,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8.w, vertical: 4.h),
                                          child: Text(
                                            movie.title,
                                            style: textTheme.bodyMedium!
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.bold),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8.w),
                                          child: Text(
                                            movie.date,
                                            style: textTheme.bodySmall,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 25.0.h, bottom: 10.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "What's Popular",
                                  style: textTheme.bodyLarge,
                                ),
                                Container(
                                  height: 40.h,
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 12.w),
                                  decoration: BoxDecoration(
                                    color: Colors.blue.withOpacity(.2),
                                    borderRadius: BorderRadius.circular(20.r),
                                    border:
                                        Border.all(color: Colors.grey[300]!),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      value: firstCategory,
                                      icon: Icon(
                                        Icons.arrow_drop_down,
                                        color: Colors.red,
                                        size: 24.sp,
                                      ),
                                      style: textTheme.bodyMedium,
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          firstCategory = newValue!;
                                        });
                                      },
                                      items: <String>[
                                        'Streaming',
                                        'On TV',
                                        'For Rent',
                                        'In Theaters',
                                      ].map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          FutureBuilder(
                            future: popularMovies,
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              final movie = snapshot.data!;
                              return SizedBox(
                                height: 300.h,
                                child: ListView.separated(
                                  separatorBuilder: (context, index) =>
                                      SizedBox(
                                    width: 8.w,
                                  ),
                                  scrollDirection: Axis.horizontal,
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  itemCount: movie.length,
                                  itemBuilder: (context, index) {
                                    final movi = movie[index];
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                MovieDetails(movi: movi),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        width: 168.w,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Stack(
                                              alignment: Alignment.topRight,
                                              children: [
                                                SizedBox(
                                                  height: 230.h,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.r),
                                                    child: Image.network(
                                                        fit: BoxFit.cover,
                                                        width: double.infinity,
                                                        "https://image.tmdb.org/t/p/original/${movi.backDropPath}"),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 8.0.h, right: 8.w),
                                                  child: Icon(
                                                    Icons.favorite_outline,
                                                    color: KColors.white,
                                                    size: 30.sp,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 8.w,
                                                  vertical: 4.h),
                                              child: Text(
                                                movi.title,
                                                style: textTheme.bodyMedium!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 8.w),
                                              child: Text(
                                                movi.date,
                                                style: textTheme.bodySmall,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                          SizedBox(height: 12.h),
                          Padding(
                            padding: EdgeInsets.only(top: 25.0.h, bottom: 10.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Free To Watch",
                                  style: textTheme.bodyLarge,
                                ),
                                Container(
                                  height: 35.h,
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 12.w),
                                  decoration: BoxDecoration(
                                    color: Colors.blue.withOpacity(.2),
                                    borderRadius: BorderRadius.circular(20.r),
                                    border:
                                        Border.all(color: Colors.grey[300]!),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      value: secondCategory,
                                      icon: Icon(
                                        Icons.arrow_drop_down,
                                        color: Colors.red,
                                        size: 24.sp,
                                      ),
                                      style: textTheme.bodyMedium,
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          secondCategory = newValue!;
                                        });
                                      },
                                      items: <String>[
                                        'Movie',
                                        'Series',
                                        'Anime',
                                      ].map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          FutureBuilder(
                            future: upComingMovies,
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              final movie = snapshot.data!;
                              return SizedBox(
                                height: 300.h,
                                child: ListView.separated(
                                  separatorBuilder: (context, index) =>
                                      SizedBox(
                                    width: 8.w,
                                  ),
                                  scrollDirection: Axis.horizontal,
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  itemCount: movie.length,
                                  itemBuilder: (context, index) {
                                    final movi = movie[index];
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                MovieDetails(movi: movi),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        width: 168.w,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Stack(
                                              alignment: Alignment.topRight,
                                              children: [
                                                SizedBox(
                                                  height: 230.h,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.r),
                                                    child: Image.network(
                                                        fit: BoxFit.cover,
                                                        width: double.infinity,
                                                        "https://image.tmdb.org/t/p/original/${movi.backDropPath}"),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 8.0.h, right: 8.w),
                                                  child: Icon(
                                                    Icons.favorite_outline,
                                                    color: KColors.white,
                                                    size: 30.sp,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 8.w,
                                                  vertical: 4.h),
                                              child: Text(
                                                movi.title,
                                                style: textTheme.bodyMedium!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 8.w),
                                              child: Text(
                                                movi.date,
                                                style: textTheme.bodySmall,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
