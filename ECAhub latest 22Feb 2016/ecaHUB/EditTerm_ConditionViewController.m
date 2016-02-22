//
//  EditTerm_ConditionViewController.m
//  ecaHUB
//
//  Created by promatics on 3/31/15.
//  Copyright (c) 2015 promatics. All rights reserved.
//

#import "EditTerm_ConditionViewController.h"
#import "Validation.h"
#import "Constant.h"
#import "WebServiceConnection.h"
#import "Indicator.h"
#import "EditFeesAndChargesViewController.h"

@interface EditTerm_ConditionViewController ()  {
    
    UIPickerView *pickerView;
    
    UIToolbar *toolBar;
    
    UIBarButtonItem *cancelButton;
    
    UIBarButtonItem *doneButton;
    
    NSArray *pickerArray;
    
    NSString *list_index;
    
    NSString *deposit_ids;
    
    NSString *servere_ids;
    
    NSString *paymentDead_id;
    
    NSString *changes_enrol_id;
    
    NSString *cancellation_id;
    
    NSString *refund_id;
    
    NSString *make_up_id;
    
    NSString *books_material_id;
    
    NSString *security_deposite_id;
    
    NSString *othercharge_deposit_id,*currencyAcpt_id;
    
    Validation *validationObj;
    
    NSMutableArray *severe_array;
    
    id activeField;
    
    Indicator *indicator;
    
    WebServiceConnection *getConn;
    
    CGFloat sizeViewOrigionY;
    
    NSDictionary *termDict;
    
    NSString *pickerValue, *pickData;
    
    NSString *data_id, *pickId;
}

@end

@implementation EditTerm_ConditionViewController

@synthesize scrollView, paymentDeadLineBtn, depositeBtn, changeEnrollmentBtn, cancellationBtn, refundBtn, make_upLessionBtn, servere_weatherBtn, books_materialBtn, securityDepositBtn, books_materialPrice, securityPriceTxtField, saveBtn, cancelBtn,othercharge_btn,othercharge_textfield,cancellation_textfield,size_view,currencyAccpt_btn,termDataDict,enterFC_btn;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"Edit Terms & Conditions";
    
    getConn = [WebServiceConnection connectionManager];
    
    indicator = [[Indicator alloc]initWithFrame:self.view.frame];
    
    books_materialBtn.userInteractionEnabled = NO;
    othercharge_btn.userInteractionEnabled = NO;
    securityDepositBtn.userInteractionEnabled = NO;
    
    //  self.navigationController.navigationBar.topItem.title = @"";
    
    sizeViewOrigionY = size_view.frame.origin.y;
    
    [self prepareInterface];
    
    validationObj = [Validation validationManager];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier]isEqualToString:@"EditfeesSegue"]) {
        
        EditFeesAndChargesViewController *feesVC = [segue destinationViewController];
        
        feesVC.termDataDict = termDict;
        feesVC.courseDataDict =termDataDict;
    }
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

-(void) prepareInterface {
    
    CGRect frame = size_view.frame;
    
    //frame.origin.y = cancellation_textfield.frame.size.height + cancellation_textfield.frame.origin.y + 20;
    
    // frame.origin.x = cancellation_textfield.frame.origin.x;
    
    size_view.frame = frame;
    
    UIStoryboard *storyboard;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        storyboard = [UIStoryboard storyboardWithName:@"Main_Ipad" bundle:nil];
        
        scrollView.frame = self.view.frame;
        
        scrollView.contentSize = CGSizeMake(self.view.frame.size.width,self.enterFC_btn.frame.origin.y + self.enterFC_btn.frame.size.height+50);
        
        CGRect frame = books_materialPrice.frame;
        
        frame.size.height = 45.0f;
        
        books_materialPrice.frame = frame;
        
        frame = securityPriceTxtField.frame;
        
        frame.size.height = 45.0f;
        
        securityPriceTxtField.frame = frame;
        
        frame = othercharge_textfield.frame;
        
        frame.size.height = 45.0f;
        
        othercharge_textfield.frame = frame;
        
        frame = cancellation_textfield.frame;
        
        frame.size.height = 45.0f;
        
        cancellation_textfield.frame = frame;
        
        enterFC_btn.layer.cornerRadius = 7.0f;
        
    } else {
        
        storyboard = [UIStoryboard storyboardWithName:@"Main_Iphone" bundle:nil];
        
        scrollView.frame = self.view.frame;
        
        scrollView.contentSize = CGSizeMake(self.view.frame.size.width,self.enterFC_btn.frame.origin.y + self.enterFC_btn.frame.size.height+50);
        
        enterFC_btn.layer.cornerRadius = 5.0f;
        
    }
    
    //[self registerForKeyboardNotifications];
    
