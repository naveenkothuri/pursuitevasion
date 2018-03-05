/* License:
 *
 * The contents of this file are subject to the Mozilla Public License
 * Version 1.1 (the "License"); you may not use this file except in
 * compliance with the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS"
 * basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the
 * License for the specific language governing rights and limitations
 * under the License.
 *
 * The Initial Developer of this code is John Hansen.
 * Portions created by John Hansen are Copyright (C) 2009-2013 John Hansen.
 * All Rights Reserved.
 *
 * ----------------------------------------------------------------------------
 *
 * \author John Hansen (bricxcc_at_comcast.net)
 * \date 2013-07-10
 * \version 1
 */

/* 2014-01-01 Modified by The MathWorks, Inc. */

/**************************************
 *     LEGO EV3 LCD Driver            *
 **************************************/
#include "driver_ev3.h"
#include "ev3_constants.h"

#include <stdio.h>
#include <fcntl.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <signal.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <stdbool.h>
#include <limits.h>
#include <errno.h>
#include <libgen.h>
#include <sys/time.h>


typedef enum {
    ti10ms,
    ti50ms,
    ti100ms,
    ti250ms,
    ti500ms,
    ti1sec
} TimerInterval;

typedef void (*TimerCallback)(int sig);

static unsigned long long msTimers[NUM_MS_TIMERS];
static unsigned long long usTimers[NUM_US_TIMERS];
static unsigned long long csTimers[NUM_CS_TIMERS];

#define TIMER_INTERVAL 10000 // 10 ms
#define TIMER_10MS     1
#define TIMER_50MS     5
#define TIMER_100MS    10
#define TIMER_250MS    25
#define TIMER_500MS    50
#define TIMER_1SEC     100
#define MAX_CALLBACKS  4

static TimerCallback callBack10ms[MAX_CALLBACKS];
static TimerCallback callBack50ms[MAX_CALLBACKS];
static TimerCallback callBack100ms[MAX_CALLBACKS];
static TimerCallback callBack250ms[MAX_CALLBACKS];
static TimerCallback callBack500ms[MAX_CALLBACKS];
static TimerCallback callBack1s[MAX_CALLBACKS];

static int callBack10ms_count;
static int callBack50ms_count;
static int callBack100ms_count;
static int callBack250ms_count;
static int callBack500ms_count;
static int callBack1s_count;

unsigned long long TimerGetUS()
{
    struct timeval tv;
    gettimeofday(&tv, 0);
    return (((unsigned long long)tv.tv_sec) * 1000000) + tv.tv_usec;
}

void _timerSigHandler(int sig)
{
    int index = 0;
    static unsigned long counter = 0;
    
    // Handle the 10ms ones first
    if (counter % TIMER_10MS == 0)
    {
        for (index = 0; index < callBack10ms_count; index++)
        {
            callBack10ms[index](sig);
        }
    }
    // Handle the 50ms ones
    if (counter % TIMER_50MS == 0)
    {
        for (index = 0; index < callBack50ms_count; index++)
        {
            callBack50ms[index](sig);
        }
    }
    
    // Handle the 100ms ones
    if (counter % TIMER_100MS == 0)
    {
        for (index = 0; index < callBack100ms_count; index++)
        {
            callBack100ms[index](sig);
        }
    }
    
    // Handle the 250ms ones
    if (counter % TIMER_250MS == 0)
    {
        for (index = 0; index < callBack250ms_count; index++)
        {
            callBack250ms[index](sig);
        }
    }
    
    // Handle the 500ms ones
    if (counter % TIMER_500MS == 0)
    {
        for (index = 0; index < callBack500ms_count; index++)
        {
            callBack500ms[index](sig);
        }
    }
    
    // Handle the 1s ones
    if (counter % TIMER_1SEC == 0)
    {
        for (index = 0; index < callBack1s_count; index++)
        {
            callBack1s[index](sig);
        }
    }
    counter++;
}

