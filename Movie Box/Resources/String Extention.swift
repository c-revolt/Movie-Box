//
//  String Extention.swift
//  Movie Box
//
//  Created by Александр Прайд on 01.06.2022.
//

import Foundation

extension String {
    func capitalizedFirstLatter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
