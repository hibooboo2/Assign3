#import <Foundation/Foundation.h>

/**
 * Purpose: demonstrate Objective-C threads with shared data.
 * Cst420 Foundations of Distributed Applications
 * see http://pooh.poly.asu.edu/Cst420
 * @author Tim Lindquist (Tim.Lindquist@asu.edu), ASU Polytechnic, Engineering
 * @version November 2010
 */
@interface AThreadClass : NSThread {
   int iden;
}

- (id) initWithId: (int) anId;
- (int) iden;
- (void) main;
- (void) print;
- (void) dealloc;

@end

