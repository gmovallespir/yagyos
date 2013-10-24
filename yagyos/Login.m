//
//  Login.m
//  yagyos
//
//  Created by Guillermo Vallespir on 24-10-13.
//  Copyright (c) 2013 Guillermo Vallespir. All rights reserved.
//

#import "Login.h"
#import "Utils.h"
#import "Conexion.h"
#import "Home.h"

@interface Login ()

@end

@implementation Login
@synthesize correo, clave;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor: [Utils colorWithHexString: @"272929"]];
    
    UILabel *titulo = [[UILabel alloc]initWithFrame:CGRectMake(10, 8, 300, 60)];
    titulo.text = @"Bienvenido a YagYos";
    titulo.textColor = [UIColor whiteColor];
    titulo.textAlignment = UITextAlignmentCenter;
    titulo.font = [UIFont fontWithName:@"Trebuchet MS" size:22.0f];
    
    UILabel *content = [[UILabel alloc]initWithFrame:CGRectMake(10, 88, 300, 60)];
    content.text = @"Ingresa tu correo electrónico y contraseña para entrar a YagYos";
    content.numberOfLines = 2;
    content.textAlignment = UITextAlignmentCenter;
    content.textColor = [UIColor whiteColor];
    content.font = [UIFont fontWithName:@"Trebuchet MS" size:16.0f];
    
    correo = [[UITextField alloc]initWithFrame:CGRectMake(10, 188, 300, 35)];
    correo.placeholder = @"Correo electrónico";
    correo.font = [UIFont fontWithName: @"Trebuchet MS" size: 16.0f];
    correo.keyboardType = UIKeyboardTypeEmailAddress;
    correo.borderStyle = UITextBorderStyleRoundedRect;
    correo.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    
    clave = [[UITextField alloc]initWithFrame:CGRectMake(10, 238, 300, 35)];
    clave.placeholder = @"Contraseña secreta";
    clave.font = [UIFont fontWithName: @"Trebuchet MS" size: 16.0f];
    clave.borderStyle = UITextBorderStyleRoundedRect;
    clave.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    clave.secureTextEntry = YES;
    
    UIButton *iniciarSesion;
    UIImage *redButtonImage = [UIImage imageNamed:@"boton_rojo_pequeno.png"];
    iniciarSesion = [UIButton buttonWithType:UIButtonTypeCustom];
    iniciarSesion.frame = CGRectMake(30.0f, 290.0f, 260.0f, 30.0f);
    [iniciarSesion setBackgroundImage:redButtonImage forState:UIControlStateNormal];
    [iniciarSesion setTitle:@"Inicia sesión" forState:UIControlStateNormal];
    [iniciarSesion addTarget: self action: @selector(login) forControlEvents: UIControlEventTouchUpInside];
    
    UILabel *recuperar = [[UILabel alloc]initWithFrame: CGRectMake(10, 350, 200, 25)];
    recuperar.text = @"¿Olvidaste tu contraseña?";
    recuperar.textAlignment = UITextAlignmentCenter;
    recuperar.textColor = [UIColor whiteColor];
    recuperar.font = [UIFont fontWithName: @"Trebuchet MS" size: 12.0f];

    
    [self.view addSubview: titulo];
    [self.view addSubview: content];
    [self.view addSubview: correo];
    [self.view addSubview: clave];
    [self.view addSubview: iniciarSesion];
    [self.view addSubview: recuperar];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)login{
    if(([correo.text isEqualToString: @""]) || [clave.text isEqualToString: @""]){
        UIAlertView *alerta = [[UIAlertView alloc]initWithTitle:@"Inicio de sesión" message:@"Debes proporcionar tu correo electrónico y contraseña para entrar" delegate: self cancelButtonTitle: @"Aceptar" otherButtonTitles: nil];
        [alerta show];
    }else{
        Conexion *conexion = [[Conexion alloc]init];
    
        NSDictionary *respuesta = (NSDictionary *)[conexion sendPost: @"" data: [NSString stringWithFormat: @"correo=%@&clave=%@", correo.text, clave.text]];
    
        if([[respuesta objectForKey: @"estado"]intValue] == 1){
            NSDictionary *dict = [respuesta objectForKey: @"respuesta"];
            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        
            [user setObject: [dict objectForKey: @"id"] forKey: @"id"];
            [user setObject: [dict objectForKey: @"token"] forKey: @"token"];
            [user synchronize];
        
            Home *controller = [[Home alloc]init];
            [self.navigationController pushViewController: controller animated: YES];
        }else{
            UIAlertView *alerta = [[UIAlertView alloc]initWithTitle:@"Inicio de sesión" message:@"Combinación correo electrónico / Contraseña incorrectos" delegate: self cancelButtonTitle: @"Aceptar" otherButtonTitles: nil];
            [alerta show];
        }
    }
}

@end
