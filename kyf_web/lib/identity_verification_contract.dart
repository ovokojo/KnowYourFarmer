import 'package:flutter/material.dart';
import 'package:flutter_web3/ethers.dart';

class IdentityVerificationContract extends ChangeNotifier {
  String _abiCode =
      "[{'inputs':[],'stateMutability':'nonpayable','type':'constructor'},{'inputs':[],'name':'owner','outputs':[{'internalType':'address','name':'','type':'address'}],'stateMutability':'view','type':'function'},{'inputs':[{'internalType':'string','name':'cid','type':'string'},{'internalType':'bytes32','name':'data','type':'bytes32'},{'internalType':'bytes32','name':'hash','type':'bytes32'}],'name':'verify','outputs':[{'internalType':'bool','name':'','type':'bool'}],'stateMutability':'payable','type':'function'},{'inputs':[],'name':'withdrawFeeBalance','outputs':[{'internalType':'bool','name':'','type':'bool'}],'stateMutability':'nonpayable','type':'function'}]";
  String? _contractAddress = '0xb3A4DDfFBF8836c825295BFf5d3d01DfB0C66f2f';
  Contract? _contract;

  IdentityVerificationContract() {
    init();
  }

  Future<void> init() async {
    await getContract();
  }

  getContract() {
    print('getting contract..');
    _contract = Contract(
      _contractAddress!,
      _abiCode,
      provider,
    );
  }
}
