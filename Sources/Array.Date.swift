import Foundation

extension Array where Element == Date {
    public func calendar<C>(transform: (Element) -> C) -> [Days<C>] where C : Equatable {
        DateInterval(start: first ?? .now, end: .now)
            .years { year, interval in
                interval
                    .months(year: year) { month, interval in
                        .init(year: year,
                              month: month,
                              items: interval
                                .days(year: year, month: month) { day, date in
                                    .init(value: day, content: transform(date))
                                })
                    }
            }
    }
}
