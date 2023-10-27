import 'package:flutter/material.dart';
import 'package:news_app/UI/screens/news_details/news_details.dart';
import 'package:news_app/model/NewsResponse/Articles.dart';

import '../Network/local/cache_helper.dart';

Widget defaultButton({
  Color background = Colors.blue,
  double width = double.infinity,
  double height = 45,
  required String? text,
  double radius = 0,
  void Function()? function,
}) =>
    Container(
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(radius),
      ),
      width: width,
      height: height,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          text!.toUpperCase(),
          style: const TextStyle(color: Colors.white, fontSize: 20.0),
        ),
      ),
    );

Widget defaultTextForm({
  TextEditingController? controller,
  required TextInputType? type,
  Function(String)? onSubmit,
  Function(String)? onchange,
  // required String? label,
  // void Function()? onTap,
  Widget? pre,
  IconData? suf,
  required String? Function(String?)? validate,
  required String hintText,
  bool isPassword = false,
  bool obsecure = false,
  Function()? suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      style: TextStyle(color:CacheHelper.getData(key: 'isDark') ? const Color(0xffDFECDB) : const Color(0xff060E1E)), // Text color
      controller: controller,
      keyboardType: type,
      enabled: isClickable,
      obscureText: isPassword ? true : false,
      onFieldSubmitted: onSubmit,
      onChanged: onchange,
      //onTap: onTap,
      decoration: InputDecoration(
        hintStyle: const TextStyle(color: Colors.grey), // Hint text color
        labelStyle: TextStyle(
            color: CacheHelper.getData(key: 'isDark') == true
                ? Colors.white
                : Colors.black), // Set label color here
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: CacheHelper.getData(key: 'isDark') == true
                  ? Colors.white
                  : Colors.black),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: CacheHelper.getData(key: 'isDark')
              ? Colors.white
              : Colors.black), // Border color when the field is focused
        ),
        hintText: hintText,
        // labelText: label,
        border: const UnderlineInputBorder(),
        prefixIcon: pre,
        suffixIcon: suf != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(suf),
              )
            : null,
      ),
      validator: validate,
    );
void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (route) => false,
    );

Widget NewsItemBuilder(Articles article , BuildContext context ) => GestureDetector(
  onTap: (){
    navigateTo(context, NewsDetailsScreen(article));
  },
  child:   Padding(
    padding: const EdgeInsets.all(15.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            article.urlToImage??"",
            width: double.infinity,
            height: 250,
            fit: BoxFit.fill,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          article.author??'',
          style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 10),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          article.title??'',
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              article.publishedAt??'',
              style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 13),
            ),
          ],
        ),
      ],
    ),
  ),
);
