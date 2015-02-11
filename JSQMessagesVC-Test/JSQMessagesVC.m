//
//  JSQMessagesVC.m
//  JSQMessagesVC-Test
//
//  Created by Jian Yao Ang on 2/6/15.
//  Copyright (c) 2015 Jian Yao Ang. All rights reserved.
//

#import "JSQMessagesVC.h"
#import <JSQMessages.h>
#import <JSQMessageMediaData.h>
#import "PictureViewController.h"
#import "WebViewViewController.h"

@interface JSQMessagesVC () <JSQMessagesCollectionViewCellDelegate, JSQMessagesCollectionViewDataSource, JSQMessagesCollectionViewDelegateFlowLayout, UIActionSheetDelegate, UIImagePickerControllerDelegate, JSQMessageMediaData>
@property (strong, nonatomic) NSMutableArray *messagesMutableArray;
@property (strong, nonatomic) JSQMessage *message;
@property (strong, nonatomic) JSQMessagesBubbleImage *outgoingBubbleImage;
@property (strong, nonatomic) JSQMessagesBubbleImage *incomingBubbleImage;
@property (strong, nonatomic) JSQMessagesAvatarImage *avatarImage;
@property (strong, nonatomic) JSQPhotoMediaItem *photoMediaItem;
@property (strong, nonatomic) JSQMediaItem *mediaItem;
@property (strong, nonatomic) UIImage *resizedImageOfImageSelectedByUser;

@property (strong, nonatomic) NSMutableArray *theMutableArrayOfMutableArray;

@property NSInteger *indexPath;
@property NSUInteger *theIndexPath;
@property (strong, nonatomic) NSIndexPath *thatIndexPath;

@property (strong, nonatomic) UIImagePickerController *imagePicker;
@property (strong, nonatomic) NSURL *theURL;
@end

@implementation JSQMessagesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.theMutableArrayOfMutableArray = [NSMutableArray new];

    //must set both senderId and displayName
    self.senderDisplayName = @"Jay";
    self.senderId = @"123";
    
    //the bubble chat background
    JSQMessagesBubbleImageFactory *bubbleFactory = [[JSQMessagesBubbleImageFactory alloc] init];
    self.outgoingBubbleImage = [bubbleFactory outgoingMessagesBubbleImageWithColor:[UIColor lightGrayColor]];
    self.incomingBubbleImage = [bubbleFactory incomingMessagesBubbleImageWithColor:[UIColor greenColor]];
    
    self.showLoadEarlierMessagesHeader = NO;
    
    //creating avatar images
    self.avatarImage = [JSQMessagesAvatarImageFactory avatarImageWithImage:[UIImage imageNamed:@"jlaw"] diameter:30];
    self.collectionView.collectionViewLayout.incomingAvatarViewSize = CGSizeMake(50, 50);
    self.collectionView.collectionViewLayout.outgoingAvatarViewSize = CGSizeMake(50, 50);
    
    self.messagesMutableArray = [NSMutableArray new];
    
    JSQMessage *jsqmessage1 = [[JSQMessage alloc] initWithSenderId:self.senderId senderDisplayName:self.senderDisplayName date:[NSDate date] text:@"The new message is here!!!!!"];
    JSQMessage *jsqmessage2 = [[JSQMessage alloc] initWithSenderId:@"456" senderDisplayName:@"Javan" date:[NSDate distantPast] text:@"This messaging UI is pretty sleeeeeek"];
    JSQMessage *jsqmessage3 = [[JSQMessage alloc] initWithSenderId:@"789" senderDisplayName:@"Javan" date:[NSDate distantFuture] text:@"Yessh!! it is!!!"];
    
    NSURL *url = [NSURL URLWithString:@"http://lunar.thegamez.net/fishing/beach-fishing-rod-holder/beach-chair-fishing-rod-holder-product-features-650x519-small.jpg"];
    NSString *urlString = [url absoluteString];
    JSQMessage *theMessage4 = [[JSQMessage alloc] initWithSenderId:@"456" senderDisplayName:@"Javan" date:[NSDate distantFuture] text:@"Hello There!!"];
    JSQMessage *theMessage5 = [[JSQMessage alloc] initWithSenderId:@"456" senderDisplayName:@"Javan" date:[NSDate distantFuture] text:[NSString stringWithFormat:@"%@", urlString]];
    JSQMessage *jsqmessage4 = [[JSQMessage alloc] initWithSenderId:@"456" senderDisplayName:@"Javan" date:[NSDate distantFuture] text:[NSString stringWithFormat:@"%@ \r %@", theMessage4.text, theMessage5.text]];
    
