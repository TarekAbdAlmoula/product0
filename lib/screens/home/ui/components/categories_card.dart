import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:product0/app_route_constants.dart';
import 'package:product0/core/utils/constants.dart';
import 'package:product0/models/categories.dart' as models;

class CategoriesCard extends StatefulWidget {
  const CategoriesCard({super.key, required this.categories});

  final List<models.Categories> categories;
  @override
  _CategoriesCardState createState() => _CategoriesCardState();
}

class _CategoriesCardState extends State<CategoriesCard> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          'الأصناف الرئيسية',
          style: TextStyle(
            color: kMainDarkColor,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.14,
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.categories.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    context.pushNamed(
                      AppRouteConstants.categories,
                      pathParameters: {
                        'id': widget.categories[index].id.toString(),
                        'name': widget.categories[index].name,
                      },
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 3, vertical: 0.5),
                    width: MediaQuery.of(context).size.width * 0.25,
                    decoration: BoxDecoration(
                      // image: DecorationImage(
                      //   fit: BoxFit.cover,
                      // image: NetworkImage(
                      //   widget.categories[index].image!.ulr,
                      // ),
                      // ),
                      // color: const Color(0xff3da9fc),
                      borderRadius: BorderRadius.all(Radius.circular(7)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadiusGeometry.circular(7),
                              child: CachedNetworkImage(
                                // fadeOutCurve: Curves.easeInOut,
                                fit: BoxFit.fill,
                                height:
                                    MediaQuery.of(context).size.height * 0.13,
                                imageUrl: widget.categories[index].image!.ulr,
                                placeholder: (context, url) =>
                                    Image.asset('assets/images/no_image.png'),
                                errorWidget: (context, url, error) =>
                                    Center(child: Icon(Icons.error)),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.09,
                                left: MediaQuery.of(context).size.width * 0.009,
                                right:
                                    MediaQuery.of(context).size.width * 0.009,
                              ),
                              height:
                                  MediaQuery.of(context).size.height * 0.028,
                              padding: EdgeInsets.symmetric(
                                vertical:
                                    MediaQuery.of(context).size.height * 0.004,
                              ),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white.withOpacity(0.7),
                              ),
                              child: Center(
                                child: Text(
                                  textAlign: TextAlign.center,
                                  widget.categories[index].name,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        // Spacer(flex: 8),
                        // Container(
                        //   height: MediaQuery.of(context).size.height * 0.028,
                        //   padding: EdgeInsets.symmetric(
                        //     vertical:
                        //         MediaQuery.of(context).size.height * 0.004,
                        //   ),
                        //   width: double.infinity,
                        //   decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(5),
                        //     color: Colors.white.withOpacity(0.7),
                        //   ),
                        //   child: Center(
                        //     child: Text(
                        //       textAlign: TextAlign.center,
                        //       widget.categories[index].name,
                        //       style: TextStyle(
                        //         fontSize: 12,
                        //         fontWeight: FontWeight.w400,
                        //         color: Colors.black,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        // Spacer(flex: 1),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        // CachedNetworkImage
      ],
    );
  }
}