void _timerCallbackInit()
{
    struct sigaction sa;
    struct itimerval timer;
    memset(&sa, 0, sizeof(sa));
    sa.sa_handler = &_timerSigHandler;
    sigaction (SIGALRM, &sa, NULL);
    timer.it_value.tv_sec = 0;
    timer.it_value.tv_usec = TIMER_INTERVAL;
    timer.it_interval.tv_sec = 0;
    timer.it_interval.tv_usec = TIMER_INTERVAL;
    setitimer(ITIMER_REAL, &timer, NULL);
    
    // Reset all the counters
    callBack10ms_count  = 0;
    callBack50ms_count  = 0;
    callBack100ms_count = 0;
    callBack250ms_count = 0;
    callBack500ms_count = 0;
    callBack1s_count    = 0;
    
    // Ensure all pointers are NULL
    memset(callBack10ms,  0, sizeof(TimerCallback) * MAX_CALLBACKS);
    memset(callBack50ms,  0, sizeof(TimerCallback) * MAX_CALLBACKS);
    memset(callBack100ms, 0, sizeof(TimerCallback) * MAX_CALLBACKS);
    memset(callBack250ms, 0, sizeof(TimerCallback) * MAX_CALLBACKS);
    memset(callBack500ms, 0, sizeof(TimerCallback) * MAX_CALLBACKS);
    memset(callBack1s,    0, sizeof(TimerCallback) * MAX_CALLBACKS);
}

void SetTimerCallback(TimerInterval interval, TimerCallback callback)
{
    if (callback != NULL)
    {
        switch(interval)
        {
            case ti10ms:  callBack10ms[callBack10ms_count++] = callback; break;
            case ti50ms:  callBack50ms[callBack50ms_count++] = callback; break;
            case ti100ms: callBack100ms[callBack100ms_count++] = callback; break;
            case ti250ms: callBack250ms[callBack250ms_count++] = callback; break;
            case ti500ms: callBack500ms[callBack500ms_count++] = callback; break;
            case ti1sec:  callBack1s[callBack1s_count++] = callback; break;
        }
    }
}

void TimerInit()
{
    unsigned long long csTick, msTick, usTick;
    int i;
    usTick = TimerGetUS();
    msTick = usTick / 1000;
    csTick = msTick / 10;
    for (i=0; i < NUM_US_TIMERS; i++)
        usTimers[i] = usTick;
    for (i=0; i < NUM_MS_TIMERS; i++)
        msTimers[i] = msTick;
    for (i=0; i < NUM_CS_TIMERS; i++)
        csTimers[i] = csTick;
    // also initialize our callback timers
    _timerCallbackInit();
}

/////////////////////////////////
// ev3_lcd.h

#include <stdio.h>
#include <fcntl.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <signal.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <stdbool.h>
#include <limits.h>
#include <errno.h>
#include <libgen.h>


#define LCD_BYTE_WIDTH ((LCD_WIDTH + 7) / 8)
#define LCD_BUFFER_SIZE (LCD_BYTE_WIDTH * LCD_HEIGHT)


#define LCD_MEM_WIDTH 60 // width of HW Buffer in bytes
#define LCD_BUFFER_LENGTH (LCD_MEM_WIDTH*LCD_HEIGHT)

byte hwBuffer[LCD_BUFFER_LENGTH];

byte PixelTab[] = {
    0x00, // 000 00000000
    0xE0, // 001 11100000
    0x1C, // 010 00011100
    0xFC, // 011 11111100
    0x03, // 100 00000011
    0xE3, // 101 11100011
    0x1F, // 110 00011111
    0xFF  // 111 11111111
};

typedef struct {
    bool Dirty;
    int DispFile;
    byte *pFB0;
    byte displayBuf[LCD_BUFFER_SIZE];
    byte *font;
    byte *pLcd;
    byte currentFont;
    bool autoRefresh;
} LCDGlobals;

LCDGlobals LCDInstance;

typedef struct
{
    const char  *pFontBits;           // Pointer to start of font bitmap
    const short FontHeight;           // Character height (all inclusive)
    const short FontWidth;            // Character width (all inclusive)
    const short FontHorz;             // Number of horizontal character in font bitmap
    const char  FontFirst;            // First character supported
    const char  FontLast;             // Last character supported
} FONTINFO;