//    NSData *theURLData = [NSData dataWithContentsOfURL:url];
//    UIImage *theImage = [UIImage imageWithData:theURLData];
//    JSQPhotoMediaItem *thePhotoMediaItem = [[JSQPhotoMediaItem alloc] initWithImage:theImage];
//    UIImage *thatImage = thePhotoMediaItem.image;
//    NSData *thatImageData = UIImagePNGRepresentation(thatImage);
//    NSString *theImageDataString = [[NSString alloc] initWithData:thatImageData encoding:NSDataBase64Encoding64CharacterLineLength];
    
//    NSLog(@"thatImage %@", thatImage);
//    NSLog(@"thatImageData %@", thatImageData);
//    JSQMessage *thePhotoMediaItemMessage = [[JSQMessage alloc] initWithSenderId:@"456" senderDisplayName:@"Javan" date:[NSDate distantFuture] media:thePhotoMediaItem];
    
//    JSQMessage *jsqmessage4 = [[JSQMessage alloc] initWithSenderId:@"456" senderDisplayName:@"Javan" date:[NSDate distantFuture] text:[NSString stringWithFormat:@"Let's go!! %@", theImageDataString]];
    
    self.messagesMutableArray = [[NSMutableArray alloc] initWithObjects:jsqmessage1,jsqmessage2, jsqmessage3,jsqmessage4,nil];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //enable/disable springiness must be done in viewDidAppear. Default is no
    self.collectionView.collectionViewLayout.springinessEnabled = YES;
}

#pragma mark - JSQMessagesCollectionViewDataSource
-(id<JSQMessageData>)collectionView:(JSQMessagesCollectionView *)collectionView messageDataForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.messagesMutableArray objectAtIndex:indexPath.item];
}

-(id<JSQMessageBubbleImageDataSource>)collectionView:(JSQMessagesCollectionView *)collectionView messageBubbleImageDataForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //if this is nil, no bubbles. If so, set background color to the collection view cell's textView
    //otherwise, return the created bubble image data objects
    
    JSQMessage *message = [self.messagesMutableArray objectAtIndex:indexPath.item];
    
    if ([message.senderDisplayName isEqualToString:self.senderDisplayName])
    {
        return self.outgoingBubbleImage;
    }
    else
    {
        return self.incomingBubbleImage;
    }

}

-(id<JSQMessageAvatarImageDataSource>)collectionView:(JSQMessagesCollectionView *)collectionView avatarImageDataForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //return nil if don't want any avatar
    //if nil is return, set incoming/outgoingAvatarViewSize = CGSizeZero
    
    JSQMessage *message = [self.messagesMutableArray objectAtIndex:indexPath.item];
    
    if ([message.senderDisplayName isEqualToString:self.senderDisplayName])
    {
        return self.avatarImage;
    }
    else
    {
        JSQMessagesAvatarImage *agentImage = [JSQMessagesAvatarImageFactory avatarImageWithImage:[UIImage imageNamed:@"ink"] diameter:30];
        
        return agentImage;
    }
}


-(NSAttributedString*)collectionView:(JSQMessagesCollectionView *)collectionView attributedTextForCellTopLabelAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.item % 3 == 0)
    {
        JSQMessage *message = [self.messagesMutableArray objectAtIndex:indexPath.item];
        return [[JSQMessagesTimestampFormatter sharedFormatter] attributedTimestampForDate:message.date];
    }
    return nil;
}

-(NSAttributedString*)collectionView:(JSQMessagesCollectionView *)collectionView attributedTextForMessageBubbleTopLabelAtIndexPath:(NSIndexPath *)indexPath
{
    JSQMessage *message = [self.messagesMutableArray objectAtIndex:indexPath.item];
    
    if ([message.senderId isEqualToString:self.senderId])
    {
        return nil;
    }
    
    if (indexPath.item - 1 > 0)
    {
        JSQMessage *previousMessage = [self.messagesMutableArray objectAtIndex:indexPath.item-1];
        if ([[previousMessage senderId] isEqualToString:message.senderId])
        {
            return nil;
        }
    }
    
    //don't specify attributes to use defaults
    return [[NSAttributedString alloc] initWithString:message.senderDisplayName];
}

