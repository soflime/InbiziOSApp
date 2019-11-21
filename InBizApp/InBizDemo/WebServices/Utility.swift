//
//  Utility.swift
//  pulse
//
//  Created by Sahu, Vinod @ Gurgaon on 11/01/19.
//  Copyright © 2019 CBRE. All rights reserved.
//

import UIKit


class Utility {
    
    static func isIpad()-> Bool{
        
        return UI_USER_INTERFACE_IDIOM() == .pad
    }
    
    static func isPhone()-> Bool{
        
        return UI_USER_INTERFACE_IDIOM() == .phone
    }
    
    static func isPhoneX()-> Bool{
        
        var hasTopNotch: Bool {
            if #available(iOS 11.0,  *) {
                return UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0 > 20
            }
            
            return false
        }
        
        return hasTopNotch
    }
    
    static func convertToDictionary(data:Data?) -> NSDictionary? {
        
        if let data = data {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    static func getDateForScheduleInspection(date:Date)-> String{
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        return formatter.string(from: date)
    }
    
    static func getTimeForScheduleInspection(date:Date)-> String{
        
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter.string(from: date)
    }
    
    static func alert(title:String?,message:String?,target:UIViewController) -> Void{
        
        let alertView = UIAlertController(title: title,
                                          message: message,
                                          preferredStyle:. alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alertView.addAction(okAction)
        target.present(alertView, animated: true)
    }
    
    static func noCamera(target:UIViewController){
        
        let alertVC = UIAlertController(
            title: "No Camera",
            message: "Sorry, this device has no camera",
            preferredStyle: .alert)
        let okAction = UIAlertAction(
            title: "OK",
            style:.default,
            handler: nil)
        alertVC.addAction(okAction)
        target.present(
            alertVC,
            animated: true,
            completion: nil)
    }
    
    static func nameWithTimeStamp(name:String) -> String {
        
        return "\(name)_\(Int(Date().timeIntervalSince1970))"
    }
    static func getFullStringFromDate(date:Date?)->String?{
        
        if let date = date{
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateStyle = .full
            dateFormatterGet.timeStyle = .full
            return dateFormatterGet.string(from: date)
        }
        return nil
    }
    static func getFullDateFromString(date:String?)->Date?{
        
        if let date = date{
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateStyle = .full
            dateFormatterGet.timeStyle = .full
            return dateFormatterGet.date(from: date)
        }
        return nil
    }
}

extension Date {
    
    /*
     
     Wednesday, Sep 12, 2018           --> EEEE, MMM d, yyyy
     09/12/2018                        --> MM/dd/yyyy
     09-12-2018 14:11                  --> MM-dd-yyyy HH:mm
     Sep 12, 2:11 PM                   --> MMM d, h:mm a
     September 2018                    --> MMMM yyyy
     Sep 12, 2018                      --> MMM d, yyyy
     Wed, 12 Sep 2018 14:11:54 +0000   --> E, d MMM yyyy HH:mm:ss Z
     2018-09-12T14:11:54+0000          --> yyyy-MM-dd'T'HH:mm:ssZ
     12.09.18
     --> dd.MM.yy
     */
    
    static func getFullStringFromDate(date:Date?){
        
        if let date = date{
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateStyle = .full
            dateFormatterGet.string(from: date)
        }
        
    }
    static func getFormattedDate(string: String , formatter:String) -> String{
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"
        
        let date: Date? = dateFormatterGet.date(from: "2018-02-01T19:10:04+00:00")
        print("Date",dateFormatterPrint.string(from: date!)) // Feb 01,2018
        return dateFormatterPrint.string(from: date!);
    }
}

// Mark: Date Extention for  Display Inspection

extension Date{
    
    func offsetFrom(date:Date) -> String {
        
        let dayHourMinuteSecond: Set<Calendar.Component> = [.day, .hour, .minute, .second]
        let difference = NSCalendar.current.dateComponents(dayHourMinuteSecond, from: date, to: self);
        
        let seconds = "\(difference.second ?? 0)s"
        let minutes = "\(difference.minute ?? 0)m"
        let hours = "\(difference.hour ?? 0)h"
        let days = "\(difference.day ?? 0)d"
        
        let day = difference.day
        if day ?? 0 > 0 {
            return days
        }
        
        let hour = difference.hour
        if hour ?? 0 > 0 {
            return hours
        }
        
        let minute = difference.minute
        if minute ?? 0 > 0 {
            return minutes
        }
        
        let second = difference.second
        if second ?? 0 > 0 {
            return seconds
        }
        else{
            return ""
        }
    }
    
    static func getFormattedDate() -> String{
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MM-yyyy"
        let currentDate = Date()
        return dateFormatterPrint.string(from: currentDate);
    }
    
    static func getDateFromCurrent() -> String{
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "yyyy-MM-dd"
        let currentDate = Date()
        return dateFormatterPrint.string(from: currentDate);
    }
    
    static func getTomorrowDateFromCurrent() -> String{
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "yyyy-MM-dd"
        let currentDate = Date()
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: currentDate)
        
        return dateFormatterPrint.string(from: tomorrow!);
    }
    
    static func geTimeFromDate(dateString:String) -> String{
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        let dateFormatterPrint = DateFormatter()
        
        dateFormatterPrint.dateFormat = "h:mm a"
        dateFormatterPrint.amSymbol = "AM"
        dateFormatterPrint.pmSymbol = "PM"
        
        
        let date: Date? = dateFormatterGet.date(from:dateString)
        //print("Date",dateFormatterPrint.string(from: date!))
        return dateFormatterPrint.string(from: date!);
    }
    
    static func getTodayTitle() -> String{
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd MMMM"
        let currentDate = Date()
        return dateFormatterPrint.string(from: currentDate);
    }
    
    
    static func getTomorrowTitle() -> String{
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd MMMM"
        let currentDate = Date()
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: currentDate)
        
        return dateFormatterPrint.string(from: tomorrow!);
    }
    
    static func getDayName() -> String{
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        let dayInWeek = formatter.string(from: date)
        return dayInWeek+", "
    }
    
    static func getTomorrowDayname() -> String{
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: date)
        let tomorrowInWeek = formatter.string(from: tomorrow!)
        return tomorrowInWeek+", "
    }
    
     func getDay() -> String{
        let date = self
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        let tomorrow = Calendar.current.date(byAdding: .day, value: 0, to: date)
        let tomorrowInWeek = formatter.string(from: tomorrow!)
        return tomorrowInWeek+", "
    }
    
    func minutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
    
    func dateKey(date: Date)-> String {
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "yyyy-MM-dd"
        return dateFormatterPrint.string(from:date);
    }
    
    func getDayTitle(date:Date) -> String{
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd MMMM"
        //let currentDate = Date()
        return dateFormatterPrint.string(from: date);
    }
    
    
    
    func dateForScheduleInspection() -> String{
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: self)
    }
    
    func timeForScheduleInspection() -> String{
        
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm:ss a"
        return formatter.string(from: self)
    }
    
    func offSetFrom(date : Date) -> Int {
        
        let dayHourMinuteSecond: Set<Calendar.Component> = [.day, .hour, .minute, .second]
        let difference = NSCalendar.current.dateComponents(dayHourMinuteSecond, from: date, to: self);
        
        return difference.minute ?? 0
        
        /*let seconds = "\(difference.second ?? 0)s"
         let minutes = "\(difference.minute ?? 0)m" + " " + seconds
         let hours = "\(difference.hour ?? 0)h" + " " + minutes
         let days = "\(difference.day ?? 0)d" + " " + hours
         
         if let day = difference.day, day          > 0 { return days }
         if let hour = difference.hour, hour       > 0 { return hours }
         if let minute = difference.minute, minute > 0 { return minutes }
         if let second = difference.second, second > 0 { return seconds }
         return ""*/
    }
    
    func dayMonthYear() -> String{
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM YYYY"
        return formatter.string(from: self)
    }
    
    func dayMonthYearTime() -> String{
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/YYYY h:mm a"
        return formatter.string(from: self)
    }
    
}
// Mark: String Extention for Date