//#include "normal_font.xbm"
#define normal_font_width 128
#define normal_font_height 54
static char normal_font_bits[] = {
    0x00, 0x10, 0x48, 0x48, 0x10, 0x80, 0x1C, 0x20, 0x20, 0x08, 0x00, 0x00,
    0x00, 0x00, 0x00, 0x40, 0x00, 0x10, 0x48, 0x48, 0xF8, 0x4E, 0x22, 0x20,
    0x10, 0x10, 0x10, 0x10, 0x00, 0x00, 0x00, 0x40, 0x00, 0x10, 0x24, 0xFC,
    0x14, 0x2A, 0x22, 0x10, 0x08, 0x20, 0x54, 0x10, 0x00, 0x00, 0x00, 0x20,
    0x00, 0x10, 0x00, 0x28, 0x1C, 0x2E, 0x22, 0x00, 0x08, 0x20, 0x38, 0x10,
    0x00, 0x00, 0x00, 0x20, 0x00, 0x10, 0x00, 0x28, 0x70, 0x10, 0x9C, 0x00,
    0x08, 0x20, 0x54, 0xFE, 0x00, 0x7C, 0x00, 0x10, 0x00, 0x10, 0x00, 0x7E,
    0x90, 0xE8, 0xA2, 0x00, 0x08, 0x20, 0x10, 0x10, 0x00, 0x00, 0x00, 0x10,
    0x00, 0x10, 0x00, 0x24, 0x90, 0xA8, 0x42, 0x00, 0x08, 0x20, 0x00, 0x10,
    0x00, 0x00, 0x00, 0x10, 0x00, 0x00, 0x00, 0x24, 0x7C, 0xE4, 0x42, 0x00,
    0x10, 0x10, 0x00, 0x10, 0x10, 0x00, 0x10, 0x08, 0x00, 0x10, 0x00, 0x00,
    0x10, 0x02, 0xBC, 0x00, 0x20, 0x08, 0x00, 0x00, 0x18, 0x00, 0x10, 0x08,
    0x78, 0x10, 0x78, 0x78, 0x40, 0xF8, 0x70, 0xFC, 0x78, 0x78, 0x00, 0x00,
    0x00, 0x00, 0x00, 0x38, 0x84, 0x1C, 0x84, 0x84, 0x60, 0x08, 0x08, 0x80,
    0x84, 0x84, 0x00, 0x00, 0x80, 0x00, 0x04, 0x44, 0x84, 0x10, 0x84, 0x80,
    0x50, 0x08, 0x04, 0x40, 0x84, 0x84, 0x10, 0x10, 0x60, 0xFE, 0x18, 0x40,
    0x84, 0x10, 0x80, 0x80, 0x48, 0x08, 0x7C, 0x40, 0x84, 0x84, 0x10, 0x10,
    0x18, 0x00, 0x60, 0x20, 0x84, 0x10, 0x40, 0x70, 0x44, 0x78, 0x84, 0x20,
    0x78, 0x84, 0x00, 0x00, 0x04, 0x00, 0x80, 0x10, 0x84, 0x10, 0x30, 0x80,
    0xFC, 0x80, 0x84, 0x20, 0x84, 0xF8, 0x00, 0x00, 0x18, 0xFE, 0x60, 0x10,
    0x84, 0x10, 0x08, 0x80, 0x40, 0x80, 0x84, 0x10, 0x84, 0x80, 0x10, 0x10,
    0x60, 0x00, 0x18, 0x10, 0x84, 0x10, 0x04, 0x84, 0x40, 0x84, 0x84, 0x10,
    0x84, 0x40, 0x10, 0x10, 0x80, 0x00, 0x04, 0x00, 0x78, 0x7C, 0xFC, 0x78,
    0x40, 0x78, 0x78, 0x08, 0x78, 0x38, 0x00, 0x08, 0x00, 0x00, 0x00, 0x10,
    0x38, 0x10, 0x3C, 0x78, 0x3E, 0xFC, 0xFC, 0x78, 0x82, 0x38, 0x38, 0x84,
    0x04, 0xC6, 0x86, 0x38, 0x44, 0x10, 0x44, 0x84, 0x42, 0x04, 0x04, 0x84,
    0x82, 0x10, 0x20, 0x44, 0x04, 0xC6, 0x86, 0x44, 0x82, 0x28, 0x44, 0x02,
    0x82, 0x04, 0x04, 0x02, 0x82, 0x10, 0x20, 0x24, 0x04, 0xAA, 0x8A, 0x82,
    0xBA, 0x28, 0x44, 0x02, 0x82, 0x04, 0x04, 0x02, 0x82, 0x10, 0x20, 0x14,
    0x04, 0xAA, 0x8A, 0x82, 0xB2, 0x44, 0x7C, 0x02, 0x82, 0xFC, 0x7C, 0x02,
    0xFE, 0x10, 0x20, 0x0C, 0x04, 0xAA, 0x92, 0x82, 0xAA, 0x44, 0x84, 0x02,
    0x82, 0x04, 0x04, 0xE2, 0x82, 0x10, 0x20, 0x14, 0x04, 0x92, 0xA2, 0x82,
    0x72, 0x7C, 0x84, 0x02, 0x82, 0x04, 0x04, 0x82, 0x82, 0x10, 0x20, 0x24,
    0x04, 0x92, 0xA2, 0x82, 0x04, 0x82, 0x84, 0x84, 0x42, 0x04, 0x04, 0x84,
    0x82, 0x10, 0x20, 0x44, 0x04, 0x92, 0xC2, 0x44, 0xF8, 0x82, 0x7C, 0x78,
    0x3E, 0xFC, 0x04, 0xF8, 0x82, 0x38, 0x1C, 0x84, 0xFC, 0x82, 0xC2, 0x38,
    0x7C, 0x38, 0x3E, 0x7C, 0xFE, 0x82, 0x82, 0x82, 0x82, 0x82, 0xFE, 0x38,
    0x08, 0x38, 0x10, 0x00, 0x84, 0x44, 0x42, 0x82, 0x10, 0x82, 0x82, 0x92,
    0x82, 0x44, 0x80, 0x08, 0x08, 0x20, 0x28, 0x00, 0x84, 0x82, 0x42, 0x02,
    0x10, 0x82, 0x82, 0x92, 0x44, 0x44, 0x40, 0x08, 0x10, 0x20, 0x44, 0x00,
    0x84, 0x82, 0x42, 0x02, 0x10, 0x82, 0x44, 0x92, 0x28, 0x28, 0x20, 0x08,
    0x10, 0x20, 0x82, 0x00, 0x84, 0x82, 0x22, 0x7C, 0x10, 0x82, 0x44, 0xAA,
    0x10, 0x28, 0x10, 0x08, 0x20, 0x20, 0x00, 0x00, 0x7C, 0x92, 0x1E, 0x80,
    0x10, 0x82, 0x28, 0xAA, 0x28, 0x10, 0x08, 0x08, 0x20, 0x20, 0x00, 0x00,
    0x04, 0x64, 0x22, 0x80, 0x10, 0x82, 0x28, 0xAA, 0x44, 0x10, 0x04, 0x08,
    0x20, 0x20, 0x00, 0x00, 0x04, 0x78, 0x42, 0x82, 0x10, 0x44, 0x10, 0x44,
    0x82, 0x10, 0x02, 0x08, 0x40, 0x20, 0x00, 0x00, 0x04, 0xC0, 0x82, 0x7C,
    0x10, 0x38, 0x10, 0x44, 0x82, 0x10, 0xFE, 0x38, 0x40, 0x38, 0x00, 0xFE,
    0x10, 0x00, 0x04, 0x00, 0x80, 0x00, 0x70, 0x00, 0x04, 0x00, 0x00, 0x04,
    0x10, 0x00, 0x00, 0x00, 0x10, 0x00, 0x04, 0x00, 0x80, 0x00, 0x08, 0x00,
    0x04, 0x10, 0x20, 0x04, 0x10, 0x00, 0x00, 0x00, 0x20, 0x78, 0x04, 0x78,
    0x80, 0x78, 0x08, 0xF8, 0x04, 0x00, 0x00, 0x44, 0x10, 0x4A, 0x74, 0x78,
    0x00, 0x80, 0x74, 0x84, 0xF8, 0x84, 0x3C, 0x84, 0x74, 0x10, 0x30, 0x24,
    0x10, 0xB6, 0x8C, 0x84, 0x00, 0x80, 0x8C, 0x04, 0x84, 0x84, 0x08, 0x84,
    0x8C, 0x10, 0x20, 0x14, 0x10, 0x92, 0x84, 0x84, 0x00, 0xF8, 0x84, 0x04,
    0x84, 0xFC, 0x08, 0xC4, 0x84, 0x10, 0x20, 0x0C, 0x10, 0x92, 0x84, 0x84,
    0x00, 0x84, 0x84, 0x04, 0x84, 0x04, 0x08, 0xB8, 0x84, 0x10, 0x20, 0x14,
    0x10, 0x92, 0x84, 0x84, 0x00, 0x84, 0x84, 0x84, 0xC4, 0x84, 0x08, 0x80,
    0x84, 0x10, 0x20, 0x24, 0x10, 0x92, 0x84, 0x84, 0x00, 0xF8, 0x7C, 0x78,
    0xB8, 0x78, 0x08, 0x78, 0x84, 0x10, 0x1C, 0x44, 0x10, 0x92, 0x84, 0x78,
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x20,
    0x10, 0x08, 0x4C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00,
    0x00, 0x00, 0x00, 0x10, 0x10, 0x10, 0x32, 0x00, 0x74, 0xF8, 0x68, 0x78,
    0x3C, 0x84, 0x84, 0x92, 0x44, 0x84, 0x7C, 0x10, 0x10, 0x10, 0x00, 0x00,
    0x8C, 0x84, 0x18, 0x04, 0x08, 0x84, 0x84, 0x92, 0x44, 0x48, 0x40, 0x10,
    0x10, 0x10, 0x00, 0x00, 0x84, 0xC4, 0x08, 0x04, 0x08, 0x84, 0x48, 0xAA,
    0x28, 0x48, 0x20, 0x08, 0x10, 0x20, 0x00, 0x00, 0x7C, 0xB8, 0x08, 0x38,
    0x08, 0x84, 0x48, 0xAA, 0x10, 0x30, 0x10, 0x10, 0x10, 0x10, 0x00, 0x00,
    0x04, 0x80, 0x08, 0x40, 0x08, 0x84, 0x48, 0xAA, 0x28, 0x30, 0x08, 0x10,
    0x10, 0x10, 0x00, 0x00, 0x04, 0x80, 0x08, 0x40, 0x08, 0xC4, 0x30, 0x44,
    0x44, 0x10, 0x04, 0x10, 0x10, 0x10, 0x00, 0x92, 0x04, 0x80, 0x08, 0x3C,
    0x30, 0xB8, 0x30, 0x44, 0x44, 0x08, 0x7C, 0x20, 0x10, 0x08, 0x00, 0x92,
};

