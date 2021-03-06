//
//  ViewModel.swift
//  Finut
//
//  Created by λΈνμ on 2021/09/02.
//

import Foundation
import RxSwift
//import Moya

// MARK: - ViewModelType

protocol ViewModelType {
    
  associatedtype Input
  associatedtype Output
    
  func transform(input: Input) -> Output
}
