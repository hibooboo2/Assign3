#import "AppDelegate.h"
#import <AppKit/NSButton.h>
#import "GuiController.h"

/**
 * Purpose: demonstrate GUI construction on Cocoa without using the
 * interface builder. This program is executable on both MacOSX and on
 * Windows running GNUstep.  This GUI is for music descriptions.
 * Cst420 Foundations of Distributed Applications
 * see http://pooh.poly.asu.edu/Cst420
 * @author Tim Lindquist (Tim.Lindquist@asu.edu), ASU Polytechnic, Engineering
 * with credits to Casper B Hansen for structure of nibless of apps.
 * @version November 2012
 */
@implementation AppDelegate

- (id) initWithHost: (NSString*) hostName port: (NSString*) portNum {
   if ( (self = [super init]) ) {
      fires = 0;
      host = [hostName retain];
      port = [portNum retain];
      // create a reference rect
      // set this window at position 100,150 (x,y) from lower left
      // with size 560,300 (x,y)
      NSRect contentSize = NSMakeRect(100.0f, 150.0f, 650.0f, 220.0f);
      // allocate window
      window = [[NSWindow alloc] initWithContentRect:contentSize
                                           styleMask:NSTitledWindowMask
                                             backing:NSBackingStoreBuffered
                                               defer:YES];
      [window setTitle:@"Dr. Lindquist's Assign3 Music Client"];
      // allocate view
      view = [[NSView alloc] initWithFrame:contentSize];
      [window setContentView:view];

      //Add the buttons across the bottom of the view.
      // place the button at 20,20 (x,y) in window with width 75 and height 30
      exitBut = [[self addButtonWithTitle:@"Exit" target: self
                                   action:@selector(endIt)
                                     rect:NSMakeRect(20,20,75,30)] retain];
      saveBut = [[self addButtonWithTitle:@"Save" target:guiController
                                       action:@selector(saveLib)
                                         rect:NSMakeRect(110,20,75,30)] retain];
      restoreBut = [[self addButtonWithTitle:@"Restore" target: guiController
                                       action:@selector(restoreLib)
                                         rect:NSMakeRect(200,20,75,30)] retain];
      addBut = [[self addButtonWithTitle:@"Add" target:guiController
                                       action:@selector(addMD)
                                         rect:NSMakeRect(290,20,75,30)] retain];
      removeBut = [[self addButtonWithTitle:@"Remove" target:guiController
                                     action:@selector(removeMD)
                                       rect:NSMakeRect(380,20,75,30)] retain];
      playBut = [[self addButtonWithTitle:@"Play" target:guiController
                                   action:@selector(playMD)
                                     rect:NSMakeRect(470,20,75,30)] retain];
      refreshBut = [[self addButtonWithTitle:@"Refresh" target:guiController
                                   action:@selector(refreshMD)
                                     rect:NSMakeRect(560,20,75,30)] retain];

      // create the labels, text fields and combo boxes for manipulating music
      titleLab = [self addLabelWithTitle:@"Title" at:NSMakeRect(20,170,30,20)];
      [titleLab retain];
      titleCB = [[NSComboBox alloc] initWithFrame: NSMakeRect(60,170,540,25)];
      [titleCB retain];
      [titleCB removeAllItems];
      [[window contentView] addSubview: titleCB];
      authorLab = [self addLabelWithTitle:@"Author"
                                       at:NSMakeRect(20,120,70,20)];
      [authorLab retain];
      authorTB = [self addFieldWithTitle:@"anAuthor"
                                       at:NSMakeRect(75,120,535,20)];
      [authorTB retain];
      albumLab = [self addLabelWithTitle:@"Album" at:NSMakeRect(20,70,50,20)];
      [albumLab retain];
      albumTB = [self addFieldWithTitle:@"album"
                                   at:NSMakeRect(70,70,540,20)];
      [albumTB retain];

   }
   return self;
}

- (void) applicationWillFinishLaunching:(NSNotification *)notification {
   // attach the view to the window
   [window setContentView:view];
}

- (void) applicationDidFinishLaunching:(NSNotification *)notification {
   // note that printf's or NSLogs do not display on the console. Write to GUI.
   // [urlTB setStringValue:@"In application did finish launching."];
   // make the window visible.
   [window makeKeyAndOrderFront:self];
   // schedule a timer with the run loop that will call 
   NSRunLoop * myRunLoop = [NSRunLoop currentRunLoop];
   aTimer = [[NSTimer scheduledTimerWithTimeInterval:2.0
                                    target:self
                                  selector:@selector(accumulateFires:)
                                  userInfo:nil
                                   repeats:YES] retain];
   guiController = [[GuiController alloc] initWithDelegate: self
                                                      host: host
                                                      port: port];
   [saveBut setAction: @selector(saveLib)];
   [saveBut setTarget: guiController];
   [restoreBut setAction: @selector(restoreLib)];
   [restoreBut setTarget: guiController];
   [addBut setAction: @selector(addMD)];
   [addBut setTarget: guiController];
   [removeBut setAction: @selector(removeMD)];
   [removeBut setTarget: guiController];
   [refreshBut setAction: @selector(refreshMD)];
   [refreshBut setTarget: guiController];
   [playBut setAction: @selector(playMD)];
   [playBut setTarget: guiController];
}

- (void) accumulateFires:(NSTimer*) theTimer{
   fires = fires+1;
   //[commentTB setStringValue:[NSString
   //                       stringWithFormat:@"Timer fired %d times.",fires]];
}

- (NSButton*) addButtonWithTitle: (NSString*)aTitle
                     target: (id) anObject
                     action: (SEL) anAction
                       rect: (NSRect) aRect {
      NSButton *button = [[[NSButton alloc] initWithFrame:aRect ] autorelease];
      [button setTitle:aTitle];
      [button setAction:anAction];
      [button setTarget: anObject];
      [button setButtonType:NSMomentaryPushButton];
      [button setBezelStyle:NSTexturedSquareBezelStyle];
      [[window contentView] addSubview: button];
      return button;
}

- (NSTextField*) addLabelWithTitle:(NSString*) aTitle at: (NSRect) aRect {
   NSTextField* label =[[[NSTextField alloc] initWithFrame: aRect] autorelease];
   [label setSelectable: NO];
   [label setBezeled: NO];
   [label setDrawsBackground: NO];
   [label setStringValue: aTitle];
   [[window contentView] addSubview: label];
   return label;
}

- (NSTextField*) addFieldWithTitle:(NSString*) aTitle at: (NSRect) aRect {
   NSTextField* label =[[[NSTextField alloc] initWithFrame: aRect] autorelease];
   [label setSelectable: YES];
   [label setEditable: YES];
   [label setBezeled: YES];
   [label setDrawsBackground: YES];
   [label setStringValue: aTitle];
   [[window contentView] addSubview: label];
   return label;
}

- (void) endIt {
   [NSApp terminate:self];
   }

- (NSTextField*) authorTB {
   return authorTB;
}

- (NSTextField*) albumTB {
   return albumTB;
}

- (NSComboBox*) titleCB {
   return titleCB;
}

- (BOOL) applicationShouldTerminate:(id) sender {
   return YES;
}

- (void)dealloc {
   // don’t forget to release allocated objects!
   [guiController release];
   [host release];
   [port release];
   [titleLab release];
   [exitBut release];
   [saveBut release];
   [restoreBut release];
   [addBut release];
   [removeBut release];
   [playBut release];
   [refreshBut release];
   [view release];
   [window release];
   [super dealloc];
}

@end
