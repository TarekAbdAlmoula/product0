import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:product0/core/utils/constants.dart';
import 'package:product0/screens/details/ui/components/details_card.dart';
import 'package:product0/models/workshop.dart';
import 'package:product0/screens/details/ui/viewmodel/details_viewmodel.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsScreenBody extends StatefulWidget {
  final Workshop workshop;

  const DetailsScreenBody({super.key, required this.workshop});

  @override
  State<DetailsScreenBody> createState() => _DetailsScreenBodyState();
}

class _DetailsScreenBodyState extends State<DetailsScreenBody> {
  @override
  initState() {
    super.initState();
    getToken();
  }

  Future<String?> getToken() async {
    final FlutterSecureStorage storage = const FlutterSecureStorage();
    token = await storage.read(key: 'token') ?? '';
    setState(() {});
    return token;
  }

  String token = '';
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            widget.workshop.isFeatured || widget.workshop.isAccredited
                ? widget.workshop.gallery.isNotEmpty
                      ? ProductImagesViewer(imageUrls: widget.workshop.gallery)
                      : Hero(
                          tag: "hero_${widget.workshop.code}",
                          child: AspectRatio(
                            aspectRatio: 3 / 2,
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                border: Border.all(color: Color(0xffA3A3A3)),

                                borderRadius: BorderRadius.circular(16),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    widget.workshop.featuredImageUrl,
                                  ),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              width: double.infinity,
                            ),
                          ),
                        )
                : Hero(
                    tag: "hero_${widget.workshop.code}",
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xffA3A3A3)),

                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                          image: NetworkImage(widget.workshop.featuredImageUrl),
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
                Text(
                  'ID:${widget.workshop.code}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                    color: Color(0xff5C5C5C),
                  ),
                ),
                Text(
                  textAlign: TextAlign.end,
                  widget.workshop.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.sp,

                    color: Color(0xff094067),
                  ),
                ),
              ],
            ),
            Visibility(
              visible:
                  widget.workshop.servicesCategory[0] == "بيع وإيجار" ||
                      widget.workshop.servicesCategory[0] == "العقارات"
                  ? false
                  : true,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.45,
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.symmetric(vertical: 5.h),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xffA3A3A3)),
                      borderRadius: BorderRadius.circular(16),
                      color: Color(0xffF8F8F8),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).size.width * 0.015,
                              ),
                              child: SvgPicture.asset(
                                height: 20.h,
                                'assets/icons/Star.svg',
                                color: Colors.amber,
                              ),
                            ),
                            SizedBox(width: 5),

                            Text(
                              (widget.workshop.rating != 0
                                  ? '${widget.workshop.rating.toString()}%'
                                  : 'لايوجد تقيمات'),
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                fontSize: widget.workshop.rating == 0
                                    ? 16.sp
                                    : 22.sp,
                                color: Color(0xff5C5C5C),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        widget.workshop.rating == 0
                            ? Text('')
                            : Text(
                                'تقييم الخدمة',

                                style: TextStyle(
                                  color: Color(0xff5C5C5C),
                                  fontSize: 15,
                                ),
                              ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xffA3A3A3)),
                      borderRadius: BorderRadius.circular(16),
                      color: Color(0xffF8F8F8),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: SvgPicture.asset(
                                'assets/images/multi_user.svg',
                                color: kMainDarkColor,
                                height: 25,
                              ),
                            ),
                            SizedBox(width: 5),
                            Text(
                              widget.workshop.totalRateers.toString(),
                              style: TextStyle(
                                fontSize: 22,
                                color: Color(0xff5C5C5C),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'مستخدم قيموا الخدمة',
                          style: TextStyle(
                            color: Color(0xff5C5C5C),
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            DetailsCard(content: widget.workshop.content, title: ': الوصف'),
            (widget.workshop.isAccredited && token == '')
                ? SizedBox()
                : DetailsCard(
                    content: widget.workshop.phoneNumber,
                    title: ': معلومات الاتصال',
                  ),
            DetailsCard(
              content: widget.workshop.location.isNotEmpty
                  ? widget.workshop.location
                  : 'لايوجد',
              title: ': المنطقة ',
            ),
            widget.workshop.isAccredited && widget.workshop.comments.isNotEmpty
                ? AnimatedContainer(
                    height: isExpanded ? 400.h : 70.h,
                    duration: Duration(milliseconds: 250),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.symmetric(vertical: 5.w),
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xffA3A3A3)),
                        borderRadius: BorderRadius.circular(16),
                        color: Color(0xffF8F8F8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isExpanded = !isExpanded;
                                  });
                                },
                                child: isExpanded
                                    ? Icon(
                                        Icons.arrow_drop_down,
                                        color: kMainColor,
                                      )
                                    : Icon(
                                        Icons.arrow_drop_up,
                                        color: kMainColor,
                                      ),
                              ),
                              Text(
                                'آراء المستخدمين',
                                style: TextStyle(
                                  color: kMainColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.end,
                              ),
                            ],
                          ),
                          Divider(color: Colors.grey),
                          Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: widget.workshop.comments.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      widget.workshop.comments[index],
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                        fontSize: 17,
                                        color: Color(0xff5C5C5C),
                                      ),
                                    ),
                                    Divider(color: Colors.grey),
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : Visibility(
                    visible: widget.workshop.isAccredited,
                    child: DetailsCard(
                      content: 'لايوجد تعليقات',
                      title: 'آراء المستخدمين',
                    ),
                  ),
            GestureDetector(
              onTap: () async {
                if (widget.workshop.isAccredited) {
                  if (token == '') {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Directionality(
                          textDirection: TextDirection.rtl,
                          child: Text('يرجى تسجيل الدخول للاتصال'),
                        ),
                      ),
                    );
                    return;
                  } else {
                    BlocProvider.of<DetailsViewmodel>(
                      context,
                    ).callService(workshopId: widget.workshop.id.toString());
                  }
                }

                final String phoneNumber = widget.workshop.phoneNumber;
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

            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
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
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xffA3A3A3)),
                      ),
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
                ),
              );
            },
            options: CarouselOptions(
              viewportFraction: 1,
              enlargeCenterPage: false,
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
                        child: LoadingIndicator(
                          indicatorType: Indicator.lineSpinFadeLoader,
                          colors: [kMainColor, kMainDarkColor],
                        ),
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
    );
  }
}
