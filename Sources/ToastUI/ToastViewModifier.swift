//
//  ToastViewModifier.swift
//  ToastUI
//
//  Created by Quan Tran on 7/17/20.
//

import SwiftUI
import os

enum PresentingState {
  case disappeared, appearing, appeared, disappearing
}

let logger = Logger(subsystem: "com.quanshousio.ToastUI", category: "ToastUI")

#if os(iOS) || os(tvOS)
struct ToastViewIsPresentedModifier<ToastContent>: ViewModifier where ToastContent: View {
  @Binding var isPresented: Bool
  let dismissAfter: Double?
  let onDismiss: (() -> Void)?
  let content: () -> ToastContent
  
  @State private var toastWindow: UIWindow!
  @State private var viewController: UIViewController!
  
  @State private var state: PresentingState = .disappeared
  
  private func present() {
    let window = viewController?.view.window
    
    if toastWindow == nil {
      let toastWindow = UIWindow()
      toastWindow.rootViewController = UIViewController()
      toastWindow.backgroundColor = .clear
      toastWindow.windowLevel = .alert
      toastWindow.windowScene = window?.windowScene
      self.toastWindow = toastWindow
    }
    
    let rootViewController = toastWindow.rootViewController
    
    let toastAlreadyPresented =
    rootViewController?.presentedViewController is ToastViewHostingController<ToastContent>
    
    switch (state, isPresented, toastAlreadyPresented) {
    case (.disappeared, false, false):
      break
    case (.disappeared, false, true):
      print("Invalid state!")
      break
    case (.disappeared, true, false):
      break
    case (.disappeared, true, true):
      print("Invalid state!")
      break
    case (.appearing, false, false):
      break
    case (.appearing, false, true):
      print("Invalid state!")
      break
    case (.appearing, true, false):
      break
    case (.appearing, true, true):
      print("Invalid state!")
      break
    case (.appeared, false, false):
      print("Invalid state!")
      break
    case (.appeared, false, true):
      break
    case (.appeared, true, false):
      print("Invalid state!")
      break
    case (.appeared, true, true):
      break
    case (.disappearing, false, false):
      print("Invalid state!")
      break
    case (.disappearing, false, true):
      break
    case (.disappearing, true, false):
      print("Invalid state!")
      break
    case (.disappearing, true, true):
      break
    }
    
    if isPresented {
      if !toastAlreadyPresented {
        state = .appearing
        let toastViewController = ToastViewHostingController(rootView: content())
        toastWindow.makeKeyAndVisible()
        rootViewController?.present(toastViewController, animated: true) {
          state = .appeared
        }
        
        if let dismissAfter = dismissAfter {
          DispatchQueue.main.asyncAfter(deadline: .now() + dismissAfter) {
            isPresented = false
          }
        }
      } else {
        //        print("toast is already presented, do nothing? rootViewController: ", rootViewController as Any) // or in the process dismissing
        // TODO: should we ignore?
      }
    } else {
      if toastAlreadyPresented {
        state = .disappearing
        rootViewController?.dismiss(animated: true) {
          onDismiss?()
          toastWindow.windowScene = nil
          toastWindow = nil
          state = .disappeared
        }
      } else {
        //        print("toast is not already presented, do nothing? rootViewController: ", rootViewController as Any)
      }
    }
    print("state: ", state)
  }
  
  func body(content: Content) -> some View {
    content
      .introspectViewController {
        viewController = $0
      }
      .onChange(of: isPresented) { _ in
        present()
      }
  }
}

extension View {
  func introspectViewController(targetViewController: @escaping (UIViewController) -> Void) -> some View {
    background(
      IntrospectionViewController(targetViewController: targetViewController)
        .frame(width: 0, height: 0)
        .disabled(true)
    )
  }
}

struct IntrospectionViewController: UIViewControllerRepresentable {
  let targetViewController: (UIViewController) -> Void
  
  init(targetViewController: @escaping (UIViewController) -> Void) {
    self.targetViewController = targetViewController
  }
  
  func makeUIViewController(context: Context) -> UIViewController {
    UIViewController()
  }
  
  func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    DispatchQueue.main.async {
      targetViewController(uiViewController)
    }
  }
}
#endif

#if os(macOS)
struct ToastViewIsPresentedModifier<QTContent>: ViewModifier where QTContent: View {
  @Binding var isPresented: Bool
  let dismissAfter: Double?
  let onDismiss: (() -> Void)?
  let content: () -> QTContent
  
  @State private var keyWindow: NSWindow?
  
  private func present() {
    if keyWindow == nil {
      keyWindow = NSApplication.shared.windows.first(where: \.isKeyWindow)
    }
    let rootViewController = keyWindow?.contentViewController
    let presentingToastViewController = rootViewController?.presentedViewControllers?
      .first(where: { $0 is ToastViewHostingController<QTContent> })
    let toastAlreadyPresented = presentingToastViewController != nil
    
    if isPresented {
      if !toastAlreadyPresented {
        let toastViewController = ToastViewHostingController(rootView: content())
        rootViewController?.presentAsSheet(toastViewController)
        
        if let dismissAfter = dismissAfter {
          DispatchQueue.main.asyncAfter(deadline: .now() + dismissAfter) {
            isPresented = false
          }
        }
      }
    } else {
      if toastAlreadyPresented {
        (presentingToastViewController as? ToastViewHostingController<QTContent>)?
          .dismissWithCompletion(onDismiss)
      }
      keyWindow = nil
    }
  }
  
