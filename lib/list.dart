import 'dart:async';
import 'package:flutter_copoun_application/post.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

class ListPage extends StatefulWidget {
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  List<Post> _posts = [];
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

      var _result =
          await http.get('https://jsonplaceholder.typicode.com/posts');

      final List<Post> _fetchedPost = [];

      final List<dynamic> _responseList = json.decode(_result.body);

      if (_responseList == null) {
        setState(() {
          _isLoading = false;
        });
      }

      for (var i = 0; i < _responseList.length; i++) {
        _fetchedPost.add(Post(
            userId: _responseList[i]['userId'],
            id: _responseList[i]['id'],
            title: _responseList[i]['title'],
            body: _responseList[i]['body']));
      }

      setState(() {
        _posts = _fetchedPost;
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
          return Column(
            children: <Widget>[
              Padding(
                child: new ListTile(
                  title: Text(_posts[index].title),
                  subtitle: Text(_posts[index].body),
                ),
                padding: EdgeInsets.all(1.0),
              ),
              Divider(
                height: 5.0,
              )
            ],
          );
        },
        itemCount: _posts.length,
      ),
    );
  }
}