//    UITapGestureRecognizer *tapScroll = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyboard)];
//    
//    tapScroll.cancelsTouchesInView = NO;
//    
//    
//    [scrollView addGestureRecognizer:tapScroll];
    
    cancellation_textfield.hidden = YES;
    
    cancellationBtn.layer.borderWidth = 1.0f;
    
    cancellationBtn.layer.borderColor = [UIColor blackColor].CGColor;
    
    cancellationBtn.layer.cornerRadius = 5.0f;
    
    othercharge_btn.layer.borderWidth = 1.0f;
    
    othercharge_btn.layer.borderColor = [UIColor blackColor].CGColor;
    
    othercharge_btn.layer.cornerRadius = 5.0f;
    
    paymentDeadLineBtn.layer.borderWidth = 1.0f;
    
    paymentDeadLineBtn.layer.borderColor = [UIColor blackColor].CGColor;
    
    paymentDeadLineBtn.layer.cornerRadius = 5.0f;
    
    currencyAccpt_btn.layer.borderWidth = 1.0f;
    
    currencyAccpt_btn.layer.borderColor = [UIColor blackColor].CGColor;
    
    currencyAccpt_btn.layer.cornerRadius = 5.0f;
    
    
    depositeBtn.layer.borderWidth = 1.0f;
    
    depositeBtn.layer.borderColor = [UIColor blackColor].CGColor;
    
    depositeBtn.layer.cornerRadius = 5.0f;
    
    changeEnrollmentBtn.layer.borderWidth = 1.0f;
    
    changeEnrollmentBtn.layer.borderColor = [UIColor blackColor].CGColor;
    
    changeEnrollmentBtn.layer.cornerRadius = 5.0f;
    
    cancellationBtn.layer.borderWidth = 1.0f;
    
    cancellationBtn.layer.borderColor = [UIColor blackColor].CGColor;
    
    cancellationBtn.layer.cornerRadius = 5.0f;
    
    refundBtn.layer.borderWidth = 1.0f;
    
    refundBtn.layer.borderColor = [UIColor blackColor].CGColor;
    
    refundBtn.layer.cornerRadius = 5.0f;
    
    make_upLessionBtn.layer.borderWidth = 1.0f;
    
    make_upLessionBtn.layer.borderColor = [UIColor blackColor].CGColor;
    
    make_upLessionBtn.layer.cornerRadius = 5.0f;
    
    servere_weatherBtn.layer.borderWidth = 1.0f;
    
    servere_weatherBtn.layer.borderColor = [UIColor blackColor].CGColor;
    
    servere_weatherBtn.layer.cornerRadius = 5.0f;
    
    books_materialBtn.layer.borderWidth = 1.0f;
    
    books_materialBtn.layer.borderColor = [UIColor blackColor].CGColor;
    
    books_materialBtn.layer.cornerRadius = 5.0f;
    
    othercharge_btn.layer.borderWidth = 1.0f;
    
    othercharge_btn.layer.borderColor = [UIColor blackColor].CGColor;
    
    othercharge_btn.layer.cornerRadius = 5.0f;
    
    securityDepositBtn.layer.borderWidth = 1.0f;
    
    securityDepositBtn.layer.borderColor = [UIColor blackColor].CGColor;
    
    securityDepositBtn.layer.cornerRadius = 5.0f;
    
    books_materialPrice.layer.borderWidth = 1.0f;
    
    books_materialPrice.layer.borderColor = [UIColor blackColor].CGColor;
    
    books_materialPrice.layer.cornerRadius = 5.0f;
    
    securityPriceTxtField.layer.borderWidth = 1.0f;
    
    securityPriceTxtField.layer.borderColor = [UIColor blackColor].CGColor;
    
    securityPriceTxtField.layer.cornerRadius = 5.0f;
    
    othercharge_textfield.layer.borderWidth = 1.0f;
    
    othercharge_textfield.layer.borderColor = [UIColor blackColor].CGColor;
    
    othercharge_textfield.layer.cornerRadius = 5.0f;
    
    cancellation_textfield.layer.borderWidth = 1.0f;
    
    cancellation_textfield.layer.borderColor = [UIColor blackColor].CGColor;
    
    cancellation_textfield.layer.cornerRadius = 5.0f;
    
    saveBtn.layer.cornerRadius = 5.0f;
    
    cancelBtn.layer.cornerRadius = 5.0f;
    
    pickerView = [[UIPickerView alloc] init];
    
    pickerView.delegate = self;
    
    pickerView.dataSource = self;
    
//    UITapGestureRecognizer *tapgest = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hidePickerView)];
//    
//    tapgest.cancelsTouchesInView = NO;
//    
//    [self.view addGestureRecognizer:tapgest];
    
    NSLog(@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"CourseDetail"]);
    
   
    
    [paymentDeadLineBtn setTitle:[@"  " stringByAppendingString:[[[[[NSUserDefaults standardUserDefaults] valueForKey:@"CourseDetail"] valueForKey:@"course_info"]
valueForKey:@"TermsPayment"] valueForKey:@"title"]] forState:UIControlStateNormal];
    
    [depositeBtn setTitle:[@"  " stringByAppendingString:[[[NSUserDefaults standardUserDefaults] valueForKey:@"CourseDetail"] valueForKey:@"deposit_name"]] forState:UIControlStateNormal];
    
    [changeEnrollmentBtn setTitle: [@"  " stringByAppendingString:[[[[[NSUserDefaults standardUserDefaults] valueForKey:@"CourseDetail"] valueForKey:@"course_info"]valueForKey:@"TermsChange"] valueForKey:@"title"]] forState:UIControlStateNormal];
    
    [cancellationBtn setTitle: [@"  " stringByAppendingString:[[[[[NSUserDefaults standardUserDefaults] valueForKey:@"CourseDetail"] valueForKey:@"course_info"]valueForKey:@"TermsCancellation"] valueForKey:@"title"]] forState:UIControlStateNormal];
    
    [refundBtn setTitle: [@"  " stringByAppendingString:[[[[[NSUserDefaults standardUserDefaults] valueForKey:@"CourseDetail"] valueForKey:@"course_info"]valueForKey:@"TermsRefund"] valueForKey:@"title"]] forState:UIControlStateNormal];
    
    [make_upLessionBtn setTitle: [@"  " stringByAppendingString:[[[[[NSUserDefaults standardUserDefaults] valueForKey:@"CourseDetail"] valueForKey:@"course_info"]valueForKey:@"TermsMakeUpLesson"] valueForKey:@"title"]] forState:UIControlStateNormal];
    
    //  NSLog(@"%@",[[[[[NSUserDefaults standardUserDefaults] valueForKey:@"CourseDetail"] valueForKey:@"severe_names"] valueForKey:@"TermsSevereWeather"] valueForKey:@"title"]);
    
    NSArray *severeArray = [[[[NSUserDefaults standardUserDefaults] valueForKey:@"CourseDetail"] valueForKey:@"severe_names"] objectAtIndex:0];
    
    severe_array = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < severeArray.count; i++) {
        
        [severe_array addObject:[[[severeArray objectAtIndex:i] valueForKey:@"TermsSevereWeather"] valueForKey:@"title"]];
    }
    
    NSLog(@"%@",severe_array);
    
    NSString *serverStr = [severe_array componentsJoinedByString:@", "];
    
    serverStr = [@"  " stringByAppendingString:serverStr];
    
    [servere_weatherBtn setTitle: serverStr forState:UIControlStateNormal];
    
    [currencyAccpt_btn setTitle: [@"  " stringByAppendingString:[[[[[NSUserDefaults standardUserDefaults] valueForKey:@"CourseDetail"] valueForKey:@"course_info"]valueForKey:@"b_m_currency"] valueForKey:@"name"]] forState:UIControlStateNormal];
    
    [books_materialBtn setTitle: [@"  " stringByAppendingString:[[[[[NSUserDefaults standardUserDefaults] valueForKey:@"CourseDetail"] valueForKey:@"course_info"]valueForKey:@"b_m_currency"] valueForKey:@"name"]] forState:UIControlStateNormal];
    
    [othercharge_btn setTitle: [@"  " stringByAppendingString:[[[[[NSUserDefaults standardUserDefaults] valueForKey:@"CourseDetail"] valueForKey:@"course_info"]valueForKey:@"other_currency"] valueForKey:@"name"]] forState:UIControlStateNormal];
    
    
    [securityDepositBtn setTitle: [@"  " stringByAppendingString:[[[[[NSUserDefaults standardUserDefaults] valueForKey:@"CourseDetail"] valueForKey:@"course_info"]valueForKey:@"security_currency"] valueForKey:@"name"]] forState:UIControlStateNormal];
    
    books_materialPrice.text = [[[[[NSUserDefaults standardUserDefaults] valueForKey:@"CourseDetail"] valueForKey:@"course_info"] valueForKey:@"CourseListing"] valueForKey:@"quantity_books_materials"];
    
    securityPriceTxtField.text = [[[[[NSUserDefaults standardUserDefaults] valueForKey:@"CourseDetail"] valueForKey:@"course_info"] valueForKey:@"CourseListing"] valueForKey:@"quantity_security"];
    
    othercharge_textfield.text = [[[[[NSUserDefaults standardUserDefaults] valueForKey:@"CourseDetail"] valueForKey:@"course_info"] valueForKey:@"CourseListing"] valueForKey:@"other_charges"];
    
    [self setData];
    
}

