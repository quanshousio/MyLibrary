//
//  ToastUISampleApp.swift
//  ToastUISample
//
//  Created by Quan Tran on 11/14/20.
//

import SwiftUI
import ToastUI

@main
struct ToastUISampleApp: App {
  @Environment(\.scenePhase) var scenePhase
  @State var showToast = false

  var body: some Scene {
    WindowGroup {
      ContentViewA(alert: $showToast)
        .toast(isPresented: $showToast) {
          LockScreen()
        }
//        .fullScreenCover(isPresented: $showToast) {
//          // nothing
//        } content: {
//          Button {
//            showToast = false
//          } label: {
//            Text("Hello")
//          }
//        }

//        .alert(isPresented: $showToast, content: {
//          Alert(title: Text("Hello"))
//        })
//        .sheet(isPresented: $showToast, content: {
//          Text("Hello")
//        })
//        .fullScreenCover(isPresented: $showToast, content: {
//          Text("Hello")
//        })
//        .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
//          print("didBecomeActive, set to false")
//          showToast = false
//        }
//        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
//          print("willResign, set to true")
//          showToast = true
//        }
//        .onReceive(NotificationCenter.default.publisher(for: UIApplication.didEnterBackgroundNotification)) { _ in
//          print("didEnterBackground, set to true")
//          showToast = true
//        }
    }
  }
}

struct LockScreen: View {
  var body: some View {
    ZStack {
      Color(.gray).edgesIgnoringSafeArea(.all)
      VStack {
        Text("Locked")
          .font(Font.system(size: 28, weight: .heavy))
          .multilineTextAlignment(.center)
      }
    }
  }
}

struct QRCode: View {
  @Binding var showSheet: Bool
  init(showSheet: Binding<Bool>) {
    self._showSheet = showSheet
  }
  var body: some View {
    NavigationView {
      Text("Test")
        .toolbar {
          ToolbarItem(placement: .navigationBarLeading) {
            Button(action: {self.showSheet.toggle()}, label: {
              Text("Cancel")
                .padding()
            })
          }
        }
    }
  }
}

struct ContentViewA: View {
  @Binding var alert: Bool
  @State var showSheet = false
  var count = 5
  var body: some View {
    VStack {
      Button {
        alert = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
          alert = false
        }
      } label: {
        Text("Show toast")
      }
      Menu {
        Button() {
        } label: {
          Image(systemName: "doc.on.doc")
          Text("Copy")
        }
        .disabled(count == 0)
        Button() {
        } label: {
          Text("Show")
          Image(systemName: "eye")
        }
        .disabled(count == 5)
        Button() {
        } label: {
          Text("View")
          Image(systemName: "doc.text.magnifyingglass")
        }
        Button() {
        } label: {
          Image(systemName: "square.and.pencil")
          Text("Edit")
        }
        Divider()
        Button(/*role: .destructive*/) {
        } label: {
          Image(systemName: "trash")
          Text("Delete")
        }
      } label: {
        Image(systemName: "ellipsis")
          .imageScale(.large)
          .padding()
      }
      Button(action: {self.showSheet.toggle()}, label: {
        Text("Show Sheet")
      })
      .sheet(isPresented: $showSheet) {
        QRCode(showSheet: self.$showSheet)
      }
    }
  }
}
