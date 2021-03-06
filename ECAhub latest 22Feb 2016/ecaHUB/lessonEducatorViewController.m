//
//  lessonEducatorViewController.m
//  ecaHUB
//
//  Created by promatics on 4/4/15.
//  Copyright (c) 2015 promatics. All rights reserved.
//

#import "lessonEducatorViewController.h"
#import "URL.h"
#import "LessonEducatorOtherListingTableViewCell.h"
#import "WebServiceConnection.h"
#import "Indicator.h"
#import "SDWebImage/UIImageView+WebCache.h"

@interface lessonEducatorViewController (){
    
    WebServiceConnection *myListingConn, *pinTOFavConnection;
    
    Indicator *indicator;
    
    NSArray *otherListingArray;
    
    LessonEducatorOtherListingTableViewCell *cell;
    
    NSArray *categoriesArray, *subcategoriesArray;
    
    NSString *memberId;
    
    NSMutableArray *FAVarray;
    
    CGFloat cellHeight;
}

@end

@implementation lessonEducatorViewController

@synthesize scrollView, educator_imgView, educator_image, educator_name, educator_description, established_year, location, offers, category, sub_cat, total_praises, total_purchased, location_lable, total_review,sub_View,establisedLbl,locationLbl,offersLbl,listing_table,otherListingLbl,achivments_lbl,awards_view,profile_view,picture_view;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title =@"About the Educator";
    
    myListingConn = [WebServiceConnection connectionManager];
    
    pinTOFavConnection = [WebServiceConnection connectionManager];
    
    indicator = [[Indicator alloc]initWithFrame:self.view.frame];
    
    // self.navigationController.navigationBar.topItem.title = @"";
    
    UIStoryboard *storyboard;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        storyboard = [UIStoryboard storyboardWithName:@"Main_Ipad" bundle:nil];
        
        scrollView.frame = self.view.frame;
        
        scrollView.contentSize = CGSizeMake(self.view.frame.size.width, 1050);
        
        educator_imgView.layer.cornerRadius = 65.0f;
        
        educator_imgView.layer.borderWidth = 8.0f;
        
    } else {
        
        storyboard = [UIStoryboard storyboardWithName:@"Main_Iphone" bundle:nil];
        
        scrollView.frame = self.view.frame;
        
        scrollView.contentSize = CGSizeMake(self.view.frame.size.width, 700);
        
        educator_imgView.layer.cornerRadius = 40.0f;
        
        educator_imgView.layer.borderWidth = 6.0f;
    }
    
    educator_imgView.layer.borderColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Text_colore"]].CGColor;
    
    [self fetchMyListing];
    
    [self setEducatorDetails];
    
    
}

