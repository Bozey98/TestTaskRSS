//
//  Extension+String.swift
//  TestTask
//
//  Created by Денис Мусатов on 04.10.2020.
//

import Foundation

extension String {
    func removeHTML() -> String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: String.CompareOptions.regularExpression, range: nil).replacingOccurrences(of: "&ndash;", with: "")
    }
}
