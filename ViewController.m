//
//  ViewController.m
//  Lock
//
//  Created by zyl on 15/10/9.
//  Copyright (c) 2015年 wyn. All rights reserved.
//

#import "ViewController.h"

#define ScreenW  [[UIScreen mainScreen] bounds].size.width
#define ScreenH  [[UIScreen mainScreen] bounds].size.height

@interface ViewController ()
{
    UIView *bgView; //整个背景
    UIView *PswView;//4个输入密码的背景
    CGFloat height;
    UIButton *cancel;
    NSMutableArray *pswArr;
}
@end

@implementation ViewController
/*! This property knows my name. */

- (void)viewDidLoad {

    [super viewDidLoad];

    bgView = [[UIView alloc]initWithFrame:self.view.frame];
    bgView.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.680];
    [self.view addSubview:bgView];
    height = ScreenH/16.675;
    pswArr = [NSMutableArray array];
    [self loadInputPsw];
    [self NumberView];


}
/*! This property knows my name. */
#pragma mark 输入密码视图
- (void)loadInputPsw{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(80, height*2, (ScreenW-80*2), 20)];
    label.text = @"输入密码";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    [bgView addSubview:label];
    
    
    PswView = [[UIView alloc]initWithFrame:CGRectMake(100, CGRectGetMaxY(label.frame)+10, (ScreenW-100*2), 20)];
//    PswView.backgroundColor = [UIColor redColor];
    [bgView addSubview:PswView];
    CGFloat tempWidth = (CGRectGetWidth(PswView.frame)-12*4)/3;
    for (int i = 0; i < 4; i ++) {
        UILabel *psw1 = [[UILabel alloc]initWithFrame:CGRectMake(i*tempWidth+i*12, (CGRectGetHeight(PswView.frame)-10)/2, 12, 12)];
        psw1.layer.cornerRadius = CGRectGetWidth(psw1.frame)/2;
        psw1.layer.borderColor = [UIColor whiteColor].CGColor;
        psw1.backgroundColor = [UIColor clearColor];
        psw1.tag = 1000+i;
        psw1.clipsToBounds = YES;
        psw1.layer.borderWidth = 1;
        [PswView addSubview:psw1];
    }
    
    
}
/**
 *  ksjdskfhjskdfhsjdf
 */
- (void)NumberView{
    
    CGFloat btnHeight = (ScreenH-CGRectGetMaxY(PswView.frame)-40*2-3*20)/4;
    CGFloat leftHeight = (ScreenW-btnHeight*3)/4;
    NSArray *arr =@[@"",@"A B C",@"D E F",@"G H I",@"J K L",@"M N O",@"P Q R S",@"T U V",@"W X Y Z",@""];
    for (int i = 0; i < 4; i++) {
        for (int j = 0; j < 4; j++) {
            if (i==3) {
                if (j==0 || j==2) {
                    continue;
                }
            }
            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(leftHeight+j*(leftHeight+btnHeight),CGRectGetMaxY(PswView.frame)+40+ i*btnHeight+i*height/2, btnHeight, btnHeight)];
            int index = i*3+j+1;
            if (index>9) {
                index=0;
            }
            [btn setTitle:[NSString stringWithFormat:@"%d",index] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont fontWithName:@"CourierNewPsmt" size:40.f];
            btn.layer.cornerRadius = CGRectGetHeight(btn.frame)/2;
            btn.layer.borderWidth = 1.5;
            btn.layer.borderColor = [UIColor whiteColor].CGColor;
            btn.clipsToBounds = YES;
            [btn addTarget:self action:@selector(inputPsw:) forControlEvents:UIControlEventTouchUpInside];
            [bgView addSubview:btn];
            
            
            
            UILabel *zm = [[UILabel alloc]initWithFrame:CGRectMake(10, btnHeight-30, btnHeight-20, 20)];
            zm.textAlignment = NSTextAlignmentCenter;
            zm.textColor = [UIColor whiteColor];
            zm.font =  [UIFont fontWithName:@"STHeitiJ-Light" size:10.f];
            if (index==0) {
                index=1;
//                num.frame = CGRectMake(0, 0, btnHeight, btnHeight);
//                num.textAlignment = NSTextAlignmentCenter;
            }
            zm.text = arr[index-1];
            
            [btn addSubview:zm];
            
        }
    }
    
    
    UIButton *jinji = [[UIButton alloc]initWithFrame:CGRectMake(leftHeight, ScreenH-40, 80, 40)];
    [jinji setTitle:@"紧急情况" forState:UIControlStateNormal];
    jinji.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [jinji addTarget:self action:@selector(jinjiAction) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:jinji];
    
    
    
    cancel = [[UIButton alloc]initWithFrame:CGRectMake(ScreenW-leftHeight-80, ScreenH-40, 80, 40)];
    cancel.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [cancel addTarget:self action:@selector(delegatePsw:) forControlEvents:UIControlEventTouchUpInside];
    [cancel setTitle:@"取消" forState:UIControlStateNormal];
    [bgView addSubview:cancel];
    
    
    
    
}


