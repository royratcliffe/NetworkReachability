// NetworkReachability NetworkReachability.swift
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

/// Wraps the SystemConfiguration framework's network reachability class. The
/// wrapper converts Core Foundation to a Swift-style network reachability
/// class.
public class NetworkReachability {

  public typealias Ref = SCNetworkReachability

  public typealias Flags = SCNetworkReachabilityFlags

  /// The designated initialiser always sets up the call-back.
  public init(ref: Ref) {
    self.ref = ref
    var context = SCNetworkReachabilityContext(version: 0,
      info: UnsafeMutableRawPointer(Unmanaged.passUnretained(self).toOpaque()),
      retain: nil,
      release: nil,
      copyDescription: nil)
    let success = SCNetworkReachabilitySetCallback(ref, NetworkReachability.callback, &context)
    assert(success)
  }

  deinit {
    let success = SCNetworkReachabilitySetCallback(ref, nil, nil)
    assert(success)
  }

  let ref: Ref

  /// Latest network reachability flags. The flags update when you ask for the
  /// flags synchronously, using `getFlags()`, or when the flags change
  /// asynchronously when the System Configuration framework calls back with new
  /// flags.
  ///
  /// Setting the flags updates the changed flags. The changed flags change just
  /// before the new flags replace the old flags. The new changed flags indicate
  /// which flags have changed and which flags have not changed.
  public internal(set) var flags: Flags = [] {
    willSet(newFlags) {
      oldFlags = flags
    }
  }

  /// - returns: Previous value of the flags. Old flags change automatically
  ///   whenever the current flags take a new value. This happens whenever the
  ///   network reachability changes.
  public internal(set) var oldFlags: Flags = []

  /// Indicates which flags changed state at the last change. Do not confuse
  /// these flags with the current latest flags; these are the flags that
  /// changed, *not* the changed flags.
  public var flagsChanged: Flags {
    return oldFlags.symmetricDifference(flags)
  }

  /// The second call-out argument to `SCNetworkReachabilitySetCallback` is a C
  /// function pointer and *not* a closure that can capture context; even though
  /// it looks like a closure. It carries the C-convention tag and so defines a
  /// block of code that exists as a C function with C calling
  /// conventions. Hence it cannot run like a normal closure.
  static let callback: SCNetworkReachabilityCallBack = { (ref, flags, info) -> Void in
    guard let info = info else {
      return
    }
    let networkReachability: NetworkReachability = Unmanaged.fromOpaque(info).takeUnretainedValue()

    // This is just pure paranoia. But then why not? Logically, the reference
    // given should match the reference retained by the wrapper. Compare
    // reference identity rather than value, although it amounts to the same
    // thing since the reference is an opaque value representing some Core
    // Foundation object with its Swift-external identity.
    guard networkReachability.ref === ref else {
      return
    }

    networkReachability.didChange(flags: flags)
  }

  /// Acquires the current network reachability flags, answering non-nil if
  /// successfully acquired; answering nil otherwise.
  ///
  /// Beware! The System Configuration framework operates synchronously by
  /// default when explicitly asking for flags. See Technical Q&A QA1693,
  /// Synchronous Networking On The Main Thread. Asking for flags blocks the
  /// current thread and potentially kills your iOS application if the
  /// reachability enquiry does not respond before the application watchdog
  /// times out.
  public func getFlags() -> Flags? {
    var flags: Flags = []
    guard SCNetworkReachabilityGetFlags(ref, &flags) else {
      return nil
    }
    self.flags = flags
    return flags
  }

  public var callback: ((NetworkReachability) -> Void)?

  public func onFlagsDidChange(_ callback: ((NetworkReachability) -> Void)?) {
    self.callback = callback
  }

  public func schedule(in runLoop: RunLoop, forMode mode: String) {
    SCNetworkReachabilityScheduleWithRunLoop(ref, runLoop.getCFRunLoop(), mode as CFString)
  }

  public func remove(from runLoop: RunLoop, forMode mode: String) {
    SCNetworkReachabilityUnscheduleFromRunLoop(ref, runLoop.getCFRunLoop(), mode as CFString)
  }

  public var dispatchQueue: DispatchQueue? {
    get {
      return nil
    }
    set(newDispatchQueue) {
      SCNetworkReachabilitySetDispatchQueue(ref, newDispatchQueue)
    }
  }

  /// This is a method that sub-classes can override, if required. Though
  /// typically, overriding is not necessary or desirable.
  func didChange(flags: SCNetworkReachabilityFlags) {
    self.flags = flags
    callback?(self)
  }

}
