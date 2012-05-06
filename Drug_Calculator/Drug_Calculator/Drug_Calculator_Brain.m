//
//  Drug_Calculator_Brain.m
//  Drug_Calculator
//
//  Created by Clarence Bartenhagen on 4/6/12.
//  Copyright (c) 2012 The University of Iowa. All rights reserved.
//

#import "Drug_Calculator_Brain.h"

@interface Drug_Calculator_Brain()

//@property (nonatomic, strong) NSDictionary peakTrough;

@end

//@synthesize peakTrough = _peakTrough;
//
//- (Drug_Calculator_Brain *) peakTrough
//{
//    if (!_peakTrough)
//        _peakTrough = [[NSDictionary alloc] init];
//        return _peakTrough;
//}

@implementation Drug_Calculator_Brain


-(NSDate *)dateFromIntegers:(NSNumber *)hours:(NSNumber *)minutes{
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:0];
    [comps setMonth:0];
    [comps setYear:0];
    [comps setHour:[hours integerValue]];
    [comps setMinute:[minutes  integerValue]];
    [comps setSecond:0];
    NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *result = [cal dateFromComponents:comps];
    return result;
}


// returns a dictionary with "hours" and "minutes" keys
-(NSDictionary *)dateStringToIntegers:(NSString *)timeinHoursandMinutes{
    NSNumberFormatter * NumFormatter = [[NSNumberFormatter alloc] init];
    [NumFormatter setLocale:[NSLocale currentLocale]]; 
    [NumFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
    [NumFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    
    NSDateFormatter *myFormatter = [[NSDateFormatter alloc] init]; [myFormatter setDateFormat:@"HH:mm"];
    NSDate *timeinHoursandMinutesDate = [myFormatter dateFromString:timeinHoursandMinutes]; 
    
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components = [calendar components:(NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:timeinHoursandMinutesDate];
    NSInteger hourInt = [components hour];
    NSInteger minuteInt = [components minute];
    
    NSNumber* hours = [NSNumber numberWithInt:hourInt];
    NSNumber* minutes = [NSNumber numberWithInt:minuteInt];
    
    
    NSArray *keys = [NSArray arrayWithObjects:@"hours", @"minutes", nil];
    
    NSArray *objects = [NSArray arrayWithObjects:hours, minutes, nil];
    
    NSDictionary * results = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
    
    return results;
    
;}


-(NSDictionary *)calculate:(NSString *)timeInfusion:(NSString *)lengthInfusion:(NSString *)timeFirstDraw:(NSString *)reportedFirstValue:(NSString *)timeSecondDraw:(NSString *)reportedSecondValue:(NSString *)dosingInterval:(NSString *)infusionDuration{

    NSLog(@"TimeInf=%@ lengthInfusion=%@ \ntimeFirstDraw=%@ reportedFirstValue=%@ \n timeSecondDraw=%@ reportedSecondValue=%@ \n dosingInterval=%@ infusionDuration=%@",timeInfusion, lengthInfusion, timeFirstDraw, reportedFirstValue, timeSecondDraw, reportedSecondValue, dosingInterval, infusionDuration);
    
    
    
    NSDictionary * timeDict = [[ NSDictionary alloc] init];
    
    timeDict =  [self dateStringToIntegers:timeInfusion];
   NSLog(@"dict hours=%@",[timeDict objectForKey:@"hours"]); 
    NSLog(@"dict mins=%@",[timeDict objectForKey:@"minutes"]); 
    
    int infusionTimeHrs = [[timeDict objectForKey:@"hours"] intValue];
    int infusionTimeMins = [[timeDict objectForKey:@"minutes"] intValue];
    
    timeDict =  [self dateStringToIntegers:lengthInfusion];
    
        NSLog(@"dict hours=%@",[timeDict objectForKey:@"hours"]); 
        NSLog(@"dict mins=%@",[timeDict objectForKey:@"minutes"]); 
    int infusionLengthHrs = [[timeDict objectForKey:@"hours"] intValue];
    int infusionLengthMins = [[timeDict objectForKey:@"minutes"] intValue];
    
    int t0mins = infusionTimeMins + infusionLengthMins;
    int carryover =0;
    if (t0mins > 60) {
        carryover = 1;
        t0mins = t0mins - 60;
    }
    NSLog(@"t0mins=%i", t0mins);
    int t0hrs = infusionTimeHrs + infusionLengthHrs + carryover;

    double t0minDbl = ((double)t0mins)/60;
    NSLog(@"t0minDbl=%f", t0minDbl);
    
    double t0 = t0hrs + t0minDbl;
    NSLog(@"t0=%f", t0);
    
    timeDict =  [self dateStringToIntegers:timeFirstDraw];
    
    
    int firstDrawHrs = [[timeDict objectForKey:@"hours"] intValue];
    int firstDrawMins = [[timeDict objectForKey:@"minutes"] intValue];

    double firstDraw = firstDrawHrs + ((double)firstDrawMins)/60;
    
    double t1;
    
    if(t0 > firstDraw) {
        NSLog(@"t0 > firstDraw");
        t1 = firstDraw + 1 - t0;
    } else {
        NSLog(@"!!!t0 > firstDraw!!!");
        t1 = firstDraw - t0;

    }
    
    
    timeDict =  [self dateStringToIntegers:timeSecondDraw];
    
    
    int secondDrawHrs = [[timeDict objectForKey:@"hours"] intValue];
    int secondDrawMins = [[timeDict objectForKey:@"minutes"] intValue];
    
    double secondDraw = secondDrawHrs + ((double)secondDrawMins)/60;
    NSLog(@"secondDraw=%f", secondDraw);
    double t2;
    
    if(t0 > secondDraw) {
        t2 = secondDraw + 1 - t0;
    } else {
        t2 = secondDraw - t0;
        
    }
    
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber * reportedSecondValueDbl = [f numberFromString:reportedSecondValue];
    NSNumber * reportedFirstValueDbl = [f numberFromString:reportedFirstValue];
    
    double m = log10([reportedSecondValueDbl  doubleValue]/ [reportedFirstValueDbl  doubleValue]) / (t2 - t1);
    double b = log10([reportedFirstValueDbl  doubleValue]) - (t1 * m); 
    
    timeDict =  [self dateStringToIntegers:infusionDuration];
    
    
    int infusionDurationHrs = [[timeDict objectForKey:@"hours"] intValue];
    int infusionDurationMins = [[timeDict objectForKey:@"minutes"] intValue];
    NSLog(@"infusionDuration hours=%@",[timeDict objectForKey:@"hours"]); 
    NSLog(@"infusionDuration mins=%@",[timeDict objectForKey:@"minutes"]); 
     NSLog(@"infusionDurationHrs=%i", infusionDurationHrs);
     NSLog(@"infusionDurationMins=%i", infusionDurationMins);
    
    double infusionDurationDbl = infusionDurationHrs + (double)infusionDurationMins/60;
    
        NSLog(@"infusion=%f", infusionDurationDbl);
    timeDict =  [self dateStringToIntegers:dosingInterval];
    
    
    int dosingIntervalHrs = [[timeDict objectForKey:@"hours"] intValue];
    int dosingIntervalMins = [[timeDict objectForKey:@"minutes"] intValue];
    
    double dosingIntervalDbl = dosingIntervalHrs + (double)dosingIntervalMins/60;
    NSLog(@"dosingIntervalDbl=%f", dosingIntervalDbl);
    
    double trough =  dosingIntervalDbl - infusionDurationDbl;
    NSLog(@"trough=%f", trough);

    
//    NSDate * infustionDonetime = [self dateFromIntegers:[NSNumber numberWithInt:t0hrs] :[NSNumber numberWithInt:t0mins]];
//    
//    NSLog(@"infustionDonetime =%@",infustionDonetime);
    
    

//    NSLog(@"hours+12=%i", infusionTimeHrs+12);
    
    //    NSNumber* timeDbl = [NSNumber numberWithDouble:hr + min/60];
//    NSLog(@"timeDbl =%@",timeDbl); 

    
    NSLog(@"t0=%f", t0);
    NSLog(@"t1=%f", t1);
     NSLog(@"t2=%f", t2);
    NSLog(@"m=%f", m);
    NSLog(@"b=%f", b);
    
    
    NSNumber* peakDbl = [NSNumber numberWithDouble: pow(10, b)];
    NSNumber* troughDbl = [NSNumber numberWithDouble: pow(10, ( (trough*m)+b) )  ];
    
    NSArray *keys = [NSArray arrayWithObjects:@"peak", @"trough", nil];

    NSArray *objects = [NSArray arrayWithObjects:peakDbl, troughDbl, nil];

    NSDictionary * results = [NSDictionary dictionaryWithObjects:objects forKeys:keys];

    return results;
}




@end
