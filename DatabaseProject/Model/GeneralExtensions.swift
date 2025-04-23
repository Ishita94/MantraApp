//
//  GeneralExtensions.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2025-04-22.
//
import Foundation
import Combine

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        stride(from: 0, to: count, by: size).map {
            Array(self[$0..<Swift.min($0 + size, count)])
        }
    }
}
