//
//  File.swift
//  
//
//  Created by shutut on 2021/10/7.
//

import Foundation

public let Hong_Kong_Zone = TimeZone(identifier:"Asia/Hong_Kong")!

public extension DateFormatter {
    convenience init(dateFormat: String) {
        self.init()
        self.timeZone = Hong_Kong_Zone
        self.dateFormat = dateFormat
    }
}

public extension String {
    
    static func isoDateFormat() -> String {
        return "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    }
    
    var isoTimeDate: Date? {
        let isoTimeString = self
        if isoTimeString.count > 0 {
            let dateFormatter = DateFormatter()
            let enUSPOSIXLocale = Locale(identifier: "en_US_POSIX")
            dateFormatter.locale = enUSPOSIXLocale
            dateFormatter.dateFormat = String.isoDateFormat()
            let date = dateFormatter.date(from: isoTimeString)
            return date
        }
        return nil
    }
    
    func dateWithFormat(_ format: String) -> Date? {
        let str = self
        let formatter = DateFormatter(dateFormat: format)
        let date = formatter.date(from: str)
        return date
    }
    
    static var commonDateFormat: String {
        "yyyy-MM-dd HH:mm:ss"
    }
    
    var commonDate: Date? {
        return dateWithFormat(String.commonDateFormat)
    }
    
    static var descDateFormat: String {
        "yyyy年MM月dd日 HH时mm分ss秒"
    }
    
    var descDate: Date? {
        return dateWithFormat(String.descDateFormat)
    }
}

public extension Date {
    
    func stringFromFormat(_ format: String) -> String {
        let date = self
        let formatter = DateFormatter(dateFormat: "yyyy-MM-dd HH:mm:ss")
        let str = formatter.string(from: date)
        return str
    }
    
    static func dateStringWith(ts: String?) -> String? {
        if let time = ts,
           let timeInt = Double(time) {
            let date = Date(timeIntervalSince1970: timeInt / 1000.0)
            return date.stringFromFormat("yyyy-MM-dd HH:mm:ss")
        }
        return nil
    }
    
    var isoTimeString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        dateFormatter.dateFormat = String.isoDateFormat()
        let str = dateFormatter.string(from: self)
        return str
    }
    
    var utcString: String {
        let df = DateFormatter()
        df.timeZone = TimeZone(abbreviation: "UTC")
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let timeString = df.string(from: self)
        return timeString
    }
    
    var dateDesc: String {
        return stringFromFormat(String.descDateFormat)
    }
    
    static var timestamp: Int {
        let curr = Date().timeIntervalSince1970 * 1000.0
        return Int(curr)
    }
    
    var timestamp: Int {
        let curr = self.timeIntervalSince1970 * 1000.0
        return Int(curr)
    }
}

public func currentDateDesc() -> String {
    return Date().dateDesc ?? "日期"
}

public extension Double {
    /// 把一个时间戳转为时间字符串
    var dateDesc: String {
        var time = self
        let nowTime = Date().timeIntervalSince1970
        if time > nowTime * 100 {
            time = time / 1000
        }
        let date = Date(timeIntervalSince1970: time)
        return date.dateDesc
    }
}

public extension Int {
    /// 把一个时间戳转为时间字符串
    var dateDesc: String {
        var time = self.double
        return time.dateDesc
    }
}