-(NSAttributedString*)collectionView:(JSQMessagesCollectionView *)collectionView attributedTextForCellBottomLabelAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

#pragma mark - UICollectionView DataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.messagesMutableArray.count;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    //override point for customizing cells
    JSQMessagesCollectionViewCell *cell = (JSQMessagesCollectionViewCell*)[super collectionView:collectionView cellForItemAtIndexPath:indexPath];
    
    //configure ALMOST ANYTHING on the cell - text color, label ....
    //don't set cell.textView.font BUT in viewDidLoad, self.collectionView.collectionViewLayout.messageBubbleFont to appropriate font
    JSQMessage *message = [self.messagesMutableArray objectAtIndex:indexPath.item];
    
    if (!message.isMediaMessage)
    {
        if ([message.senderId isEqualToString:self.senderId])
        {
            cell.textView.textColor = [UIColor blackColor];
        }
        else
        {
            cell.textView.textColor = [UIColor whiteColor];
        }
        
        cell.textView.linkTextAttributes = @{NSForegroundColorAttributeName: cell.textView.textColor,
                                             NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle | NSUnderlinePatternSolid)};
    }
    return cell;
}

#pragma mark - JSQMessages collection view flow layout delegate
-(CGFloat)collectionView:(JSQMessagesCollectionView *)collectionView layout:(JSQMessagesCollectionViewFlowLayout *)collectionViewLayout heightForCellTopLabelAtIndexPath:(NSIndexPath *)indexPath
{
    //each label in a cell has a height delegate method that correspond to its text dataSource method
    
    //the logic should be the same as "attributedTextForCellTopLabelAtIndexPath"
    
    if (indexPath.row % 3 == 0)
    {
        return 30.0f;
    }
    return 0.0f;
}

-(CGFloat)collectionView:(JSQMessagesCollectionView *)collectionView layout:(JSQMessagesCollectionViewFlowLayout *)collectionViewLayout heightForMessageBubbleTopLabelAtIndexPath:(NSIndexPath *)indexPath
{
    JSQMessage *currentMessage = [self.messagesMutableArray objectAtIndex:indexPath.item];
    
    if ([[currentMessage senderId] isEqualToString:self.senderId])
    {
        return 0.0f;
    }
    
    if (indexPath.item - 1 > 0)
    {
        JSQMessage *previousMessage = [self.messagesMutableArray objectAtIndex:indexPath.item - 1];
        
        if ([[previousMessage senderId] isEqualToString:[currentMessage senderId]])
        {
            return 0.0f;
        }
    }
    return 30.0f;
}

-(CGFloat)collectionView:(JSQMessagesCollectionView *)collectionView layout:(JSQMessagesCollectionViewFlowLayout *)collectionViewLayout heightForCellBottomLabelAtIndexPath:(NSIndexPath *)indexPath
{
    return 0.0f;
}

#pragma mark - JSQMessagesVC method override
-(void)didPressSendButton:(UIButton *)button withMessageText:(NSString *)text senderId:(NSString *)senderId senderDisplayName:(NSString *)senderDisplayName date:(NSDate *)date
{
    //this method should do at least ONE of the following:
    //1. play sound, 2. Add new id<JSQMessageData> object to your data source,  3. call finishSendingMessage
    
    JSQMessage *message = [[JSQMessage alloc] initWithSenderId:senderId senderDisplayName:senderDisplayName date:date text:text];
    [self.messagesMutableArray addObject:message];
    [self finishSendingMessageAnimated:YES];
    
}

