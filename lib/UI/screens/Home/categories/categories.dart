import 'package:flutter/material.dart';
import 'package:news_app/UI/screens/Home/categories/category_model.dart';
import 'package:news_app/UI/Categories%20Details/category_details.dart';
import 'package:news_app/shared/components.dart';

class CategoriesWidget extends StatelessWidget {
  CategoriesWidget({Key? key}) : super(key: key);
  List<Category> categories = Category.getAllCategories();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Pick your category",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: const Color(0xff4F5A69)),
            ),
            Text(
              "of interest",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: const Color(0xff4F5A69)),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 24,
                    crossAxisSpacing: 20,
                ),
                itemBuilder: (context, index) =>
                    BuildCategoryWidget(categories[index], index , context),
                itemCount: categories.length,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget BuildCategoryWidget(Category category, int index , BuildContext context) => InkWell(
        onTap: () {
          navigateTo(context, CategoryDetails(category));
        },
        child: Container(
          decoration: BoxDecoration(
            color: category.color,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(24),
              topRight: const Radius.circular(24),
              bottomLeft: index == 1 || index == 2 || index == 3 || index == 5
                  ? const Radius.circular(24)
                  : const Radius.circular(0),
              bottomRight: index == 0 || index == 4
                  ? const Radius.circular(24)
                  : const Radius.circular(0),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image(
                image: AssetImage(category.imageName),
                height: 120,
                fit: BoxFit.fitHeight,
              ),
              Text(category.title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w400
                  )),
            ],
          ),
        ),
      );
}
