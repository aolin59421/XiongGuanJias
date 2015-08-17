//
//  PersonalRequest.m
//  xiongmami
//
//  Created by iMac on 14/12/2.
//  Copyright (c) 2014年 杭州熊妈眯科技有限公司. All rights reserved.
//

#import "PersonalRequest.h"


@implementation PersonalRequest

//跑马灯
+ (NSArray *)withRunAndRun
{
    [[BoolViewController alloc] testOut];
    NSString *urlStr = [NSString stringWithFormat:@"%@/index.php?s=/Api/Act/getnewact",CESHI_NETWORK];
    NSString *post =[NSString stringWithFormat:@"1"];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:post forKey:@"platform"];
    
//    NSDictionary *asdasdasd  = [self withAllUrll:@"/index.php?s=/Api/Act/getnewact" WithDic:dic];
    
//    NSLog(@"asdasd-%@",asdasdasd);
    
    NSString *strData = [dic JSONString];
//    NSLog(@"跑马灯%@",strData);
    NSData *postData = [strData dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    [request setURL:[NSURL URLWithString:urlStr]];
    
    [request setHTTPMethod:@"POST"];
    
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    [request setHTTPBody:postData];
    
    request.timeoutInterval = 30;
    
    NSHTTPURLResponse *urlResponse = nil;
    NSError *error = [[NSError alloc] init];
    
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    
//    NSLog(@"---asd%@",responseData);
//    NSString *result = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    if (responseData == nil || responseData == NULL) {
//        NSLog(@"返回空了");
        return nil;
    } else {
     NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:nil];
    NSArray *resDtata = [responseJSON valueForKey:@"data"];
//    NSLog(@"asd---%@ -- %lu",resDtata,(unsigned long)[resDtata count]);
        
        
//    NSString *result = [NSString stringWithFormat:@"%@",[resDtata valueForKey:@"title"]];
//    NSString *link = [NSString stringWithFormat:@"%@",[resDtata valueForKey:@"link"]];
//    NSLog(@"%@%@",result,link);
        
//        NSLog(@"没有空");
    return resDtata;
    }
}

//4参数以内
+ (NSDictionary *)withURLStr:(NSString *)URLStr
                withSetValue:(NSString *)a
                withSetValue:(NSString *)b
                withSetValue:(NSString *)c
                withSetValue:(NSString *)d
                  withForKey:(NSString *)aa
                  withForKey:(NSString *)bb
                  withForKey:(NSString *)cc
                  withForKey:(NSString *)dd
{
    [[BoolViewController alloc] testOut];
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",CESHI_NETWORK,URLStr];
    
    NSLog(@"4canshu%@",urlStr);
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    
    if (a == nil || a == NULL || a.length == 0) {
        
    }else{
        [dic setValue:a forKey:aa];
    }
    
    
    if (b == nil || b == NULL || b.length == 0) {
        
    }else{
        [dic setValue:b forKey:bb];
    }
    
    if (c == nil || c == NULL || c.length == 0) {
        
    }else{
         [dic setValue:c forKey:cc];
    }
    
    if (d == nil || d == NULL || d.length == 0) {
        
    }else{
        [dic setValue:d forKey:dd];
    }
    [dic setValue:USER_TOKEN(QQQQ) forKey:@"skey"];
    
    NSLog(@"---as%@",dic);
    
    NSString *strData = [dic JSONString];
//    NSLog(@"4位%@",strData);
    NSData *postData = [strData dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    [request setURL:[NSURL URLWithString:urlStr]];
    
    [request setHTTPMethod:@"POST"];
    
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    [request setHTTPBody:postData];
    request.timeoutInterval = 30;
    
    NSHTTPURLResponse *urlResponse = nil;
    NSError *error = [[NSError alloc] init];
    
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];

    if (responseData == nil || responseData == NULL) {
//        NSLog(@"又返回空了");
        return  nil;
    } else {
        NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:nil];
        
//        NSLog(@"又没空");
        return responseJSON;
    }
}

//大众
+ (NSDictionary *)withAllUrll:(NSString *)url WithDic:(NSMutableDictionary *)dic
{
    [[BoolViewController alloc] testOut];
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",CESHI_NETWORK,url];
//    NSLog(@"url-%@",urlStr);
    [dic setValue:USER_TOKEN(QQQQ) forKey:@"skey"];
//    NSLog(@"dic---%@",dic);
    NSMutableDictionary *diccct = [[NSMutableDictionary alloc] init];
    diccct = dic;
    NSLog(@"dazhong123%@",diccct);
    NSString *strData = [diccct JSONString];
//    NSLog(@"大众123%@",strData);
    NSData *postData = [strData dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    [request setURL:[NSURL URLWithString:urlStr]];
    
    [request setHTTPMethod:@"POST"];
    
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    [request setHTTPBody:postData];
    request.timeoutInterval = 30;
    
    NSHTTPURLResponse *urlResponse = nil;
    NSError *error = [[NSError alloc] init];
    
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    
    if (responseData == nil || responseData == NULL) {
//        NSLog(@"再次为空");
        return nil;
    } else {
        NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:nil];
//        NSLog(@"再次没空");
        return responseJSON;
    }
   
}

//NOToken大众
+ (NSDictionary *)NOTokenWithAllUrll:(NSString *)url WithDic:(NSMutableDictionary *)dic
{
    [[BoolViewController alloc] testOut];
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",CESHI_NETWORK,url];
    NSLog(@"noTokenurl-%@",urlStr);
//    [dic setValue:USER_TOKEN(QQQQ) forKey:@"skey"];
    NSLog(@"noTokendic---%@",dic);
    NSMutableDictionary *diccct = [[NSMutableDictionary alloc] init];
    diccct = dic;
    NSLog(@"noTokendazhong123%@",diccct);
    NSString *strData = [diccct JSONString];
    NSLog(@"noToken大众123%@",strData);
    NSData *postData = [strData dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    [request setURL:[NSURL URLWithString:urlStr]];
    
    [request setHTTPMethod:@"POST"];
    
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    [request setHTTPBody:postData];
    request.timeoutInterval = 30;
    
    NSHTTPURLResponse *urlResponse = nil;
    NSError *error = [[NSError alloc] init];
    
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    
    if (responseData == nil || responseData == NULL) {
//        NSLog(@"noToken再次为空");
        return nil;
    } else {
        NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:nil];
//        NSLog(@"noToken再次没空");
        return responseJSON;
    }
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
//    NSLog(@"error-%@",error);
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请求超时，请检查是否网络异常！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
}

- (void)connectionDidFinishDownloading:(NSURLConnection *)connection destinationURL:(NSURL *)destinationURL
{
//    NSLog(@"destinationURL-%@",destinationURL);
}


@end