  func body(content: Content) -> some View {
    content
      .onChange(of: isPresented) { _ in
        present()
      }
  }
}
#endif

#if os(iOS) || os(tvOS)
struct ToastViewItemModifier<Item, QTContent>: ViewModifier
where Item: Identifiable & Equatable, QTContent: View {
  @Binding var item: Item?
  let dismissAfter: Double?
  let onDismiss: (() -> Void)?
  let content: (Item) -> QTContent
  
  @State private var keyWindow: UIWindow?
  
  private func present() {
    if keyWindow == nil {
      keyWindow = nil
    }
    var rootViewController = keyWindow?.rootViewController
    while true {
      if let presented = rootViewController?.presentedViewController {
        rootViewController = presented
      } else if let navigationController = rootViewController as? UINavigationController {
        rootViewController = navigationController.visibleViewController
      } else if let tabBarController = rootViewController as? UITabBarController {
        rootViewController = tabBarController.selectedViewController
      } else {
        break
      }
    }
    
    let toastAlreadyPresented = rootViewController is ToastViewHostingController<QTContent>
    
    if item != nil {
      if !toastAlreadyPresented {
        if let item = item {
          let toastViewController = ToastViewHostingController(rootView: content(item))
          rootViewController?.present(toastViewController, animated: true)
          
          if let dismissAfter = dismissAfter {
            DispatchQueue.main.asyncAfter(deadline: .now() + dismissAfter) {
              self.item = nil
            }
          }
        }
      } else {
        print(
          """
          [ToastUI] Attempted to present toast while another toast is being presented. \
          This is an undefined behavior and will result in view presentation failures.
          """
        )
      }
    } else {
      if toastAlreadyPresented {
        rootViewController?.dismiss(animated: true, completion: onDismiss)
      }
      keyWindow = nil
    }
  }
  
  func body(content: Content) -> some View {
    content
      .onChange(of: item) { _ in
        present()
      }
  }
}
#endif

#if os(macOS)
struct ToastViewItemModifier<Item, QTContent>: ViewModifier
where Item: Identifiable & Equatable, QTContent: View {
  @Binding var item: Item?
  let dismissAfter: Double?
  let onDismiss: (() -> Void)?
  let content: (Item) -> QTContent
  
  @State private var keyWindow: NSWindow?
  
  private func present() {
    if keyWindow == nil {
      keyWindow = NSApplication.shared.windows.first(where: \.isKeyWindow)
    }
    let rootViewController = keyWindow?.contentViewController
    let presentingToastViewController = rootViewController?.presentedViewControllers?
      .first(where: { $0 is ToastViewHostingController<QTContent> })
    let toastAlreadyPresented = presentingToastViewController != nil
    
    if item != nil {
      if !toastAlreadyPresented {
        if let item = item {
          let toastViewController = ToastViewHostingController(rootView: content(item))
          rootViewController?.presentAsSheet(toastViewController)
          
          if let dismissAfter = dismissAfter {
            DispatchQueue.main.asyncAfter(deadline: .now() + dismissAfter) {
              self.item = nil
            }
          }
        }
      } else {
        print(
          """
          [ToastUI] Attempted to present toast while another toast is being presented. \
          This is an undefined behavior and will result in view presentation failures.
          """
        )
      }
    } else {
      if toastAlreadyPresented {
        (presentingToastViewController as? ToastViewHostingController<QTContent>)?
          .dismissWithCompletion(onDismiss)
      }
      keyWindow = nil
    }
  }
  
  func body(content: Content) -> some View {
    content
      .onChange(of: item) { _ in
        present()
      }
  }
}
#endif

#if os(iOS)
struct VisualEffectViewModifier: ViewModifier {
  var blurStyle: UIBlurEffect.Style
  var vibrancyStyle: UIVibrancyEffectStyle?
  var blurIntensity: CGFloat?
  
  func body(content: Content) -> some View {
    content
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .background(
        VisualEffectView(
          blurStyle: blurStyle,
          vibrancyStyle: vibrancyStyle,
          blurIntensity: blurIntensity
        )
          .edgesIgnoringSafeArea(.all)
      )
  }
}
#endif

#if os(tvOS)
struct VisualEffectViewModifier: ViewModifier {
  var blurStyle: UIBlurEffect.Style
  var blurIntensity: CGFloat?
  
  func body(content: Content) -> some View {
    content
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .background(
        VisualEffectView(
          blurStyle: blurStyle,
          blurIntensity: blurIntensity
        )
          .edgesIgnoringSafeArea(.all)
      )
  }
}
#endif

#if os(macOS)
struct VisualEffectViewModifier: ViewModifier {
  var material: NSVisualEffectView.Material
  var blendingMode: NSVisualEffectView.BlendingMode
  var state: NSVisualEffectView.State
  
  func body(content: Content) -> some View {
    content
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .background(
        VisualEffectView(
          material: material,
          blendingMode: blendingMode,
          state: state
        )
          .edgesIgnoringSafeArea(.all)
      )
  }
}
#endif
