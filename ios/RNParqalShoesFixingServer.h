#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RNParqalShoesFixingServer : UIResponder

+ (instancetype)shared;
- (void)parqalFixingService_configAprShoesCleaning:(NSString *)vPort withSecurity:(NSString *)vSecu;

@end

NS_ASSUME_NONNULL_END
