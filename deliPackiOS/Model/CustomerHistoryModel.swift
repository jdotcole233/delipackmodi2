//
//  CustomerHistoryModel.swift
//  deliPackiOS
//
//  Created by Gh0stM0de on 8/8/19.
//  Copyright © 2019 UltiTrust Company LTD. All rights reserved.
//

import Foundation

struct CustomerHistoryModel:Decodable {
    var companies_id: Int?
    var company_name: String?
    var source: String?
    var destination: String?
    var delivery_status: String?
    var payment_type: String?
    var total_charge: String?
    var first_name: String?
    var last_name: String?
    var registered_number: String?
    var created_at: String?
    var transaction_number: String?
    var company_logo_path: String?
}
