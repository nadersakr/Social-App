import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:social_app/view_model/user_viewmodel.dart';

class PicWidget extends ChangeNotifier {
  String? picUrl = UserViewModel.userModel!.avatar;
  PicWidgetType picWidgetType = UserViewModel.userModel!.avatar == null
      ? PicWidgetType.svgPicture
      : PicWidgetType.networkImage;
  String? picAsset;
  File? picFile;
  String picSvg = 'assets/svg/person.svg';
  void _changePicWidgetType(PicWidgetType type) {
    picWidgetType = type;
    notifyListeners();
  }

  void changeToAsset(String asset) {
    picAsset = asset;
    _changePicWidgetType(PicWidgetType.assetImage);
  }

  void changeToNetwork(String url) {
    picUrl = url;
    _changePicWidgetType(PicWidgetType.networkImage);
    notifyListeners();
  }

  void changeToSvg(String svg) {
    picSvg = svg;
    _changePicWidgetType(PicWidgetType.svgPicture);
  }

  void changeTofile(File file) {
    picFile = file;
    _changePicWidgetType(PicWidgetType.fileImage);
  }

  Widget mainWidget() {
    switch (picWidgetType) {
      case PicWidgetType.svgPicture:
        return _svgWidget();
      case PicWidgetType.assetImage:
        return _assetWidget();
      case PicWidgetType.networkImage:
        return _networkWidget();
      case PicWidgetType.fileImage:
        return _fileWidget();
    }
  }

  Widget _svgWidget() => SvgPicture.asset(
        picSvg,
        fit: BoxFit.fill,
      );
  Widget _assetWidget() => Image.asset(
        picAsset!,
        fit: BoxFit.cover,
      );
  Widget _networkWidget() => Image.network(
        picUrl!,
        fit: BoxFit.cover,
      );
  Widget _fileWidget() => Image.file(
        picFile!,
        fit: BoxFit.cover,
      );
}

enum PicWidgetType { svgPicture, assetImage, networkImage, fileImage }
