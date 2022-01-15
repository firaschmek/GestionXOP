import 'package:appgestion/UI/widgets/nav_bar.dart';
import 'package:appgestion/UI/widgets/search_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../blocs/sous_famille_bloc.dart';
import '../widgets/sous_famille_item.dart';
import '../../models/sous_famille_response.dart';
import '../../networking/api_response.dart';

class SousFamilleScreen extends StatefulWidget {
  const SousFamilleScreen({Key key}) : super(key: key);

  @override
  State<SousFamilleScreen> createState() => _SousFamilleScreenState();
}

class _SousFamilleScreenState extends State<SousFamilleScreen> {
  SousFamilleBloc _bloc;
  String searchVal;
  int currentIndex = 0;
  String code_fam;

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
      _bloc = SousFamilleBloc(arguments['cod_fam']);
      this.code_fam = arguments['code_fam'];
    } else
      print("code_fam is null");
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30),
      child: RefreshIndicator(
        onRefresh: () => _bloc.fetchSousFamilleList(code_fam),
        child: StreamBuilder<ApiResponse<List<SousFamille>>>(
          stream: _bloc.sousFamilleListStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.data.status) {
                case Status.LOADING:
                  return Loading(loadingMessage: snapshot.data.message);
                  break;
                case Status.COMPLETED:
                  return SousFamilleList(familleList: snapshot.data.data);
                  break;
                case Status.ERROR:
                  return Error(
                    errorMessage: snapshot.data.message,
                    onRetryPressed: () => _bloc.fetchSousFamilleList(code_fam),
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

class SousFamilleList extends StatefulWidget {
  final List<SousFamille> familleList;
  List<SousFamille> queryList;
  final Function(String) updateList;

  SousFamilleList({Key key, this.familleList, this.updateList})
      : super(key: key);

  @override
  State<SousFamilleList> createState() => _SousFamilleListState();
}

class _SousFamilleListState extends State<SousFamilleList> {
  @override
  void initState() {
    super.initState();
    widget.queryList = widget.familleList;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 20, top: 10),
          child: Text(
            "SousFamilles",
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
                  ? widget.familleList
                      .where((element) => element.lib_sfam
                          .toUpperCase()
                          .contains(val.toUpperCase()))
                      .toList()
                  : widget.familleList;
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
                return SousFamilleItem(widget.queryList[index]);
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
