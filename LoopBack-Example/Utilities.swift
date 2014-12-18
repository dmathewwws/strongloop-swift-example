//
//  Utilities.swift
//  LoopBack-Example
//
//  Created by Daniel Mathews on 2014-12-17.
//  Copyright (c) 2014 com.red-cedar. All rights reserved.
//

import Foundation

class Utilities{
    
    let appDelegate = (UIApplication.sharedApplication().delegate as AppDelegate!)
    
    class var sharedInstance: Utilities {
        struct Static {
            static var instance: Utilities?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            Static.instance = Utilities()
        }
        
        return Static.instance!
    }
    
    
    func getDataFromModel(modelName:String, completionClosure:(models: [AnyObject]?, error: NSError?) ->()){
        var error1:NSError?
        var models1:[AnyObject]?
        
        var errorBlock = {
            (error: NSError!) -> () in
            println("in Utilities error")
            completionClosure(models: nil, error: error1)
        }
        
        var successBlock = {
            (models: [AnyObject]!) -> () in
            models1 = models
            println("in Utilities success")
            completionClosure(models: models1, error: nil)
        }
        
        let adapter = appDelegate.adapter as LBRESTAdapter!
        
        var productList:LBModelRepository = adapter.repositoryWithModelName(modelName)
        
        productList.allWithSuccess(successBlock, errorBlock)
        
    }
    
    func postDataFromModel(modelName:String, dict:[NSObject : AnyObject], completionClosure:(models: String?, error: NSError?) ->()){
        
        var error1:NSError?
        var models1:String?
        
        var errorBlock = {
            (error: NSError!) -> () in
            println("in Utilities error \(error.description)")
            completionClosure(models: nil, error: error1)
        }
        
        var successBlock = {
            () -> Void in
            completionClosure(models: "SUCCESS!!", error: nil)
        }

        let adapter = appDelegate.adapter as LBRESTAdapter!
        
        var productList:LBModelRepository = adapter.repositoryWithModelName(modelName)
        
        var transaction:LBModel = productList.modelWithDictionary(dict)
        
        transaction.saveWithSuccess(successBlock,failure: errorBlock)
        
    }

}