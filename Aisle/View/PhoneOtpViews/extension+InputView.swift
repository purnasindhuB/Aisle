//
//  extension+ReusableView.swift
//  Aisle
//
//  Created by Purnasindhu-749 on 19/07/25.
//

import Foundation
import UIKit
extension InputView {
      
        func setupCountryCodeMenu() {
            let actions = CountryProvider.supportedCountries.map { country in
                UIAction(title: "\(country.flag) \(country.code)", handler: { [weak self] _ in
                    self?.countryCodeButton.setTitle("\(country.flag) \(country.code)", for: .normal)
                })
            }

            countryCodeButton.menu = UIMenu(title: "Select Country Code", children: actions)
            countryCodeButton.showsMenuAsPrimaryAction = true
        }
    }

