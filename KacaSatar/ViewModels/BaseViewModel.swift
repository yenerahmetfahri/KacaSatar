//
//  BaseViewModel.swift
//  KacaSatar
//
//  Created by Ahmet Fahri Yener on 11.11.2023.
//

import Foundation
import RxSwift
import RxCocoa

class BaseViewModel {
    let disposeBag = DisposeBag()
    var isLoadingRelay = BehaviorRelay<Bool>(value: false)
    
    var isLoading: Driver<Bool> {
        return isLoadingRelay.asDriver()
    }
}
