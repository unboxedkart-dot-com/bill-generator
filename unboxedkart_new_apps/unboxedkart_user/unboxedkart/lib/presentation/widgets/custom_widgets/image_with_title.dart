import 'package:flutter/material.dart';
import 'package:unboxedkart/presentation/widgets/custom_sized_text.dart';

class Params {
  final String param;

  Params(this.param);
}

class ImageWithTitleWidget extends StatelessWidget {
  String redirectUrl;
  String imageUrl;
  String title;
  String param;
   

  ImageWithTitleWidget(
      {Key key, this.title, this.redirectUrl, this.imageUrl, this.param}) : super(key: key);

  factory ImageWithTitleWidget.fromDocument(doc) {
    return ImageWithTitleWidget(
        redirectUrl: doc['redirectUrl'],
        imageUrl: doc['imageUrl'],
         
        title: doc['title'],
        param: doc['param']);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        
        
        Navigator.pushNamed(context, redirectUrl,
            arguments: Params(param));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Material(
          elevation: 2,
          borderRadius: BorderRadius.circular(15),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.5,
            height: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15), color: Colors.white),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      color: Colors.white,
                      child: ClipRRect(
                         
                        child: Image(
                          width: MediaQuery.of(context).size.width * 0.7,
                          height: MediaQuery.of(context).size.width * 0.7,
                          image: AssetImage(imageUrl),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: CustomSizedTextBox(
                      addPadding: true,
                      textContent: title,
                      isBold: true,
                      color: Colors.black,
                    ),
                  )
                ]),
          ),
        ),
      ),
    );
  }

   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   

   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
}


 
 
 
 
 
