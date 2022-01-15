
import 'package:appgestion/UI/widgets/product_item.dart';
import 'package:appgestion/UI/widgets/search_field.dart';
import 'package:appgestion/blocs/article_bloc.dart';
import 'package:appgestion/models/article_response.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../networking/api_response.dart';

class ArticleScreen extends StatefulWidget {
  const ArticleScreen({Key key}) : super(key: key);

  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  ArticleBloc _bloc;
  String searchVal;
  int currentIndex = 0;
  String code_s_fam;

  @override
  void initState() {
    super.initState();

  }
@override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    final arguments = ModalRoute.of(context).settings.arguments as Map;

    if (arguments != null) {
      _bloc = ArticleBloc(arguments['cod_s_fam']);
      this.code_s_fam = arguments['cod_s_fam'];
    } else
      print("code_s_fam is null");
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30),
      child: RefreshIndicator(
        onRefresh: () => _bloc.fetchArticleList(code_s_fam),
        child: StreamBuilder<ApiResponse<List<Article>>>(
          stream: _bloc.articleListStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.data.status) {
                case Status.LOADING:
                  return Loading(loadingMessage: snapshot.data.message);
                  break;
                case Status.COMPLETED:
                  return ArticleList(articleList: snapshot.data.data);
                  break;
                case Status.ERROR:
                  return Error(
                    errorMessage: snapshot.data.message,
                    onRetryPressed: () => _bloc.fetchArticleList(code_s_fam),
                  );
                  break;
              }
            }
            return Container();
          },
        ),
      ),
    );
  }
}

class ArticleList extends StatefulWidget {
  final List<Article> articleList;
  List<Article> queryList;
  final Function(String) updateList;

  ArticleList({Key key, this.articleList, this.updateList})
      : super(key: key);

  @override
  State<ArticleList> createState() => _ArticleListState();
}

class _ArticleListState extends State<ArticleList> {
  @override
  void initState() {
    super.initState();
    widget.queryList = widget.articleList;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 20, top: 10),
          child: Text(
            "Articles",
            style: GoogleFonts.pacifico(
              textStyle: TextStyle(
                  fontSize: 20, color: Colors.black, letterSpacing: .5),
            ),
          ),
        ),
        SearchField(
          onSearchTxtChanged: (String val) {
            setState(() {
              widget.queryList = (val != null && val.isNotEmpty)
                  ? widget.articleList
                      .where((element) => element.lib_art
                          .toUpperCase()
                          .contains(val.toUpperCase()))
                      .toList()
                  : widget.articleList;
            });
          },
        ),
        Expanded(
          child: SizedBox(
            child: GridView.builder(
              itemCount: widget.queryList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.5 / 1.8,
              ),
              itemBuilder: (context, index) {
                return ProductItem(widget.queryList[index]);
              },
            ),
          ),
        )
      ],
    );
  }
}

class Error extends StatelessWidget {
  final String errorMessage;

  final Function onRetryPressed;

  const Error({Key key, this.errorMessage, this.onRetryPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            errorMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.red,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 8),
          RaisedButton(
            color: Colors.redAccent,
            child: Text(
              'Retry',
              style: TextStyle(
//                color: Colors.white,
                  ),
            ),
            onPressed: onRetryPressed,
          )
        ],
      ),
    );
  }
}

class Loading extends StatelessWidget {
  final String loadingMessage;

  const Loading({Key key, this.loadingMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            loadingMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
//              color: Colors.lightGreen,
              fontSize: 24,
            ),
          ),
          SizedBox(height: 24),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.lightGreen),
          ),
        ],
      ),
    );
  }
}
