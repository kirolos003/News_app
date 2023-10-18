import 'package:flutter/material.dart';
import 'package:news_app/UI/screens/Home/categories/categories.dart';
import 'package:news_app/UI/screens/Home/settings/settings.dart';
import 'package:provider/provider.dart';
import '../../../provider/app_provider.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppProvider provider = Provider.of<AppProvider>(context);
    return Drawer(
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.only(
                top: 60 ,
                bottom: 50
              ),
              color: Theme.of(context).primaryColor,
              child: const Text("News App!" , textAlign: TextAlign.center , style: TextStyle(
                color: Colors.white ,
                fontSize: 25 ,
                fontWeight: FontWeight.w700
              ),),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  InkWell(
                    onTap: (){
                      provider.changeDrawerItem(CategoriesWidget());
                      Navigator.pop(context);

                    },
                    child: const Row(
                      children: [
                        Icon(Icons.list , size: 35,),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Categories")
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  InkWell(
                    onTap: (){
                      provider.changeDrawerItem(SettingsWidget());
                      Navigator.pop(context);
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.settings , size: 35,),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Settings")
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
