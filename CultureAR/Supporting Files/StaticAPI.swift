//
//  StaticApi.swift
//  CultureAR
//
//  Created by Franck-Stephane Ndame Mpouli on 19/03/2019.
//  Copyright © 2019 Ahmad Karkouti. All rights reserved.
//

import Foundation

class StaticAPI {
    static let shared = StaticAPI()
    
    var arModels: [ARModel] =
        
    [ARModel(name: "Case", image: #imageLiteral(resourceName: "iMacPro"), path: "Case"),
     ARModel(name: "IphoneX", image: #imageLiteral(resourceName: "iPhoneX"), path: "iPhoneX"),
     ARModel(name: "iPhone8", image: #imageLiteral(resourceName: "iPhone8Plus"), path: "iPhone8")]
    
}
