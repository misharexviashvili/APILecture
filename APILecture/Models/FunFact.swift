//
//  FunFact.swift
//  APILecture
//
//  Created by Misha on 13.07.2026.
//

import Foundation

struct FunFact: Decodable {
    let created_at: String
    let url: String
    let value: String
}
