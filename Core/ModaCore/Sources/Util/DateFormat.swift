//
//  DateFormat.swift
//  moda
//
//  Created by 황득연 on 4/2/24.
//

import Foundation

public extension Date {
  func format(_ format: DateFormatUtil.DateFormat) -> String {
    DateFormatUtil.shared.cached(format: format).string(from: self)
  }
}

public final class DateFormatUtil {

  public static let shared = DateFormatUtil()

  private init() {}

  // MARK: - Enumeration

  public enum DateFormat: String {
    /// ex) 6월
    case month = "M"

    /// ex) 24일
    case day = "d"

    /// ex) 일요일
    case weekday = "EEEEE"

    /// ex) June
    case monthText = "MMMM"

    /// Monthly ID
    case monthlyId = "yyMM"

    /// Daily ID
    case dailyId = "yyMMdd"

    var isEnglish: Bool {
      switch self {
      case .monthText:
        return true

      default:
        return false
      }
    }
  }

  // MARK: - Getters

  private var cached: [String: DateFormatter] = [:]

  public func cached(format: DateFormat) -> DateFormatter {
    if let cached = cached[format.rawValue] { return cached }

    let formatter = DateFormatUtil.formatter(with: format)
    self.cached[format.rawValue] = formatter
    return formatter
  }

  private static func formatter(with format: DateFormat) -> DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = format.rawValue
    formatter.locale = Locale(identifier: format.isEnglish ? "en_US" : "ko_KR")
    return formatter
  }
}
