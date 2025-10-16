import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:product0/core/utils/constants.dart';
import 'package:product0/screens/details/ui/components/details_card.dart';
import 'package:product0/models/workshop.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsScreenBody extends StatelessWidget {
  final Workshop workshop;
  const DetailsScreenBody({super.key, required this.workshop});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            workshop.isFeatured
                ? workshop.gallery.isNotEmpty
                      ? ProductImagesViewer(imageUrls: workshop.gallery)
                      : Hero(
                          tag: "hero_${workshop.code}",
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              image: DecorationImage(
                                image: NetworkImage(workshop.featuredImageUrl),
                                fit: BoxFit.fill,
                              ),
                            ),
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.3,
                          ),
                        )
                : Hero(
                    tag: "hero_${workshop.code}",
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                          image: NetworkImage(workshop.featuredImageUrl),
                          fit: BoxFit.fill,
                        ),
                      ),
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.3,
                    ),
                  ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'ID:${workshop.code}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black.withOpacity(0.7),
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.width * 0.015,
                          ),
                          child: SvgPicture.asset(
                            height: 15,
                            'assets/icons/Star.svg',
                            color: Colors.amber,
                          ),
                        ),
                        Text(
                          ((workshop.rating / 5) * 100).toString().length > 4
                              ? '${((workshop.rating / 5) * 100).toString().substring(0, 4)}%'
                              : '${((workshop.rating / 5) * 100).toString()}%',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.7),
                            fontSize: 16,

                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Text(
                  textAlign: TextAlign.end,
                  workshop.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Color(0xff094067),
                  ),
                ),
              ],
            ),
            DetailsCard(content: workshop.content, title: ': الوصف'),
            DetailsCard(
              content: workshop.phoneNumber,
              title: 'معلومات الاتصال',
            ),
            DetailsCard(
              content: workshop.location.isNotEmpty
                  ? workshop.location
                  : 'لايوجد',
              title: ': منطقة الخدمة',
            ),

            GestureDetector(
              onTap: () async {
                final String phoneNumber = workshop.phoneNumber;
                final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
                await launchUrl(launchUri);
              },
              child: Container(
                padding: EdgeInsets.only(top: 10, bottom: 5),
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                decoration: BoxDecoration(
                  color: kMainColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text(
                    'اتصال',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductImagesViewer extends StatefulWidget {
  final List<String> imageUrls;

  const ProductImagesViewer({super.key, required this.imageUrls});

  @override
  State<ProductImagesViewer> createState() => _ProductImagesViewerState();
}

class _ProductImagesViewerState extends State<ProductImagesViewer> {
  int _currentIndex = 0;
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  void _openFullScreenGallery(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            FullScreenGallery(images: widget.imageUrls, initialIndex: index),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          CarouselSlider.builder(
            carouselController: _carouselController,
            itemCount: widget.imageUrls.length,
            itemBuilder: (context, index, realIndex) {
              final url = widget.imageUrls[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: GestureDetector(
                  onTap: () => _openFullScreenGallery(index),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: url,
                      fit: BoxFit.fill,
                      width: double.infinity,
                      placeholder: (context, url) => const Center(
                        child: LoadingIndicator(
                          indicatorType: Indicator.lineSpinFadeLoader,
                          colors: [kMainColor, kMainDarkColor],
                        ),
                      ),
                      errorWidget: (context, url, error) => Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'خطأ في تحميل الصورة',
                            style: TextStyle(fontSize: 16),
                          ),
                          const Icon(Icons.error),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
            options: CarouselOptions(
              viewportFraction: 1,
              enlargeCenterPage: false,
              // pageSnapping: true,
              aspectRatio: 3 / 2,
              autoPlay: true,
              onPageChanged: (index, reason) {
                setState(() => _currentIndex = index);
              },
            ),
          ),

          // This is where the small pictures begin
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 5),
              scrollDirection: Axis.horizontal,
              itemCount: widget.imageUrls.length,
              itemBuilder: (context, index) {
                final url = widget.imageUrls[index];
                return GestureDetector(
                  onTap: () {
                    _carouselController.animateToPage(index);
                    setState(() => _currentIndex = index);
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    padding: _currentIndex == index
                        ? const EdgeInsets.all(2)
                        : EdgeInsets.zero,
                    decoration: BoxDecoration(
                      border: _currentIndex == index
                          ? Border.all(color: Colors.blue, width: 2)
                          : null,
                    ),
                    child: CachedNetworkImage(
                      imageUrl: url,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class FullScreenGallery extends StatelessWidget {
  final List<String> images;
  final int initialIndex;

  const FullScreenGallery({
    super.key,
    required this.images,
    this.initialIndex = 0,
  });

  @override
  Widget build(BuildContext context) {
    return PhotoViewGallery.builder(
      pageController: PageController(initialPage: initialIndex),
      itemCount: images.length,
      builder: (context, index) {
        return PhotoViewGalleryPageOptions(
          imageProvider: NetworkImage(images[index]),
          heroAttributes: PhotoViewHeroAttributes(tag: images[index]),
        );
      },
      // scrollPhysics: const BouncingScrollPhysics(),
      // backgroundDecoration: const BoxDecoration(color: Colors.black),
    );
  }
}
