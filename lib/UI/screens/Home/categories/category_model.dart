import 'dart:ui';

class Category {
  String id;
  String title;
  Color color;
  String imageName;

  Category({
    required this.id,
    required this.title,
    required this.color,
    required this.imageName,
  });

  static List<Category> getAllCategories() {
    return [
      Category(
          id: 'sports',
          title: 'sports',
          color: const Color(0xffC91C22),
          imageName: 'assets/images/ball.png'
      ),
      Category(
          id: 'general',
          title: 'General',
          color: const Color(0xff003E90),
          imageName: 'assets/images/Politics.png'
      ),
      Category(
          id: 'health',
          title: 'Health',
          color: const Color(0xffED1E79),
          imageName: 'assets/images/health.png'
      ),
      Category(
          id: 'business',
          title: 'Business',
          color: const Color(0xffCF7E48),
          imageName: 'assets/images/bussines.png'
      ),
      Category(
          id: 'entertainment',
          title: 'Entertainment',
          color: const Color(0xff4882CF),
          imageName: 'assets/images/environment.png'
      ),
      Category(
          id: 'science',
          title: 'Science',
          color: const Color(0xffF2D352),
          imageName: 'assets/images/science.png'
      ),
    ];
  }
}
