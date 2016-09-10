#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
 
#include <cutils/log.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <fcntl.h>
#include <pthread.h>
#include <math.h>

#include "properties.h"

//declare variables
int r;
int g;
int b;
int on;
int off;

//declare constants
char const*const RED_LED_FILE
        = "/sys/class/leds/red/brightness";

char const*const GREEN_LED_FILE
        = "/sys/class/leds/green/brightness";

char const*const BLUE_LED_FILE
        = "/sys/class/leds/blue/brightness";

//fork to a daemon process so that lights.msm8909.so can finish its thread while leds continue to blink
int daemon_int(void)
{
    pid_t pid;
    if ((pid = fork()) < 0){
        return (-1) ;
    }else if (pid != 0){
       exit(0); /* The parent process exits */
       setsid();   /* become session leader */
       chdir("/"); /* change the working dir */
       umask(0);   /* clear out the file mode creation mask */
       return(0);
    }
    return(0);
}

//function to write integers to file
static int
write_int(char const* path, int value)
{
    int fd;
    fd = open(path, O_RDWR);
    if (fd >= 0) {
        char buffer[20];
        int bytes = snprintf(buffer, sizeof(buffer), "%d\n", value);
        ssize_t amt = write(fd, buffer, (size_t)bytes);
        close(fd);
        return 0;
    }else{
	      return 1;
}
        
}

//function that runs it all
static int
set_lights(int red, int green, int blue, int onMS, int offMS)
{
    int onUS, offUS;  
    property_set("lights.notification", "on");
    //convert milliseconds to microseconds as required by usleep
    onUS = (onMS * 1000);
    offUS = (offMS * 1000);
    while (property_get_bool("lights.notification", 0) == 1){
        //turn leds on if color chosen
        write_int(RED_LED_FILE, red);
        write_int(GREEN_LED_FILE, green);
        write_int(BLUE_LED_FILE, blue);
        //wait for onUS microseconds before turning leds off
        usleep(onUS);
        //turn off all leds
        write_int(RED_LED_FILE, 0);
        write_int(GREEN_LED_FILE, 0);
        write_int(BLUE_LED_FILE, 0);
        //wait for offUS microseconds before restarting loop
        usleep(offUS);
    }
    exit(0);
    return 0;
}

//main called function
int main(int argc, char *argv[])
{
    //check the correct amount of arguments are passed
    if (argc != 6){     
    printf( "lightsd needs 5 integer arguments passed <red> <green> <blue> <onMS> <offMs>.\n" );
    exit(1);
}
    daemon_int();
    //convert execution arguments to integers for further processing
    r = atoi(argv[1]);
    g = atoi(argv[2]);
    b = atoi(argv[3]);
    on = atoi(argv[4]);
    off = atoi(argv[5]);
    system("am startservice com.destructosphere.ledwakelock/.wakelock");
    set_lights(r, g, b, on, off);
    return 0;
}
