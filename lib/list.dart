import 'dart:async';
import 'package:flutter_copoun_application/coupon.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

class ListPage extends StatefulWidget {
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  List<Coupon> _coupons = [];
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Copouns'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : _buildPostList(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

//    Timer.run(() {
//      showAlertDialog(context);
//    });

    _fetchPosts();
  }

  Future<dynamic> _fetchPosts() async {
    try {
      setState(() {
        _isLoading = true;
      });

      var _result = await http.get('http://206.189.143.99:3000/copouns');

      final List<Coupon> _fetchedCoupons = [];

      final List<dynamic> _responseList = json.decode(_result.body);

      if (_responseList == null) {
        setState(() {
          _isLoading = false;
        });
      }

      for (var i = 0; i < _responseList.length; i++) {
        _fetchedCoupons.add(Coupon(
            title: _responseList[i]['name'], url: _responseList[i]['url']));
      }

      setState(() {
        _coupons = _fetchedCoupons;
        _isLoading = false;
      });
    } catch (Exception) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<dynamic> _onRefresh() {
    return _fetchPosts();
  }

  Widget _buildPostList() {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          var _container = _coupons[index].isSvg()
              ? Container(
                  width: 40,
                  height: 45,
                  child: SvgPicture.network(
                    _coupons[index].url,
                    placeholderBuilder: (BuildContext context) => Container(
                        padding: const EdgeInsets.all(1.0),
                        child: const CircularProgressIndicator()),
                  ),
                )
              : CircleAvatar(
                  backgroundColor: Colors.black,
                  backgroundImage: NetworkImage(_coupons[index].url),
                );

          return Column(
            children: <Widget>[
              Padding(
                child: new ListTile(
                  title: Text(_coupons[index].title),
                  leading: GestureDetector(
                    onTap: () {
                      _showDialog(_coupons[index]);
                    },
                    child: _container,
                  ),
                ),
                padding: EdgeInsets.all(1.0),
              ),
              Divider(
                height: 5.0,
              )
            ],
          );
        },
        itemCount: _coupons.length,
      ),
    );
  }

  void _showDialog(Coupon coupon) {
    var _container = coupon.isSvg()
        ? Container(
            width: 250,
            height: 250,
            decoration: BoxDecoration(
                border: Border.all(width: 2.0),
                borderRadius: BorderRadius.all(Radius.circular(2.0))),
            child: SvgPicture.network(
              coupon.url,
              placeholderBuilder: (BuildContext context) => Container(
                  padding: const EdgeInsets.all(1.0),
                  child: const CircularProgressIndicator()),
            ),
          )
        : Container(
            width: 250,
            height: 250,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(coupon.url), fit: BoxFit.cover),
                border: Border.all(width: 2.0),
                borderRadius: BorderRadius.all(Radius.circular(2.0))),
          );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: _container,
          );
        });
  }
}
