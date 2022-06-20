import XCTest
@testable import Dater

final class DatesTests: XCTestCase {
    func testEmpty() {
        let dates = [Date]()
        let calendar = dates.calendar { _ in
            false
        }
        XCTAssertNotNil(calendar.first?.items.first?.first)
    }
    
    func testCalendar() {
        let monday = Calendar.global.date(from: .init(year: 2021, month: 3, day: 15))!
        let wednesday = Calendar.global.date(from: .init(year: 2021, month: 3, day: 17))!
        let thursday = Calendar.global.date(from: .init(year: 2021, month: 3, day: 18))!
        let saturday = Calendar.global.date(from: .init(year: 2021, month: 3, day: 20))!
        
        let dates = [monday, wednesday, thursday, saturday, saturday]
        let calendar = dates.calendar { date in
            dates.contains { inner in
                Calendar.global.isDate(inner, inSameDayAs: date)
            }
        }

        XCTAssertEqual(.init(year: 2021, month: 3, items: [
            [.init(value: 1, content: false),
             .init(value: 2, content: false),
             .init(value: 3, content: false),
             .init(value: 4, content: false),
             .init(value: 5, content: false),
             .init(value: 6, content: false),
             .init(value: 7, content: false)],
            [.init(value: 8, content: false),
             .init(value: 9, content: false),
             .init(value: 10, content: false),
             .init(value: 11, content: false),
             .init(value: 12, content: false),
             .init(value: 13, content: false),
             .init(value: 14, content: false)],
            [.init(value: 15, content: true),
             .init(value: 16, content: false),
             .init(value: 17, content: true),
             .init(value: 18, content: true),
             .init(value: 19, content: false),
             .init(value: 20, content: true),
             .init(value: 21, content: false)],
            [.init(value: 22, content: false),
             .init(value: 23, content: false),
             .init(value: 24, content: false),
             .init(value: 25, content: false),
             .init(value: 26, content: false),
             .init(value: 27, content: false),
             .init(value: 28, content: false)],
             [.init(value: 29, content: false),
             .init(value: 30, content: false),
             .init(value: 31, content: false)]
        ]), calendar.first!)
    }
    
    func testTimezones() {
        let timezone = Calendar.global.timeZone

        let berlin = TimeZone(identifier: "Europe/Berlin")!
        Calendar.global.timeZone = berlin
        let date1 = Calendar.global.date(from: .init(timeZone: berlin, year: 2021, month: 1, day: 2, hour: 1))!
        
        let mexico = TimeZone(identifier: "America/Mexico_City")!
        Calendar.global.timeZone = mexico
        let date2 = Calendar.global.date(from: .init(timeZone: mexico, year: 2021, month: 1, day: 3, hour: 22))!
        
        let dates = [date1, date2]
        let calendar = dates.calendar { _ in
            true
        }
        
        Calendar.global.timeZone = berlin
        
        let month = calendar
            .first { $0.year == 2021 && $0.month == 1 }!
        
        XCTAssertTrue(month.items.first![1].content)
        XCTAssertTrue(month.items.first![2].content)
        
        Calendar.global.timeZone = timezone
    }
}
