/**
 * Cst420Socket.m - Simple objective-c class for manipulating stream sockets.
 * Purpose: demonstrate stream sockets in Objective-C.
 * These examples are buildable on MacOSX and GNUstep on top of Windows7
 * Cst420 Founations of Distributed Applications,

 * See http://pooh.poly.asu.edu/Cst420
 * @author Tim Lindquist (Tim.Lindquist@asu.edu), ASU Polytechnic, Engineering
 * @version October 2010
 */
#import <Foundation/Foundation.h>

#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <string.h>
#include <sys/types.h>
#include <signal.h>

#if defined(WINGS)
#define _WIN32_WINNT 0x0501
#include <ws2tcpip.h>
#include <winsock2.h>
#else
#include <sys/wait.h>
#include <netdb.h>
#include <unistd.h>
#include <sys/param.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#endif /* !WINGS */
#define BACKLOG 10  /* queue size for pending connect requests */
#define MAXDATASIZE 4096 /* 4K bytes maximum with a single receive */

/**
 * Cst420Socket.h - objective-c class for manipulating stream sockets.
 * Purpose: demonstrate stream sockets in Objective-C.
 * These examples are buildable on MacOSX and GNUstep on top of Windows7
 * Cst420 Founations of Distributed Applications,
 * based on the simple server and client sockets in C by Jeez.

 * See http://pooh.poly.asu.edu/Cst420
 * @author Tim Lindquist (Tim.Lindquist@asu.edu), ASU Polytechnic, Engineering
 * @version October 2010
 */

@interface Socket : NSObject {
   BOOL connected;
   int sockfd, numbytes, rv;
   struct addrinfo hints, *servinfo, *p;
   NSString *hostName, *portNum;
   char s[INET6_ADDRSTRLEN];
}
- (id) initWithHost: (NSString*) host portNumber: (NSString*) port;
- (BOOL) connect;
- (int) sendBytes: (char*) byteMsg OfLength: (int) msgLength Index: (int) at;
- (NSString*) receiveBytes: (char*) byteMsg
                  maxBytes: (int) max
                   beginAt: (int) at;
- (BOOL) close;
@end

