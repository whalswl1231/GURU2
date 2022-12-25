//
//  DataStructure.swift
//  GURU
//
//  Created by swuad_25 on 18/07/2019.
//  Copyright © 2019 swuad_19. All rights reserved.
//

import Foundation

struct Token:Codable{
    var token:String
}

struct User:Codable{
    var id:Int
    var username:String
}

struct Chapel:Codable {
    var seat:String
    var total:String
    var success:String
    var fail:String
    var remain:Int
}

struct Major:Codable {
    var major:String
    var std_id:String
    var grad_need:String
}
struct Student:Codable {
    var total_std:Int
    var necc_culture: Int
    var selec_culture: Int
    var major_necc: Int
    var major_selec: Int
    var major: Int
    var sec_major_necc: Int
    var sec_major_selec: Int
    var sec_major: Int
    
    var total_std_my:Int
    var necc_culture_my: Int
    var selec_culture_my: Int
    var major_necc_my: Int
    var major_selec_my: Int
    var major_my: Int
    var sec_major_necc_my: Int
    var sec_major_selec_my: Int
    var sec_major_my: Int
    
    var ct1: Int
    var ct2: Int
    var ct3: Int
    var ct4: Int
    var ct5: Int
    
    var a1: String
    var a2: String
    var a3: String
    var a4: String
    var a5: String
    
    var toeic: String
    var english:String
}