-(void) setData {
    
    paymentDead_id = [[[[[NSUserDefaults standardUserDefaults] valueForKey:@"CourseDetail"] valueForKey:@"course_info"] valueForKey:@"CourseListing"] valueForKey:@"payment_deadline"];
    
    deposit_ids = [[[[[NSUserDefaults standardUserDefaults] valueForKey:@"CourseDetail"] valueForKey:@"course_info"] valueForKey:@"CourseListing"] valueForKey:@"deposit"];
    
    changes_enrol_id = [[[[[NSUserDefaults standardUserDefaults] valueForKey:@"CourseDetail"] valueForKey:@"course_info"] valueForKey:@"CourseListing"] valueForKey:@"change_enrollment"];
    
    cancellation_id = [[[[[NSUserDefaults standardUserDefaults] valueForKey:@"CourseDetail"] valueForKey:@"course_info"] valueForKey:@"CourseListing"] valueForKey:@"cancellation"];
    
    refund_id = [[[[[NSUserDefaults standardUserDefaults] valueForKey:@"CourseDetail"] valueForKey:@"course_info"] valueForKey:@"CourseListing"] valueForKey:@"refund"];
    
    make_up_id = [[[[[NSUserDefaults standardUserDefaults] valueForKey:@"CourseDetail"] valueForKey:@"course_info"] valueForKey:@"CourseListing"] valueForKey:@"make_up_lessons"];
    
    servere_ids = [[[[[NSUserDefaults standardUserDefaults] valueForKey:@"CourseDetail"] valueForKey:@"course_info"] valueForKey:@"CourseListing"] valueForKey:@"severe_weather"];
    
    currencyAcpt_id = [[[[[NSUserDefaults standardUserDefaults] valueForKey:@"CourseDetail"] valueForKey:@"course_info"] valueForKey:@"CourseListing"] valueForKey:@"currency"];
    
    books_material_id = [[[[[NSUserDefaults standardUserDefaults] valueForKey:@"CourseDetail"] valueForKey:@"course_info"] valueForKey:@"CourseListing"] valueForKey:@"currency"];
    
    security_deposite_id = [[[[[NSUserDefaults standardUserDefaults] valueForKey:@"CourseDetail"] valueForKey:@"course_info"] valueForKey:@"CourseListing"] valueForKey:@"currency_security"];
    
    NSString *quantity_books_materials = [[[[[NSUserDefaults standardUserDefaults] valueForKey:@"CourseDetail"] valueForKey:@"course_info"] valueForKey:@"CourseListing"] valueForKey:@"quantity_books_materials"];
    
    othercharge_deposit_id = [[[[[NSUserDefaults standardUserDefaults] valueForKey:@"CourseDetail"] valueForKey:@"course_info"] valueForKey:@"CourseListing"] valueForKey:@"other_charges_currency"];
    
    
    //    NSString *currency_security = [[[[[NSUserDefaults standardUserDefaults] valueForKey:@"CourseDetail"] valueForKey:@"course_info"] valueForKey:@"CourseListing"] valueForKey:@"currency_security"];
    
    NSString *quantity_security = [[[[[NSUserDefaults standardUserDefaults] valueForKey:@"CourseDetail"] valueForKey:@"course_info"] valueForKey:@"CourseListing"] valueForKey:@"quantity_security"];
    
    NSDictionary *term_conData = @{@"payment_deadline":paymentDead_id, @"deposit":deposit_ids, @"change_enrollment":changes_enrol_id,@"cancellation":cancellation_id, @"refund":refund_id, @"make_up_lessons":make_up_id, @"severe_weather":servere_ids, @"currency":books_material_id, @"quantity_books_materials":quantity_books_materials, @"currency_security":security_deposite_id,@"quantity_security":quantity_security};
    
    NSLog(@"%@", term_conData);
    
    [[NSUserDefaults standardUserDefaults] setValue:term_conData forKey:@"Term_CondData"];
    
}

#pragma mark - Hide Picker View

-(void)hidePickerView {
    
    [toolBar removeFromSuperview];
    [pickerView removeFromSuperview];
}

-(void)cancelKeyboard:(UIBarButtonItem *)sender {
    
    [toolBar removeFromSuperview];
    [pickerView removeFromSuperview];
}

