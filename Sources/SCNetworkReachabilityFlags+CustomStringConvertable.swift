// NetworkReachability SCNetworkReachabilityFlags+CustomStringConvertable.swift
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

extension SCNetworkReachabilityFlags: CustomStringConvertible {

  /// Maps between network reachability flags and characters. Ordering is
  /// important. Left-to-right in the resulting string corresponds to
  /// most-to-least significant flags.
  public var description: String {
    var description = ""
    [
      // The “Is WWAN flag” is only available on iOS, i.e. iPhones and
      // iPads. Devices without GPRS, EDGE or other “cell” connection hardware
      // cannot reach Wireless Wide-Area Networks.
      //
      // Always include this flag even for non-iOS platforms however. Doing so
      // will make the first flag character always output a dash for such
      // platforms. But the resulting string will always have a consistent
      // length, with consistent character flag positions within the string,
      // regardless of the platform. The framework aims towards cross-platform
      // compatibility.
      ("W", SCNetworkReachabilityFlags.isWWAN),

      ("d", SCNetworkReachabilityFlags.isDirect),
      ("l", SCNetworkReachabilityFlags.isLocalAddress),
      ("D", SCNetworkReachabilityFlags.connectionOnDemand),
      ("i", SCNetworkReachabilityFlags.interventionRequired),
      ("C", SCNetworkReachabilityFlags.connectionOnTraffic),
      ("c", SCNetworkReachabilityFlags.connectionRequired),
      ("R", SCNetworkReachabilityFlags.reachable),
      ("t", SCNetworkReachabilityFlags.transientConnection),
    ].forEach { (string, flags) in
      description.append(contains(flags) ? string : "-")
    }
    return description
  }

}