FONTINFO FontInfo[] =
{
    [FONTTYPE_NORMAL] = {
        .pFontBits    = (const char*)normal_font_bits,
        .FontHeight   = 9,
        .FontWidth    = 8,
        .FontHorz     = 16,
        .FontFirst    = 0x20,
        .FontLast     = 0x7F
    },
};

void lcdToFrameBuffer(byte* pSrc, byte* pDst)
{
    unsigned long Pixels;
    unsigned short X;
    unsigned short Y;
    
    for (Y = 0; Y < LCD_HEIGHT; Y++)
    {
        for (X = 0; X < 7; X++)
        {
            Pixels  =  (unsigned long)*pSrc << 0;  pSrc++;
            Pixels |=  (unsigned long)*pSrc << 8;  pSrc++;
            Pixels |=  (unsigned long)*pSrc << 16; pSrc++;
            
            *pDst   =  PixelTab[Pixels & 0x07]; pDst++;
            Pixels >>= 3;
            *pDst   =  PixelTab[Pixels & 0x07]; pDst++;
            Pixels >>= 3;
            *pDst   =  PixelTab[Pixels & 0x07]; pDst++;
            Pixels >>= 3;
            *pDst   =  PixelTab[Pixels & 0x07]; pDst++;
            Pixels >>= 3;
            *pDst   =  PixelTab[Pixels & 0x07]; pDst++;
            Pixels >>= 3;
            *pDst   =  PixelTab[Pixels & 0x07]; pDst++;
            Pixels >>= 3;
            *pDst   =  PixelTab[Pixels & 0x07]; pDst++;
            Pixels >>= 3;
            *pDst   =  PixelTab[Pixels & 0x07]; pDst++;
        }
        Pixels  =  (unsigned long)*pSrc << 0; pSrc++;
        Pixels |=  (unsigned long)*pSrc << 8; pSrc++;
        
        *pDst   =  PixelTab[Pixels & 0x07]; pDst++;
        Pixels >>= 3;
        *pDst   =  PixelTab[Pixels & 0x07]; pDst++;
        Pixels >>= 3;
        *pDst   =  PixelTab[Pixels & 0x07]; pDst++;
        Pixels >>= 3;
        *pDst   =  PixelTab[Pixels & 0x07]; pDst++;
    }
}

