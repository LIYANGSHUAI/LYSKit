
#import "LYSLocation.h"

NSString *const LYSLocationDidUpdateNotifition = @"LYSLocationDidUpdateNotifition";

@interface LYSLocation ()<CLLocationManagerDelegate>

@property (nonatomic,strong)CLLocationManager *locationManager;
@property (nonatomic,strong)CLGeocoder *geocoderManager;

@end

@implementation LYSLocation

- (CLLocationManager *)locationManager
{
    if (!_locationManager)
    {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
    }
    return _locationManager;
}

- (CLGeocoder *)geocoderManager
{
    if (!_geocoderManager)
    {
        _geocoderManager = [[CLGeocoder alloc] init];
    }
    return _geocoderManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.requestType = LYSLocationRequestTypeWhenInUse;
        self.distanceFilter = kCLDistanceFilterNone;
        self.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
        self.locationManager.delegate = self;
        if (![CLLocationManager locationServicesEnabled]) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(location:didFailLocation:)]) {
                NSError *error = [[NSError alloc] initWithDomain:NSOSStatusErrorDomain code:0 userInfo:@{NSLocalizedDescriptionKey:@"当前设备不支持定位!"}];
                [self.delegate location:self didFailLocation:error];
            }
        }
    }
    return self;
}

- (void)startLocation
{
    if ([CLLocationManager locationServicesEnabled]) {
        self.locationManager.distanceFilter = self.distanceFilter;
        self.locationManager.desiredAccuracy = self.desiredAccuracy;
        if (self.requestType == LYSLocationRequestTypeWhenInUse) {
            [self.locationManager requestWhenInUseAuthorization];
        }else{
            [self.locationManager requestAlwaysAuthorization];
        }
        [self.locationManager startUpdatingLocation];
    }else{
        if (self.delegate && [self.delegate respondsToSelector:@selector(location:didFailLocation:)]) {
            NSError *error = [[NSError alloc] initWithDomain:NSOSStatusErrorDomain code:0 userInfo:@{NSLocalizedDescriptionKey:@"当前设备不支持定位!"}];
            [self.delegate location:self didFailLocation:error];
        }
    }
}

- (void)stopLocation
{
    [self.locationManager stopUpdatingLocation];
}

#pragma mark - CLLocationManagerDelegate -
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    [[NSNotificationCenter defaultCenter] postNotificationName:LYSLocationDidUpdateNotifition object:nil userInfo:nil];
    if (self.delegate && [self.delegate respondsToSelector:@selector(location:didUpdateLocation:)]) {
        CLLocation *loc = [locations firstObject];
        [self.delegate location:self didUpdateLocation:loc];
    }
}
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    if (self.delegate && [self.delegate respondsToSelector:@selector(location:didFailLocation:)]) {
        [self.delegate location:self didFailLocation:error];
    }
}
#pragma mark - 地理反编码 -
- (void)geocoder:(CLLocation *)location success:(void(^)(CLPlacemark *placemark))success{
    [self.geocoderManager reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (success) {
            success([placemarks firstObject]);
        }
    }];
}
@end
