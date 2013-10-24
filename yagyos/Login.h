//
//  Login.h
//  yagyos
//
//  Created by Guillermo Vallespir on 24-10-13.
//  Copyright (c) 2013 Guillermo Vallespir. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Login : UIViewController{
    UITextField *correo;
    UITextField *clave;
}


@property (nonatomic, strong) UITextField *correo;
@property (nonatomic, strong) UITextField *clave;

@end
