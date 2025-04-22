import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provide_boiler_plate/utils/delegate.dart';
import 'package:stacked/stacked.dart';

import '../../commons/colors.dart';
import '../../commons/strings.dart';
import '../../commons/styles.dart';
import '../../utils/dialogs.dart';
import 'login_view_model.dart';

class LoginView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginView();
}

class _LoginView extends State<LoginView> implements Delegate {
  BuildContext? _context;

  final GlobalKey<FormState> _formState = GlobalKey();
  LoginViewModel? _viewModel;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
        builder: (context, vm, child) {
          _context = context;
          _viewModel = vm;

          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text(
                login,
                style: appBarTitleTextStyle,
              ),
              shadowColor: Colors.transparent,
              backgroundColor: Colors.white,
              leading: new IconButton(
                icon: new Icon(
                  Icons.arrow_back_ios_rounded,
                  color: base,
                  size: 24,
                ),
                onPressed: () {
                  if (Navigator.canPop(context)) Navigator.of(context).pop();
                },
              ),
            ),
            body: Form(
              key: _formState,
              child: Stack(children: [
                Visibility(
                  visible: _viewModel?.state == ViewState.Loading,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    _phoneNumberFun(),
                    SizedBox(
                      height: 10,
                    ),
                    _pass(),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 25.0, right: 25),
                            child: Row(
                              children: [
                                Flexible(
                                    flex: 5,
                                    child: Divider(
                                      color: disableButton,
                                      thickness: 1,
                                    )),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 5.0, right: 5.0),
                                  child: Text("or"),
                                ),
                                Flexible(
                                    flex: 5,
                                    child: Divider(
                                      color: disableButton,
                                      thickness: 1,
                                    )),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          _login(context),
                        ],
                      )),
                ),
              ]),
            ),
          );
        },
        viewModelBuilder: () => LoginViewModel(this));
  }

  Widget _pass() {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25),
      child: TextFormField(
        textInputAction: TextInputAction.done,
        controller: _viewModel?.password,
        validator: (value) {
          return value == null || value.isEmpty ? passWordEmptyMsg : null;
        },
        style: mediumFontStyleNormal,
        decoration: InputDecoration(
          labelStyle: mediumHintFontStyleNormal,
          hintStyle: mediumHintFontStyleNormal,
          labelText: enterPassword,
          alignLabelWithHint: true,
        ),
      ),
    );
  }

  Widget _phoneNumberFun() {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25),
      child: TextFormField(
        autofocus: false,
        textInputAction: TextInputAction.next,
        controller: _viewModel?.username,
        maxLength: 10,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
        ],
        validator: (value) {
          return value == null || value.isEmpty ? phoneNumberEmptyMsg : null;
        },
        keyboardType: TextInputType.phone,
        style: mediumFontStyleNormal,
        decoration: InputDecoration(
          labelStyle: mediumHintFontStyleNormal,
          counterText: "",
          prefixText: "+91",
          hintStyle: mediumHintFontStyleNormal,
          labelText: enterPhoneNumber,
          suffixIcon: Icon(
            Icons.phone,
            color: disableButton,
            size: 20,
          ),
          alignLabelWithHint: true,
        ),
      ),
    );
  }

  Widget _login(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.only(left: 25.0, right: 25),
        child: Container(
          height: kToolbarHeight - 10,
          decoration: BoxDecoration(
              color: base, borderRadius: BorderRadius.circular(5)),
          child: Center(
            child: Text(
              login,
              style: mediumTextStyle.copyWith(color: Colors.white),
            ),
          ),
        ),
      ),
      onTap: () async {
        _viewModel?.login();
      },
    );
  }

  @override
  onError(msg) {
    Dialogs.showErrorPopup(context, msg);
  }

  @override
  onSuccess() {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Loggin Successful')));
  }
}
