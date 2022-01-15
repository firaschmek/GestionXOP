import 'package:appgestion/UI/widgets/search_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../blocs/famille_bloc.dart';
import '../widgets/famille_item.dart';
import '../../models/famille_response.dart';
import '../../networking/api_response.dart';

class FamilleScreen extends StatefulWidget {
  const FamilleScreen({Key key}) : super(key: key);

  @override
  State<FamilleScreen> createState() => _FamilleScreenState();
}

class _FamilleScreenState extends State<FamilleScreen> {
  FamilleBloc _bloc;
  String searchVal;

  @override
  void initState() {
    super.initState();
    _bloc = FamilleBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30),
      child: RefreshIndicator(
        onRefresh: () => _bloc.fetchFamilleList(),
        child: StreamBuilder<ApiResponse<List<Famille>>>(
          stream: _bloc.familleListStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.data.status) {
                case Status.LOADING:
                  return Loading(loadingMessage: snapshot.data.message);
                  break;
                case Status.COMPLETED:
                  return FamilleList(familleList: snapshot.data.data);
                  break;
                case Status.ERROR:
                  return Error(
                    errorMessage: snapshot.data.message,
                    onRetryPressed: () => _bloc.fetchFamilleList(),
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

class FamilleList extends StatefulWidget {
  final List<Famille> familleList;
  List<Famille> queryList;
  final Function(String) updateList;

  FamilleList({Key key, this.familleList, this.updateList}) : super(key: key);

  @override
  State<FamilleList> createState() => _FamilleListState();
}

class _FamilleListState extends State<FamilleList> {


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
            "Familles",
            style: GoogleFonts.pacifico(
              textStyle: TextStyle(
                  fontSize: 20, color: Colors.black, letterSpacing: .5),
            ),
          ),
        ),
        SearchField(
          onSearchTxtChanged: (String val) {
            setState(() {
              widget.queryList= (val != null && val.isNotEmpty)
                  ? widget.familleList.where((element) =>
                  element.lib_fam.toUpperCase().contains(val.toUpperCase())).toList()
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
                return FamilleItem(widget.queryList[index]);
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
