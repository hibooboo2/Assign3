#import "UploadThread.h"

/**
 * Purpose: demonstrate Objective-C threads with shared data.
 * Cst420 Foundations of Distributed Applications
 * see http://pooh.poly.asu.edu/Cst420
 * @author Tim Lindquist (Tim.Lindquist@asu.edu), ASU Polytechnic, Engineering
 * @version November 2010
 */
@implementation AThreadClass

- (id) initWithId:(int)anId {
   if ( (self = [super init]) ) {
      iden = anId;
   }
   return self;
}

- (int) iden {
   return iden;
}

- (void) main {
   NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
   printf("Started thread # %d\n",iden);
   [pool release];
}

- (void) print {
   printf("Print: Thread with ID %d.\n", iden);
}

- (void)dealloc {
   // release retained, allocated, and copied objects.
   [super dealloc];
}

@end