-(void) setEducatorDetails {
    
    NSLog(@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"lessonDetail"]);
    
    NSString *img_url = [[[[[NSUserDefaults standardUserDefaults] valueForKey:@"lessonDetail"] valueForKey:@"lesson_info"] valueForKey:@"BusinessProfile"] valueForKey:@"identity"];
    
    if ([img_url length] > 1) {
        
        img_url = [BusinessProfileImgURL stringByAppendingString:img_url];
        
        [self downloadImageWithString:img_url];
        
    } else {
        
        educator_image.image = [UIImage imageNamed:@"user_img"];
    }
    
    NSLog(@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"lessonDetail"]);
    
    educator_name.text = [[[[[NSUserDefaults standardUserDefaults] valueForKey:@"lessonDetail"] valueForKey:@"lesson_info"] valueForKey:@"BusinessProfile"] valueForKey:@"name_educator"];
    
    educator_description.text = [[[[[NSUserDefaults standardUserDefaults] valueForKey:@"lessonDetail"] valueForKey:@"lesson_info"] valueForKey:@"BusinessProfile"] valueForKey:@"description_educator"];
    
    otherListingLbl.text =[@"Other Listings by "stringByAppendingString:[[[[[NSUserDefaults standardUserDefaults] valueForKey:@"lessonDetail"] valueForKey:@"lesson_info"] valueForKey:@"BusinessProfile"] valueForKey:@"name_educator"]];
    
    CGRect frame1;
    
    educator_name.numberOfLines = 0;
    
    educator_name.lineBreakMode = NSLineBreakByWordWrapping;
    
    [educator_name sizeToFit];
    
    if (educator_name.frame.size.width < self.picture_view.frame.size.width- (2*(educator_name.frame.origin.x))) {
        
        frame1 = educator_name.frame;
        
        frame1.size.width = self.picture_view.frame.size.width- (2*(educator_name.frame.origin.x));
        
        educator_name.frame = frame1;
        
    }
    
    [educator_name setTextAlignment:NSTextAlignmentCenter];
    
    frame1 = picture_view.frame;
    
    frame1.size.height = educator_name.frame.origin.y + educator_name.frame.size.height +15;
    
    picture_view.frame = frame1;
    
    frame1 = profile_view.frame;
    
    frame1.size.height = educator_name.frame.origin.y + educator_name.frame.size.height +15;
    
    profile_view.frame = frame1;
    
    frame1 = educator_description.frame;
    
    frame1.origin.y = picture_view.frame.origin.y + picture_view.frame.size.height +10;
    
    frame1.size.height = [self heightCalculate1:educator_description.text]+20;
    
    educator_description.frame = frame1;
    
    frame1 = sub_View.frame;
    
    established_year.text = [[[[[[NSUserDefaults standardUserDefaults] valueForKey:@"lessonDetail"] valueForKey:@"lesson_info"] valueForKey:@"BusinessProfile"] valueForKey:@"year"]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    NSLog(@"%@",[[[[NSUserDefaults standardUserDefaults] valueForKey:@"lessonDetail"] valueForKey:@"lesson_info"] valueForKey:@"LessonListing"]);
    
//    NSString *locationStr = [[[[[NSUserDefaults standardUserDefaults] valueForKey:@"lessonDetail"] valueForKey:@"lesson_info"] valueForKey:@"LessonListing"] valueForKey:@"author_venu_unit"];
//    
//    locationStr = [locationStr stringByAppendingString:@", "];
//    
//    locationStr = [locationStr stringByAppendingString:[[[[[NSUserDefaults standardUserDefaults] valueForKey:@"lessonDetail"] valueForKey:@"lesson_info"] valueForKey:@"LessonListing"] valueForKey:@"author_venu_building_name"]];
//    
//    locationStr = [locationStr stringByAppendingString:@", "];
//    
//    locationStr = [locationStr stringByAppendingString:[[[[[NSUserDefaults standardUserDefaults] valueForKey:@"lessonDetail"] valueForKey:@"lesson_info"] valueForKey:@"LessonListing"] valueForKey:@"author_venu_street"]];
//    
//    locationStr = [locationStr stringByAppendingString:@", "];
    
    NSString *locationStr = [[[[[NSUserDefaults standardUserDefaults] valueForKey:@"lessonDetail"] valueForKey:@"lesson_info"] valueForKey:@"BusinessProfile"] valueForKey:@"author_venu_district"];
    
    offers.text = [[[[NSUserDefaults standardUserDefaults] valueForKey:@"lessonDetail"] valueForKey:@"offer_names"]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    location.text = [locationStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
//    locationStr = [locationStr stringByAppendingString:@", "];
//    
//    locationStr = [locationStr stringByAppendingString:[[[[[NSUserDefaults standardUserDefaults] valueForKey:@"lessonDetail"] valueForKey:@"lesson_info"] valueForKey:@"author_city"] valueForKey:@"city_name"]];
//    
//    locationStr = [locationStr stringByAppendingString:@", "];
//    
//    locationStr = [locationStr stringByAppendingString:[[[[[NSUserDefaults standardUserDefaults] valueForKey:@"lessonDetail"] valueForKey:@"lesson_info"] valueForKey:@"author_state"] valueForKey:@"state_name"]];
//    
//    locationStr = [locationStr stringByAppendingString:@", "];
//    
//    locationStr = [locationStr stringByAppendingString:[[[[[NSUserDefaults standardUserDefaults] valueForKey:@"lessonDetail"] valueForKey:@"lesson_info"] valueForKey:@"author_country"] valueForKey:@"country_name"]];
    
//    CGFloat height = [self heightCalculate:locationStr];
//    
//    CGRect frame = location.frame;
//    
//    frame.origin.y = locationLbl.frame.origin.y;
//    
//    frame.size.height = locationLbl.frame.size.height;
//    
//    NSLog(@"%f",self.view.frame.size.width - (location_lable.frame.size.width + location_lable.frame.origin.x + 10));
//    
//    frame.size.width = self.view.frame.size.width - (location_lable.frame.size.width + location_lable.frame.origin.x + 30);
//    
//    location.frame = frame;
//    
//    [location setFrame:frame];
//    
//    [location setLineBreakMode:NSLineBreakByClipping];
//    
//    [location  setNumberOfLines:0];
//    
//    [location  setBaselineAdjustment:UIBaselineAdjustmentAlignBaselines];
//    
//    UIStoryboard *storyboard;
//    
//    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//        
//        storyboard = [UIStoryboard storyboardWithName:@"Main_Ipad" bundle:nil];
//        
//        [location setFont:[UIFont systemFontOfSize:20]];
//        
//    } else {
//        
//        storyboard = [UIStoryboard storyboardWithName:@"Main_Iphone" bundle:nil];
//        
//        [location setFont:[UIFont systemFontOfSize:17]];
//        
//    }
//    
//    //    [location sizeToFit];
//    
//    location.text = locationStr;
//    
//    NSString *str = [[[NSUserDefaults standardUserDefaults] valueForKey:@"lessonDetail"] valueForKey:@"offer_names"];
//    
//    height = [self heightCalculate:str];
//    
//    frame = offers.frame;
//    
//    frame.size.width = self.view.frame.size.width - (location_lable.frame.size.width + location_lable.frame.origin.x+30);
//    
//    frame.origin.y = offersLbl.frame.origin.y;
//    
//    frame.size.height = offersLbl.frame.size.height;
//    
//    offers.frame = frame;
//    
//    //[offers sizeToFit];
//    
//    offers.text = [[[NSUserDefaults standardUserDefaults] valueForKey:@"lessonDetail"] valueForKey:@"offer_names"];
//    
//    str = [[[NSUserDefaults standardUserDefaults] valueForKey:@"lessonDetail"] valueForKey:@"result_string"];
//    
//    height = [self heightCalculate:str];
//    
//    frame = category.frame;
//    
//    frame.size.height = height;
//    
//    frame.size.width = self.view.frame.size.width - (location_lable.frame.size.width + location_lable.frame.origin.x+30);
//    
//    category.frame = frame;
//    
//    //    [category sizeToFit];
//    
//    category.text = [[[NSUserDefaults standardUserDefaults] valueForKey:@"lessonDetail"] valueForKey:@"result_string"];
//    
//    str = [[[NSUserDefaults standardUserDefaults] valueForKey:@"lessonDetail"] valueForKey:@"subcategory_name"];
//    
//    height = [self heightCalculate:str];
//    
//    frame = sub_cat.frame;
//    
//    frame.size.height = height;
//    
//    frame.size.width = self.view.frame.size.width - (location_lable.frame.size.width + location_lable.frame.origin.x+30);
//    
//    sub_cat.frame = frame;
//    
//    //    [sub_cat sizeToFit];
//    
//    sub_cat.text = [[[NSUserDefaults standardUserDefaults] valueForKey:@"lessonDetail"] valueForKey:@"subcategory_name"];
    
    CGRect Frame2 = established_year.frame;
    
    Frame2.origin.y = establisedLbl.frame.origin.y;
    
    established_year.frame = Frame2;
    
    Frame2 = offersLbl.frame;
    
    Frame2.origin.y = established_year.frame.origin.y + established_year.frame.size.height +5;
    
    offersLbl.frame = Frame2;
    
    Frame2 = offers.frame;
    
    Frame2.origin.y = established_year.frame.origin.y + established_year.frame.size.height +5;
    
    Frame2.size.height = [self heightCalculate:offers.text];
    
    offers.frame = Frame2;
    
    Frame2 = locationLbl.frame;
    
    Frame2.origin.y = offers.frame.origin.y + offers.frame.size.height +5;
    
    locationLbl.frame = Frame2;
    
    Frame2 = location.frame;
    
    Frame2.origin.y = offers.frame.origin.y + offers.frame.size.height +5;
    
    location.frame = Frame2;
    
    Frame2 = achivments_lbl.frame;
    
    Frame2.origin.y = location.frame.origin.y + location.frame.size.height +5;
    
    achivments_lbl.frame = Frame2;
    
    Frame2 = awards_view.frame;
    
    Frame2.origin.y = achivments_lbl.frame.origin.y + achivments_lbl.frame.size.height +5;
    
    awards_view.frame = Frame2;
    
    frame1.origin.y =educator_description.frame.origin.y + educator_description.frame.size.height + 5;
    
    frame1.size.height = awards_view.frame.origin.y + awards_view.frame.size.height+5;
    
    sub_View.frame = frame1;
    
    frame1 = otherListingLbl.frame;
    
    frame1.origin.y = sub_View.frame.origin.y + sub_View.frame.size.height +30;
    
    otherListingLbl.frame = frame1;
    
    otherListingLbl.numberOfLines = 0;
    
    otherListingLbl.lineBreakMode = NSLineBreakByWordWrapping;
    
    [otherListingLbl sizeToFit];
    
    if (otherListingLbl.frame.size.width < self.view.frame.size.width- (2*(otherListingLbl.frame.origin.x))) {
        
        frame1 = otherListingLbl.frame;
        
        frame1.size.width = self.view.frame.size.width- (2*(otherListingLbl.frame.origin.x));
        otherListingLbl.frame = frame1;
        
    }
    
    [otherListingLbl setTextAlignment:NSTextAlignmentCenter];
    
    frame1 = listing_table.frame;
    
    frame1.origin.y = otherListingLbl.frame.origin.y + otherListingLbl.frame.size.height +5;
    
    listing_table.frame = frame1;
    
    [established_year sizeToFit];
    
    [establisedLbl sizeToFit];
    
    [offersLbl sizeToFit];
    
    [offers sizeToFit];
    
    [location sizeToFit];
    
    [locationLbl sizeToFit];
    
    scrollView.frame = self.view.frame;
    
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width,listing_table.frame.origin.y + listing_table.frame.size.height);
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [self setExtendedLayoutIncludesOpaqueBars:YES];
    
    self.tabBarController.tabBar.hidden = YES;
    
    [super viewWillAppear:animated];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = NO;
    
    [super viewWillDisappear:animated];
    
}
-(CGFloat)heightCalculate1:(NSString *)calculateText{
    
    UILabel *calculateText_lbl = [[UILabel alloc] init];
    
    [calculateText_lbl setLineBreakMode:NSLineBreakByClipping];
    
    [calculateText_lbl setNumberOfLines:0];
    
    [calculateText_lbl setBaselineAdjustment:UIBaselineAdjustmentAlignBaselines];
    
    NSString *text = calculateText;
    
    NSLog(@"%@",calculateText);
    
    CGSize constraint = CGSizeMake(educator_description.frame.size.width - (1.0f * 2), FLT_MAX);
    
    UIFont *font;
    
    UIStoryboard *storyboard;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        storyboard = [UIStoryboard storyboardWithName:@"Main_Ipad" bundle:nil];
        
        font = [UIFont systemFontOfSize:19];
        
    } else {
        
        storyboard = [UIStoryboard storyboardWithName:@"Main_Iphone" bundle:nil];
        
        font = [UIFont systemFontOfSize:17];
        
    }
    
    CGRect frame = [text boundingRectWithSize:constraint options:NSStringDrawingUsesLineFragmentOrigin
                                   attributes:@{NSFontAttributeName:font} context:nil];
    
    CGSize size = CGSizeMake(frame.size.width, frame.size.height + 1);
    
    [calculateText_lbl setFrame:CGRectMake(10, 74, 300 ,size.height+5)];
    
    [calculateText_lbl sizeToFit];
    
    CGFloat height_lbl = size.height;
    
    return (height_lbl + 10);
}


