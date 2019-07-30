import 'package:flutter/material.dart';

class SHTextField extends StatefulWidget {
  SHTextField(
      {this.hintText,
      this.obscure = false,
      this.icon,
      this.inputtype = TextInputType.text,
      this.text});
  final String hintText;
  final bool obscure;
  final IconData icon;
  final TextInputType inputtype;
  String text;
  bool isClear = false;
  bool isError = false;
  String errorMessage = "";
  SHTextFieldState sHTextFieldState = new SHTextFieldState();
  TextEditingController controller = new TextEditingController();

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return sHTextFieldState;
  }
}

class SHTextFieldState extends State<SHTextField> {
  FocusNode _focusNode;
  @override
  void initState() {
    widget.controller.text = widget.text;
    widget.controller.addListener(_printLatestValue);
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        setState(() {
          widget.isClear = false;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _printLatestValue() {
    widget.text = widget.controller.text;
    if (widget.isError) {
      setState(() {
        widget.isError = false;
      });
    }
    if (widget.controller.text.length > 0 &&
        !widget.isClear &&
        _focusNode.hasFocus) {
      setState(() {
        widget.isClear = true;
      });
    }
    if (widget.controller.text.length <= 0 && widget.isClear) {
      setState(() {
        widget.isClear = false;
      });
    }
  }

  void showErrorMessage(String message) {
    setState(() {
      widget.isError = true;
      widget.errorMessage = message;
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Column(
      children: <Widget>[
        new Container(
          child: new Row(
            children: <Widget>[
              new Icon(
                widget.icon,
                color: const Color(0xFF0C0738),
              ),
              new SizedBox(
                width: width / 30,
              ),
              new Expanded(
                  child: new TextFormField(
                controller: widget.controller,
                obscureText: widget.obscure,
                focusNode: _focusNode,
                keyboardType: widget.inputtype,
                onSaved: (String val) {
                  widget.text = val;
                },
                decoration: new InputDecoration(
                    labelText: widget.hintText,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent)),
                    labelStyle: TextStyle(color: const Color(0xFF0C0738))),
              )),
              widget.isClear
                  ? new IconButton(
                      icon: Icon(
                        Icons.cancel,
                        color: const Color(0xFF0C0738),
                      ),
                      onPressed: () {
                        setState(() {
                          widget.text = "";
                          widget.controller.text = "";
                          widget.isClear = false;
                        });
                      })
                  : Container()
            ],
          ),
          padding: EdgeInsets.only(
            bottom: 4.0,
          ),
          margin: EdgeInsets.only(
              top: height / 80, right: width / 20, left: width / 20),
          decoration: BoxDecoration(
              border: new Border(
                  bottom: BorderSide(color: const Color(0xFF0C0738)))),
        ),
        widget.isError
            ? Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Icon(
                    Icons.warning,
                    size: 15.0,
                    color: Colors.red,
                  ),
                  SizedBox(
                    width: 4.0,
                  ),
                  Text(widget.errorMessage),
                  SizedBox(
                    width: 20.0,
                  )
                ],
              )
            : Container()
      ],
    );
  }
}
