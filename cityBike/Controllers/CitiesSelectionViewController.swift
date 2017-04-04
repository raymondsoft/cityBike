//
//  CitiesSelectionViewController.swift
//  cityBike
//
//  Created by etudiant-09 on 27/03/2017.
//  Copyright © 2017 etudiant-09. All rights reserved.
//

import UIKit

class CitiesSelectionViewController: UIViewController , UIPickerViewDelegate, UIPickerViewDataSource, ContractProvider {

    @IBOutlet weak var contractsPickerView: UIPickerView!
    
    var contracts : [Contract]? {
        didSet {
            self.contractsPickerView.reloadAllComponents()
        }
    }
    
    var city : String? {
        didSet {
            print("City selected : \(city)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contractsPickerView.delegate = self
        self.contractsPickerView.dataSource = self

        // Do any additional setup after loading the view.
        
        // I request for contracts only at view load, because thoses datas doesn't change frequently.
        JCDecauxHelper.getContracts() {
            json in
            var tempContracts = [Contract]()
            for contractJson in json.arrayValue {
                tempContracts.append(Contract(contract: contractJson))
            }
            self.contracts = tempContracts
            print("Contracts Loaded")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("city : \(self.city)")
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

    
    
    // -MARK: PickerView DATA SOURCE
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        print("NB rows : \(self.contracts?.count)")
        return self.contracts?.count ?? 0
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // -MARK: PickerView DELEGATE
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        // I have only 1 component, so I ignore the component number
        return self.contracts?[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.city = self.contracts?[row].name
    }
    
    func selectedCity() -> String? {
        print("Contract Provider. City sent : \(self.city)")
        return self.city
    }
}
