////
////  DeviceGroup.swift
////  Finut
////
////  Created by 노한솔 on 2021/09/01.
////
//
//import DeviceKit
//import Foundation
//
//// MARK: - DeviceGroup
//
//public enum DeviceGroup {
//    case FOURINCHES /// 320 x 568
//    case FIVEINCHES /// 375 x 667
//    case XDEFUALT /// 375 x 812
//    case NOTXPLUS /// 414 x 736
//    case XIDEFAULT /// 414 x 896
//    case XIIDEFAULT /// 390 x 844
//    case XIIPROMAX /// 428 x 926
//    case PADS /// PADS
//    
//    public var rawValue: [Device] {
//        switch self {
//        case .FOURINCHES:
//            return [.iPhone5s, .iPhoneSE]
//        case .FIVEINCHES:
//            return [.iPhone6, .iPhone6s, .iPhone7, .iPhone8, .iPhoneSE2]
//        case .XDEFUALT:
//            return [.iPhone11Pro, .iPhoneXS, .iPhoneX, .iPhone12Mini]
//        case .NOTXPLUS:
//            return [.iPhone7Plus, .iPhone8Plus, .iPhone6sPlus, .iPhone6Plus]
//        case .XIDEFAULT:
//            return [.iPhone11, .iPhoneXR, .iPhoneXSMax, .iPhone11ProMax]
//        case .XIIDEFAULT:
//            return [.iPhone12, .iPhone12Pro]
//        case .XIIPROMAX:
//            return [.iPhone12ProMax]
//        case .PADS:
//            return Device.allPads
//        }
//    }
//}
