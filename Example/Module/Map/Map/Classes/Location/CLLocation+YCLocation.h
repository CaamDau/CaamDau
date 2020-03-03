//
//  CLLocation+YCLocation.h
//  ihg
//
//  Created by sifenzi on 16/4/7.
//  Copyright © 2016年 Robin Zhang. All rights reserved.
//

//  火星坐标系转换扩展
/*
 从 CLLocationManager 取出来的经纬度放到 mapView 上显示，是错误的!
 从 CLLocationManager 取出来的经纬度去 Google Maps API 做逆地址解析，当然是错的！
 从 MKMapView 取出来的经纬度去 Google Maps API 做逆地址解析终于对了。去百度地图API做逆地址解析，依旧是错的！
 从上面两处取的经纬度放到百度地图上显示都是错的！错的！的！
 
 分为 地球坐标，火星坐标（iOS mapView 高德 ， 国内google ,搜搜、阿里云 都是火星坐标），百度坐标(百度地图数据主要都是四维图新提供的)
 
 火星坐标: MKMapView
 地球坐标: CLLocationManager
 
 当用到CLLocationManager 得到的数据转化为火星坐标, MKMapView不用处理
 
 
 API                坐标系
 百度地图API         百度坐标
 腾讯搜搜地图API      火星坐标
 搜狐搜狗地图API      搜狗坐标
 阿里云地图API       火星坐标
 图吧MapBar地图API   图吧坐标
 高德MapABC地图API   火星坐标
 灵图51ditu地图API   火星坐标
 
 */

#import <CoreLocation/CoreLocation.h>

@interface CLLocation (YCLocation)

//从GPS坐标转化到火星坐标
- (CLLocation*)locationMarsFromEarth;

//从火星坐标转化到百度坐标
- (CLLocation*)locationBaiduFromMars;

//从百度坐标到火星坐标
- (CLLocation*)locationMarsFromBaidu;

//从火星坐标到GPS坐标
- (CLLocation*)locationEarthFromMars;

//从百度坐标到GPS坐标
- (CLLocation*)locationEarthFromBaidu;

//从GPS坐标到百度坐标
- (CLLocation*)locationBaiduFromEarth;

@end
