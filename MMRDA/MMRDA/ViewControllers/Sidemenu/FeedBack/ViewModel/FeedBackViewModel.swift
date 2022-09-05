//
//  FeedBackViewModel.swift
//  MMRDA
//
//  Created by Kirti Chavda on 05/09/22.
//

import Foundation
class FeedBackViewModel {
    var delegate:ViewcontrollerSendBackDelegate?
    var inputErrorMessage: Observable<String?> = Observable(nil)
    func sendValue<T>(_ handleData: inout T) {
        self.delegate?.getInformatioBack(&handleData)
    }
    
}
