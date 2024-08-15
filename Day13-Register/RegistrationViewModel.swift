//
//  RegistrationViewModel.swift
//  Day13-Register
//
//  Created by Beatriz Cardozo on 15/8/24.
//

import Foundation
import Combine

class RegistrationViewModel: ObservableObject { //FrameWork Combine
    
    //Inputs
    @Published var username = ""
    @Published var password = ""
    @Published var passwordValidation = ""
    
    
    //Validation
    @Published var isUsernameLengthValid = false
    @Published var isPasswordLengthValid = false
    @Published var isPasswordCapitalValid = false
    @Published var isPasswordConfirmedValid = false
    
    
    //AnyCancellable
    private var cancellableSet: Set<AnyCancellable> = []
    
    init() {
        
        //Username validation
        $username //We check what the user is writing inside the username variable - Everytime there is a new letter in the field we check
            .receive(on: RunLoop.main)
            .map{ username in //we will map to check the lenght of the username and validate it
                return username.count >= 6
            }
            .assign(to: \.isUsernameLengthValid, on: self) //we assign it to the bool Published variable
            .store(in: &cancellableSet)
        
        //Password validation 1
        $password
            .receive(on: RunLoop.main)
            .map { password in
                return password.count >= 8
            }
            .assign(to: \.isPasswordLengthValid, on: self)
            .store(in: &cancellableSet)
        
        //Password validation 2
        $password
            .receive(on: RunLoop.main)
            .map { password in
                let pattern = "[A-Z]" //pattern to a capital letter: CHECK THIS
                if let _ = password.range(of: pattern, options: .regularExpression){ //Lo que hacemos es buscar dentro de la contraseña si encontramos ese patron de busqueda como expresion regular
                    return true
                } else {
                    return false
                }
            }
            .assign(to: \.isPasswordCapitalValid, on: self)
            .store(in: &cancellableSet)
        
        //PASSWORDS MATCH
        Publishers.CombineLatest($password, $passwordValidation)
            .receive(on: RunLoop.main)
            .map { (password, password2) in
                return !password.isEmpty && !password2.isEmpty && (password == password2)
            }
            .assign(to: \.isPasswordConfirmedValid, on: self)
            .store(in: &cancellableSet)
    }
}
