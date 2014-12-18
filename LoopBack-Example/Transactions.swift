//
//  TodoModel.swift
//  LoopBack-Example
//
//  Created by Daniel Mathews on 2014-12-12.
//  Copyright (c) 2014 com.red-cedar. All rights reserved.
//

import Foundation

extension LBModel {
    
    struct Transactions{
        var amount:String
        
        init(amount:String){
            self.amount = amount
        }
    }
    
}
