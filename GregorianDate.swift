//
//  GregorianDate.swift
//  rhayhu2_swift_project
//
//  Created by Bob on 4/29/16.
//  Copyright © 2016 rhayhu2. All rights reserved.
//

import Foundation

class GregorianDate
{
    let month:     Int
    let day:       Int
    let year:      Int
    
    init(month: Int, day: Int, year: Int)
    {
        self.month     = month
        self.day       = day
        self.year      = year
    }
    
    func errorCheck()->String
    {
        if month < 1 || day < 1 || year < 1
        {
            return "All entries must be greater than zero"
        }
        
        if month > 12 // check that all months are <= 12
        {
            return "Months must be less than 12"
        }
        
        if year > 5000 // check that all years are below 5000
        {
            return "Years must be less than 5000"
        }
        
        if day > 31 // check that at all days are < 31
        {
            return "Days must be at least less than 31"
        }
        
        if month == 4 || month == 6 || month == 11
        {
            if day > 30
            {
                return "Apr, Jun, Nov have 30 days"
            }
        }
        
        if month == 2
        {
            if day > 29
            {
                return "Feb has at most 29 days"
            }
        }
        return ""
    }
    
    func isLeapYear(year: Int)->Bool
    {
        if year%4 != 0 {return false}
        else
        {
            if year%100 != 0 {return true }
            else
            {
                if year%400 == 0 {return true}
                else          {return false}
            }
        }
    }
    
    func getNumDaysUntilEndOfMonth()->Int
    {
        //
        // get the number of days until the end of the month
        //
        switch month
        {
        // all the months with 31 days
        case 1: fallthrough
        case 3: fallthrough
        case 5: fallthrough
        case 6: fallthrough
        case 7: fallthrough
        case 8: fallthrough
        case 9: fallthrough
        case 12:
            return 31-day
            
        // all the months with 30 days
        case 4: fallthrough
        case 6: fallthrough
        case 9: fallthrough
        case 11:
            return 30-day
            
        // Februrary is special
        case 2:
            if isLeapYear(year) {return 29-day}
            else                {return 28-day}
        default:
            print("ERROR IN FIRST SWITCH STATEMENT IN getNumDaysUntilEndOfYear()")
            return -999
        }
    }
    
    func getNumDaysUntilEndOfYear()->Int
    {
        let numDays = getNumDaysUntilEndOfMonth()
        //
        // add the remaining days in each month to get the
        // total number of days from the date until the end of the
        // year
        //
        switch month
        {
        case 1:
            if isLeapYear(year) {return numDays+335}
            else                {return numDays+334}
        case 2:                  return numDays+306
        case 3:                  return numDays+275
        case 4:                  return numDays+245
        case 5:                  return numDays+241
        case 6:                  return numDays+184
        case 7:                  return numDays+153
        case 8:                  return numDays+122
        case 9:                  return numDays+92
        case 10:                 return numDays+61
        case 11:                 return numDays+31
        case 12:                 return numDays
        default:
            print("ERROR: IN SECOND SWITCH STATMENT IN getNumDaysUntilEndOfYear()")
            return -999
        }
    }
    
    func getNumDaysFromEndOfStartYearToStartOfEndYear(endYear: Int)->Int
    {
        var numDaysBetweemYears = 0
        for var i = 0; i < endYear-year-1; i+=1
        {
            if isLeapYear(i+year) {numDaysBetweemYears+=366}
            else                  {numDaysBetweemYears+=365}
        }
        return numDaysBetweemYears
    }
    
    func getJulianNumber()->Int
    {
        let m: Int
        let y: Int
        let d = day
        if month == 1 || month == 2
        {
            m = month+12
            y = year-1
        }
        else
        {
            m = month
            y = year
        }
        return(365*y)+(y/4)+(y/100)+(y/400)+d+(((153*m)+8)/5)
    }
    
    func getNumDaysFromBeginningOfYearToDate()->Int
    {
        if isLeapYear(year){return 366-getNumDaysUntilEndOfYear()}
        else               {return 365-getNumDaysUntilEndOfYear()}
    }
    
    
}