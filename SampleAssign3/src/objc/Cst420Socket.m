#import "Cst420Socket.h"
#define PORT "4444"

/**
 * Cst420Socket.m - objective-c class for manipulating stream sockets.
 * Purpose: demonstrate stream sockets in Objective-C.
 * These examples are buildable on MacOSX and GNUstep on top of Windows7
 * Cst420 Founations of Distributed Applications,
 * based on the simple server and client sockets in C by Jeez.

 * See http://pooh.poly.asu.edu/Cst420
 * @author Tim Lindquist (Tim.Lindquist@asu.edu), ASU Polytechnic, Engineering
 * @version October 2010
 */

// get sockaddr, IPv4 or IPv6:
void *get_in_addr(struct sockaddr *sa){
    if (sa->sa_family == AF_INET) {
        return &(((struct sockaddr_in*)sa)->sin_addr);
    }
    return &(((struct sockaddr_in6*)sa)->sin6_addr);
}

@implementation Socket
- (id) initWithHost: (NSString*) host portNumber: (NSString*) port {
   self = [super init];
   hostName = host;
   [hostName retain];
   portNum = port;
   [portNum retain];
   return self;
}

- (BOOL) connect {
   connected = YES;
   memset(&hints, 0, sizeof hints);
   hints.ai_family = AF_UNSPEC;
   hints.ai_socktype = SOCK_STREAM;
   if ((rv = getaddrinfo([hostName UTF8String], [portNum UTF8String],
                         &hints, &servinfo)) != 0) {
      fprintf(stderr, "client error getting host address: %s\n",
              gai_strerror(rv));
      connected = NO;
   }
   // loop through all the results and connect to the first we can
   for(p = servinfo; p != NULL; p = p->ai_next) {
      if ((sockfd = socket(p->ai_family,p->ai_socktype,p->ai_protocol)) == -1){
         perror("client error creating socket");
         connected = NO;
         continue;
      }
      int callret = connect(sockfd, p->ai_addr, p->ai_addrlen);
      if (callret == -1) {
#if defined(WINGS)
         closesocket(sockfd);
#else
         close(sockfd);
#endif
#if defined(WINGS)
         //printf("client failed to connect.\n");
#else
         inet_ntop(p->ai_family, get_in_addr((struct sockaddr *)p->ai_addr),
                   s, sizeof s);
         printf("client failed to connect to %s\n", s);
#endif
         //perror("client error connecting");
         connected = NO;
         continue;
      }
      break;
   }
   if (p == NULL) {
      printf("client failed to connect\n");
      connected = NO;
   }else{
#if defined(WINGS)
      //printf("client connected\n");
#else
      inet_ntop(p->ai_family, get_in_addr((struct sockaddr *)p->ai_addr),
                s, sizeof s);
      printf("client connected to %s\n", s);
#endif
      connected = YES;
   }
   return connected;
}

- (int) sendBytes: (char*) byteMsg OfLength: (int) msgLength Index: (int) at{
   int ret = send(sockfd, byteMsg, msgLength, 0);
   if(ret == -1){
      NSLog(@"client error sending bytes");
   }
   return ret;
}

- (NSString*) receiveBytes: (char*) byteMsg
                  maxBytes: (int) max
                   beginAt: (int) at {
   int ret = recv(sockfd, byteMsg, max-1, at);
   if(ret == -1){
      NSLog(@"client error receiving bytes");
   }
   byteMsg[ret+at] = '\0';
   NSString * retStr = [NSString stringWithUTF8String: byteMsg];
   return retStr;
}

- (BOOL) close{
   connected = NO;
   return YES;
}

- (void) dealloc {
   [hostName release];
   [portNum release];
   [super dealloc];
}

@end