void doUpdateScreen()
{
    if (LCDInstance.Dirty && (LCDInstance.pFB0 != NULL) && (LCDInstance.pLcd != NULL))
    {
        lcdToFrameBuffer(LCDInstance.pLcd, hwBuffer);
        memmove((void*)LCDInstance.pFB0, (const void *)hwBuffer, LCD_BUFFER_LENGTH);
        LCDInstance.Dirty = false;
    }
}

void LcdUpdateHandler(int sig)
{
    if (LCDInstance.autoRefresh)
        doUpdateScreen();
}

bool LcdInitialized()
{
    return (LCDInstance.DispFile != -1) &&
            (LCDInstance.pFB0 != NULL);
}

void LcdCloseDevices()
{
    if (!LcdInitialized())
        return;
    
    if (LCDInstance.DispFile >= 0)
    {
        close(LCDInstance.DispFile);
        if (LCDInstance.pFB0 != NULL)
            munmap(LCDInstance.pFB0, LCD_BUFFER_LENGTH);
        LCDInstance.pFB0 = NULL;
        LCDInstance.DispFile = -1;
    }
}

bool LcdInit()
{
    int i;
    byte * pTmp;
    if (LcdInitialized()) return true;
    
    LCDInstance.autoRefresh = true;
    LCDInstance.Dirty = false;
    LCDInstance.pFB0 = NULL;
    LCDInstance.DispFile = -1;
    LCDInstance.font = NULL;
    LCDInstance.pLcd = NULL;
    LCDInstance.currentFont = FONTTYPE_NORMAL;
    
    LCDInstance.DispFile = open(LMS_LCD_DEVICE_NAME, O_RDWR);
    if (LCDInstance.DispFile != -1)
    {
        pTmp = (byte*)mmap(NULL, LCD_BUFFER_LENGTH, PROT_READ + PROT_WRITE, MAP_SHARED, LCDInstance.DispFile, 0);
        if (pTmp == MAP_FAILED)
        {
            LcdCloseDevices();
            return false;
        }
        else
        {
            LCDInstance.pFB0 = pTmp;
//      LCDInstance.font := @(font_data[0]);
            LCDInstance.pLcd = LCDInstance.displayBuf;
            
            // initialize timer system
            TimerInit();
            
            // register update handler with timer system
            SetTimerCallback(ti250ms, &LcdUpdateHandler);
            
            return true;
        }
    }
}


