//
//  File.swift
//
//
//  Created by Quan Tran on 8/10/20.
//

import SwiftUI

/// Another Struct
public struct AnotherStruct: Identifiable {
  /// ID
  public var id: String
  /// Boolean
  public var flag: Bool
}

/// Another Hello World
public class HelloWorld {
  /// Number
  public var num: Int = 0
}

/// This is a ToastView
public struct ToastView: View {
  @State private var presenting: Bool = false

  /// This is the body in ToastView
  public var body: some View {
    Text("Hello")
      .alert(isPresented: $presenting, content: {
        Alert(title: Text("Hello"))
      })
  }
}
