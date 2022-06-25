import 'package:flutter/material.dart';
import 'package:kyf_mobile/models/farmer.dart';
import 'package:kyf_mobile/services/ipfsUploader.dart';
import 'package:kyf_mobile/services/validations.dart';
import 'package:kyf_mobile/styles/styles.dart';
import 'package:uuid/uuid.dart';

class NewFarmer extends StatefulWidget {
  const NewFarmer({Key? key}) : super(key: key);

  @override
  State<NewFarmer> createState() => _NewFarmerState();
}

class _NewFarmerState extends State<NewFarmer> {
  String _labelName = "Enter name";
  String _labelPhone = "Enter phone";
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  FocusNode _focusNodeName = FocusNode();
  FocusNode _focusNodePhone = FocusNode();
  ScrollController _scrollController = ScrollController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  var _uid = Uuid();

  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;
    final ipfs = IpfsUploader();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: keyboardIsOpen ? false : true,
        centerTitle: true,
        title: Text("New Farmer"),
      ),
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    focusNode: _focusNodeName,
                    cursorColor: Colors.green,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    decoration: primaryFormDecoration(_labelName),
                    validator: nameValidator,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _phoneController,
                    focusNode: _focusNodePhone,
                    cursorColor: Colors.green,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    decoration: primaryFormDecoration(_labelPhone),
                    validator: phoneValidator,
                  ),
                  OutlinedButton.icon(
                    style: ButtonStyle(),
                    icon: Icon(Icons.upload),
                    label: Text("Submit"),
                    onPressed: () {
                      final newFarmer = Farmer(
                          uid: _uid.v4(), name: _nameController.text, phone: _phoneController.text);
                      print(newFarmer.toString());
                      setState(() {
                        _isLoading = true;
                        ipfs.upload(context: context, farmer: newFarmer);
                      });
                    },
                  )
                ],
              )),
        ),
      )),
    );
  }
}