-(void)doneKeyboard:(UIBarButtonItem *)sender {
    
    [toolBar removeFromSuperview];
    [pickerView removeFromSuperview];
    
    pickerValue = pickData;
    
    data_id = pickId;
    
    switch ([list_index intValue]) {
            
        case 0:{
            
            [paymentDeadLineBtn setTitle:pickerValue forState:UIControlStateNormal];
            
            paymentDead_id = data_id;
            
            if([pickerValue isEqualToString:@"  Select"]) {
                
                [paymentDeadLineBtn setTitleColor:UIColorFromRGB(placeholder_text_color_hexcode) forState:UIControlStateNormal];
                
            } else {
                
                [paymentDeadLineBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            }
            
            
            break;
            
        }  case 1:{
            
            [depositeBtn setTitle:pickerValue forState:UIControlStateNormal];
            
            // deposit_ids = data_id;
            break;
            
        }  case 2:{
            
            [changeEnrollmentBtn setTitle:pickerValue forState:UIControlStateNormal];
            
            changes_enrol_id = data_id;
            
            if([pickerValue isEqualToString:@"  Select"]) {
                
                [changeEnrollmentBtn setTitleColor:UIColorFromRGB(placeholder_text_color_hexcode) forState:UIControlStateNormal];
                
            } else {
                
                [changeEnrollmentBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            }
            
            
            break;
            
        }  case 3:{
            
            [cancellationBtn setTitle:pickerValue forState:UIControlStateNormal];
            
            cancellation_id = data_id;
            
            if([pickerValue isEqualToString:@"  Select"]) {
                
                [cancellationBtn setTitleColor:UIColorFromRGB(placeholder_text_color_hexcode) forState:UIControlStateNormal];
                
            } else {
                
                [cancellationBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            }
            
            if ([cancellation_id isEqualToString:@"3"]) {
                
                cancellation_textfield.hidden = NO;
                
                [self sizeScrollView];
                
            }
            else{
                
                cancellation_textfield.hidden = YES;
                [self sizeScrollView];
                
            }
            
            
            break;
            
        }  case 4:{
            
            [refundBtn setTitle:pickerValue forState:UIControlStateNormal];
            
            refund_id = data_id;
            
            if([pickerValue isEqualToString:@"  Select"]) {
                
                [refundBtn setTitleColor:UIColorFromRGB(placeholder_text_color_hexcode) forState:UIControlStateNormal];
                
            } else {
                
                [refundBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            }
            
            break;
            
        }  case 5:{
            
            [make_upLessionBtn setTitle:pickerValue forState:UIControlStateNormal];
            
            make_up_id = data_id;
            
            if([pickerValue isEqualToString:@"  Select"]) {
                
                [make_upLessionBtn setTitleColor:UIColorFromRGB(placeholder_text_color_hexcode) forState:UIControlStateNormal];
                
            } else {
                
                [make_upLessionBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            }
            
            break;
            
        }  case 6:{
            
            [servere_weatherBtn setTitle:pickerValue forState:UIControlStateNormal];
            
            //servere_ids = data_id;
            break;
            
        }  case 7:{
            
            [books_materialBtn setTitle:pickerValue forState:UIControlStateNormal];
            
            books_material_id = data_id;
            
            [securityDepositBtn setTitle:pickerValue forState:UIControlStateNormal];
            
            security_deposite_id = data_id;
            
            [othercharge_btn setTitle:pickerValue forState:UIControlStateNormal];
            
            othercharge_deposit_id = data_id;
            break;
            
        }  case 8:{
            
            [securityDepositBtn setTitle:pickerValue forState:UIControlStateNormal];
            
            security_deposite_id = data_id;
            break;
        } case 9:{
            
            [othercharge_btn setTitle:pickerValue forState:UIControlStateNormal];
            
            othercharge_deposit_id = data_id;
            break;
        }
//        }case 10:{
//            
//            
//            data_id = [[[pickerArray objectAtIndex:row] valueForKey:@"Currency"]  valueForKey:@"id"];
//            
//            pickerValue = [[[pickerArray objectAtIndex:row] valueForKey:@"Currency"] valueForKey:@"name"];
//            
//            pickerValue = [@"  " stringByAppendingString:pickerValue];
//            
//            currencyAcpt_id = [[[pickerArray objectAtIndex:row] valueForKey:@"Currency"]  valueForKey:@"id"];
//            
//            [currencyAccpt_btn setTitle:pickerValue forState:UIControlStateNormal];
//            
//            currencyAcpt_id = data_id;
//            
//            [books_materialBtn setTitle:pickerValue forState:UIControlStateNormal];
//            
//            books_material_id = data_id;
//            
//            [securityDepositBtn setTitle:pickerValue forState:UIControlStateNormal];
//            
//            security_deposite_id = data_id;
//            
//            [othercharge_btn setTitle:pickerValue forState:UIControlStateNormal];
//            
//            othercharge_deposit_id = data_id;
//            
//            break;
//            
//        }
            
        default:
            break;
    }
    
    
}

#pragma mark - PickerView Delegates & Datasource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return pickerArray.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    if ([list_index isEqualToString:@"10"]) {
        
        return [[[pickerArray objectAtIndex:row] valueForKey:@"Currency"]  valueForKey:@"name"];
        
    } else {
        
        return [[pickerArray objectAtIndex:row] valueForKey:@"name"];
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    
    UILabel *pickerlbl = (UILabel*)view;
    
    if (!pickerlbl){
        pickerlbl = [[UILabel alloc] init];
    }
    
    pickerlbl.frame = CGRectMake(10, 0, self.view.frame.size.width - 20, 30);
    
    [pickerlbl setLineBreakMode:NSLineBreakByClipping];
    
    [pickerlbl  setNumberOfLines:0];
    
    [pickerlbl  setBaselineAdjustment:UIBaselineAdjustmentAlignBaselines];
    
    [pickerlbl setFont:[UIFont systemFontOfSize:17]];
    
    pickerlbl.textAlignment = NSTextAlignmentCenter;
    
    NSString *text;
    
    if ([list_index isEqualToString:@"10"]) {
        
        text = [[[pickerArray objectAtIndex:row] valueForKey:@"Currency"]  valueForKey:@"name"];
        
    } else {
        
        text = [[pickerArray objectAtIndex:row] valueForKey:@"name"];
    }
    
    UIFont *font = [UIFont systemFontOfSize:17];
    
    CGSize constraint = CGSizeMake(self.view.frame.size.width - (1.0 * 2), FLT_MAX);
    
    CGRect frame = [text boundingRectWithSize:constraint options:NSStringDrawingUsesLineFragmentOrigin
                                   attributes:@{NSFontAttributeName:font}
                                      context:nil];
    
    CGSize size = CGSizeMake(frame.size.width, frame.size.height + 1);
    
    CGRect lable_frame = pickerlbl.frame;
    
    lable_frame.size.height = size.height + 10;
    
    [pickerlbl  setFrame:lable_frame];
    
    [pickerlbl sizeToFit];
    
    //Set text value
    pickerlbl.text = text;
    
    return pickerlbl;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    
    UILabel *pickerlbl = [[UILabel alloc] init];
    
    pickerlbl.frame = CGRectMake(10, 0, self.view.frame.size.width - 20, 30);
    
    [pickerlbl setLineBreakMode:NSLineBreakByClipping];
    
    [pickerlbl  setNumberOfLines:0];
    
    [pickerlbl  setBaselineAdjustment:UIBaselineAdjustmentAlignBaselines];
    
    [pickerlbl setFont:[UIFont systemFontOfSize:17]];
    
    NSString *text;
    
    if ([list_index isEqualToString:@"10"]) {
        
        text = [[[pickerArray objectAtIndex:2] valueForKey:@"Currency"]  valueForKey:@"name"];
        
    } else {
        
        text = [[pickerArray objectAtIndex:component] valueForKey:@"name"];
    }
    
    pickerlbl.text = text;
    
    [pickerlbl sizeToFit];
    
    CGFloat height = pickerlbl.frame.size.height+10;
    
//    UIFont *font = [UIFont systemFontOfSize:17];
//    
//    CGSize constraint = CGSizeMake(self.view.frame.size.width - (1.0 * 2), FLT_MAX);
//    
//    CGRect frame = [text boundingRectWithSize:constraint options:NSStringDrawingUsesLineFragmentOrigin
//                                   attributes:@{NSFontAttributeName:font}
//                                      context:nil];
//    
//    CGSize size = CGSizeMake(frame.size.width, frame.size.height + 1);
//    
//    CGRect lable_frame = pickerlbl.frame;
//    
//    lable_frame.size.height = size.height + 10;
//    
//    [pickerlbl sizeToFit];
//    
//    CGFloat height = size.height + 10;
//    
//    if (height < 70.0) {
//        
//        height = 70;
//    }
    return height;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    pickData = [[pickerArray objectAtIndex:row] valueForKey:@"name"];
    
    pickId =[[pickerArray objectAtIndex:row] valueForKey:@"id"];
    
    pickData = [@"  " stringByAppendingString:pickData];
    
    
//    if ([list_index isEqualToString:@"10"]) {
//        
//        pickerValue = [[[pickerArray objectAtIndex:row] valueForKey:@"Currency"] valueForKey:@"name"];
//        
//        data_id = [[[pickerArray objectAtIndex:row] valueForKey:@"Currency"]valueForKey:@"id"];
//        
//    }
//    else
//        
//    {
//        
//        pickerValue =
//        
//        data_id =
//        
//    }
//    
//    pickerValue = [@"  " stringByAppendingString:pickerValue];
    
    
}
-(void)sizeScrollView{
    if ([cancellation_id isEqualToString:@"3"]){
        
        CGRect frame = size_view.frame;
        
        frame.origin.y = cancellation_textfield.frame.size.height + cancellation_textfield.frame.origin.y + 20;
        
        // frame.origin.x = cancellation_textfield.frame.origin.x;
        
        if(UIUserInterfaceIdiomPad == UI_USER_INTERFACE_IDIOM()){
            
            scrollView.contentSize = CGSizeMake(self.view.frame.size.width,self.enterFC_btn.frame.origin.y + self.enterFC_btn.frame.size.height+50);
            
        } else {
            
            scrollView.contentSize = CGSizeMake(self.view.frame.size.width,self.enterFC_btn.frame.origin.y + self.enterFC_btn.frame.size.height+50);
        }
        
        size_view.frame = frame;
        
    } else {
        
        if(UIUserInterfaceIdiomPad == UI_USER_INTERFACE_IDIOM()){
            
            scrollView.contentSize = CGSizeMake(self.view.frame.size.width,self.enterFC_btn.frame.origin.y + self.enterFC_btn.frame.size.height+50);
            
        } else {
            
            scrollView.contentSize = CGSizeMake(self.view.frame.size.width,self.enterFC_btn.frame.origin.y + self.enterFC_btn.frame.size.height+50);
        }
        CGRect frame = size_view.frame;
        
        frame.origin.y = sizeViewOrigionY;
        
        // frame.origin.x = cancellation_textfield.frame.origin.x;
        
        size_view.frame = frame;
        
    }
}

-(void) showPicker {
    
    pickData = @"  Select";
    
    pickId =@"";
    
    [toolBar removeFromSuperview];
    
    [pickerView removeFromSuperview];
    
    cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelKeyboard:)];
    
    [cancelButton setWidth:100];
    
    doneButton =[[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(doneKeyboard:)];
    
    [doneButton setWidth:100];
    
    pickerView = [[UIPickerView alloc] init];
    
    pickerView.delegate = self;
    
    pickerView.dataSource = self;
    
    CGRect frame = pickerView.frame;
    
    frame.origin.y = self.view.frame.size.height - frame.size.height - 40;
    
    frame.size.width = self.view.frame.size.width;
    
    pickerView.frame = frame;
    
    pickerView.backgroundColor = [UIColor lightGrayColor];
    
    toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,(self.view.frame.size.height- pickerView.frame.size.height) - 84, self.view.frame.size.width, 44)];
    
    toolBar.backgroundColor = [UIColor darkGrayColor];
    
    UIBarButtonItem *flexibleItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    toolBar.items = @[cancelButton,flexibleItem, doneButton];
    
    [self.view addSubview:toolBar];
    
    [self.view addSubview:pickerView];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */



- (IBAction)tapCurrncyAccpt_btn:(id)sender {
    NSDictionary *paramURL =@{};
    
    [self.view addSubview:indicator];
    
    [getConn startConnectionWithString:@"get_currency" HttpMethodType:Post_Type HttpBodyType:paramURL Output:^(NSDictionary *receivedData) {
        
        [indicator removeFromSuperview];
        
        if([getConn responseCode]==1)
        {
            
            NSLog(@"%@",receivedData);
            
            pickerArray =[receivedData valueForKey:@"info"];
            
            list_index = @"10";
            
            [self showPicker];
        }
    }];
    
}

- (IBAction)tappaymentDeadLine:(id)sender {
    
    pickerArray = @[@{@"id":@"0", @"name":@"Select"},@{@"id":@"0", @"name":@"Once the educator accepts the enrollment request, payment is required 48 hours prior to course commencement."},@{@"id":@"1", @"name":@"Once the educator accepts the enrollment request, payment is required within 7 days or within 24 hours if the course is less than 7 days away."},@{@"id":@"2", @"name":@"Once the educator accepts the enrollment request, payment is required immediately."}];
    
    list_index = @"0";
    
    [self showPicker];
}

- (IBAction)tapDepositeBtn:(id)sender {
    
    list_index = @"1";
    
    pickerArray = @[@{@"id":@"0", @"name":@"Deposits are not required."},@{@"id":@"1", @"name":@"A deposit is required to secure enrolment."},@{@"id":@"2", @"name":@"Deposit amounts are refunded when the student commences lessons."}];
    
    [self showListData:[pickerArray valueForKey:@"name"] allowMultipleSelection:YES selectedData:[depositeBtn.titleLabel.text componentsSeparatedByString:@", "] title:@"Deposit"];
}

- (IBAction)tapChangeEnrollment:(id)sender {
    
    list_index = @"2";
    
    pickerArray = @[@{@"id":@"0", @"name":@"Select"}, @{@"id":@"0", @"name":@"Once enrolment is confirmed, changes to enrolment can be made under special circumstances by messaging the educator."},@{@"id":@"1", @"name":@"Once enrolment is confirmed, changes to enrolment cannot be made."}];
    
    [self showPicker];
}

- (IBAction)tapCancellationBtn:(id)sender {
    
    list_index = @"3";
    
    pickerArray = @[@{@"id":@"0", @"name":@"Select"}, @{@"id":@"0", @"name":@"Once enrolment is confirmed, cancellations are permitted under special circumstances by messaging the educator."},@{@"id":@"1", @"name":@"Once enrolment is confirmed, cancellations can only be made 7 days before the first lesson, and only by messaging the educator."},@{@"id":@"2", @"name":@"Once enrolment is confirmed, cancellations cannot be made."}];
    
    [self showPicker];
}

- (IBAction)tapRefundBtn:(id)sender {
    
    list_index = @"4";
    
    pickerArray = @[@{@"id":@"0", @"name":@"Select"}, @{@"id":@"0", @"name":@"Once enrolment is confirmed, refunds are available by request from the educator."},@{@"id":@"1", @"name":@"Once enrolment is confirmed, refunds are only available under special circumstances by request from the educator."},@{@"id":@"2", @"name":@"Once enrolment is confirmed, refunds are not available."}];
    
    [self showPicker];
}

- (IBAction)tapmake_upLession:(id)sender {
    
    list_index = @"5";
    
    pickerArray = @[@{@"id":@"0", @"name":@"Select"}, @{@"id":@"0", @"name":@"Make-up lessons are available upon request."},@{@"id":@"1", @"name":@"Make-up lessons can only be arrange due to sickness or travel."},@{@"id":@"2", @"name":@"Make-up lessons are not available."}];
    
    [self showPicker];
}

- (IBAction)tapservere_weather:(id)sender {
    
    list_index = @"6";
    
    //[[NSUserDefaults standardUserDefaults]setValue:@"1" forKey:@""];
    
    pickerArray = @[@{@"id":@"0", @"name":@"Lessons are not held during severe weather warnings such as Typhoon 8 and Black Rain Storm Warnings."},@{@"id":@"1", @"name":@"Make-up lessons can be arranged due to forced closures under certain circumstances Make-up lessons can be arranged due to forced closures under certain circumstances."},@{@"id":@"2", @"name":@"Make-up classes cannot be arranged due to forced closures."},@{@"id":@"7",@"name":@"Lessons will still continue during severe weather."}];
    
    [self showListData:[pickerArray valueForKey:@"name"] allowMultipleSelection:YES selectedData:[depositeBtn.titleLabel.text componentsSeparatedByString:@", "] title:@"Severe Weather"];
    
}

- (IBAction)tapBooks_materialBtn:(id)sender {
    
    list_index = @"7";
    
    pickerArray = @[@{@"id":@"0", @"name":@"Select"},@{@"id":@"0", @"name":@"HKD"},@{@"id":@"1", @"name":@"SGD"},@{@"id":@"2", @"name":@"THB"},@{@"id":@"3", @"name":@"MYR"},@{@"id":@"4", @"name":@"PHP"},@{@"id":@"5", @"name":@"IRD"},@{@"id":@"6", @"name":@"RMB"},@{@"id":@"7", @"name":@"USD"}];
    
    // [self showPicker];
}

- (IBAction)tapSecurityDeposit:(id)sender {
    
    list_index = @"8";
    
    pickerArray = @[@{@"id":@"0", @"name":@"Select"},@{@"id":@"0", @"name":@"HKD"},@{@"id":@"1", @"name":@"SGD"},@{@"id":@"2", @"name":@"THB"},@{@"id":@"3", @"name":@"MYR"},@{@"id":@"4", @"name":@"PHP"},@{@"id":@"5", @"name":@"IRD"},@{@"id":@"6", @"name":@"RMB"},@{@"id":@"7", @"name":@"USD"}];
    
    // [self showPicker];
}

- (IBAction)tapOtherCharge_btnn:(id)sender {
    
    list_index = @"9";
    
    pickerArray = @[@{@"id":@"0", @"name":@"Select"},@{@"id":@"0", @"name":@"HKD"},@{@"id":@"1", @"name":@"SGD"},@{@"id":@"2", @"name":@"THB"},@{@"id":@"3", @"name":@"MYR"},@{@"id":@"4", @"name":@"PHP"},@{@"id":@"5", @"name":@"IRD"},@{@"id":@"6", @"name":@"RMB"},@{@"id":@"7", @"name":@"USD"}];
    
    // [self showPicker];
    
    
}

- (IBAction)tappSaveBtn:(id)sender {
    
    NSString *message;
    
    NSLog(@"%@",paymentDeadLineBtn.titleLabel.text);
    
    if ([paymentDeadLineBtn.titleLabel.text isEqualToString:@"  Select"]) {
        
        message = @"Please select the payment deadline option";
        
    } else if ([depositeBtn.titleLabel.text isEqualToString:@"  Select"] || [depositeBtn.titleLabel.text isEqualToString:@""] ) {
        
        message = @"Please select the deposit option";
        
    } else if ([changeEnrollmentBtn.titleLabel.text isEqualToString:@"  Select"]) {
        
        message = @"Please select the change to enrollment option";
        
    }  else if ([cancellationBtn.titleLabel.text isEqualToString:@"  Select"]) {
        
        message = @"Please select the cancellation option";
        
    } else if ([refundBtn.titleLabel.text isEqualToString:@"  Select"]) {
        
        message = @"Please select the refund option";
        
    } else if ([make_upLessionBtn.titleLabel.text isEqualToString:@"  Select"]) {
        
        message = @"Please select the make-up lesson option";
        
    } else if ([servere_weatherBtn.titleLabel.text isEqualToString:@"  Select"] || [depositeBtn.titleLabel.text isEqualToString:@""] ) {
        
        message = @"Please select the severe weather option";
        
    } else if ([books_materialBtn.titleLabel.text isEqualToString:@"  Select"]) {
        
        message = @"Please select currency";
        
    } else if (![books_materialPrice.text isEqualToString:@""]) {
        
        if (![validationObj validateNumber:books_materialPrice.text]) {
            
            message = @"Please enter valid price for books and material";
        }
    } else if (![securityPriceTxtField.text isEqualToString:@""]) {
        
        if (![validationObj validateNumber:securityPriceTxtField.text]) {
            
            message = @"Please enter valid price for security deposit";
            
        }
    }else if (![othercharge_textfield.text isEqualToString:@""]) {
        
        if (![validationObj validateNumber:othercharge_textfield.text]) {
            
            message = @"Please enter valid price for other charges.";
            
        }
    }  else {
        
        if ([cancellation_id isEqualToString:@"3"]) {
            
            if ([cancellation_textfield.text isEqualToString:@""]) {
                
                message = @"Please add the other condition";
            }
            
        } else{
            
            if ([cancellationBtn.titleLabel.text isEqualToString:@"  Select"]) {
                
                message = @"Please select the cancellation option";
                
            }
        }
    }
    
    
    //    else if ([securityDepositBtn.titleLabel.text isEqualToString:@"  Select"]) {
    //
    //        message = @"Please select the deposit option";
    //
    //    } else if ([securityPriceTxtField.text isEqualToString:@""]) {
    //
    //        message = @"Please select the deposit option";
    //    }
    
    if ([message length] > 1) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:Alert_title  message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
        
    } else {
        
        NSDictionary *term_conData = @{@"payment_deadline":paymentDead_id, @"deposit":deposit_ids, @"change_enrollment":changes_enrol_id,@"cancellation":cancellation_id, @"refund":refund_id, @"make_up_lessons":make_up_id, @"severe_weather":servere_ids, @"currency":books_material_id, @"quantity_books_materials":books_materialPrice.text, @"currency_security":security_deposite_id,@"quantity_security":securityPriceTxtField.text,@"other_charges_currency":othercharge_deposit_id,@"other_charges":othercharge_textfield.text,@"other_cancellation":cancellation_textfield.text};
        
        NSLog(@"%@", term_conData);
        
        [[NSUserDefaults standardUserDefaults] setValue:term_conData forKey:@"Term_CondData"];
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (IBAction)tappCancelBtn:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)showListData:(NSArray *)items allowMultipleSelection:(BOOL)allowMultipleSelection selectedData:(NSArray *)selectedData title:(NSString *)title {
    
    ListingViewController *listViewController = [[ListingViewController alloc] init];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        listViewController = [[UIStoryboard storyboardWithName:@"Main_Ipad" bundle:nil] instantiateViewControllerWithIdentifier:@"listingVC"];
        
    } else {
        
        listViewController = [[UIStoryboard storyboardWithName:@"Main_Iphone" bundle:nil] instantiateViewControllerWithIdentifier:@"listingVC"];
    }
    
    listViewController.isMultipleSelected = allowMultipleSelection;
    
    listViewController.array_data = [items mutableCopy];
    
    listViewController.selectedData = [selectedData mutableCopy];
    
    listViewController.delegate = self;
    
    listViewController.title = title;
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:listViewController];
    
    [self presentViewController:nav animated:YES completion:nil];
    
}

