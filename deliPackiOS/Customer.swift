//
//  Customer.swift
//  deliPackiOS
//
//  Created by Gh0stM0de on 8/5/19.
//  Copyright © 2019 UltiTrust Company LTD. All rights reserved.
//

import Foundation


struct Customer:Decodable {
    let success_cue: String
    let customer_id: Int
    let first_name: String
    let last_name: String
    let phone_number: String 
}
