import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutor_search_system/commons/colors.dart';
import 'package:tutor_search_system/cubits/image_cubit.dart';
import 'package:tutor_search_system/repositories/image_repository.dart';
import 'package:tutor_search_system/screens/common_ui/full_screen_image.dart';
import 'package:tutor_search_system/screens/common_ui/no_data_screen.dart';
import 'package:tutor_search_system/screens/common_ui/waiting_indicator.dart';
import 'package:tutor_search_system/states/image_state.dart';

class CertificationImageScreen extends StatefulWidget {
  @override
  _CertificationImageScreenState createState() =>
      _CertificationImageScreenState();
}

class _CertificationImageScreenState extends State<CertificationImageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: BlocProvider(
          create: (context) => ImageCubit(ImageRepository()),
          child: BlocBuilder<ImageCubit, ImageState>(builder: (context, state) {
            //
            //
            final imageCubit = context.watch<ImageCubit>();
            imageCubit
                // .getTuteeTransactionByTuteeId(authorizedTutor.id);
                .getImageByEmail('duongchinhngu@gmail.com', 'certification');
            //
            if (state is ImageErrorState) {
              // return ErrorScreen();
              return Text(state.errorMessage);
            } else if (state is InitialImageState) {
              return buildLoadingIndicator();
            } else if (state is ImageNoDataState) {
              return NoDataScreen();
            } else if (state is ImageListLoadedState) {
              List<String> certificationImages = [
                'https://lakeridgeumcyoungadults.files.wordpress.com/2019/11/27706588173_e1c1327bb3_b.jpg'
                // 'https://thumbor.forbes.com/thumbor/fit-in/416x416/filters%3Aformat%28jpg%29/https%3A%2F%2Fspecials-images.forbesimg.com%2Fimageserve%2F5ed670179e384f0007b7db8f%2F0x0.jpg%3Fbackground%3D000000%26cropX1%3D1032%26cropX2%3D3642%26cropY1%3D186%26cropY2%3D2795',
                // 'https://tudienwiki.com/wp-content/uploads/2016/08/rihanna_huy_concert_vi_vu_khung_bo_o_phap_1.jpg',
                // 'https://www.biography.com/.image/t_share/MTM2OTI2NTY2Mjg5NTE2MTI5/justin_bieber_2015_photo_courtesy_dfree_shutterstock_348418241_croppedjpg.jpg',
                // 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRAIR__lXBMUKvVqPmKtDQ8jKq9t_GZoZGevur3vDl1gcft1jH0KD01YZ-B_qEaOSRd52o&usqp=CAU',
                // 'https://upload.wikimedia.org/wikipedia/commons/3/3f/TechCrunch_Disrupt_2019_%2848834434641%29_%28cropped%29.jpg',
                // 'https://upload.wikimedia.org/wikipedia/commons/a/ae/Michael_Jordan_in_2014.jpg'
              ];
              //
              certificationImages = state.images
                  .replaceFirst(']', '')
                  .replaceFirst('[', '')
                  .split(', ');
              //
              return Container(
                width: double.infinity,
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(top: 5, left: 5),
                child: Wrap(
                  runAlignment: WrapAlignment.spaceBetween,
                  runSpacing: 5,
                  spacing: 5,
                  children: List.generate(certificationImages.length, (index) {
                    //view photo in fullscreen
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FullScreenImage(
                              imageWidget: Image.network(
                                certificationImages[index],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      },
                      child: Container(
                        height: 114,
                        width: 114,
                        child: Image.network(
                          certificationImages[index],
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  }),
                ),
              );
            }
          })),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: mainColor,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: backgroundColor,
          size: 15,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      centerTitle: true,
      title: Text(
        'Certification',
      ),
      // actions: [Icon(Icons.sort)],
    );
  }
}