#pragma mark - list delegate

-(void)didSelectListItem:(id)item index:(NSInteger)index{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)didSaveItems:(NSArray*)items indexs:(NSArray *)indexs{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    NSMutableArray *array_selectedInterest = [NSMutableArray array];
    
    NSMutableArray *array_Ids = [NSMutableArray array];
    
    for (NSIndexPath *indexPath in indexs) {
        
        // NSLog(@"IndexPath:%ld",(long)indexPath.row);
        
        if (indexs.count > pickerArray.count) {
            
            if (indexPath.row < pickerArray.count) {
                
                [array_selectedInterest addObject:[pickerArray[indexPath.row] valueForKey :@"name"]];
                
                [array_Ids addObject:[pickerArray[indexPath.row] valueForKey :@"id"]];
            }
            
        } else {
            
            [array_selectedInterest addObject:[pickerArray[indexPath.row-1] valueForKey:@"name"]];
            
            [array_Ids addObject:[pickerArray[indexPath.row-1] valueForKey :@"id"]];
        }
    }
    
    NSString *str = [array_selectedInterest  componentsJoinedByString:@","];
    
    str = [@"  " stringByAppendingString:str];
    
    NSString *str_ids = [array_Ids  componentsJoinedByString:@","];
    
    if ([list_index isEqualToString:@"1"]) {
        
        [depositeBtn setTitle:str forState:UIControlStateNormal];
        
        deposit_ids = str_ids;
        
    } else if ([list_index isEqualToString:@"6"]){
        
        [servere_weatherBtn setTitle:str forState:UIControlStateNormal];
        
        servere_ids = str_ids;
    }
}