-(CGFloat)heightCalculate:(NSString *)calculateText{
    
    UILabel *calculateText_lbl = [[UILabel alloc] init];
    
    [calculateText_lbl setLineBreakMode:NSLineBreakByClipping];
    
    [calculateText_lbl setNumberOfLines:0];
    
    [calculateText_lbl setBaselineAdjustment:UIBaselineAdjustmentAlignBaselines];
    
    NSString *text = calculateText;
    
    NSLog(@"%@",calculateText);
    
    CGSize constraint = CGSizeMake(offers.frame.size.width - (1.0f * 2), FLT_MAX);
    
    UIFont *font;
    
    UIStoryboard *storyboard;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        storyboard = [UIStoryboard storyboardWithName:@"Main_Ipad" bundle:nil];
        
        font = [UIFont systemFontOfSize:19];
        
    } else {
        
        storyboard = [UIStoryboard storyboardWithName:@"Main_Iphone" bundle:nil];
        
        font = [UIFont systemFontOfSize:17];
        
    }
    
    CGRect frame = [text boundingRectWithSize:constraint options:NSStringDrawingUsesLineFragmentOrigin
                                   attributes:@{NSFontAttributeName:font} context:nil];
    
    CGSize size = CGSizeMake(frame.size.width, frame.size.height + 1);
    
    [calculateText_lbl setFrame:CGRectMake(10, 74, 300 ,size.height+5)];
    
    [calculateText_lbl sizeToFit];
    
    CGFloat height_lbl = size.height;
    
    return (height_lbl + 10);
}


