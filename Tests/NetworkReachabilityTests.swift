// NetworkReachabilityTests NetworkReachabilityTests.swift
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

import XCTest
@testable import NetworkReachability

class NetworkReachabilityTests: XCTestCase {

  // given
  let linkLocalReachability = NetworkReachability(localLink: ())
  let internetReachability = NetworkReachability(internet: ())

  func testNetworkReachabilityFlagsDescription() {
    XCTAssertEqual(NetworkReachability.Flags(rawValue: 0x00000000).description, "---------")
    XCTAssertEqual(NetworkReachability.Flags(rawValue: 0xffffffff).description, "WdlDiCcRt")
    XCTAssertEqual(NetworkReachability.Flags([.reachable]).description, "-------R-")
  }

  func testLinkLocalReachability() {
    // when
    let flags = linkLocalReachability?.getFlags()
    // then
    XCTAssertNotNil(flags)
    XCTAssertEqual(flags?.description, "-d-----R-")
  }

  func testLinkLocalReachable() {
    // when
    let flags: NetworkReachability.Flags = [.reachable, .isDirect]
    // then
    XCTAssertEqual(flags.reachability, Reachability.reachable(.wiFi))
  }

  /// Reachable on link-local addresses requires reachable and direct, not just
  /// reachable, nor just direct.
  func testLinkLocalNotReachable() {
    // when
    let localReachableFlags: NetworkReachability.Flags = [.isLocalAddress, .reachable]
    let localDirectFlags: NetworkReachability.Flags = [.isLocalAddress, .isDirect]
    // then
    XCTAssertEqual(localReachableFlags.reachability, Reachability.notReachable)
    XCTAssertEqual(localDirectFlags.reachability, Reachability.notReachable)
  }

  func testInternetReachability() {
    // when
    let flags = internetReachability?.getFlags()
    // then
    XCTAssertNotNil(flags)
    XCTAssertEqual(flags?.description, "-------R-")
  }

}
