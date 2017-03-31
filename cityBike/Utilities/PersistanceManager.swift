//
//  PersistanceManager.swift
//  cityBike
//
//  Created by teressa on 29/03/2017.
//  Copyright © 2017 teressa. All rights reserved.
//

import Foundation

class PersistanceManager {
    //key est la clé utilisée dans les UserDefaults
    // Isoler cette fonction permet de modifier au choix le mode de stockage
    //    static func getChosenIds(screenType : ScreenType)->[Int]? {
    //        let key = screenType.userDefaultsKey
    //
    //        return UserDefaults.standard.object(forKey: key) as? [Int]
    //    }
    
    static func getFavoriteIds()->[Int]? {
        let key = params.favoriteId
        return UserDefaults.standard.object(forKey: key) as? [Int]
    }
    
    static func getFavoriteIds(for key: String)->[Int]? {
         return UserDefaults.standard.object(forKey: key) as? [Int]
    }
    
    
    static func saveStationsId(for key: String, with stationIds : [Int]) {
        UserDefaults.standard.set(stationIds, forKey: key)
        UserDefaults.standard.synchronize()
        
        NSUbiquitousKeyValueStore.default().set(stationIds, forKey: key)
        NSUbiquitousKeyValueStore.default().synchronize()
    }
    
    //key est la clé utilisée dans les UserDefaults
    static func saveFavoritesIds(stationIds : [Int]) {
        let key = params.favoriteId
        
        //  logDebug("writing for \(screenType) : \(myArray)")
        
        UserDefaults.standard.set(stationIds, forKey: key)
        UserDefaults.standard.synchronize()
        
        NSUbiquitousKeyValueStore.default().set(stationIds, forKey: key)
        NSUbiquitousKeyValueStore.default().synchronize()
    }
    
    //key est la clé utilisée dans les UserDefaults
    //    static func persistChosenIds(screenType : ScreenType, stationIds : [Int]) {
    //        let key = screenType.userDefaultsKey
    //
    //        //  logDebug("writing for \(screenType) : \(myArray)")
    //
    //        UserDefaults.standard.set(stationIds, forKey: key)
    //        UserDefaults.standard.synchronize()
    //
    //        NSUbiquitousKeyValueStore.default().set(stationIds, forKey: key)
    //        NSUbiquitousKeyValueStore.default().synchronize()
    //    }
    
    static func deleteChosenIds(for key: String) {
        UserDefaults.standard.set(nil, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    
    static func deleteChosenIds() {
        //        UserDefaults.standard.set(nil, forKey: ScreenType.home.userDefaultsKey)
        //        UserDefaults.standard.set(nil, forKey: ScreenType.work.userDefaultsKey)
        UserDefaults.standard.set(nil, forKey: params.favoriteId)
        UserDefaults.standard.synchronize()
    }
}

