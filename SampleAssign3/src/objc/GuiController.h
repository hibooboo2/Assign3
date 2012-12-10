#import <Cocoa/Cocoa.h>
#import <APPKit/NSTextField.h>
#import "Cst420Socket.h"

/**
 * Purpose: demonstrate GUI construction on Cocoa without using the
 * interface builder. This program is executable on both MacOSX and on
 * Windows running GNUstep. This GUI controller is for music descriptions.
 * Cst420 Foundations of Distributed Applications
 * see http://pooh.poly.asu.edu/Cst420
 * @author Tim Lindquist (Tim.Lindquist@asu.edu), ASU Polytechnic, Engineering
 * with credits to Casper B Hansen for structure of nibless of apps.
 * @version November 2012
 */
@class AppDelegate;
@interface GuiController : NSObject {
   AppDelegate * appDelegate;
   Socket * connection;
}
- (id) initWithDelegate: (AppDelegate*) theDelegate
                   host: (NSString*) hostName
                   port: (NSString*) portNum;
- (void) dealloc;	// Other methods to be added here.

- (void) saveLib;
- (void) restoreLib;
- (void) addMD;
- (void) removeMD;
- (void) refreshMD;
- (void) playMD;
- (void) comboBoxSelectionDidChange: (NSNotification*)notification;
- (void) debug: (NSString*) aMessage;
@end
