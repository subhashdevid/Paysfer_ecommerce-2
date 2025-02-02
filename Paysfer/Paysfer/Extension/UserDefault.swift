//
//  UserDefault.swift
//  Paysfer
//
//  Created by VISHAL VERMA on 10/06/20.
//  Copyright © 2020 VISHAL VERMA. All rights reserved.
//

import UIKit

enum UserDefaultsKeys : String {
    case userdetails
    case isLoggedIn
    case userID
    case device_token
    case device_id
    case profileImg
    case sideMenuList
}

extension UserDefaults{
    
    
    func setUserDetails(value:[String:Any]) {
        set(value, forKey: UserDefaultsKeys.userdetails.rawValue)
    }
    func getUserDetails() -> [String:Any] {
        
        return (object(forKey:UserDefaultsKeys.userdetails.rawValue) as? [String : Any] ?? [:])
    }
    
    
    func setToken(value: String) {
        set(value, forKey: UserDefaultsKeys.device_token.rawValue)
        //synchronize()
    }
    func getToken()-> String? {
        return string(forKey: UserDefaultsKeys.device_token.rawValue)
    }
    func setDeviceID(value: String) {
        set(value, forKey: UserDefaultsKeys.device_id.rawValue)
        //synchronize()
    }
    
    func getDeviceID()-> String {
        return string(forKey: UserDefaultsKeys.device_id.rawValue)!
    }
    func setProfileImg(value: String) {
        set(value, forKey: UserDefaultsKeys.profileImg.rawValue)
        //synchronize()
    }
    func getProfileImg()-> String? {
        return string(forKey: UserDefaultsKeys.profileImg.rawValue)
    }
    
    //MARK: Check Login
    func setLoggedIn(value: Bool) {
        set(value, forKey: UserDefaultsKeys.isLoggedIn.rawValue)
        //synchronize()
    }
    
    
    func isLoggedIn()-> Bool {
        return bool(forKey: UserDefaultsKeys.isLoggedIn.rawValue)
    }
    
    //Save User ID
    func setUserID(value: Int){
        set(value, forKey: UserDefaultsKeys.userID.rawValue)
        //synchronize()
    }
    
    //Retrieve User ID
    func getUserID() -> Int{
        return integer(forKey: UserDefaultsKeys.userID.rawValue)
    }
    
    
    
    func setSetSideMenuListIn(detailList: Array<Dictionary<String,AnyObject>>) {
        set(detailList, forKey: UserDefaultsKeys.sideMenuList.rawValue) as? Array<Dictionary<String,AnyObject>> ?? []
    }
    
    func getSetSideMenuListIn() -> Array<Dictionary<String,AnyObject>> {
       
        return array(forKey: UserDefaultsKeys.sideMenuList.rawValue) as? Array<Dictionary<String,AnyObject>> ?? []
        //synchronize()
    }
    
}
