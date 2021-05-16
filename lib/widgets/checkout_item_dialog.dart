import 'package:brother_app/providers/checkout_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../util/constants.dart' as constants;

class CheckoutItemDialog extends StatefulWidget {
  final int productId;

  const CheckoutItemDialog({Key? key, required this.productId})
      : super(key: key);

  @override
  _CheckoutItemDialogState createState() => _CheckoutItemDialogState();
}

class _CheckoutItemDialogState extends State<CheckoutItemDialog> {
  @override
  void initState() {
    super.initState();
    context
        .read<CheckoutProvider>()
        .initializeNewCheckoutDialog(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    int tempAmount = context.read<CheckoutProvider>().tempAmount;

    return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Stack(
          children: [
            Container(
                padding: EdgeInsets.fromLTRB(
                    constants.PADDING,
                    constants.AVATAR_RADIUS + constants.PADDING,
                    constants.PADDING,
                    constants.PADDING),
                margin: EdgeInsets.only(top: constants.AVATAR_RADIUS),
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(constants.PADDING),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black,
                          offset: Offset(0, 10),
                          blurRadius: 10)
                    ]),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                            flex: 5,
                            child: MaterialButton(
                                child: Icon(
                                  Icons.chevron_left,
                                ),
                                onPressed: tempAmount > 0
                                    ? (() {
                                        context
                                            .read<CheckoutProvider>()
                                            .decrementTempAmount();
                                        setState(() {});
                                      })
                                    : null //Disables the button
                                )),
                        Expanded(
                            flex: 3,
                            child: Text(
                              tempAmount.toString(),
                            )),
                        Expanded(
                            flex: 5,
                            child: MaterialButton(
                                child: Icon(
                                  Icons.chevron_right,
                                ),
                                onPressed: (() {
                                  setState(() {
                                    context
                                        .read<CheckoutProvider>()
                                        .incrementTempAmount();
                                  });
                                }))),
                        //Arrows and value amount
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Align(
                        alignment: Alignment.bottomRight,
                        child: TextButton(
                          onPressed: () {
                            if (tempAmount == 0) {
                              context
                                  .read<CheckoutProvider>()
                                  .removeScannedId(widget.productId);
                            } else {
                              context
                                  .read<CheckoutProvider>()
                                  .setNewAmountForId(widget.productId);
                            }
                            Navigator.pop(context);
                          },
                          child: tempAmount > 0
                              ? Text("Submit")
                              : Text("Confirm Delete"),
                        ))
                  ],
                )),
            Positioned(
              left: constants.PADDING,
              right: constants.PADDING,
              child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: constants.AVATAR_RADIUS,
                  child: ClipRRect()),
            )
          ],
        ));
  }
}
