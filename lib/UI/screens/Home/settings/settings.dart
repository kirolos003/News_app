import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../provider/app_provider.dart';

class SettingsWidget extends StatelessWidget {
  const SettingsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppProvider provider = Provider.of<AppProvider>(context);
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 40,
            ),
            Text("Language" ,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(
              height: 10,),
            InkWell(
              onTap: (){
                showLanguageBottomSheet(context);
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(15)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(provider.isEnglish == 'en' ? "English" : "arabic" ,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const Icon(Icons.arrow_drop_down_outlined)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showLanguageBottomSheet(BuildContext context) {
    showModalBottomSheet(context: context, builder: (context) => const LangugeBottomSheet());
  }
}

class LangugeBottomSheet extends StatelessWidget{
  const LangugeBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    AppProvider provider = Provider.of<AppProvider>(context);
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: (){
              provider.changeAppLanguage();
              Navigator.pop(context);
            },
            child: Text("English" ,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: provider.isDark ? Colors.black :  Colors.black,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: (){
              provider.changeAppLanguage();
              Navigator.pop(context);
            },
            child: Text("Arabic" ,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: provider.isDark ? Colors.black : Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

