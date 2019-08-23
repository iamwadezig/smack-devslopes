//
//  Constants.swift
//  smack@devslopes
//
//  Created by Ario Nugroho on 21/08/19.
//  Copyright © 2019 Ario Nugroho. All rights reserved.
//

import Foundation

typealias CompletionHandler = (_ Success: Bool) -> ()

//URL Constant
let BASE_URL = "https://smackchatie.herokuapp.com/v1/"
let URL_REGISTER = "\(BASE_URL)account/register"
//Segues
let TO_LOGIN = "loginSegue"
let TO_CREATE_ACCOUNT = "createAccountSegue"
let TO_CHANNEL = "unwindToChannel"
//User Defaults
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"
