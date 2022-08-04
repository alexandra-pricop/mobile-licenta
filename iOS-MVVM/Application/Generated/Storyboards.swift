// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

// swiftlint:disable sorted_imports
import Foundation
import UIKit

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length implicit_return

// MARK: - Storyboard Scenes

// swiftlint:disable explicit_type_interface identifier_name line_length type_body_length type_name
internal enum StoryboardScene {
  internal enum AddFirmViewController: StoryboardType {
    internal static let storyboardName = "AddFirmViewController"

    internal static let initialScene = InitialSceneType<iOS_MVVM.AddFirmViewController>(storyboard: AddFirmViewController.self)
  }
  internal enum DocumentDetailsViewController: StoryboardType {
    internal static let storyboardName = "DocumentDetailsViewController"

    internal static let initialScene = InitialSceneType<iOS_MVVM.DocumentDetailsViewController>(storyboard: DocumentDetailsViewController.self)
  }
  internal enum DocumentsReportsViewController: StoryboardType {
    internal static let storyboardName = "DocumentsReportsViewController"

    internal static let initialScene = InitialSceneType<iOS_MVVM.DocumentsReportsViewController>(storyboard: DocumentsReportsViewController.self)
  }
  internal enum DocumentsViewController: StoryboardType {
    internal static let storyboardName = "DocumentsViewController"

    internal static let initialScene = InitialSceneType<iOS_MVVM.DocumentsViewController>(storyboard: DocumentsViewController.self)
  }
  internal enum EditAccountDetailsViewController: StoryboardType {
    internal static let storyboardName = "EditAccountDetailsViewController"

    internal static let initialScene = InitialSceneType<iOS_MVVM.EditAccountDetailsViewController>(storyboard: EditAccountDetailsViewController.self)
  }
  internal enum EmployeeDetailsViewController: StoryboardType {
    internal static let storyboardName = "EmployeeDetailsViewController"

    internal static let initialScene = InitialSceneType<iOS_MVVM.EmployeeDetailsViewController>(storyboard: EmployeeDetailsViewController.self)
  }
  internal enum EmployeeListViewController: StoryboardType {
    internal static let storyboardName = "EmployeeListViewController"

    internal static let initialScene = InitialSceneType<iOS_MVVM.EmployeeListViewController>(storyboard: EmployeeListViewController.self)
  }
  internal enum FirmListViewController: StoryboardType {
    internal static let storyboardName = "FirmListViewController"

    internal static let initialScene = InitialSceneType<iOS_MVVM.FirmListViewController>(storyboard: FirmListViewController.self)
  }
  internal enum FirmRequestsViewController: StoryboardType {
    internal static let storyboardName = "FirmRequestsViewController"

    internal static let initialScene = InitialSceneType<iOS_MVVM.FirmRequestsViewController>(storyboard: FirmRequestsViewController.self)
  }
  internal enum HomeViewController: StoryboardType {
    internal static let storyboardName = "HomeViewController"

    internal static let initialScene = InitialSceneType<iOS_MVVM.HomeViewController>(storyboard: HomeViewController.self)
  }
  internal enum LaunchScreen: StoryboardType {
    internal static let storyboardName = "Launch Screen"

    internal static let initialScene = InitialSceneType<UIKit.UIViewController>(storyboard: LaunchScreen.self)
  }
  internal enum LoginScreenViewController: StoryboardType {
    internal static let storyboardName = "LoginScreenViewController"

    internal static let initialScene = InitialSceneType<iOS_MVVM.LoginScreenViewController>(storyboard: LoginScreenViewController.self)
  }
  internal enum LoginViewController: StoryboardType {
    internal static let storyboardName = "LoginViewController"

    internal static let initialScene = InitialSceneType<iOS_MVVM.LoginViewController>(storyboard: LoginViewController.self)
  }
  internal enum MainScreenViewController: StoryboardType {
    internal static let storyboardName = "MainScreenViewController"