-(void) downloadImageWithString:(NSString *)urlString {
    
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *reponse,NSData *data, NSError *error) {
        
        if ([data length]>0) {
            
            UIImage *image = [UIImage imageWithData:data];
            
            educator_image.image = image;
        }
    }];
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

-(void)fetchMyListing{
    
    memberId =[[[[[NSUserDefaults standardUserDefaults] valueForKey:@"lessonDetail"]valueForKey:@"lesson_info"] valueForKey:@"LessonListing"] valueForKey:@"member_id"];
    
    NSDictionary *paramURL = @{@"member_id" : memberId};
    
    [self.view addSubview:indicator];
    
    [myListingConn startConnectionWithString:[NSString stringWithFormat:@"other_listing"] HttpMethodType:Post_Type HttpBodyType:paramURL Output:^(NSDictionary *receivedData){
        
        [indicator removeFromSuperview];
        
        if ([myListingConn responseCode] == 1) {
            
            NSLog(@"%@", receivedData);
            
            if ([[receivedData valueForKey:@"code"] integerValue] == 0) {
                
                otherListingLbl.hidden = YES;
                
                [scrollView setContentSize:CGSizeMake(self.view.frame.size.width, awards_view.frame.origin.y+ awards_view.frame.size.height +50)];
                
//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:Alert_title message:@"You have not yet addedd any Listing to ECAhub. Create a Listing now by clicking the '+' sign above.." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//                
//                [alert show];
                
            } else {
                
                otherListingArray = [[NSArray alloc]init];
                
                otherListingArray= [receivedData valueForKey:@"other_posted_listing"];
                
                NSLog( @"%@ ye jo data hai ", otherListingArray);
                
                FAVarray = [[NSMutableArray alloc]init];
                
                BOOL isfav = NO;
                
                [FAVarray removeAllObjects];
                
                for (int j = 0; j< otherListingArray.count; j++) {
                    
                    NSArray *favoriteArray = [[otherListingArray objectAtIndex:j] valueForKey:@"Favorite"];
                    
                    isfav = NO;
                    
                    for (int i = 0; i< favoriteArray.count; i++) {
                        
                        if ([memberId isEqualToString:[[favoriteArray objectAtIndex:i] valueForKey:@"member_id"]]) {
                            
                            [cell.favpinBtn setBackgroundImage:[UIImage imageNamed:@"favPin_yellow"] forState:UIControlStateNormal];
                            
                            isfav =YES;
                            
                            break;
                            
                        } else{
                            
                            isfav = NO;
                        }
                    }
                    if (isfav) {
                        
                        [FAVarray addObject:@"YES"];
                        
                    } else{
                        
                        [FAVarray addObject:@"NO"];
                    }
                }
                
                // NSArray *array = [[receivedData valueForKey:@"posted_courses"]valueForKey:@"CourseListing"];
                
                categoriesArray = [receivedData valueForKey:@"category_names"];
                
                subcategoriesArray = [receivedData valueForKey:@"subcategory_names"];
                
                NSLog( @"%@ ye jo data hai ", categoriesArray);
                
                cellHeight = 0;
                
                [listing_table reloadData];
                
            }
            
        }
        else{
            
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}

#pragma tableView delegets


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return cell.subcellView.frame.origin.y + cell.subcellView.frame.size.height +20;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [otherListingArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    cell = [tableView dequeueReusableCellWithIdentifier:@"OtherListingCell" forIndexPath:indexPath];
    
    NSString *listing,*type_name,*type,*location_other,*urll,*status_type;
    
    listing = [[otherListingArray objectAtIndex:indexPath.row] valueForKey:@"model"] ;
    
    listing_table.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSLog(@"%@",listing);
    
    if ([listing isEqualToString:@"CourseListing"]) {
        
        listing = @"CourseListing";
        type_name = @"course_name";
        status_type = @"course_status";
        urll = CourseImageURL;
        location_other = @"course_city";
        type = @"Course" ;
        
    } else if ([listing isEqualToString:@"LessonListing"]) {
        
        listing = @"LessonListing";
        type_name = @"lesson_name";
        status_type = @"lesson_status";
        urll = LessonImageURL;
        location_other = @"lesson_city";
        type = @"Lesson";
    } else if ([listing isEqualToString:@"EventListing"]) {
        
        listing = @"EventListing";
        type_name = @"event_name";
        status_type = @"event_status";
        urll = EventImageURL;
        location_other = @"event_city";
        type = @"Event";
    }
    
    if ([@"YES" isEqualToString:[FAVarray objectAtIndex:indexPath.row]]) {
        
        [cell.favpinBtn setBackgroundImage:[UIImage imageNamed:@"favPin_yellow"] forState:UIControlStateNormal];
        
    } else {
        
        [cell.favpinBtn setBackgroundImage:[UIImage imageNamed:@"favPin_gray"] forState:UIControlStateNormal];
    }
    
    [cell.favpinBtn addTarget:self action:@selector(tapFavBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.favpinBtn.tag = indexPath.row;
    
    [cell setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"light_grayColor"]]];
    
    
    cell.listing_name.text = [[[[otherListingArray objectAtIndex:indexPath.row] valueForKey:listing]valueForKey:type_name]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    cell.educatorName.text = [[[[otherListingArray objectAtIndex:indexPath.row] valueForKey:@"BusinessProfile"]valueForKey:@"name_educator"]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    NSString *typeCity = [type stringByAppendingString:@" | "];
    
    cell.type_city_lbl.text = [typeCity stringByAppendingString:[NSString stringWithFormat:@"%@",[[[otherListingArray objectAtIndex:indexPath.row] valueForKey:location_other] valueForKey:@"city_name"]]];
    
    NSString *categoriesStr = [[[otherListingArray objectAtIndex:indexPath.row] valueForKey:listing] valueForKey:@"category_id"];
    
    cell.praise_count.text = [[[otherListingArray objectAtIndex:indexPath.row] valueForKey:@"BusinessProfile"] valueForKey:@"praise_count"];
    
    NSArray *cat_id = [categoriesStr componentsSeparatedByString:@","];
    
    NSMutableArray *categories = [[NSMutableArray alloc] init];
    
    for (int i =0 ; i< cat_id.count; i++) {
        
        [categories addObject:[[[[categoriesArray objectAtIndex:indexPath.row] objectAtIndex:i] valueForKey:@"Category"] valueForKey:@"category_name"]];
    }
    
    NSMutableArray *subcategories = [[NSMutableArray alloc] init];
    
    NSArray * countArray =[subcategoriesArray objectAtIndex:indexPath.row ];
    
    for (int i =0 ; i< countArray.count; i++) {
        
        [subcategories addObject:[[[[subcategoriesArray objectAtIndex:indexPath.row] objectAtIndex:i] valueForKey:@"Subcategory"] valueForKey:@"subcategory_name"]];
    }
    
    cell.cat_name.text = [[[categories componentsJoinedByString:@", "]stringByAppendingString:@", "]stringByAppendingString:[subcategories componentsJoinedByString:@", "]];
    
    NSString *imageURL = [[[otherListingArray objectAtIndex:indexPath.row] valueForKey:listing] valueForKey:@"picture0"];
    
    for (int i = 1; i<4; i++) {
        
        NSString *pic = [NSString stringWithFormat:@"picture%d",i];
        
        if ([imageURL length] < 1) {
            
            imageURL = [[[otherListingArray objectAtIndex:indexPath.row] valueForKey:listing] valueForKey:pic];
        }
    }
    
    imageURL = [imageURL stringByTrimmingCharactersInSet:
                [NSCharacterSet whitespaceCharacterSet]];
    
    cell.image_view.image = [UIImage imageNamed:@"Listing_Image"];
    
    if ([imageURL length] < 1) {
        
        //Listing_Image
        cell.image_view.image = [UIImage imageNamed:@"Listing_Image"];
        
    } else {
        
        imageURL = [urll stringByAppendingString:imageURL];
        
        [cell.image_view sd_setImageWithURL:[NSURL URLWithString:imageURL] placeholderImage:[UIImage imageNamed:@"Listing_Image"]];
    }
    
    [cell.image_view  setContentMode:UIViewContentModeScaleAspectFill];
    
    CGRect frame = cell.listing_name.frame;
    
    frame.size.height = [self heightCalculate3:cell.listing_name.text :cell.listing_name];
    
    cell.listing_name.frame = frame;
    
    frame = cell.educatorName.frame;
    
    frame.origin.y = cell.listing_name.frame.origin.y + cell.listing_name.frame.size.height +5;
    
    frame.size.height = [self heightCalculate3:cell.educatorName.text :cell.educatorName];
    
    cell.educatorName.frame = frame;
    
    frame = cell.cat_name.frame;
    
    frame.origin.y = cell.educatorName.frame.origin.y + cell.educatorName.frame.size.height +5;
    
    frame.size.height = [self heightCalculate3:cell.cat_name.text :cell.cat_name];
    
    cell.cat_name.frame = frame;
    
    frame = cell.type_city_lbl.frame;
    
    frame.origin.y = cell.cat_name.frame.origin.y + cell.cat_name.frame.size.height +5;
    
    frame.size.height = [self heightCalculate3:cell.type_city_lbl.text :cell.type_city_lbl];
    
    cell.type_city_lbl.frame = frame;
    
    frame = cell.praise_btn.frame;
    
    frame.origin.y = cell.cat_name.frame.origin.y + cell.cat_name.frame.size.height +5;
    
    cell.praise_btn.frame = frame;
    
    frame = cell.praise_count.frame;
    
    frame.origin.y = cell.cat_name.frame.origin.y + cell.cat_name.frame.size.height +5;
    
    cell.praise_count.frame = frame;
    
    frame = cell.subcellView.frame;
    
    frame.size.height = cell.type_city_lbl.frame.origin.y + cell.type_city_lbl.frame.size.height +15;
    
    cell.subcellView.frame = frame;
    
    CGFloat height = cell.subcellView.frame.origin.y + cell.subcellView.frame.size.height +20;
    
    cellHeight = cellHeight + height;
    
    if (indexPath.row == (otherListingArray.count-1)) {
        
        [self setTableHeight];
        
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString * type_name;
    
    NSString *listing = [[otherListingArray objectAtIndex:indexPath.row] valueForKey:@"model"] ;
    
    if ([listing isEqualToString:@"CourseListing"]) {
        
        listing = @"CourseListing";
        type_name = @"course_name";
        
    } else if ([listing isEqualToString:@"LessonListing"]){
        
        listing = @"LessonListing";
        type_name = @"lession_name";
        
    }  else if ([listing isEqualToString:@"EventListing"]){
        
        listing = @"EventListing";
        type_name = @"event_name";
    }
    
    NSString *course_id = [[[otherListingArray objectAtIndex:indexPath.row] valueForKey:listing] valueForKey:@"id"];
    
    NSLog(@"Course Tap Id%@", course_id);
    
    [[NSUserDefaults standardUserDefaults] setValue:course_id forKey:@"course_id"];
    
    if ([listing isEqualToString:@"CourseListing"]) {
        
        [self performSegueWithIdentifier:@"courseDetailSegue" sender:self];
        
    } else if ([listing isEqualToString:@"LessonListing"]){
        
        [self performSegueWithIdentifier:@"lession_view" sender:self];
        
    }  else if ([listing isEqualToString:@"EventListing"]){
        
        [self performSegueWithIdentifier:@"event_view_segue" sender:self];
    }
}

-(void)tapFavBtn:(UIButton *)sender{
    
    [self.view addSubview:indicator];
    
    NSString *course_id,*type_str,*listing;
    
    listing = [[otherListingArray objectAtIndex:sender.tag] valueForKey:@"model"] ;
    
    if ([listing isEqualToString:@"CourseListing"]) {
        
        listing = @"CourseListing";
        
        course_id = [[[otherListingArray objectAtIndex:sender.tag] valueForKey: @"CourseListing"] valueForKey:@"id"];
        
        type_str = @"1";
        
        
    } else if ([listing isEqualToString:@"LessonListing"]) {
        
        
        course_id = [[[otherListingArray objectAtIndex:sender.tag] valueForKey: @"LessonListing"] valueForKey:@"id"];
        
        listing = @"LessonListing";
        
        type_str = @"3";
        
        
    } else if ([listing isEqualToString:@"EventListing"]) {
        
        course_id = [[[otherListingArray objectAtIndex:sender.tag] valueForKey: @"EventListing"] valueForKey:@"id"];
        
        listing = @"EventListing";
        
        type_str = @"2";
        
    }
    
    NSDictionary *paramURL;
    
    NSString *msg;
    
    if ([[FAVarray objectAtIndex:sender.tag] isEqualToString:@"YES"]) {
        
        paramURL = @{@"member_id" : [[[[NSUserDefaults standardUserDefaults] valueForKey:@"userInfo"] valueForKey:@"Member"] valueForKey:@"id"], @"list_id":course_id, @"type":type_str, @"un_fav":@"1"};
        
        msg = @"You have successfully unpinned this listing from your Favorites.";
        
    } else {
        
        paramURL = @{@"member_id" : [[[[NSUserDefaults standardUserDefaults] valueForKey:@"userInfo"] valueForKey:@"Member"] valueForKey:@"id"], @"list_id":course_id, @"type":type_str};
        
        msg = @"You have successfully pinned this listing to your Favorites.";
    }
    
    [pinTOFavConnection startConnectionWithString:@"add_favorite" HttpMethodType:Post_Type HttpBodyType:paramURL Output:^(NSDictionary *receivedData){
        
        [indicator removeFromSuperview];
        
        if([pinTOFavConnection responseCode] == 1) {
            
            NSLog(@"%@",receivedData);
            
            if([[receivedData valueForKey:@"code"] integerValue] == 1) {
                
                [sender setBackgroundImage:[UIImage imageNamed:@"favPin_yellow"] forState:UIControlStateNormal];
                
                //                if (mySearch) {
                //
                //                    [self tapUseMySearchPrefBtn:nil];
                //                } else {
                //
                //                    [self searchMyListing:search_bar.text];
                //                }
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:Alert_title  message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                [alert show];
            }
        }
    }];
}

-(CGFloat)heightCalculate3:(NSString *)calculateText :(UILabel *)lbl{
    
    UILabel *calculateText_lbl = [[UILabel alloc] init];
    
    [calculateText_lbl setLineBreakMode:NSLineBreakByClipping];
    
    [calculateText_lbl setNumberOfLines:0];
    
    [calculateText_lbl setBaselineAdjustment:UIBaselineAdjustmentAlignBaselines];
    
    NSString *text = calculateText;
    
    NSLog(@"%@",calculateText);
    
    CGSize constraint = CGSizeMake(lbl.frame.size.width - (1.0f * 2), FLT_MAX);
    
    UIFont *font;
    
    UIStoryboard *storyboard;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        storyboard = [UIStoryboard storyboardWithName:@"Main_Ipad" bundle:nil];
        
        font = [UIFont systemFontOfSize:19];
        
    } else {
        
        storyboard = [UIStoryboard storyboardWithName:@"Main_Iphone" bundle:nil];
        
        font = [UIFont systemFontOfSize:17];
        
    }
    
    CGRect frame = [text boundingRectWithSize:constraint options:NSStringDrawingUsesLineFragmentOrigin
                                   attributes:@{NSFontAttributeName:font} context:nil];
    
    CGSize size = CGSizeMake(frame.size.width, frame.size.height + 1);
    
    [calculateText_lbl setFrame:CGRectMake(10, 74, 300 ,size.height)];
    
    [calculateText_lbl sizeToFit];
    
    CGFloat height_lbl = size.height;
    
    return (height_lbl);
}


-(void)setTableHeight{
    
    CGRect frame = listing_table.frame;
    
    frame.size.height = cellHeight;
    
    listing_table.frame = frame;
    
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, listing_table.frame.origin.y + listing_table.frame.size.height);
}


@end
