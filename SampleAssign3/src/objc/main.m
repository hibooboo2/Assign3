#import <Cocoa/Cocoa.h>
#import "AppDelegate.h"

/**
 * Purpose: demonstrate GUI construction on Cocoa without using the
 * interface builder. This program is executable on both MacOSX and on
 * Windows running GNUstep. This application is for Music Descriptions
 * Cst420 Foundations of Distributed Applications
 * see http://pooh.poly.asu.edu/Cst420
 * @author Tim Lindquist (Tim.Lindquist@asu.edu), ASU Polytechnic, Engineering
 * with credits to Casper B Hansen for structure of nibless of apps.
 * @version November 2012
 */
int main(int argc, char *argv[]) {
    // create an autorelease pool
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    // make sure the application singleton has been instantiated
    NSApplication * application = [NSApplication sharedApplication];
    // instantiate our application delegate
    NSString* hostName = @"localhost";
    NSString* portNum = @"2020";
    if (argc >= 3){
       hostName = [NSString stringWithUTF8String: argv[1]];
       portNum = [NSString stringWithUTF8String: argv[2]];
    }
    AppDelegate * applicationDelegate =
       [[[AppDelegate alloc] initWithHost: hostName
                                     port: portNum ] autorelease];
    // assign our delegate to the NSApplication
    [application setDelegate:applicationDelegate];
    // call the run method of our application
    [application run];
    // drain the autorelease pool
    [pool drain];
    // execution never gets here ..
    return 0;
}
