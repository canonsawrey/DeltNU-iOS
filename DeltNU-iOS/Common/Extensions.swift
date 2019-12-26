//
//  Extensions.swift
//  DeltNU-iOS
//
//  Created by Canon Sawrey on 11/25/19.
//  Copyright © 2019 Canon Sawrey. All rights reserved.
//

import Foundation
import SwiftUI


//-------------DATE-----------------
extension Date {
    func formattedDate() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter.string(from: self)
    }
}


//------------COLOR-----------------
extension Color {

    func uiColor() -> UIColor {

        let components = self.components()
        return UIColor(red: components.r, green: components.g, blue: components.b, alpha: components.a)
    }

    private func components() -> (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {

        let scanner = Scanner(string: self.description.trimmingCharacters(in: CharacterSet.alphanumerics.inverted))
        var hexNumber: UInt64 = 0
        var r: CGFloat = 0.0, g: CGFloat = 0.0, b: CGFloat = 0.0, a: CGFloat = 0.0

        let result = scanner.scanHexInt64(&hexNumber)
        if result {
            r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
            g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
            b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
            a = CGFloat(hexNumber & 0x000000ff) / 255
        }
        return (r, g, b, a)
    }
}

//----------STRING--------------
extension String {
    func toGreekCharacter() -> String {
        switch self {
        case "Alpha":
            return "Α"
        case "Beta":
            return "B"
        case "Gamma":
            return "Γ"
        case "Delta":
            return "Δ"
        case "Epsilon":
            return "E"
        case "Zeta":
            return "Z"
        case "Eta":
            return "H"
        case "Theta":
            return "Θ"
        case "Iota":
            return "I"
        case "Kappa":
            return "K"
        case "Lambda":
            return "Λ"
        case "Mu":
            return "M"
        case "Nu":
            return "N"
        default:
            return "-"
        }
    }
}

// ----------VIEW---------------
extension Image {
    func resizeImage(side: CGFloat, resized: Bool? = nil) -> some View {
        return self.resizable().frame(width: side, height: side)
    }
    
    func resizeImage(width: CGFloat, height: CGFloat) -> some View {
        return self.resizable().frame(width: width, height: height)
    }
}


// ------------DATE -----------------
extension Date {
    func getElapsedInterval() -> String {

        let interval = Calendar.current.dateComponents([.year, .month, .day], from: self, to: Date())

        if let year = interval.year, year > 0 {
            return year == 1 ? "\(year)" + " " + "year ago" :
                "\(year)" + " " + "years ago"
        } else if let month = interval.month, month > 0 {
            return month == 1 ? "\(month)" + " " + "month ago" :
                "\(month)" + " " + "months ago"
        } else if let day = interval.day, day > 0 {
            return day == 1 ? "\(day)" + " " + "day ago" :
                "\(day)" + " " + "days ago"
        } else {
            return "a moment ago"

        }

    }
}