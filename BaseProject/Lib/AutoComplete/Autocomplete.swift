//
//  Autocomplete.swift
//  Autocomplete
//
//  Created by Amir Rezvani on 3/6/16.
//  Copyright © 2016 cjcoaxapps. All rights reserved.
//

import UIKit
open class Autocomplete {
    open class func setupAutocompleteForViewcontroller(viewController: UIViewController) -> AutoCompleteViewController {
        let autoCompleteViewController = initAutoCompleteVC()
        autoCompleteViewController.delegate = viewController as? AutocompleteDelegate
        
        setupUI(autoCompleteViewController, parentViewController: viewController)
        return autoCompleteViewController;
    }
    
    open class func setupAutocompleteForViewcontrollerWithDetachedDelegate(_ viewController: UIViewController, delegate:AutocompleteDelegate) {
        let autoCompleteViewController = initAutoCompleteVC()
        autoCompleteViewController.delegate = delegate
        
        setupUI(autoCompleteViewController, parentViewController: viewController)
    }
    
    fileprivate class func initAutoCompleteVC() -> AutoCompleteViewController {
        let podBundle: Bundle = Bundle(for: Autocomplete.self)
        
        let storyboard = UIStoryboard(name: "Autocomplete", bundle: podBundle)
        return storyboard.instantiateViewController(withIdentifier: "autocompleteScene") as! AutoCompleteViewController
    }
    
    fileprivate class func setupUI(_ autoCompleteViewController: AutoCompleteViewController, parentViewController: UIViewController) {
        
        if (autoCompleteViewController.view.superview == parentViewController.view) {
            
        }
        //Remove from any superview and super viewcontrollers
        autoCompleteViewController.view.removeFromSuperview()
        autoCompleteViewController.removeFromParent()
        
        autoCompleteViewController.willMove(toParent: parentViewController)
        parentViewController.addChild(autoCompleteViewController)
        autoCompleteViewController.didMove(toParent: parentViewController)
        
        autoCompleteViewController.view.willMove(toSuperview: parentViewController.view)
        parentViewController.view.addSubview(autoCompleteViewController.view)
        autoCompleteViewController.view.didMoveToSuperview()
    }
    
    open class func removed(_ autoCompleteViewController: AutoCompleteViewController) {
        //Remove from any superview and super viewcontrollers
        autoCompleteViewController.view.removeFromSuperview()
        autoCompleteViewController.removeFromParent()
    }
}
