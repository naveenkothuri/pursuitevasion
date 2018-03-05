/*
 * File: ert_main.c
 *
 * Code generated for Simulink model 'lego_move_optitrack1'.
 *
 * Model version                  : 1.13
 * Simulink Coder version         : 8.8 (R2015a) 09-Feb-2015
 * TLC version                    : 8.8 (Jan 20 2015)
 * C/C++ source code generated on : Thu Feb 02 15:22:54 2017
 *
 * Target selection: realtime.tlc
 * Embedded hardware selection: ARM Compatible->ARM 9
 * Code generation objectives: Unspecified
 * Validation result: Not run
 */

#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>
#include <pthread.h>
#include <sched.h>
#include <semaphore.h>
#include <errno.h>
#include <limits.h>
#include <signal.h>
#include <time.h>
#include "lego_move_optitrack1.h"
#include <fcntl.h>
#include <sys/mman.h>
#include "lms2012.h"
#include "driver_ev3.h"

DEVCON DevCon;
int uartFile = -1;
UART *pUart = NULL;

#include "lego_move_optitrack1_private.h"
#include "rtwtypes.h"

static int buttonFile = -1;
static UI *pUI;

// Initialize button device
static void initBackButton()
{
  buttonFile = open(UI_DEVICE_NAME, O_RDWR | O_SYNC);
  if (buttonFile == -1) {
    _EV3_DEBUG_PRINTF(("Failed to open button device file.\n"));
    return;
  }

  pUI = (UI*)mmap(0, sizeof(UI), PROT_READ | PROT_WRITE, MAP_FILE | MAP_SHARED,
                  buttonFile, 0);
  if (pUI == MAP_FAILED) {
    _EV3_DEBUG_PRINTF(("Failed to map button memory.\n"));
    return;
  }

  _EV3_DEBUG_PRINTF(("Successfully initialized button device.\n"));
}

// Get button value
static uint8_T getBackButtonValue()
{
  return pUI->Pressed[5];
}

// Terminate button
static void terminateBackButton()
{
  close(buttonFile);
  buttonFile = -1;
}

typedef struct {
  int signo;
  sigset_t sigMask;
  double period;
} baseRateInfo_t;

void MW_blockSignal(int sigNo, sigset_t *sigMask);
void MW_setTaskPeriod(double periodInSeconds, int sigNo);
void MW_sigWait(sigset_t *sigMask);
void MW_exitHandler(int sig);
void MW_sem_wait(sem_t *sem);

#define CHECK_STATUS(status, fcn)      if (status != 0) {printf("Call to %s returned error status (%d).\n", fcn, status); perror(fcn); fflush(stdout); exit(EXIT_FAILURE);}

/* Semaphore(s) used for thread synchronization */
sem_t stopSem;
void baseRateTask(void *arg)
{
  baseRateInfo_t info = *((baseRateInfo_t *)arg);
  initLCDImpl();
  lcdDisplayText("Running ...", 1, 1);
  lcdDisplayText("lego_move_optitrack1", 1, 20);
  initBackButton();
  MW_setTaskPeriod(info.period, info.signo);
  while (rtmGetErrorStatus(lego_move_optitrack1_M) == (NULL) ) {
    /* Wait for the next timer interrupt */
    MW_sigWait(&info.sigMask);
    lego_move_optitrack1_output();

    /* Get model outputs here */
    lego_move_optitrack1_update();
    if (getBackButtonValue())
      break;
  }                                    /* while */

  sem_post(&stopSem);
}

void MW_sem_wait(sem_t *sem)
{
  int status;
  while (((status = sem_wait(sem)) == -1) && (errno == EINTR)) {
    /* Restart if interrupted by a signal */
    continue;
  }

  CHECK_STATUS(status, "sem_wait");
}

void MW_exitHandler(int sig)
{
  sem_post(&stopSem);
}

void MW_blockSignal(int sigNo, sigset_t *sigMask)
{
  int ret;
  sigaddset(sigMask, sigNo);
  ret = pthread_sigmask(SIG_BLOCK, sigMask, NULL);
  CHECK_STATUS(ret, "pthread_sigmask");
}

