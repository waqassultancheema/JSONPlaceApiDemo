//
//  XCTestCase.swift
//  TransferWiseDemoTests
//
//  Created by Waqas Sultan on 2/20/19.
//  Copyright © 2019 Waqas Sultan. All rights reserved.
//

import XCTest

extension XCTestCase {
    
    // MARK: - Helper Methods
    
    func loadJSONDictionaryFromBundle(withName name: String, extension: String) ->  [Dictionary<String,AnyObject>] {
        let bundle = Bundle(for: classForCoder)
        let url = bundle.url(forResource: name, withExtension: `extension`)
        
        let data = try! Data(contentsOf: url!)
        let jsonResult = try! JSONSerialization.jsonObject(with: data, options: [])
        let jsonDicArray = jsonResult as! [Dictionary<String,AnyObject>]
        return jsonDicArray
    }
    
}