-(void)didCancel{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

//#pragma mark - TextField Delegates & Datasource
//
//-(BOOL)textFieldShouldReturn:(UITextField *)textField {
//    
//    [textField resignFirstResponder];
//    
//    if (textField == books_materialPrice || textField == securityPriceTxtField) {
//        
//        if (![validationObj validateNumber:textField.text]) {
//            
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:Alert_title  message:@"Please enter valid amount" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//            
//            [alert show];
//        }
//    }
//    
//    return TRUE;
//}
//
//-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
//    
//    return TRUE;
//}
//
//- (void)textFieldDidBeginEditing:(UITextField *)textField
//{
//    activeField = textField;
//    
//    scrollView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
//    
//    //[self animateTextField: textField up: YES];
//}
//
//
//- (void)textFieldDidEndEditing:(UITextField *)textField
//{
//    
//    activeField = nil;
//    //[self animateTextField: textField up: NO];
//}
//
//- (void)animateTextField:(UITextField*)textField up:(BOOL) up {
//    
//    const int movementDistance = -(self.view.frame.size.height - textField.frame.origin.y - 50);
//    
//    const float movementDuration = 0.3f;
//    
//    int movement = (up ? -movementDistance : movementDistance);
//    
//    [UIView beginAnimations: @"anim" context: nil];
//    
//    [UIView setAnimationBeginsFromCurrentState: YES];
//    
//    [UIView setAnimationDuration: movementDuration];
//    
//    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
//    
//    [UIView commitAnimations];
//    
//}
//// Called when the UIKeyboardDidShowNotification is sent.
//
//- (void)registerForKeyboardNotifications
//{
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self
//     
//                                             selector:@selector(keyboardWasShown:)
//     
//                                                 name:UIKeyboardDidShowNotification object:nil];
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self
//     
//                                             selector:@selector(keyboardWillBeHidden:)
//     
//                                                 name:UIKeyboardWillHideNotification object:nil];
//    
//}
//
//-(void)keyboardWasShown:(NSNotification*)aNotification {
//    
//    NSDictionary* info = [aNotification userInfo];
//    
//    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
//    
//    float kbHeight = 0.0;
//    
//    if (kbSize.width > kbSize.height) {
//        
//        kbHeight = kbSize.height;
//        
//    } else {
//        
//        kbHeight = kbSize.width;
//    }
//    
//    NSLog(@"%f", self.view.frame.origin.x);
//    
//    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbHeight-self.view.frame.origin.x, 0.0);
//    
//    UIStoryboard *storyboard;
//    
//    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//        
//        storyboard = [UIStoryboard storyboardWithName:@"Main_Ipad" bundle:nil];
//        
//        //[scrollView setContentSize:CGSizeMake(self.view.frame.size.width, 1700)];
//        
//    } else {
//        
//        storyboard = [UIStoryboard storyboardWithName:@"Main_Iphone" bundle:nil];
//        
//        //[scrollView setContentSize:CGSizeMake(self.view.frame.size.width, 1300)];
//        
//    }
//    
//    scrollView.contentInset = contentInsets;
//    
//    CGRect aRect = self.view.frame;
//    
//    aRect.size.height -= kbHeight;
//    
//    UIView *activeView = activeField;
//    
//    if (!CGRectContainsPoint(aRect, activeView.frame.origin) ) {
//        
//        [scrollView scrollRectToVisible: activeView.frame  animated:YES];
//    }
//}
//
//// Called when the UIKeyboardWillHideNotification is sent
//
//- (void)keyboardWillBeHidden:(NSNotification*)aNotification {
//    
//    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
//    
//    scrollView.contentInset = contentInsets;
//    
//    scrollView.scrollIndicatorInsets = contentInsets;
//    
//    scrollView.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height);
//    
//}
//
//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//    
//    [self.view endEditing:YES];
//    
//    [super touchesBegan:touches withEvent:event];
//}
//
//- (void)hideKeyboard {
//    
//    [self.view endEditing:YES];
//}


- (IBAction)tap_infoBtn:(id)sender {
    
    UIAlertView *alertview = [[UIAlertView alloc]initWithTitle:nil message:@"Specify your enrollment terms & conditions, which govern the terms and conditions by which other members should follow when enrolling in your course." delegate:self cancelButtonTitle:@"Ok Thanks" otherButtonTitles:nil, nil];
    
    [alertview show];
}
- (IBAction)tap_enterFC_btn:(id)sender {
    
    NSString *message;
    
    NSLog(@"%@",paymentDeadLineBtn.titleLabel.text);
    
    if ([paymentDeadLineBtn.titleLabel.text isEqualToString:@"  Select"]) {
        
        message = @"Please select the payment deadline option.";
        
    } else if ([depositeBtn.titleLabel.text isEqualToString:@"  Select"] || [depositeBtn.titleLabel.text isEqualToString:@""] ) {
        
        message = @"Please select the deposit option.";
        
    } else if ([changeEnrollmentBtn.titleLabel.text isEqualToString:@"  Select"]) {
        
        message = @"Please select the change to enrollment option.";
        
    }   else if ([refundBtn.titleLabel.text isEqualToString:@"  Select"]) {
        
        message = @"Please select the refund option.";
        
    } else if ([make_upLessionBtn.titleLabel.text isEqualToString:@"  Select"]) {
        
        message = @"Please select the make-up lesson option.";
        
    } else if ([servere_weatherBtn.titleLabel.text isEqualToString:@"  Select"] || [depositeBtn.titleLabel.text isEqualToString:@""] ) {
        
        message = @"Please select the severe weather option.";
        
    }
    
    //    } else if ([books_materialBtn.titleLabel.text isEqualToString:@"  Select"]) {
    //
    //        message = @"Please select currency";
    //
    //    } else if (![books_materialPrice.text isEqualToString:@""]) {
    //
    //        if (![validationObj validateNumber:books_materialPrice.text]) {
    //
    //            message = @"Please enter valid price for books and material";
    //        }
    //    } else if (![securityPriceTxtField.text isEqualToString:@""]) {
    //
    //        if (![validationObj validateNumber:securityPriceTxtField.text]) {
    //
    //            message = @"Please enter valid price for security deposit";
    //        }
    //    } else if (![othrCharge_textfield.text isEqualToString:@""]) {
    //
    //        if (![validationObj validateNumber:othrCharge_textfield.text]) {
    //
    //            message = @"Please enter valid price for other charge security deposit";
    //        }
    //    }
    
    else {
        
        if ([cancellation_id isEqualToString:@"3"]) {
            
            if ([cancellation_textfield.text isEqualToString:@""]) {
                
                message = @"Please add the other condition.";
            }
            
        } else{
            
            if ([cancellationBtn.titleLabel.text isEqualToString:@"  Select"]) {
                
                message = @"Please select the cancellation option.";
                
            }
        }
    }
    
    //    else if ([securityDepositBtn.titleLabel.text isEqualToString:@"  Select"]) {
    //
    //        message = @"Please select the deposit option";
    //
    //    } else if ([securityPriceTxtField.text isEqualToString:@""]) {
    //
    //        message = @"Please select the deposit option";
    //    }
    
    if ([message length] > 1) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:Alert_title  message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
        
    } else {
        
        termDict = @{@"payment_deadline":paymentDead_id, @"deposit":deposit_ids, @"change_enrollment":changes_enrol_id,@"cancellation":cancellation_id, @"refund":refund_id, @"make_up_lessons":make_up_id, @"severe_weather":servere_ids,@"other_cancellation":cancellation_textfield.text};
        
        //        NSDictionary *term_conData = @{@"payment_deadline":paymentDead_id, @"deposit":deposit_ids, @"change_enrollment":changes_enrol_id,@"cancellation":cancellation_id, @"refund":refund_id, @"make_up_lessons":make_up_id, @"severe_weather":servere_ids, @"currency":books_material_id, @"quantity_books_materials":books_materialPrice.text, @"currency_security":security_deposite_id,@"quantity_security":securityPriceTxtField.text,@"other_charges_currency":othercharges_deposite_id,@"other_charges":othrCharge_textfield.text,@"other_cancellation":cancellation_textfield.text};
        
        //        NSString *currecy_name = currencyAccpt_btn.titleLabel.text;
        //
        //        currecy_name = [currecy_name stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        //
        //        NSDictionary *dict = @{@"currency_id":currencyAccpt_id,@"currency_name":currecy_name};
        //
        //        [[NSUserDefaults standardUserDefaults] setValue:dict forKey:@"Currency"];
        //
        //
        //        NSLog(@"%@", term_conData);
        //
        //        [[NSUserDefaults standardUserDefaults] setValue:term_conData forKey:@"Term_CondData"];
        
        [self performSegueWithIdentifier:@"EditfeesSegue" sender:self];
        
    }
    
}
@end