void MW_setTaskPeriod(double periodInSeconds, int sigNo)
{
  timer_t timerId;
  struct sigevent sev;
  struct itimerspec its;
  long stNanoSec;
  int ret;

  /* Create a timer */
  sev.sigev_notify = SIGEV_SIGNAL;
  sev.sigev_signo = sigNo;
  sev.sigev_value.sival_ptr = &timerId;
  ret = timer_create(CLOCK_REALTIME, &sev, &timerId);
  CHECK_STATUS(ret, "timer_create");

  /* Arm real-time scheduling timer */
  stNanoSec = (long)(periodInSeconds * 1e9);
  its.it_value.tv_sec = stNanoSec / 1000000000;
  its.it_value.tv_nsec = stNanoSec % 1000000000;
  its.it_interval.tv_sec = its.it_value.tv_sec;
  its.it_interval.tv_nsec = its.it_value.tv_nsec;
  ret = timer_settime(timerId, 0, &its, NULL);
  CHECK_STATUS(ret, "timer_settime");
}

void MW_sigWait(sigset_t *sigMask)
{
  int ret;
  while (((ret = sigwaitinfo(sigMask, NULL)) == -1) && (errno == EINTR)) {
    /* Restart if interrupted by a signal other than the one we
       are waiting on */
    continue;
  }
}

int main(int argc, char **argv)
{
  int ret;
  baseRateInfo_t info;
  pthread_attr_t attr;
  pthread_t baseRateThread;
  size_t stackSize;
  unsigned long cpuMask = 0x1;
  unsigned int len = sizeof(cpuMask);
  printf("**starting the model**\n");
  fflush(stdout);
  rtmSetErrorStatus(lego_move_optitrack1_M, 0);

  /* Unused arguments */
  (void)(argc);
  (void)(argv);

  /* All threads created by this process must run on a single CPU */
  ret = sched_setaffinity(0, len, (cpu_set_t *) &cpuMask);
  CHECK_STATUS(ret, "sched_setaffinity");

  /* Initialize semaphore used for thread synchronization */
  ret = sem_init(&stopSem, 0, 0);
  CHECK_STATUS(ret, "sem_init:stopSem");

  /* Create threads executing the Simulink model */
  pthread_attr_init(&attr);
  ret = pthread_attr_setinheritsched(&attr, PTHREAD_EXPLICIT_SCHED);
  CHECK_STATUS(ret, "pthread_attr_setinheritsched");
  ret = pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_DETACHED);
  CHECK_STATUS(ret, "pthread_attr_setdetachstate");

  /* PTHREAD_STACK_MIN is the minimum stack size required to start a thread */
  stackSize = 64000 + PTHREAD_STACK_MIN;
  ret = pthread_attr_setstacksize(&attr, stackSize);
  CHECK_STATUS(ret, "pthread_attr_setstacksize");

  /* Block signal used for timer notification */
  info.period = 0.1;
  info.signo = SIGRTMIN;
  sigemptyset(&info.sigMask);
  MW_blockSignal(info.signo, &info.sigMask);
  signal(SIGTERM, MW_exitHandler);     /* kill */
  signal(SIGHUP, MW_exitHandler);      /* kill -HUP */
  signal(SIGINT, MW_exitHandler);      /* Interrupt from keyboard */
  signal(SIGQUIT, MW_exitHandler);     /* Quit from keyboard */
  lego_move_optitrack1_initialize();
  ioctl(uartFile, UART_SET_CONN, &DevCon);

  /* Create base rate task */
  ret = pthread_create(&baseRateThread, &attr, (void *) baseRateTask, (void *)
                       &info);
  CHECK_STATUS(ret, "pthread_create");
  pthread_attr_destroy(&attr);

  /* Wait for a stopping condition. */
  MW_sem_wait(&stopSem);

  /* Received stop signal */
  printf("**stopping the model**\n");
  if (rtmGetErrorStatus(lego_move_optitrack1_M) != NULL) {
    printf("\n**%s**\n", rtmGetErrorStatus(lego_move_optitrack1_M));
  }

  /* Disable rt_OneStep() here */

  /* Terminate model */
  lego_move_optitrack1_terminate();
  terminateLCD();
  terminateBackButton();
  return 0;
}

/*
 * File trailer for generated code.
 *
 * [EOF]
 */
