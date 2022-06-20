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
            [.init(value: 1, today: false, content: false),
             .init(value: 2, today: false, content: false),
             .init(value: 3, today: false, content: false),
             .init(value: 4, today: false, content: false),
             .init(value: 5, today: false, content: false),
             .init(value: 6, today: false, content: false),
             .init(value: 7, today: false, content: false)],
            [.init(value: 8, today: false, content: false),
             .init(value: 9, today: false, content: false),
             .init(value: 10, today: false, content: false),
             .init(value: 11, today: false, content: false),
             .init(value: 12, today: false, content: false),
             .init(value: 13, today: false, content: false),
             .init(value: 14, today: false, content: false)],
            [.init(value: 15, today: false, content: true),
             .init(value: 16, today: false, content: false),
             .init(value: 17, today: false, content: true),
             .init(value: 18, today: false, content: true),
             .init(value: 19, today: false, content: false),
             .init(value: 20, today: false, content: true),
             .init(value: 21, today: false, content: false)],
            [.init(value: 22, today: false, content: false),
             .init(value: 23, today: false, content: false),
             .init(value: 24, today: false, content: false),
             .init(value: 25, today: false, content: false),
             .init(value: 26, today: false, content: false),
             .init(value: 27, today: false, content: false),
             .init(value: 28, today: false, content: false)],
             [.init(value: 29, today: false, content: false),
             .init(value: 30, today: false, content: false),
             .init(value: 31, today: false, content: false)]
        ]), calendar.first!)
    }
    
    func testToday() {
        let today = Calendar.global.component(.day, from: .init())
        let dates = [Date]()
        let calendar = dates.calendar { _ in
            false
        }
        XCTAssertEqual(.init(today), calendar.first?.items.flatMap { $0 }.first { $0.today }?.value)
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
