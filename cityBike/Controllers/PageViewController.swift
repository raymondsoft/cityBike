//
//  PageViewController.swift
//  cityBike
//
//  Created by etudiant-09 on 30/03/2017.
//  Copyright © 2017 etudiant-09. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDelegate , UIPageViewControllerDataSource {
    
    var pages = [UIViewController]()
    
    // I know this is the correct index !!!
    let startPageViewControlerIndex = 0
    
    //var viewControllers: [UIViewController]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        self.delegate = self
        
        // Do any additional setup after loading the view.
        
        
        if let startPage = storyboard?.instantiateViewController(withIdentifier: "CityView") {
            pages.append(startPage)
        }
        pages.append(instanciateFavoriteViewController(for: .favorite))
        pages.append(instanciateFavoriteViewController(for: .home))
        pages.append(instanciateFavoriteViewController(for: .work))
        pages.append(instanciateFavoriteViewController(for: .geoloc))
        
        
        
        
        self.setViewControllers([self.pages[0]], direction: .forward, animated: true, completion: nil)
        
        
    }
    
    private func instanciateFavoriteViewController(for type: ScreenType) -> UIViewController {
        let viewController = storyboard?.instantiateViewController(withIdentifier: "FavoriteStations") as! FavoriteStationsViewController
        viewController.screenType = type
        return viewController
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    // - MARK: PageViwController DELEGATE
    
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        print("Begin WillTransitionTo")
        print("\t \(self.pages)")
        if let viewController = pendingViewControllers.first {
            print("\t viewController OK")
            if let favoriteViewController = viewController as? FavoriteStationsViewController {
                print("\t favoriteViewController OK")
                if let navigationView = self.pages[self.startPageViewControlerIndex] as? UINavigationController {
                    print("\t navigationView OK")
                    if let stationProvider = navigationView.viewControllers.first as? StationListProvider {
                        print("\t stationProvider OK")
                        favoriteViewController.stations = stationProvider.getStationList()
                        
                    }
                }
            }
        }
        print("--------------------")
    }
    
    
    // - MARK: PageViwController DATASOURCE
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let currentIndex = self.pages.index(of: viewController)
        if(currentIndex == 0 || currentIndex == nil) {
            return nil
        } else {
            return self.pages[currentIndex! - 1]
        }
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        let currentIndex = self.pages.index(of: viewController)
        if(currentIndex == self.pages.count - 1) || (currentIndex == nil) {
            return nil
        } else {
            return self.pages[currentIndex! + 1]
        }
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.pages.count
    }
    
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
}
