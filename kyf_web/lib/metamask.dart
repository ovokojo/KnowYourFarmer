import 'package:universal_html/html.dart' as html;
import 'package:flutter_web3/flutter_web3.dart' as ethers;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MetaMaskProvider extends ChangeNotifier {
  static const operatingChain = 1337; // change to local
  String currentAddress = '';
  int currentChain = -1;

  bool get isEnabled => ethers.ethereum != null;
  bool get isInOperatingChain => currentChain == operatingChain;
  bool get isConnected => isEnabled && currentAddress.isNotEmpty;

  Future<void> connect() async {
    if (isEnabled) {
      final acct = await ethers.ethereum!.requestAccount();
      if (acct.isNotEmpty) {
        currentAddress = acct.first;
        currentChain = await ethers.ethereum!.getChainId();
        notifyListeners();
      }
    }
  }

  clear() {
    String currentAddress = '';
    int currentChain = -1;
  }

  init() {
    if (isEnabled) {
      ethers.ethereum!.onAccountsChanged((accounts) {
        html.window.location.reload();
        notifyListeners();
        clear();
      });
      ethers.ethereum!.onChainChanged((accounts) {
        html.window.location.reload();
        notifyListeners();
        clear();
      });
    }
  }
}

// UI

class MetamaskButton extends StatelessWidget {
  const MetamaskButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final metamask = Provider.of<MetaMaskProvider>(context);
    return Consumer<MetaMaskProvider>(builder: (context, metamask, child) {
      late final String text;
      if (metamask.isConnected && metamask.isInOperatingChain) {
        child = Text('Connected');
      } else if (metamask.isConnected && !metamask.isInOperatingChain) {
        child = Text('Wrong Chain. Please connect to ${MetaMaskProvider.operatingChain}');
      } else if (metamask.isEnabled) {
        child = ElevatedButton(
            // Note: note that `context.read<T>()` is interchangeable with `Provider.of<T>(context)`.
            onPressed: () => context.read<MetaMaskProvider>().connect(),
            child: Text("Connect To Metamask"));
      } else {
        child = Text('Please use web3 browser');
      }
      return child;
    });
  }
}

// Popup to show when MetaMask is not connected
connectMetaMaskPopup(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("MetaMask not connected"),
          content: Text("Please connect to MetaMask"),
          actions: [
            ElevatedButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      });
}