extension String
{
    /*func timeAgoSinceDate(date:NSDate, numericDates:Bool) -> String {
        let calendar = NSCalendar.current
        let unitFlags = NSCalendar.Unit.CalendarUnitMinute | NSCalendar.Unit.CalendarUnitHour | NSCalendar.Unit.CalendarUnitDay | NSCalendar.Unit.CalendarUnitWeekOfYear | NSCalendar.Unit.CalendarUnitMonth | NSCalendar.Unit.CalendarUnitYear | NSCalendar.Unit.CalendarUnitSecond
        let now = NSDate()
        let earliest = now.earlierDate(date as Date)
        let latest = (earliest == now as Date) ? date : now
        let components:NSDateComponents = calendar.components(unitFlags, fromDate: earliest, toDate: latest, options: nil)
        
        if (components.year >= 2) {
            return "\(components.year) years ago"
        } else if (components.year >= 1){
            if (numericDates){
                return "1 year ago"
            } else {
                return "Last year"
            }
        } else if (components.month >= 2) {
            return "\(components.month) months ago"
        } else if (components.month >= 1){
            if (numericDates){
                return "1 month ago"
            } else {
                return "Last month"
            }
        } else if (components.weekOfYear >= 2) {
            return "\(components.weekOfYear) weeks ago"
        } else if (components.weekOfYear >= 1){
            if (numericDates){
                return "1 week ago"
            } else {
                return "Last week"
            }
        } else if (components.day >= 2) {
            return "\(components.day) days ago"
        } else if (components.day >= 1){
            if (numericDates){
                return "1 day ago"
            } else {
                return "Yesterday"
            }
        } else if (components.hour >= 2) {
            return "\(components.hour) hours ago"
        } else if (components.hour >= 1){
            if (numericDates){
                return "1 hour ago"
            } else {
                return "An hour ago"
            }
        } else if (components.minute >= 2) {
            return "\(components.minute) minutes ago"
        } else if (components.minute >= 1){
            if (numericDates){
                return "1 minute ago"
            } else {
                return "A minute ago"
            }
        } else if (components.second >= 3) {
            return "\(components.second) seconds ago"
        } else {
            return "Just now"
        }
        
    }*/
    func toDateTime() -> Date
    {
        //print("Scheduled Date --->",self)
        //Create Date Formatter
        let dateFormatter = DateFormatter()
        
        //Specify Format of String to Parse
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        //dateFormatter.timeZone = TimeZone.current
        
        //Parse into NSDate
        let dateFromString : Date = dateFormatter.date(from: self)! as Date
        
        //Return Parsed Date
        return dateFromString
    }
    
