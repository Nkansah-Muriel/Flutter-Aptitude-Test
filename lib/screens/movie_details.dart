import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moviemot/model/movies.dart';
import 'package:moviemot/theme/colors.dart';

class MovieDetails extends StatefulWidget {
  final Movies movi;

  const MovieDetails({super.key, required this.movi});

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  @override
  Widget build(BuildContext context) {
    // final phoneHeight = MediaQuery.of(context).size.height;
    // final phoneWidth = MediaQuery.of(context).size.width;
    var textTheme = Theme.of(context).textTheme;
    final List<Map<String, String>> castList = [
      {
        'name': 'James Gadner ',
        'imageUrl': 'assets/Rectangle 18.png',
      },
      {
        'name': 'Jango Proud',
        'imageUrl': 'assets/Rectangle 20.png',
      },
      {
        'name': 'Eric Menz',
        'imageUrl': 'assets/Rectangle 22.png',
      },
      {
        'name': 'Michael Yurii',
        'imageUrl': 'assets/Rectangle 24.png',
      },
    ];

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: 393.h,
                    width: 375.w,
                    padding: EdgeInsets.only(
                        top: 56.h, left: 22.w, right: 40.w, bottom: 2.r),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(0.r),
                          topRight: Radius.circular(0.r),
                          bottomLeft: Radius.circular(16.r),
                          bottomRight: Radius.circular(16.r),
                        ),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                'https://image.tmdb.org/t/p/original/${widget.movi.backDropPath}'))),
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                    style: IconButton.styleFrom(
                                      fixedSize: Size(40.w, 40.h),
                                      backgroundColor: KColors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: Icon(
                                      Icons.arrow_back_ios_new_outlined,
                                      size: 24.sp,
                                      color: Colors.blue.withOpacity(.5),
                                    )),
                                Icon(
                                  Icons.favorite_outline,
                                  color: KColors.white,
                                  size: 24.sp,
                                )
                              ],
                            ),
                            SizedBox(
                              height: 190.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  widget.movi.title,
                                  style: textTheme.bodyLarge!.copyWith(
                                      color: KColors.white, fontSize: 27),
                                ),
                                Text(
                                  '1h 45mins',
                                  style: textTheme.bodySmall!.copyWith(
                                      color: KColors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Text(
                              widget.movi.date,
                              style: textTheme.bodySmall!.copyWith(
                                  color: KColors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Container(
                              height: 24.h,
                              width: 80.w,
                              decoration: BoxDecoration(
                                  color: const Color.fromRGBO(7, 200, 212, 1),
                                  borderRadius: BorderRadius.circular(50.r)),
                              child: Center(
                                child: Text(
                                  'Action',
                                  style: textTheme.bodySmall!
                                      .copyWith(color: KColors.white),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 26.0.h, left: 16.w, right: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.movi.overview,
                      style: textTheme.bodyMedium,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 22.h, bottom: 10.h),
                      child: Text(
                        "Cast",
                        style: textTheme.bodyLarge,
                      ),
                    ),
                    SizedBox(
                      height: 150.h, // Height of the cast + name
                      child: ListView.separated(
                        separatorBuilder: (context, index) => SizedBox(
                          width: 6.w,
                        ),
                        scrollDirection: Axis.horizontal,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount:
                            castList.length, // Use the length of castList
                        itemBuilder: (context, index) {
                          final cast = castList[index];
                          return Container(
                            padding: EdgeInsets.all(6.w),
                            width: 120.w, // Width of each item
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 90.h, // Cast member image height
                                  decoration: BoxDecoration(
                                    color: Colors.blueAccent,
                                    borderRadius: BorderRadius.circular(5.r),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage(cast[
                                          'imageUrl']!), // Use imageUrl from castList
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 10.0.h),
                                    child: Text(
                                      cast['name']!, // Use name from castList
                                      style: textTheme.bodyMedium!.copyWith(
                                          fontSize: 12,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromRGBO(7, 200, 212, 1),
                            fixedSize: Size(341.w, 48.h),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r))),
                        onPressed: () {},
                        child: Text(
                          "Play Trailer",
                          style: textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.normal,
                              color: KColors.white),
                        )),
                    TextButton(
                        style: ElevatedButton.styleFrom(
                            fixedSize: Size(341.w, 48.h),
                            side: BorderSide.none,
                            shape: const RoundedRectangleBorder()),
                        onPressed: () {},
                        child: Text(
                          "Download",
                          style: textTheme.bodyMedium,
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
