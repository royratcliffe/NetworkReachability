// NetworkReachability NetworkReachability+Convenience.swift
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

extension NetworkReachability {

  // MARK: - Convenience Initialisers: Socket Address

  public convenience init?(address: sockaddr) {
    guard let ref = create(with: address) else {
      return nil
    }
    self.init(ref: ref)
  }

  // MARK: - Convenience Initialisers: Internet Address

  public convenience init?(internetAddress: in_addr_t) {
    var address = sockaddr_in()
    address.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
    address.sin_family = sa_family_t(AF_INET)
    address.sin_addr.s_addr = CFSwapInt32HostToBig(internetAddress)
    guard let ref = create(with: address) else {
      return nil
    }
    self.init(ref: ref)
  }

  public convenience init?(internet: ()) {
    self.init(internetAddress: INADDR_ANY)
  }

  public convenience init?(localLink: ()) {
    self.init(internetAddress: IN_LINKLOCALNETNUM)
  }

  // MARK: - Convenience Initialisers: Host Name

  public convenience init?(name: String) {
    guard let ref = SCNetworkReachabilityCreateWithName(nil, name) else {
      return nil
    }
    self.init(ref: ref)
  }

}
