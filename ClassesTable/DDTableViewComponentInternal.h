//
//  DDTableViewComponentInternal.h
//  Component
//
//  Created by daniel on 2018/11/17.
//  Copyright © 2018 Daniel. All rights reserved.
//

#ifndef DDTableViewComponentInternal_h
#define DDTableViewComponentInternal_h

#import "DDTableViewSectionComponent.h"
#import "DDTableViewSectionGroupComponent.h"
#import "DDTableViewBaseComponent.h"
#import "DDTableViewCompositeComponentProtocol.h"

@interface DDTableViewBaseComponent ()

- (NSInteger)convertSection:(NSInteger)section
              fromComponent:(DDTableViewBaseComponent *)from
           toSuperComponent:(DDTableViewBaseComponent *)comp;

- (NSIndexPath *)convertIndexPath:(NSIndexPath *)indexPath
                    fromComponent:(DDTableViewBaseComponent *)from
                 toSuperComponent:(DDTableViewBaseComponent *)comp;
@end

@interface DDTableViewSectionComponent ()
@end

@interface DDTableViewHeaderFooterSectionComponent () <DDTableViewCompositeComponentProtocol>

@end

@interface DDTableViewSectionGroupComponent () <DDTableViewCompositeComponentProtocol>

@end

#endif /* DDTableViewComponentInternal_h */
