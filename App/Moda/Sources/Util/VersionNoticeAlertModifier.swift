////
////  VersionNoticeAlertModifier.swift
////  ModaCore
////
////  Created by 황득연 on 10/1/24.
////  Copyright © 2024 Moda. All rights reserved.
////
//
//import SwiftUI
//
//struct VersionNoticeAlertModifier: ViewModifier {
//    @ObservedObject var manager = BottomMenuManager.shared
//
//    func body(content: Content) -> some View {
//      content
//        .overlay {
//          Color.black
//              .ignoresSafeArea()
//              .opacity(manager.isPresented ? 0.6 : 0)
//              .onTapGesture {
//                  manager.dismiss()
//              }
//        }
//        .overlay(if: manager.isPresented) {
//          
//          VersionNoticeAlertView()
//          Color.red
//            .frame(size: 200)
//        }
//
//        ZStack {
//            content
//
//            ZStack {
//                Color.black
//                    .ignoresSafeArea()
//                    .opacity(manager.isPresented ? 0.6 : 0)
//                    .onTapGesture {
//                        manager.dismiss()
//                    }
//
////                if manager.isPresented {
////                    BottomMenu(
////                        confirmTitle: manager.configuration.confirmTitle,
////                        cancelTitle: manager.configuration.cancelTitle,
////                        confirmAction: {
////                            await manager.configuration.confirmAction()
////                            manager.dismiss()
////                        },
////                        cancelAction: {
////                            manager.dismiss()
////                        }
////                    )
////                    .transition(.move(edge: .bottom))
////                    .zIndex(1)
////                }
//            }
//            .zIndex(2)
//            .animation(.spring(duration: 0.4), value: manager.isPresented)
//            .ignoresSafeArea(edges: .bottom)
//        }
//    }
//}
//
//public extension View {
//    func versionNoticeAlert() -> some View {
//        modifier(VersionNoticeAlertModifier())
//    }
//}
