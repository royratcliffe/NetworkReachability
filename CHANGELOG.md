# Change Log

## [0.2.0](https://github.com/royratcliffe/NetworkReachability/tree/0.2.0) (2016-08-13)

- Merge branch 'feature/swift_3_0' into develop
- Renamed sub-folders to Sources and Tests
- Fix Travis configuration
- Upgrade to latest Swift 3.0 using Xcode 8, beta 5

[Full Change Log](https://github.com/royratcliffe/NetworkReachability/compare/0.1.4...0.2.0)

## [0.1.4](https://github.com/royratcliffe/NetworkReachability/tree/0.1.4) (2016-08-13)

- Fix Travis configuration
- Sources and tests in sub-folders: Sources and Tests
- Merge branch 'feature/swift_2_3' into develop
- Whole-module Swift optimisation
- Using Xcode 8
- Using Swift 2.3

[Full Change Log](https://github.com/royratcliffe/NetworkReachability/compare/0.1.3...0.1.4)

## [0.1.3](https://github.com/royratcliffe/NetworkReachability/tree/0.1.3) (2016-06-14)

- Store old flags, derive flags changed
- Merge branch 'feature/swift_lint' into develop
- SwiftLint configuration
- Fix whitespace
- Run SwiftLint automatically
- Clean up Pod description's whitespace

[Full Change Log](https://github.com/royratcliffe/NetworkReachability/compare/0.1.2...0.1.3)

## [0.1.2](https://github.com/royratcliffe/NetworkReachability/tree/0.1.2) (2016-03-24)

- Deprecation for Swift 2.2: var parameters
- Note in comment with regard to posting different reachability notifications

[Full Change Log](https://github.com/royratcliffe/NetworkReachability/compare/0.1.1...0.1.2)

## [0.1.1](https://github.com/royratcliffe/NetworkReachability/tree/0.1.1) (2016-03-19)

- Factored out postFlagsDidChangeNotification
- Added flagsChanged
- Xcode 7.2 (Travis)
- Update `xctool` using Homebrew
- Do not specify iPhone simulator version (Travis fix)
- Tell Travis to test using iPhone simulator
- Share the scheme for Travis
- Remove Tests from scheme
- Travis wants an explicit project and scheme

[Full Change Log](https://github.com/royratcliffe/NetworkReachability/compare/0.1.0...0.1.1)

## [0.1.0](https://github.com/royratcliffe/NetworkReachability/tree/0.1.0) (2016-02-25)

- CocoaPods specification
- Use onFlagsDidChange internally
- Added onFlagsDidChange(callback) method
- Removed redundant "given" comment
- Not-reachable test on link-local addresses
- Use assert equal
- MIT license
- Ignore build and docs sub-folders
- Jazzy configuration
- Travis CI integration
- Initial commit
