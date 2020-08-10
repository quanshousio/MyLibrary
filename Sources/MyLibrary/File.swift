//
//  File.swift
//
//
//  Created by Quan Tran on 8/10/20.
//

import SwiftUI

@available(iOS 13.0, tvOS 13.0, *)
struct ToastView: View {
  @State private var presenting: Bool = false

  var body: some View {
    Text("Hello")
      .alert(isPresented: $presenting, content: {
        Alert(title: Text("Hello"))
      })
  }
}
