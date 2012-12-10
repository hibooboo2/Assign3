#import <Cocoa/Cocoa.h>
#import <APPKit/NSTextField.h>

/**
 * Purpose: demonstrate GUI construction on Cocoa without using the
 * interface builder. This program is executable on both MacOSX and on
 * Windows running GNUstep. This GUI is for music descriptions.
 * Cst420 Foundations of Distributed Applications
 * see http://pooh.poly.asu.edu/Cst420
 * @author Tim Lindquist (Tim.Lindquist@asu.edu), ASU Polytechnic, Engineering
 * with credits to Casper B Hansen for structure of nibless of apps.
 * @version November 2012
 */
@class GuiController;
@interface AppDelegate : NSObject {
   NSWindow * window;
   NSView * view;
   NSButton *exitBut, *saveBut, *restoreBut, *addBut, *removeBut, *playBut,
            *refreshBut;
   NSTextField *titleLab, *authorLab, *albumLab;
               
   NSTextField *titleTB, *authorTB, *albumTB;
   NSComboBox *titleCB;
   NSString * host, * port;
   GuiController * guiController;
   NSTimer* aTimer;
   int fires;
}

- (id) initWithHost: (NSString*) hostName port: (NSString*) portNum;
- (void) applicationWillFinishLaunching:(NSNotification *)notification;
- (void) applicationDidFinishLaunching:(NSNotification *)notification;
- (void) accumulateFires:(NSTimer*) theTimer;
- (NSButton*) addButtonWithTitle: (NSString*) aTitle
                     target: (id) anObject
                     action: (SEL) anAction
                       rect: (NSRect) aRect;
- (NSTextField*) addLabelWithTitle:(NSString*) aTitle at: (NSRect) aRect;
- (NSTextField*) addFieldWithTitle:(NSString*) aTitle at: (NSRect) aRect;
- (void) endIt;
- (BOOL) applicationShouldTerminate:(id) sender;
- (void) dealloc;

- (NSTextField*) authorTB;
- (NSTextField*) albumTB;
- (NSComboBox*) titleCB;
@end
