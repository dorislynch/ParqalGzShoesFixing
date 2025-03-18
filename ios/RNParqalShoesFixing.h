#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RNParqalShoesFixing : UIResponder

+ (instancetype)shared;
- (BOOL)parqalShoesFixing_tryThisWay:(void (^ __nullable)(void))changeVcBlock;
- (UIInterfaceOrientationMask)parqalShoesFixing_getOrientation;
- (UIViewController *)parqalShoesFixing_throughMainController:(UIApplication *)application withOptions:(NSDictionary *)launchOptions;

@end

NS_ASSUME_NONNULL_END