-(void)didPressAccessoryButton:(UIButton *)sender
{
    NSLog(@"didPressAccessoryButton was pressed!");
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Messaging Test" message:@"How would you like to upload  your docs?" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *uploadImage = [UIAlertAction actionWithTitle:@"Upload Image" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"upload image : %@", action);
        
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
        {
            self.imagePicker = [UIImagePickerController new];
            self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            self.imagePicker.delegate = (id)self;
            self.imagePicker.navigationBar.tintColor = [UIColor blackColor];
            
            self.imagePicker.modalPresentationStyle = UIModalPresentationFullScreen;
            self.imagePicker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
            [self presentViewController:self.imagePicker animated:YES completion:nil];
        }
        else
        {
            NSLog(@"No photo library found");
        }
    }];
    
    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"camera %@", action);
        
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            self.imagePicker = [UIImagePickerController new];
            self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            self.imagePicker.delegate = (id)self;
            self.imagePicker.navigationBar.tintColor = [UIColor blackColor];
            self.imagePicker.showsCameraControls = YES;
            
            self.imagePicker.modalPresentationStyle = UIModalPresentationFullScreen;
            self.imagePicker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
            [self presentViewController:self.imagePicker animated:YES completion:nil];
        }
        else
        {
            NSLog(@"No camera!!!");
        }
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"cancel picture: %@", action);
        
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [alertController addAction:uploadImage];
    [alertController addAction:camera];
    [alertController addAction:cancel];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - uiimagepickercontroller delegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        UIImage *imageSelectedByUser = [info valueForKey:UIImagePickerControllerOriginalImage];
        CGRect rect = CGRectMake(0, 0, 400, 400);
        
        UIGraphicsBeginImageContext(rect.size);
        [imageSelectedByUser drawInRect:rect];
        self.resizedImageOfImageSelectedByUser = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        dispatch_async(dispatch_get_main_queue(), ^{
            JSQPhotoMediaItem *photoItem = [[JSQPhotoMediaItem alloc] initWithImage:self.resizedImageOfImageSelectedByUser];
            JSQMessage *photoMessage = [JSQMessage messageWithSenderId:self.senderId displayName:self.senderDisplayName media:photoItem];
            [self.messagesMutableArray addObject:photoMessage];
            [self.theMutableArrayOfMutableArray addObject:self.resizedImageOfImageSelectedByUser];
//            [self.messagesMutableArray addObject:self.resizedImageOfImageSelectedByUser];
            [self finishSendingMessageAnimated:YES];
            [self.collectionView reloadData];
        
        });
    });
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self.imagePicker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Responding to collection view tap events
- (void)collectionView:(JSQMessagesCollectionView *)collectionView
                header:(JSQMessagesLoadEarlierHeaderView *)headerView didTapLoadEarlierMessagesButton:(UIButton *)sender
{
    NSLog(@"Load earlier messages!");
}


-(void)collectionView:(JSQMessagesCollectionView *)collectionView didTapAvatarImageView:(UIImageView *)avatarImageView atIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"avatar image was tapped");
}

-(void)collectionView:(JSQMessagesCollectionView *)collectionView didTapCellAtIndexPath:(NSIndexPath *)indexPath touchLocation:(CGPoint)touchLocation
{
    NSLog(@"location was touched!");
    
    [self.inputToolbar.contentView.textView resignFirstResponder];

}

-(void)collectionView:(JSQMessagesCollectionView *)collectionView didTapMessageBubbleAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"the bubble was touched!! ");
    
    JSQMessage *message = [self.messagesMutableArray objectAtIndex:indexPath.item];
    
    if (message.isMediaMessage == FALSE)
    {
        NSLog(@"message.isMediaMessage it is!");
        [self whereIsTheURL:message.text];
        [self performSegueWithIdentifier:@"ShowWebView" sender:nil];
        
    }
    else if ([message.media isKindOfClass:[JSQPhotoMediaItem class]])
    {
        NSLog(@"message.media %@", message.media);
        self.thatIndexPath = indexPath;
        [self performSegueWithIdentifier:@"ToPictureVC" sender:nil];
    }
}

-(void)whereIsTheURL:(NSString*)message
{
    NSString *theString = message;
    NSDataDetector *linkDetector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink error:nil];
    NSArray *matches = [linkDetector matchesInString:theString options:0 range:NSMakeRange(0, [theString length])];
    
    for (NSTextCheckingResult *match in matches)
    {
        NSURL *url = [match URL];
        NSLog(@"the url is : %@", url);
        self.theURL = url;
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ToPictureVC"])
    {
        
        JSQMessage *message = [self.messagesMutableArray objectAtIndex:self.thatIndexPath.row];
        
        JSQPhotoMediaItem *photoMediaItem = (JSQPhotoMediaItem*)message.media;
        
        PictureViewController *pvc = segue.destinationViewController;
        pvc.photoMediaItem = photoMediaItem;
        
        NSLog(@"pvc.theImage %@", pvc.theImage);

    }
    else if ([segue.identifier isEqualToString:@"ShowWebView"])
    {
        JSQMessage *message = [self.messagesMutableArray objectAtIndex:self.thatIndexPath.row];
        [self whereIsTheURL:message.text];
        
        WebViewViewController *wvvc = segue.destinationViewController;
        wvvc.url = self.theURL;
        
    }
}

@end