- (void)inputPsw:(UIButton *)sender{
    [cancel setTitle:@"删除" forState:UIControlStateNormal];
    
    [pswArr addObject:sender.currentTitle];
    [self dealAction];
   
    
}


- (void)jinjiAction{
    NSLog(@"紧急情况");
}




- (void)delegatePsw:(UIButton *)sender{
    [pswArr removeLastObject];
    if (pswArr.count>=1) {
        for (int i = 0; i < 4; i ++) {
            UILabel *psw1 = (UILabel *)[self.view viewWithTag:1000+i];
            if (i<=pswArr.count-1) {
                psw1.backgroundColor = [UIColor whiteColor];
            }else{
                psw1.backgroundColor = [UIColor clearColor];
            }
        }
        
    }else{
        [sender setTitle:@"取消" forState:UIControlStateNormal];
        for (int i = 0; i < 4; i ++) {
            UILabel *psw1 = (UILabel *)[self.view viewWithTag:1000+i];
            
                psw1.backgroundColor = [UIColor clearColor];

        }
    }
    
    
    
    
}


- (void)dealAction{
    for (int i = 0; i < pswArr.count; i ++) {
        UILabel *psw1 = (UILabel *)[self.view viewWithTag:1000+i];
        psw1.backgroundColor = [UIColor whiteColor];
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (pswArr.count==4) {
            NSString *string = [self stringAppending:pswArr];
            if ([string isEqualToString:@"1111"]) {
                NSLog(@"密码正确");
            }else{
                for (int i = 0; i < pswArr.count; i ++) {
                    UILabel *psw1 = (UILabel *)[self.view viewWithTag:1000+i];
                    psw1.backgroundColor = [UIColor clearColor];
                }
                
                CGAffineTransform moveRight = CGAffineTransformTranslate(CGAffineTransformIdentity, 20, 0);
                CGAffineTransform moveLeft = CGAffineTransformTranslate(CGAffineTransformIdentity, -20, 0);
                CGAffineTransform resetTransform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, 0);
                [UIView animateWithDuration:0.1 animations:^{
                    PswView.transform = moveLeft;
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.1 animations:^{
                        PswView.transform = moveRight;
                    } completion:^(BOOL finished) {
                        [UIView animateWithDuration:0.1 animations:^{
                            PswView.transform = moveLeft;
                        } completion:^(BOOL finished) {
                            [UIView animateWithDuration:0.1 animations:^{
                                PswView.transform = resetTransform;
                            }];
                        }];
                        
                    }];
                }];
                
            }
            [pswArr removeAllObjects];
            [cancel setTitle:@"取消" forState:UIControlStateNormal];
        }
    });
}


- (NSString *)stringAppending:(NSArray *)arr{
    NSString *string = @"";
    for (int i = 0; i < arr.count; i ++) {
        string = [string stringByAppendingString:arr[i]];
    }
    return string;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
