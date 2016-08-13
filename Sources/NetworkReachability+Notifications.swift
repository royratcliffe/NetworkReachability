// NetworkReachability NetworkReachability+Notifications.swift
//
// Copyright © 2016, Roy Ratcliffe, Pioneering Software, United Kingdom
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the “Software”), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED “AS IS,” WITHOUT WARRANTY OF ANY KIND, EITHER
// EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO
// EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES
// OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
// ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
// DEALINGS IN THE SOFTWARE.
//
//------------------------------------------------------------------------------

import Foundation

public let FlagsDidChangeNotification = "NetworkReachabilityFlagsDidChange"
public let FlagsKey = "NetworkReachabilityFlags"

extension NetworkReachability {

  /// It is common to have a network reachability object to post notifications,
  /// rather than invoke a call-back capture. This method supplies a capture
  /// that converts the call-back to a notification.
  public func beginGeneratingFlagsDidChangeNotifications() {
    onFlagsDidChange { [weak self] (networkReachability) -> Void in
      guard let strongSelf = self else { return }
      strongSelf.postFlagsDidChangeNotification()
    }
  }

  /// Posts a flags-did-change notification. This method exists separately in
  /// order that applications can trigger an initial notification, if required,
  /// and also supply a call-back that performs custom handling _as well as_
  /// posting notifications. For example, applications may wish to post
  /// different notifications for different types of reachability: one for local
  /// link, another for Internet.
  ///
  /// Posts to the default notification centre. The network reachability wrapper
  /// becomes the notification object. The notification's user information
  /// contains the changed flag type-converted to an unsigned 32-bit integer.
  public func postFlagsDidChangeNotification() {
    let userInfo = [FlagsKey: NSNumber(value: flags.rawValue)]
    let center = NotificationCenter.default
    center.post(name: Notification.Name(rawValue: FlagsDidChangeNotification), object: self, userInfo: userInfo)
  }

}
