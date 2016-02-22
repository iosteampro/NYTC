//
//  LessonEnrollmentViewController.h
//  ecaHUB
//
//  Created by promatics on 4/11/15.
//  Copyright (c) 2015 promatics. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListingViewController.h"

@interface LessonEnrollmentViewController : UIViewController <listingDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *continueBtn;
- (IBAction)tapContinueBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *studentHeading;
@property (weak, nonatomic) IBOutlet UILabel *name_lbl;
@property (weak, nonatomic) IBOutlet UILabel *dob_lbl;
@property (weak, nonatomic) IBOutlet UILabel *GenderStd_lbl;
@property (weak, nonatomic) IBOutlet UILabel *lessonDetailsHeading;
@property (weak, nonatomic) IBOutlet UILabel *lessonName_lbl;
@property (weak, nonatomic) IBOutlet UILabel *educator_lbl;
@property (weak, nonatomic) IBOutlet UILabel *session_lbl;
@property (weak, nonatomic) IBOutlet UILabel *referenceId_lbl;
@property (weak, nonatomic) IBOutlet UILabel *lessonDuration_lbl;
@property (weak, nonatomic) IBOutlet UILabel *teachingMethod_lbl;
@property (weak, nonatomic) IBOutlet UILabel *language_lbl;
@property (weak, nonatomic) IBOutlet UILabel *gender_lbl;
@property (weak, nonatomic) IBOutlet UILabel *ageGroup_lbl;
@property (weak, nonatomic) IBOutlet UILabel *selectedTimeSlot_lbl;
@property (weak, nonatomic) IBOutlet UILabel *location_lbl;
@property (weak, nonatomic) IBOutlet UILabel *lessonFeeHeading;
@property (weak, nonatomic) IBOutlet UILabel *lessonFee_lbl;
@property (weak, nonatomic) IBOutlet UILabel *sessionOptionsHeading;
@property (weak, nonatomic) IBOutlet UIButton *selectSsnoptnBtn;
@property (weak, nonatomic) IBOutlet UILabel *preferedLocationHeading;
@property (weak, nonatomic) IBOutlet UILabel *if_subLbl;
@property (weak, nonatomic) IBOutlet UITextField *location_txtfld;
@property (weak, nonatomic) IBOutlet UILabel *otherFeesHeading;
@property (weak, nonatomic) IBOutlet UILabel *book_lbl;
@property (weak, nonatomic) IBOutlet UILabel *security_lbl;
@property (weak, nonatomic) IBOutlet UILabel *otherFees;
@property (weak, nonatomic) IBOutlet UILabel *educatorTermsHeading;
@property (weak, nonatomic) IBOutlet UILabel *paymentDeadline_lbl;
@property (weak, nonatomic) IBOutlet UILabel *deposite_lbl;
@property (weak, nonatomic) IBOutlet UILabel *enrollment_lbl;
@property (weak, nonatomic) IBOutlet UILabel *minimumPayment_lbl;
@property (weak, nonatomic) IBOutlet UILabel *changesEnroll_lbl;
@property (weak, nonatomic) IBOutlet UILabel *cancellation_lbl;
@property (weak, nonatomic) IBOutlet UILabel *makeupEvent_lbl;
@property (weak, nonatomic) IBOutlet UILabel *severeWeather_lbl;
@property (weak, nonatomic) IBOutlet UILabel *refund_lbl;
@property (weak, nonatomic) IBOutlet UILabel *name_value;
@property (weak, nonatomic) IBOutlet UILabel *dob_value;
@property (weak, nonatomic) IBOutlet UILabel *genderStd_value;
@property (weak, nonatomic) IBOutlet UILabel *lessonName_value;
@property (weak, nonatomic) IBOutlet UILabel *educator_value;
@property (weak, nonatomic) IBOutlet UILabel *session_value;
@property (weak, nonatomic) IBOutlet UILabel *teachingMethod_value;
@property (weak, nonatomic) IBOutlet UILabel *language_value;
@property (weak, nonatomic) IBOutlet UILabel *gender_value;
@property (weak, nonatomic) IBOutlet UILabel *ageGroup_value;
@property (weak, nonatomic) IBOutlet UILabel *selectedTimeSlot_value;
@property (weak, nonatomic) IBOutlet UILabel *location_value;
@property (weak, nonatomic) IBOutlet UILabel *lessonFee_value;
@property (weak, nonatomic) IBOutlet UILabel *bookMaterial_value;
@property (weak, nonatomic) IBOutlet UILabel *security_value;

@property (weak, nonatomic) IBOutlet UILabel *otherFees_value;
@property (weak, nonatomic) IBOutlet UILabel *paymentdeadline_value;
@property (weak, nonatomic) IBOutlet UILabel *changesEnroll_value;
@property (weak, nonatomic) IBOutlet UILabel *deposite_value;
@property (weak, nonatomic) IBOutlet UILabel *enrollment_value;
@property (weak, nonatomic) IBOutlet UILabel *minimumpymnt_value;
@property (weak, nonatomic) IBOutlet UILabel *cancellation_value;
@property (weak, nonatomic) IBOutlet UILabel *makeupEvant_value;
@property (weak, nonatomic) IBOutlet UILabel *severeWeather_value;
@property (weak, nonatomic) IBOutlet UILabel *refund_value;

@property (weak, nonatomic) IBOutlet UIButton *bookBtn;
- (IBAction)tap_bookBtn:(id)sender;

- (IBAction)tap_securityBtn:(id)sender;
- (IBAction)tap_otherFeesBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *otherFeesBtn;

@property (weak, nonatomic) IBOutlet UIButton *securityBtn;
@property (weak, nonatomic) IBOutlet UILabel *referenceId_value;
@property (weak, nonatomic) IBOutlet UILabel *lessonDuration_value;
- (IBAction)tap_selectSlotBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *enrollmentOptn_view;
@property (weak, nonatomic) IBOutlet UIView *preferred_startDateview;
- (IBAction)tap_prefddtTooltip:(id)sender;
- (IBAction)tap_EnrlmntOpnsTooltip:(id)sender;
- (IBAction)tap_startDtBtn:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *startDtBtn;
- (IBAction)tap_EnrlmtOptn1:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *enrlmtOptn1;
- (IBAction)tap_EnrlmntOptn2:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *enrlmntOptn2;


@end
