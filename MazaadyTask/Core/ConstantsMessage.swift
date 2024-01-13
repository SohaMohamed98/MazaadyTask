//
//  ConstantsMessage.swift
//  MazaadyTask
//
//  Created by mac on 13/01/2024.
//

import Foundation
enum ConstanstMessage: String{
    case emptySubCategory = "Sorry, No Child"
    case emptyProperties = "Sorry, No Process Type"
    case emptyBrand = "Sorry, No Brand"
    case emptyModel = "Sorry, No Model"
    case emptyType = "Sorry, No Type"
    
    case categoryPlaceholder = "select category"
    case subCategoryPlaceholder = "select subcategory"
    case PropertiesPlaceholder =  "select process type"
    case brandPlaceholder = "select brand"
    case modelPlaceholder = "select model"
    case TypePlaceholder = "select type"
    
    case Other = "Other"
    
    
    case inValidSubCategory = "Please, Select subcategory "
    case inValidBrand = "Please, Select brand"
    case inValidModel = "Please, Select model"
}
