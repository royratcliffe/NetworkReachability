// NetworkReachability SCNetworkReachabilityFlags.swift
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

import SystemConfiguration

extension SCNetworkReachabilityFlags {

  /// Interprets the given network reachability flags, answering one of three
  /// reachable conclusions: not reachable, reachable via wi-fi or reachable via
  /// wireless wide-area network.
  ///
  /// The method translates the given combination of reachability flags within
  /// the context of some network reachability object. The flags originate from
  /// `getFlags()` or from a reachability notification, where you can extract
  /// the up-to-date flags by sending `NSNotification.userInfo` and asking for
  /// the `NetworkReachability.FlagsKey`. The key returns an `NSNumber` whose
  /// unsigned 32-bit integer value gives the flags' raw value.
  public var reachability: Reachability {
    if contains(SCNetworkReachabilityFlags.isLocalAddress) {
      if contains(SCNetworkReachabilityFlags.reachable) && contains(SCNetworkReachabilityFlags.isDirect) {
        return .reachable(.wiFi)
      } else {
        return .notReachable
      }
    } else {
      if contains(SCNetworkReachabilityFlags.reachable) {
        if contains(SCNetworkReachabilityFlags.isWWAN) {
          return .reachable(.wwan)
        } else {
          if contains(SCNetworkReachabilityFlags.connectionOnTraffic) || contains(SCNetworkReachabilityFlags.connectionOnDemand) {
            if contains(SCNetworkReachabilityFlags.interventionRequired) {
              return contains(SCNetworkReachabilityFlags.connectionRequired) ? .notReachable : .reachable(.wiFi)
            } else {
              return .reachable(.wiFi)
            }
          } else {
            return contains(SCNetworkReachabilityFlags.connectionRequired) ? .notReachable : .reachable(.wiFi)
          }
        }
      } else {
        return .notReachable
      }
    }
  }

}