bool LcdExit()
{
    // if not initialized then just exit
    if (!LcdInitialized())
        return true;
    
    LcdCloseDevices();
    
    LCDInstance.font = NULL;
    LCDInstance.pLcd = NULL;
    return true;
}

void dLcdDrawPixel(byte *pImage, char Color, short X0, short Y0)
{
    if ((X0 >= 0) && (X0 < LCD_WIDTH) && (Y0 >= 0) && (Y0 < LCD_HEIGHT))
    {
        if (Color)
        {
            pImage[(X0 >> 3) + Y0 * LCD_BYTE_WIDTH]  |=  (1 << (X0 % 8));
        }
        else
        {
            pImage[(X0 >> 3) + Y0 * LCD_BYTE_WIDTH]  &= ~(1 << (X0 % 8));
        }
    }
}

void dLcdDrawChar(byte *pImage, char Color, short X0, short Y0, char Font, char Char)
{
    short CharWidth;
    short CharHeight;
    short CharByteIndex;
    short LcdByteIndex;
    byte  CharByte;
    short Tmp,X,Y,TmpX,MaxX;
    byte  bC1, bC2;
    
    CharWidth  = FontInfo[Font].FontWidth;
    CharHeight = FontInfo[Font].FontHeight;
    
    if ((Char >= FontInfo[Font].FontFirst) && (Char <= FontInfo[Font].FontLast))
    {
        Char -= FontInfo[Font].FontFirst;
        
        CharByteIndex  = (Char % FontInfo[Font].FontHorz) * ((CharWidth + 7) / 8);
        CharByteIndex += ((Char / FontInfo[Font].FontHorz) * ((CharWidth + 7) / 8) * CharHeight * FontInfo[Font].FontHorz);
        
        if (((CharWidth % 8) == 0) && ((X0 % 8) == 0))
        {
            // Font aligned
            X0           = (X0 >> 3) << 3;
            LcdByteIndex = (X0 >> 3) + Y0 * LCD_BYTE_WIDTH;
            while (CharHeight)
            {
                Tmp = 0;
                do
                {
                    if (LcdByteIndex < LCD_BUFFER_SIZE)
                    {
                        if (Color)
                            CharByte = FontInfo[Font].pFontBits[CharByteIndex + Tmp];
                        else
                            CharByte = ~FontInfo[Font].pFontBits[CharByteIndex + Tmp];
                        pImage[LcdByteIndex + Tmp] = CharByte;
                    }
                    Tmp++;
                }
                while (Tmp < (CharWidth / 8));
                CharByteIndex += (CharWidth * FontInfo[Font].FontHorz) / 8;
                LcdByteIndex  += LCD_BYTE_WIDTH;
                CharHeight--;
            }
        }
        else
        {
            // Font not aligned
            MaxX = X0 + CharWidth;
            if (Color)
            {
                bC1 = 1;
                bC2 = 0;
            }
            else
            {
                bC1 = 0;
                bC2 = 1;
            }
            for (Y = 0;Y < CharHeight;Y++)
            {
                TmpX = X0;
                for (X = 0;X < ((CharWidth + 7) / 8);X++)
                {
                    CharByte = FontInfo[Font].pFontBits[CharByteIndex + X];
                    for (Tmp = 0;(Tmp < 8) && (TmpX < MaxX);Tmp++)
                    {
                        if (CharByte & 1)
                        {
                            dLcdDrawPixel(pImage,bC1,TmpX,Y0);
                        }
                        else
                        {
                            dLcdDrawPixel(pImage,bC2,TmpX,Y0);
                        }
                        CharByte >>= 1;
                        TmpX++;
                    }
                }
                Y0++;
                CharByteIndex += ((CharWidth + 7) / 8) * FontInfo[Font].FontHorz;
            }
        }
    }
}
void dLcdDrawText(byte *pImage, char Color, short X0, short Y0, char Font, char *pText)
{
    while (*pText)
    {
        if (X0 < (LCD_WIDTH - FontInfo[Font].FontWidth))
        {
            dLcdDrawChar(pImage,Color,X0,Y0,Font,*pText);
            X0 += FontInfo[Font].FontWidth;
        }
        pText++;
    }
}