    func toDateOnly() -> Date
    {
        //Create Date Formatter
        let dateFormatter = DateFormatter()
        
        //Specify Format of String to Parse
        dateFormatter.dateFormat = "yyyy-MM-dd"
        //dateFormatter.timeZone = TimeZone.current
        
        //Parse into NSDate
        let dateFromString : Date = dateFormatter.date(from: self)! as Date
        
        //Return Parsed Date
        return dateFromString
    }
    
    func toDateTimeFromString() -> Date{
        //Create Date Formatter
        let dateFormatter = DateFormatter()
        
        //Specify Format of String to Parse
        dateFormatter.dateFormat = "yyyy-MM-dd' 'HH:mm:ss"
        dateFormatter.timeZone = TimeZone.current
        //Parse into NSDate
        let dateFromString : Date = dateFormatter.date(from: self)! as Date
        
        //Return Parsed Date
        return dateFromString
    }
    
    func stringDateToDate(dateString:String)->Date {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'"
        let date = dateFormatter.date(from: dateString)
        return date!
    }
    
    
    func getTodayString() -> String{
        
        let date = Date()
        let calender = Calendar.current
        let components = calender.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)
        
        let year = components.year
        let month = components.month
        let day = components.day
        let hour = components.hour
        let minute = components.minute
        let second = components.second
        
        let today_string = String(year!) + "-" + String(month!) + "-" + String(day!) + " " + String(hour!)  + ":" + String(minute!) + ":" +  String(second!) + ".jpg"
        
        return today_string
        
    }
    
}

// Mark: Color RGB To HEX.

extension UIColor{
    
    func HexToColor(hexString: String, alpha:CGFloat? = 1.0) -> UIColor {
        // Convert hex string to an integer
        let hexint = Int(self.intFromHexString(hexStr: hexString))
        let red = CGFloat((hexint & 0xff0000) >> 16) / 255.0
        let green = CGFloat((hexint & 0xff00) >> 8) / 255.0
        let blue = CGFloat((hexint & 0xff) >> 0) / 255.0
        let alpha = alpha!
        // Create color object, specifying alpha as well
        let color = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        return color
    }
    
    func intFromHexString(hexStr: String) -> UInt32 {
        var hexInt: UInt32 = 0
        // Create scanner
        let scanner: Scanner = Scanner(string: hexStr)
        // Tell scanner to skip the # character
        scanner.charactersToBeSkipped = NSCharacterSet(charactersIn: "#") as CharacterSet
        // Scan hex value
        scanner.scanHexInt32(&hexInt)
        return hexInt
    }
    
}
// Mark: Resize the image

extension UIImage {
    
    func resizeImage(targetSize: CGSize) -> UIImage {
        
        let size = self.size
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        let newSize = widthRatio > heightRatio ?  CGSize(width: size.width * heightRatio, height: size.height * heightRatio) : CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    func resizeWith(width: CGFloat) -> UIImage? {
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))))
        imageView.contentMode = .scaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        guard let result = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return result
    }
}



extension Encodable {
    
    func asDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            throw NSError()
        }
        return dictionary
    }
}
