//
//  ViewController.m
//  TestHookEncryption
//
//  Created by Augus on 2023/7/14.
//

#import "ViewController.h"
#import "GuanEncryptionManger.h"



static const NSInteger kAugusButtonTagOffset = 10000;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    
    [self setupButtons];
}


- (void)setupButtons {
    NSArray *buttonTitles = @[@"MD5",@"AES",@"DES",@"RSA",@"SHA512",@"Hmac"];
    CGFloat y = 200.0;
    CGFloat width = 70.0;
    NSInteger lineOfCount = 4;
    CGFloat padding = (self.view.frame.size.width - lineOfCount * width) / 5;
    for (int i = 0; i < buttonTitles.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:buttonTitles[i] forState:UIControlStateNormal];
        [button setBackgroundColor:[self randomColor]];
        CGFloat x = 0;
        if(i < lineOfCount) {
            x = padding * (i + 1) + i * width;
        } else {
            y = 300;
            x = padding * (i - lineOfCount + 1) + (i - lineOfCount) * width;
        }
        
        button.frame = CGRectMake(x, y, width, width);
        button.tag = kAugusButtonTagOffset + i;
        [button addTarget:self action:@selector(encryptionButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        
    }
}


- (void)encryptionButtonAction:(UIButton *)sender {
    
    switch (sender.tag) {
        case 10000:{
            NSLog(@"%@",sender.titleLabel.text);
            [self augusMD5];
            break;
        }
        case 10001:{
            NSLog(@"%@",sender.titleLabel.text);
            [self augusAES];
            break;
        }
        case 10002:{
            NSLog(@"%@",sender.titleLabel.text);
            [self augusDES];
            break;
        }
        case 10003:{
            NSLog(@"%@",sender.titleLabel.text);
            [self augusRSA];
            break;
        }
        case 10004:{
            NSLog(@"%@",sender.titleLabel.text);
            [self augusSHA512];
            break;
        }
        case 10005:{
            NSLog(@"%@",sender.titleLabel.text);
            [self augusHmac];
            break;
        }
        default:
            NSLog(@"unknown methods");
            break;
    }
}


#pragma mark - Private Methos

- (void)augusMD5 {
    
    NSString *test = @"augus123";
    NSString *res = [GuanEncryptionManger md5FromString:test];
    NSLog(@"md5 before %@ and after %@",test,res);
    
}

- (void)augusAES {
    
    //iv向量
    NSString *iv = @"abcdefghijklmnop";
    //转化为data，在java中是一个byte类型
    NSData *ivData = [iv dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString *keyString = @"abcdefghi1234567";
    
    //aes-cbc加密
    NSString *aesCbcE = [GuanEncryptionManger aesEncryptString:@"这个是AES-CBC加密" keyString:keyString iv:ivData];
    NSLog(@"aes-cbc加密: %@", aesCbcE);
    
    //aes-cbc解密
    NSString *aesCbcD = [GuanEncryptionManger aesDecryptString:aesCbcE keyString:keyString iv:ivData];
    NSLog(@"aes-cbc解密: %@", aesCbcD);
}


- (void)augusDES {
    
    
    NSString *keyString = @"abcdefghi1234567";
    
    //aes-ecb加密, iv直接传nil就行
    NSString *desEcbE = [GuanEncryptionManger desEncryptString:@"这个是DES-ECB加密" keyString:keyString iv:nil];
    NSLog(@"des-ecb加密: %@", desEcbE);
    
    //aes-ecb解密, iv直接传nil就行
    NSString *desEcbD = [GuanEncryptionManger desDecryptString:desEcbE keyString:keyString iv:nil];
    NSLog(@"des-ecb解密: %@", desEcbD);
}


- (void)augusRSA {
    
    
    NSString *pubkey = @"-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDDI2bvVLVYrb4B0raZgFP60VXY\ncvRmk9q56QiTmEm9HXlSPq1zyhyPQHGti5FokYJMzNcKm0bwL1q6ioJuD4EFI56D\na+70XdRz1CjQPQE3yXrXXVvOsmq9LsdxTFWsVBTehdCmrapKZVVx6PKl7myh0cfX\nQmyveT/eqyZK1gYjvQIDAQAB\n-----END PUBLIC KEY-----";
    NSString *privkey = @"-----BEGIN PRIVATE KEY-----\nMIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAMMjZu9UtVitvgHS\ntpmAU/rRVdhy9GaT2rnpCJOYSb0deVI+rXPKHI9Aca2LkWiRgkzM1wqbRvAvWrqK\ngm4PgQUjnoNr7vRd1HPUKNA9ATfJetddW86yar0ux3FMVaxUFN6F0KatqkplVXHo\n8qXubKHRx9dCbK95P96rJkrWBiO9AgMBAAECgYBO1UKEdYg9pxMX0XSLVtiWf3Na\n2jX6Ksk2Sfp5BhDkIcAdhcy09nXLOZGzNqsrv30QYcCOPGTQK5FPwx0mMYVBRAdo\nOLYp7NzxW/File//169O3ZFpkZ7MF0I2oQcNGTpMCUpaY6xMmxqN22INgi8SHp3w\nVU+2bRMLDXEc/MOmAQJBAP+Sv6JdkrY+7WGuQN5O5PjsB15lOGcr4vcfz4vAQ/uy\nEGYZh6IO2Eu0lW6sw2x6uRg0c6hMiFEJcO89qlH/B10CQQDDdtGrzXWVG457vA27\nkpduDpM6BQWTX6wYV9zRlcYYMFHwAQkE0BTvIYde2il6DKGyzokgI6zQyhgtRJ1x\nL6fhAkB9NvvW4/uWeLw7CHHVuVersZBmqjb5LWJU62v3L2rfbT1lmIqAVr+YT9CK\n2fAhPPtkpYYo5d4/vd1sCY1iAQ4tAkEAm2yPrJzjMn2G/ry57rzRzKGqUChOFrGs\nlm7HF6CQtAs4HC+2jC0peDyg97th37rLmPLB9txnPl50ewpkZuwOAQJBAM/eJnFw\nF5QAcL4CYDbfBKocx82VX/pFXng50T7FODiWbbL4UnxICE0UBFInNNiWJxNEb6jL\n5xd0pcy9O2DOeso=\n-----END PRIVATE KEY-----";

    NSString *encrypted = [GuanEncryptionManger encryptString:@"hello world Augus!" publicKey:pubkey];
    NSLog(@"rsa encrypted: %@", encrypted);
    NSString *decrypted = [GuanEncryptionManger decryptString:encrypted privateKey:privkey];
    NSLog(@"rsa decrypted: %@", decrypted);
    
}

- (void)augusSHA512 {
    NSString *test = @"augus123";
    NSString *res = [GuanEncryptionManger sha512FromString:test];
    NSLog(@"sha512 before %@ and after %@",test,res);
    
    NSString *res2 = [GuanEncryptionManger shaUtf8:test type:@"SHA-512"];
    NSLog(@"other sha512 %@",res2);
}

- (void)augusHmac {
    NSString *test = @"augus123";
    NSString *key = @"tian";
    NSString *res = [GuanEncryptionManger hmacFromString:test keyString:key];
    NSLog(@"sha512 before %@ and after %@",test,res);
}



- (UIColor *)randomColor {
    
    return [UIColor colorWithRed:(CGFloat)random() / (CGFloat)RAND_MAX
                         green:(CGFloat)random() / (CGFloat)RAND_MAX
                          blue:(CGFloat)random() / (CGFloat)RAND_MAX
                         alpha:1.0f];
}


@end