bool LcdText(char Color, short X, short Y, char* Text)
{
    if (!LcdInitialized())
        return false;
    
    dLcdDrawText(LCDInstance.pLcd, Color, X, Y, LCDInstance.currentFont, Text);
    LCDInstance.Dirty = true;
    return true;
}

bool LcdClean()
{
    if (!LcdInitialized())
        return false;
    LCDInstance.currentFont = FONTTYPE_NORMAL;
    memset((void*)LCDInstance.pLcd, 0, LCD_BUFFER_SIZE);
    LCDInstance.Dirty = true;
    return true;
}

/////////////////////////////////////////////////
void initLCD()
{
}

void initLCDImpl()
{
    _EV3_DEBUG_PRINTF(("Start LCD initialized led.\n"));
    LcdInit();
    _EV3_DEBUG_PRINTF(("Finish LCD initialized led.\n"));
}

void lcdDisplay(int32_T inData, char* s, uint8_T line, uint8_T mode)
{
    char str[12];
    if(mode == 1) {
        sprintf(str, "%11d", inData);
    } else {
        sprintf(str, "%11x", inData);
    }
    LcdText(1, 0, (line - 1) * 12, s);
    LcdText(1, 80, (line - 1) * 12, str);
}

void lcdDisplayText(char* s, short X, short Y)
{
    LcdText(1, X, Y, s);
}

void terminateLCD()
{
    _EV3_DEBUG_PRINTF(("Exiting LCD...\n"));
    LcdClean();
    lcdDisplayText("Done!", 1, 30);
    lcdDisplayText("Press <Back> to return.", 1, 50);
    doUpdateScreen();
    LcdExit();
}