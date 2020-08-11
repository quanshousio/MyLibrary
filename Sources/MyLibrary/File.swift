//
//  File.swift
//
//
//  Created by Quan Tran on 8/10/20.
//

import SwiftUI

/// Another Struct
public struct AnotherStruct: Identifiable {
  public var id: String
  public var flag: Bool
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
