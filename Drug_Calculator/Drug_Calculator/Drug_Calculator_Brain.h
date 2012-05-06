//
//  Drug_Calculator_Brain.h
//  Drug_Calculator
//
//  Created by Clarence Bartenhagen on 4/6/12.
//  Copyright (c) 2012 The University of Iowa. All rights reserved.
//

#import <Foundation/Foundation.h>
        

@interface Drug_Calculator_Brain : NSObject

-(NSDictionary *)calculate:(NSString *)timeInfusion:(NSString *)lengthInfusion:(NSString *)timeFirstDraw:(NSString *)reportedFirstValue:(NSString *)timeSecondDraw:(NSString *)reportedSecondValue:(NSString *)dosingInterval:(NSString *)infusionDuration;


@end
