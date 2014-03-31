TNBDeviceStub
=============

A stub class for UIDevice, UIScreen.

## Usage
Create cutom device instance and invoke replace.
```objective-c
TNBDeviceStub *stubDevice = [TNBDeviceStub new];
stubDevice.name = @"My iPhone";
stubDevice.model = @"stub";
stubDevice.systemVersion = @"5.0";
stubDevice.batteryLevel = 0;
[stubDevice replace];
```

See [UIDevice currentDevice]
```objective-c
NSLog(@"%@", [UIDevice currentDevice].name); // My iPhone
NSLog(@"%@", [UIDevice currentDevice].model); // stub
NSLog(@"%@", [UIDevice currentDevice].systemVersion); // 5.0
NSLog(@"%f", [UIDevice currentDevice].batteryLevel); // 0.000000
```

Restore original implementation
```objective-c
[TNBDeviceStub restore];

// depends on your device
NSLog(@"%@", [UIDevice currentDevice].name); // iPad Simulator
NSLog(@"%@", [UIDevice currentDevice].model); // iPhone Simulator
NSLog(@"%@", [UIDevice currentDevice].systemVersion); // 7.1
NSLog(@"%f", [UIDevice currentDevice].batteryLevel); // -1.000000
```

## License
TNBLogger is available under the MIT license. See the LICENSE file for more info.