    internal static let initialScene = InitialSceneType<iOS_MVVM.MainScreenViewController>(storyboard: MainScreenViewController.self)
  }
  internal enum ProfileViewController: StoryboardType {
    internal static let storyboardName = "ProfileViewController"

    internal static let initialScene = InitialSceneType<iOS_MVVM.ProfileViewController>(storyboard: ProfileViewController.self)
  }
  internal enum ReceiptDetailsViewController: StoryboardType {
    internal static let storyboardName = "ReceiptDetailsViewController"

    internal static let initialScene = InitialSceneType<iOS_MVVM.ReceiptDetailsViewController>(storyboard: ReceiptDetailsViewController.self)
  }
  internal enum RegisterViewController: StoryboardType {
    internal static let storyboardName = "RegisterViewController"

    internal static let initialScene = InitialSceneType<iOS_MVVM.RegisterViewController>(storyboard: RegisterViewController.self)
  }
  internal enum ReportsViewController: StoryboardType {
    internal static let storyboardName = "ReportsViewController"

    internal static let initialScene = InitialSceneType<iOS_MVVM.ReportsViewController>(storyboard: ReportsViewController.self)
  }
  internal enum RequestsScreenViewController: StoryboardType {
    internal static let storyboardName = "RequestsScreenViewController"

    internal static let initialScene = InitialSceneType<iOS_MVVM.RequestsScreenViewController>(storyboard: RequestsScreenViewController.self)
  }
  internal enum ShowReceiptViewController: StoryboardType {
    internal static let storyboardName = "ShowReceiptViewController"

    internal static let initialScene = InitialSceneType<iOS_MVVM.ShowReceiptViewController>(storyboard: ShowReceiptViewController.self)
  }
  internal enum SplashViewController: StoryboardType {
    internal static let storyboardName = "SplashViewController"

    internal static let initialScene = InitialSceneType<iOS_MVVM.SplashViewController>(storyboard: SplashViewController.self)
  }
  internal enum StartScreenViewController: StoryboardType {
    internal static let storyboardName = "StartScreenViewController"

    internal static let initialScene = InitialSceneType<iOS_MVVM.StartScreenViewController>(storyboard: StartScreenViewController.self)
  }
  internal enum UploadViewController: StoryboardType {
    internal static let storyboardName = "UploadViewController"

    internal static let initialScene = InitialSceneType<iOS_MVVM.UploadViewController>(storyboard: UploadViewController.self)
  }
}
// swiftlint:enable explicit_type_interface identifier_name line_length type_body_length type_name

// MARK: - Implementation Details

internal protocol StoryboardType {
  static var storyboardName: String { get }
}

internal extension StoryboardType {
  static var storyboard: UIStoryboard {
    let name = self.storyboardName
    return UIStoryboard(name: name, bundle: BundleToken.bundle)
  }
}

internal struct SceneType<T: UIViewController> {
  internal let storyboard: StoryboardType.Type
  internal let identifier: String

  internal func instantiate() -> T {
    let identifier = self.identifier
    guard let controller = storyboard.storyboard.instantiateViewController(withIdentifier: identifier) as? T else {
      fatalError("ViewController '\(identifier)' is not of the expected class \(T.self).")
    }
    return controller
  }

  @available(iOS 13.0, tvOS 13.0, *)
  internal func instantiate(creator block: @escaping (NSCoder) -> T?) -> T {
    return storyboard.storyboard.instantiateViewController(identifier: identifier, creator: block)
  }
}

internal struct InitialSceneType<T: UIViewController> {
  internal let storyboard: StoryboardType.Type

  internal func instantiate() -> T {
    guard let controller = storyboard.storyboard.instantiateInitialViewController() as? T else {
      fatalError("ViewController is not of the expected class \(T.self).")
    }
    return controller
  }

  @available(iOS 13.0, tvOS 13.0, *)
  internal func instantiate(creator block: @escaping (NSCoder) -> T?) -> T {
    guard let controller = storyboard.storyboard.instantiateInitialViewController(creator: block) else {
      fatalError("Storyboard \(storyboard.storyboardName) does not have an initial scene.")
    }
    return controller
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
