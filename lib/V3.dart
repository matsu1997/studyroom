
import 'package:flutter/material.dart';

import 'V1V2.dart';
import 'V2.dart';
import 'color_filters.dart';

class V3 extends StatefulWidget {
  @override
  State<V3> createState() => _V3State();
}

class _V3State extends State<V3> {
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return buildColoredCard(
                    child: ListTile(
                        onTap: () {
                          // Navigator.of(context).push(
                          //   MaterialPageRoute(
                          //       builder: (context) => V2()),);
                        }
                    ),
                  );
                },
              ),
            ),]
      ),
    ));
  }

  Widget buildQuoteCard() => Card(
    child: Padding(
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'If life were predictable it would cease to be life, and be without flavor.',
            style: TextStyle(fontSize: 24),
          ),
          const SizedBox(height: 12),
          Text(
            'Eleanor Roosevelt',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ),
  );

  Widget buildRoundedCard() => Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    child: Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Rounded card',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'This card is rounded',
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    ),
  );
//
  Widget buildColoredCard({required ListTile child}) => Card(
    shadowColor: Colors.grey[100],
    elevation: 8,
    clipBehavior: Clip.antiAlias,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24),
    ),
    child: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors:[Colors.white,Colors.white ],//[Colors.redAccent, Colors.red],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      padding: EdgeInsets.all(16),

      child:Row(
        children: [
          Container(
            width: 80,
            child:Icon(Icons.library_books_rounded,)
          ),
          Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Colored card',
            style: TextStyle(
              fontSize: 20,
              //color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'This card is rounded and has a gradient',
            style: TextStyle(
              fontSize: 20,
             // color: Colors.white,
            ),
          ),
          FlatButton(
            child: Text('詳しくはこちら',style: TextStyle(color: Colors.blue),),
            onPressed: () {},
          ),
        ],)
      ),],)
    ),
  );

  Widget buildImageCard() => Card(
    clipBehavior: Clip.antiAlias,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24),
    ),
    child: Stack(
      alignment: Alignment.center,
      children: [
        Ink.image(
          image: NetworkImage(
            'https://images.unsplash.com/photo-1514888286974-6c03e2ca1dba?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1327&q=80',
          ),
          colorFilter: ColorFilters.greyscale,
          child: InkWell(
            onTap: () {},
          ),
          height: 240,
          fit: BoxFit.cover,
        ),
        Text(
          'Card With Splash',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 24,
          ),
        ),
      ],
    ),
  );

  Widget buildImageInteractionCard() => Card(
    clipBehavior: Clip.antiAlias,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24),
    ),
    child: Column(
      children: [
        Stack(
          children: [
            Ink.image(
              image: NetworkImage(
                'https://images.unsplash.com/photo-1514888286974-6c03e2ca1dba?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1327&q=80',
              ),
              height: 240,
              fit: BoxFit.cover,
            ),
            Positioned(
              bottom: 16,
              right: 16,
              left: 16,
              child: Text(
                'Cats rule the world!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.all(16).copyWith(bottom: 0),
          child: Text(
            'The cat is the only domesticated species in the family Felidae and is often referred to as the domestic cat to distinguish it from the wild members of the family.',
            style: TextStyle(fontSize: 16),
          ),
        ),
        ButtonBar(
          alignment: MainAxisAlignment.start,
          children: [
            FlatButton(
              child: Text('Buy Cat'),
              onPressed: () {},
            ),
            FlatButton(
              child: Text('Buy Cat Food'),
              onPressed: () {},
            )
          ],
        )
      ],
    ),
  );
}
