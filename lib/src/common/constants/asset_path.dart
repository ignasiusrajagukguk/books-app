const String _imageBasePath = 'assets/images';

class ImagePath {
  static General general = const General();
}

class General {
  const General();
  String get book => '$_imageBasePath/book.png';
}
