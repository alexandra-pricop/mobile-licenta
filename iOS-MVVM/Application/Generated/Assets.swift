// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(OSX)
  import AppKit.NSImage
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIImage
#endif

// MARK: - Asset Catalogs

internal typealias Colors = Asset.Colors
internal typealias Images = Asset.Images

internal enum Asset {
  internal enum Colors {
    internal static let main = UIColor(named: "Main", in: Bundle(for: BundleToken.self), compatibleWith: nil)!
    internal static let white = UIColor(named: "White", in: Bundle(for: BundleToken.self), compatibleWith: nil)!
  }
  internal enum Images {
    internal static let logo = UIImage(named: "Logo", in: Bundle(for: BundleToken.self), compatibleWith: nil)!
    internal static let documents = UIImage(named: "documents", in: Bundle(for: BundleToken.self), compatibleWith: nil)!
    internal static let home = UIImage(named: "home", in: Bundle(for: BundleToken.self), compatibleWith: nil)!
    internal static let profile = UIImage(named: "profile", in: Bundle(for: BundleToken.self), compatibleWith: nil)!
    internal static let upload = UIImage(named: "upload", in: Bundle(for: BundleToken.self), compatibleWith: nil)!
  }
}

// MARK: - Implementation Details

private final class BundleToken {}
