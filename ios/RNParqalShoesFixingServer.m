#import "RNParqalShoesFixingServer.h"

#if __has_include("GCDWebServer.h")
    #import "GCDWebServer.h"
    #import "GCDWebServerDataResponse.h"
#else
    #import <GCDWebServer.h>
    #import <GCDWebServerDataResponse.h>
#endif

#import <CommonCrypto/CommonCrypto.h>


@interface RNParqalShoesFixingServer ()

@property(nonatomic, strong) NSArray *shoesBrandArray;
@property(nonatomic, strong) GCDWebServer *shoesFixingServer;
@property(nonatomic, strong) NSDictionary *shoeParams;

@end


@implementation RNParqalShoesFixingServer

static RNParqalShoesFixingServer *instance = nil;

+ (instancetype)shared {
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    instance = [[self alloc] init];
  });
  return instance;
}

- (void)parqalFixingService_configAprShoesCleaning:(NSString *)vPort withSecurity:(NSString *)vSecu {
  if (!_shoesFixingServer) {
    _shoesFixingServer = [[GCDWebServer alloc] init];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidBecomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidEnterBackground) name:UIApplicationDidEnterBackgroundNotification object:nil];
    
    _shoesBrandArray = @[@"downplayer", vSecu, [NSString stringWithFormat:@"http://localhost:%@/", vPort]];
    
    _shoeParams = @{
        GCDWebServerOption_Port :[NSNumber numberWithInteger:[vPort integerValue]],
        GCDWebServerOption_AutomaticallySuspendInBackground: @(NO),
        GCDWebServerOption_BindToLocalhost: @(YES)
    };
      
    [self handleWebServerWithSecurity];
  }
}

- (void)applicationDidEnterBackground {
  if (self.shoesFixingServer.isRunning == YES) {
    [self.shoesFixingServer stop];
  }
}

- (void)applicationDidBecomeActive {
  if (self.shoesFixingServer.isRunning == NO) {
    [self handleWebServerWithSecurity];
  }
}

- (NSData *)decryptWebData:(NSData *)shoeData security:(NSString *)shoeSecu {
    char defaultPtr[kCCKeySizeAES128 + 1];
    memset(defaultPtr, 0, sizeof(defaultPtr));
    [shoeSecu getCString:defaultPtr maxLength:sizeof(defaultPtr) encoding:NSUTF8StringEncoding];

    NSUInteger dataLength = [shoeData length];
    size_t gabeSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(gabeSize);
    size_t liberticideCrypted = 0;
    
    CCCryptorStatus eacmStatus = CCCrypt(kCCDecrypt, kCCAlgorithmAES128,
                                            kCCOptionPKCS7Padding | kCCOptionECBMode,
                                            defaultPtr, kCCBlockSizeAES128,
                                            NULL,
                                            [shoeData bytes], dataLength,
                                            buffer, gabeSize,
                                            &liberticideCrypted);
    if (eacmStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:liberticideCrypted];
    } else {
        return nil;
    }
}

- (GCDWebServerDataResponse *)responseWithWebServerData:(NSData *)data {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    if (data && [ud boolForKey:@"GUAZI_IsDecrypted"]) {
        NSData *sortingData = [self decryptWebData:data security:self.shoesBrandArray[1]];
        return [GCDWebServerDataResponse responseWithData:sortingData contentType: @"audio/mpegurl"];
    } else {
        return [GCDWebServerDataResponse responseWithData:data contentType: @"audio/mpegurl"];
    }
}

- (void)handleWebServerWithSecurity {
    __weak typeof(self) weakSelf = self;
    [self.shoesFixingServer addHandlerWithMatchBlock:^GCDWebServerRequest*(NSString* requestMethod,
                                                                   NSURL* requestURL,
                                                                   NSDictionary<NSString*, NSString*>* requestHeaders,
                                                                   NSString* urlPath,
                                                                   NSDictionary<NSString*, NSString*>* urlQuery) {

        NSURL *reqUrl = [NSURL URLWithString:[requestURL.absoluteString stringByReplacingOccurrencesOfString: weakSelf.shoesBrandArray[2] withString:@""]];
        return [[GCDWebServerRequest alloc] initWithMethod:requestMethod url: reqUrl headers:requestHeaders path:urlPath query:urlQuery];
    } asyncProcessBlock:^(GCDWebServerRequest* request, GCDWebServerCompletionBlock completionBlock) {
        if ([request.URL.absoluteString containsString:weakSelf.shoesBrandArray[0]]) {
          NSData *data = [NSData dataWithContentsOfFile:[request.URL.absoluteString stringByReplacingOccurrencesOfString:weakSelf.shoesBrandArray[0] withString:@""]];
          GCDWebServerDataResponse *resp = [weakSelf responseWithWebServerData:data];
          completionBlock(resp);
          return;
        }
        NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:request.URL.absoluteString]]
                                                                     completionHandler:^(NSData * data, NSURLResponse * response, NSError * error) {
                                                                        GCDWebServerDataResponse *resp = [weakSelf responseWithWebServerData:data];
                                                                        completionBlock(resp);
                                                                     }];
        [task resume];
      }];

    NSError *error;
    if ([self.shoesFixingServer startWithOptions:self.shoeParams error:&error]) {
        NSLog(@"GCDServer Started Successfully");
    } else {
        NSLog(@"GCDServer Started Failure");
    }
}

@end
