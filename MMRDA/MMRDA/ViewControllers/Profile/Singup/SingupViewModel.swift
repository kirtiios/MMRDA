//
//  SingupViewModel.swift
//  MMRDA
//
//  Created by Sandip Patel on 17/08/22.
//

import Foundation


protocol SingupViewModelCoordinatorDelegate : AnyObject {
    
    func SignViewModelPresent(user:[String:Any])
    
}

final class SingupViewModel: ObservableObject {
    
    // MARK: Observables
    
    @Published var updateView: Bool = false
    
    // MARK: Properties

    weak var coordinatorDelegate: SingupViewModelCoordinatorDelegate?
    
    func submitUserData() {
//        usersRepo.fetch(fromStorage: true, query: "language:swift") { [weak self] (users) in
//            self?.users = users
//            self?.updateView = true
//        }
    }
    
    
}
