const String _imageBasePath = 'assets/images';

class ImagePath {
  static General general = const General();
  static Home home = const Home();
}

class General {
  const General();
  String get book => '$_imageBasePath/book.png';
}


class Home {
  const Home();
  String get person => '$_imageBasePath/person.png';
}

