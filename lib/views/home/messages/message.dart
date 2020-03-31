import 'package:Tether/domain/rooms/events/model.dart';
import 'package:Tether/global/colors.dart';
import 'package:Tether/global/formatters.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/**
 * RoundedPopupMenu
 * Mostly an example for myself on how to override styling or other options on
 * existing components app wide
 */
class MessageWidget extends StatelessWidget {
  MessageWidget({
    Key key,
    @required this.message,
    this.isUserSent,
    this.isLastSender,
    this.isNextSender,
  }) : super(key: key);

  final Message message;
  final bool isLastSender;
  final bool isNextSender;
  final bool isUserSent;

  @override
  Widget build(BuildContext context) {
    final message = this.message;
    var textColor = Colors.white;
    var senderColor = hashedColor(message.sender);
    var bubbleBorder = BorderRadius.circular(16);
    var messageAlignment = MainAxisAlignment.start;
    var messageTextAlignment = CrossAxisAlignment.start;
    var bubbleSpacing = EdgeInsets.symmetric(vertical: 8);

    if (isLastSender) {
      if (isNextSender) {
        // Message in the middle of a sender messages block
        bubbleSpacing = EdgeInsets.symmetric(vertical: 2);
        bubbleBorder = BorderRadius.only(
          topRight: Radius.circular(16),
          bottomRight: Radius.circular(16),
          topLeft: Radius.circular(4),
          bottomLeft: Radius.circular(4),
        );
      } else {
        // Message at the beginning of a sender messages block
        bubbleSpacing = EdgeInsets.only(top: 8, bottom: 2);
        bubbleBorder = BorderRadius.only(
          topRight: Radius.circular(16),
          bottomRight: Radius.circular(16),
          topLeft: Radius.circular(16),
          bottomLeft: Radius.circular(4),
        );
      }
    }

    if (!isLastSender && isNextSender) {
      // End of a sender messages block
      bubbleSpacing = EdgeInsets.only(top: 2, bottom: 8);
      bubbleBorder = BorderRadius.only(
        topRight: Radius.circular(16),
        bottomRight: Radius.circular(16),
        bottomLeft: Radius.circular(16),
        topLeft: Radius.circular(4),
      );
    }

    if (isUserSent) {
      textColor = GREY_DARK_COLOR;
      senderColor = ENABLED_GREY_COLOR;
      messageAlignment = MainAxisAlignment.end;
      messageTextAlignment = CrossAxisAlignment.end;
    }

    return Container(
      child: Flex(
        direction: Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: bubbleSpacing,
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
            ),
            // decoration: BoxDecoration( // DEBUG ONLY
            //   color: Colors.red,
            // ),
            child: Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: messageAlignment,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Visibility(
                  visible: !isLastSender && !isUserSent,
                  maintainState: true,
                  maintainAnimation: true,
                  maintainSize: true,
                  child: Container(
                    margin: const EdgeInsets.only(
                      right: 12,
                    ),
                    child: CircleAvatar(
                      radius: 14,
                      backgroundColor: senderColor,
                      child: Text(
                        formatSenderInitials(message.sender),
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  fit: FlexFit.loose,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                        color: senderColor, borderRadius: bubbleBorder),
                    child: Flex(
                        direction: Axis.vertical,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: messageTextAlignment,
                        children: <Widget>[
                          Visibility(
                            visible: !isUserSent,
                            child: Container(
                              margin: EdgeInsets.only(bottom: 4),
                              child: Text(
                                formatSender(message.sender),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: textColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 4),
                            child: Text(
                              message.body.trim(),
                              style: TextStyle(
                                fontSize: 14,
                                color: textColor,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                          Container(
                            child: Text(
                              formatTimestamp(
                                lastUpdateMillis: message.timestamp,
                              ),
                              style: TextStyle(
                                fontSize: 12,
                                color: textColor,
                                fontWeight: FontWeight.w100,
                              ),
                            ),
                          )
                        ]),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
