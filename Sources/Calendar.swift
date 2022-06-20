import Foundation

extension Calendar {
    public static var global = current
    
    public var daysLeftMonth: Int {
        component(.day, from: date(
            byAdding: .day,
            value: -1,
            to: dateInterval(of: .month, for: .init())!.end)!)
        - component(.day, from: .init())
    }
    
    public func leadingWeekdays(year: UInt16, month: UInt8, day: UInt8) -> Int {
        {
            $0 < firstWeekday ? 7 - firstWeekday + $0 : $0 - firstWeekday
        } (component(.weekday, from: date(from: .init(year: .init(year),
                                                      month: .init(month),
                                                      day: .init(day)))!))
    }
    
    public func trailingWeekdays(year: UInt16, month: UInt8, day: UInt8) -> Int {
        {
            $0 < firstWeekday ? firstWeekday - 1 - $0 : 6 + firstWeekday - $0
        } (component(.weekday, from: date(from: .init(year: .init(year),
                                                      month: .init(month),
                                                      day: .init(day)))!))
    }
}
