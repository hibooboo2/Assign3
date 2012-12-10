#import <Cocoa/Cocoa.h>
#import <Foundation/NSString.h>
#import <Foundation/Foundation.h>
#import <APPKit/NSTextField.h>
#import "GuiController.h"
#import "AppDelegate.h"
#import "Cst420Socket.h"
#import "UploadThread.h"


// to see debug messages, change NO below to YES
#define DEBUGON YES
// buffer size for reading byte arrays to/from server
#define MAXDATASIZE 4096
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
@implementation GuiController

- (id) initWithDelegate: (AppDelegate*) theDelegate
                   host: (NSString*) hostName
                   port: (NSString*) portNum {
   // set self to result of initializing parent. If initialization succeeds
   if ( (self = [super init])) {
      // set properties and increment the reference count for its object.
      appDelegate = [theDelegate retain];
      NSTextField* albumTB = [appDelegate albumTB];
      [albumTB setStringValue:[NSString stringWithFormat:
                                  @"Probably should look for server %s:%s",
                                  [hostName UTF8String],[portNum UTF8String]]];
      NSComboBox* titCB = [appDelegate titleCB];
      [titCB setDelegate:self];
	  //Connect to Server
	  Socket* cs = [[Socket alloc] initWithHost: hostName 
												portNumber: portNum];
	  connection = [cs retain];	  
	  [connection connect];
	  NSString * objc = @"objc";
	  //Send to server that it is objective c connection
	  [connection sendBytes:[objc UTF8String] OfLength:[objc length]
                  Index:0];

	 
	  
   }
   return self;
}

- (void) dealloc {
   //decrease the reference count for all instance variable objects.
   [appDelegate release];
   [super dealloc];
}

- (void) saveLib {
   [self debug:[NSString stringWithFormat:@"asked to save.\n"]];
   NSString * saveStr = @"save^save";
 /*  char * buf = malloc(MAXDATASIZE);

   if (buf){
      int i = [cs sendBytes:[saveStr UTF8String]
                   OfLength:[saveStr length]
                      Index:0];
      NSString* retStr = [cs receiveBytes: buf maxBytes:MAXDATASIZE beginAt:0];
      [[appDelegate albumTB] setStringValue:
           [NSString stringWithFormat:@"Save result: %s",[retStr UTF8String]]];
      free(buf);
      [self debug:[NSString stringWithFormat:@"save return: %s\n",
                            [retStr UTF8String]]];
   }
*/
   [[appDelegate albumTB] setStringValue: [NSString stringWithFormat:@"Saved"]];
   [connection sendBytes:[saveStr UTF8String] OfLength:[saveStr length]
                  Index:0];
}

- (void) restoreLib {
   NSString * restoreStr = @"restore^restore";
   [self debug:[NSString stringWithFormat:@"asked to restore.\n"]];
   [[appDelegate albumTB]
                        setStringValue:[NSString stringWithFormat:@"Restored"]];
	[connection sendBytes:[restoreStr UTF8String] OfLength:[restoreStr length]
                  Index:0];
}

- (void) addMD {
   NSString * musicDescription = @"add^";
   [self debug:[NSString stringWithFormat:@"asked to add music.\n"]];
	musicDescription = [musicDescription stringByAppendingString:[[appDelegate titleCB] stringValue]];
	musicDescription = [musicDescription stringByAppendingString:@"$"];
	musicDescription = [musicDescription stringByAppendingString:[[appDelegate authorTB] stringValue]];
	musicDescription = [musicDescription stringByAppendingString:@"$"];
	musicDescription = [musicDescription stringByAppendingString:[[appDelegate albumTB] stringValue]];
	musicDescription = [musicDescription stringByAppendingString:@"#"];
	[connection sendBytes:[musicDescription UTF8String] OfLength:[musicDescription length]
                  Index:0];
	//[self refreshMD];
	// NSOpenPanel *panel;
	// NSString *path;
	// panel = [NSOpenPanel openPanel];
	// [panel setAllowsMultipleSelection: NO];
	// [panel runModalForTypes: [NSSound soundUnfilteredFileTypes]];
	// path = [[panel filenames] objectAtIndex: 0];
}

- (void) removeMD {
   NSString * musicDescription = @"remove^";
   [self debug:[NSString stringWithFormat:@"asked to add music.\n"]];
	musicDescription = [musicDescription stringByAppendingString:[[appDelegate titleCB] stringValue]];
	[connection sendBytes:[musicDescription UTF8String] OfLength:[musicDescription length]
                  Index:0];
	//[self refreshMD];
}

- (void) refreshMD {
   NSString * refreshMusicStr = @"refresh^refresh";
   [self debug:[NSString stringWithFormat:@"asked to refresh\n"]];
   [[appDelegate titleCB] removeAllItems];
   [connection sendBytes:[refreshMusicStr UTF8String] OfLength:[refreshMusicStr length]
                  Index:0];
	char * buf = malloc(MAXDATASIZE);
	int end= [[connection receiveBytes: buf maxBytes:MAXDATASIZE beginAt:0] intValue];
	int i = 0;
	 for ( i ; i < end; i++){
		[[appDelegate titleCB] addItemWithObjectValue: [connection receiveBytes: buf 
																	maxBytes:MAXDATASIZE beginAt:0]];
		}
	[[appDelegate titleCB] reloadData];
}

- (void) playMD {
   NSString * playMusicStr = @"play^";
   [self debug:[NSString stringWithFormat:@"asked to play:\n"]];
   [[appDelegate albumTB]
                       setStringValue:[NSString stringWithFormat:@"Played it"]];
}

- (void) comboBoxSelectionDidChange: (NSNotification*)notification {
	char * buf = malloc(MAXDATASIZE);
	NSString * command = @"getsong^";
	command = [command stringByAppendingString: [[appDelegate titleCB] objectValueOfSelectedItem]];
   [connection sendBytes:[command UTF8String] OfLength:[command length] Index:0];
	NSString *recieved = [connection receiveBytes: buf maxBytes:MAXDATASIZE beginAt:0];
	NSArray *chunks = [recieved componentsSeparatedByString: @"$"];
<<<<<<< HEAD:MY Assgn 3/SampleAssign3/src/objc/GuiController.m
	 [self debug:[NSString stringWithFormat:@"Recieved\n"]];
	  [self debug:[NSString stringWithFormat:[chunks objectAtIndex:0]]];
=======
>>>>>>> Fixed Display of songs:SampleAssign3/src/objc/GuiController.m
	[[appDelegate albumTB] setStringValue:[chunks objectAtIndex:2]];
	[[appDelegate authorTB] setStringValue:[chunks objectAtIndex:1]];
	[[appDelegate titleCB] setStringValue:[chunks objectAtIndex:0]];
	[[appDelegate titleCB] reloadData];
	// POPULATE FIELDS IS CURRENT
}

- (void) debug: (NSString*) aMessage{
   if(DEBUGON){
      NSString * fileName = @"C:\\log.txt";
      NSFileHandle* fh = [NSFileHandle fileHandleForWritingAtPath: fileName];
      [fh seekToEndOfFile];
      [fh writeData: [aMessage dataUsingEncoding:NSUTF8StringEncoding]];
      [fh closeFile];
       //printf("debug: %s\n", [aMessage UTF8String]);
   }
}

@end
