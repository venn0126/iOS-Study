//
//  SNCalculateMethod.m
//  SNCalculatorDemo
//
//  Created by Augus on 2023/6/24.
//

#import "SNCalculateMethod.h"

@interface SNCalculateMethod ()

/// 表达式1
@property (nonatomic, assign) long double operand1;

/// 表达式2
@property (nonatomic, assign) long double operand2;

/// 计算结果
@property (nonatomic, assign) long double result;

/// 当前表达式
@property (nonatomic, assign) long double currentNumber;

/// 操作符
@property (nonatomic, copy) NSString *op;


@property (nonatomic, copy) NSString *errorResult;

@end

@implementation SNCalculateMethod

- (instancetype)init {
    self = [super init];
    if(!self) return nil;
    
    _operand1 = 0;
    _operand2 = 0;
    _result = 0;
    
    
    _totalDecimals = 0;
    _isDecimal = NO;
    _decimals = 0;
    _op = @"";
    _errorResult = @"";
    
    return self;
}


- (long double)performOperation:(NSString *)operation outputTextField:(UITextField *)outputTextField{
    
    if(_errorResult.length != 0) {
        outputTextField.text = _errorResult;
        return 0;
    }
    
    if([operation isEqualToString:@"÷"]) {
        if(_operand2 != 0) {
            _result = _operand1 / _operand2;
        } else {
            _errorResult = @"错误";
            outputTextField.text = _errorResult;
        }
    } else  if([operation isEqualToString:@"×"]) {
        _result = _operand1 * _operand2;
    } else  if([operation isEqualToString:@"-"]) {
        _result = _operand1 - _operand2;
    } else  if([operation isEqualToString:@"+"]) {
        _result = _operand1 + _operand2;
    }
    
    return _result;
}


- (void)clear:(UITextField *)outputTextField {
    _operand1 = 0;
    _operand2 = 0;
    _result = 0;
    
    _op = @"";
    _currentNumber = 0;
    _totalDecimals = 0;
    _isDecimal = NO;
    _decimals = 0;
    _errorResult = @"";
    
    [self displayString:@"0" withMethod:@"cover" outputTextField:outputTextField];
}


- (void)displayString:(NSString *)str withMethod:(NSString *)method outputTextField:(UITextField *)outputTextField
{
    NSMutableString *displayString = [NSMutableString stringWithString:outputTextField.text];
    if([method isEqualToString:@"cover"])  //覆盖
        displayString = [NSMutableString stringWithString:str];
    else if([method isEqualToString:@"add"]) // 追加
        [displayString appendString:str];
    else {
        displayString = [NSMutableString stringWithString:@"错误"];
        _errorResult = @"错误";
    }
    outputTextField.text = displayString;
}


- (void)processDigit:(int)digit outputTextField:(UITextField *)outputTextField {
    // 如果期间发生错误，然后没有按操作符，按数字清除错误
    if(_op.length == 0) {
        _errorResult = @"";
    }
    if(_currentNumber == 0 && !_isDecimal)
        [self displayString:[NSString stringWithFormat:@"%i",digit] withMethod:@"cover" outputTextField:outputTextField];
    else {
        [self displayString:[NSString stringWithFormat:@"%i",digit] withMethod:@"add" outputTextField:outputTextField];
    }
    if(!_isDecimal){
        if(_currentNumber >= 0) {
            _currentNumber = _currentNumber * 10 + digit;
        }else{
            _currentNumber = _currentNumber * 10 - digit;
        }
    }else { // 处理小数情况
        _decimals++;
        if(_currentNumber >= 0) {
            _currentNumber = _currentNumber + digit * pow(10, (-1) * _decimals);
        }else {
            _currentNumber = _currentNumber - digit * pow(10, (-1) * _decimals);
        }
    }
    NSLog(@"processDigit _currentNumber is %.18Lf",_currentNumber);
}


- (void)processOp:(NSString *)op outputTextField:(UITextField *)outputTextField
{

    if([op isEqualToString:@"+/-"]) {
        if(_currentNumber >= 0) {
            NSMutableString *negative = [NSMutableString stringWithString:@"-"];
            [negative appendString:outputTextField.text];
            [self displayString:negative withMethod:@"cover" outputTextField:outputTextField];
        } else {
            NSMutableString *positive = [NSMutableString stringWithString:outputTextField.text];
            [positive deleteCharactersInRange:NSMakeRange(0,1)];
            [self displayString:positive withMethod:@"cover" outputTextField:outputTextField];
        }
        _currentNumber = -_currentNumber;
    } else if([op isEqualToString:@"%"]){
        _currentNumber = _currentNumber * 0.01;
        [self displayString:[NSString stringWithFormat:@"%Lg",_currentNumber] withMethod:@"cover" outputTextField:outputTextField];
        _totalDecimals = (int)outputTextField.text.length - 1;
        _decimals = (int)outputTextField.text.length - (int)[outputTextField.text rangeOfString:@"."].location - 1;
        if([outputTextField.text rangeOfString:@"."].length > 0) {
            _isDecimal = YES;
        }
    } else if([op isEqualToString:@"="]){
        _totalDecimals = 0;
        _operand2 = _currentNumber;
        _currentNumber = [self performOperation:_op outputTextField:outputTextField];
        if(![_errorResult isEqualToString:@"错误"]) {
            [self displayString:[NSString stringWithFormat:@"%Lg",_currentNumber] withMethod:@"cover" outputTextField:outputTextField];
            _operand1 = _result;
        }
        _op = @"";
    } else {// + - x ÷
        _totalDecimals = 0;
        if(_op.length == 0) {
            _op = op;
            _operand1 = _currentNumber;
            _currentNumber = 0;
        } else {
            _operand2 = _currentNumber;
            _currentNumber = [self performOperation:op outputTextField:outputTextField];
            [self displayString:[NSString stringWithFormat:@"%Lg",_currentNumber] withMethod:@"cover" outputTextField:outputTextField];
            _operand1 = _result;
            _currentNumber = 0;
            _op = op;
        }
        _isDecimal = NO;
        
    }

    NSLog(@"processOp currentNumber %.18Lf",_currentNumber);
}

@end
