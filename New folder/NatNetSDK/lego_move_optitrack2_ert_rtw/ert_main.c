/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * File: ert_main.c
 *
 * Code generated for Simulink model 'lego_move_optitrack2'.
 *
 * Model version                  : 1.13
 * Simulink Coder version         : 8.12 (R2017a) 16-Feb-2017
 * C/C++ source code generated on : Tue Aug 08 12:11:07 2017
 *
 * Target selection: ert.tlc
 * Embedded hardware selection: ARM Compatible->ARM 9
 * Code generation objectives: Unspecified
 * Validation result: Not run
 */

#include <stdio.h>
#include <stdlib.h>
#include "lego_move_optitrack2.h"
#include "lego_move_optitrack2_private.h"
#include "rtwtypes.h"
#include "limits.h"
#include "driver_ev3.h"
#include "ev3_constants.h"
#include "ev3_include.h"
#include "lms2012.h"
#include "linuxinitialize.h"
#define UNUSED(x)                      x = x

/* Function prototype declaration*/
void exitFcn(int sig);
void *terminateTask(void *arg);
void *baseRateTask(void *arg);
void *subrateTask(void *arg);
volatile boolean_T runModel = true;
sem_t stopSem;
sem_t baserateTaskSem;
pthread_t schedulerThread;
pthread_t baseRateThread;
pthread_t backgroundThread;
unsigned long threadJoinStatus[8];
int terminatingmodel = 0;
void *baseRateTask(void *arg)
{
  runModel = (rtmGetErrorStatus(lego_move_optitrack2_M) == (NULL)) &&
    !rtmGetStopRequested(lego_move_optitrack2_M);
  while (runModel) {
    sem_wait(&baserateTaskSem);

    /* External mode */
    {
      boolean_T rtmStopReq = false;
      rtExtModePauseIfNeeded(lego_move_optitrack2_M->extModeInfo, 1, &rtmStopReq);
      if (rtmStopReq) {
        rtmSetStopRequested(lego_move_optitrack2_M, true);
      }

      if (rtmGetStopRequested(lego_move_optitrack2_M) == true) {
        rtmSetErrorStatus(lego_move_optitrack2_M, "Simulation finished");
        break;
      }
    }

    lego_move_optitrack2_step();

    /* Get model outputs here */
    rtExtModeCheckEndTrigger();
    runModel = (rtmGetErrorStatus(lego_move_optitrack2_M) == (NULL)) &&
      !rtmGetStopRequested(lego_move_optitrack2_M);
    runModel = runModel && !getBackButtonValue();
  }

  runModel = 0;
  terminateTask(arg);
  pthread_exit((void *)0);
  return NULL;
}

void exitFcn(int sig)
{
  UNUSED(sig);
  rtmSetErrorStatus(lego_move_optitrack2_M, "stopping the model");
}

void *terminateTask(void *arg)
{
  UNUSED(arg);
  terminatingmodel = 1;

  {
    runModel = 0;

    /* Wait for background task to complete */
    CHECK_STATUS(pthread_join(backgroundThread,(void *)&threadJoinStatus), 0,
                 "pthread_join");
  }

  MW_legoev3_terminatetasks();
  rtExtModeShutdown(1);

  /* Disable rt_OneStep() here */

  /* Terminate model */
  lego_move_optitrack2_terminate();
  sem_post(&stopSem);
  return NULL;
}

void backgroundTask(void *arg)
{
  while (runModel) {
    /* External mode */
    {
      boolean_T rtmStopReq = false;
      rtExtModeOneStep(lego_move_optitrack2_M->extModeInfo, 1, &rtmStopReq);
      if (rtmStopReq) {
        rtmSetStopRequested(lego_move_optitrack2_M, true);
      }
    }
  }
}

int main(int argc, char **argv)
{
  UNUSED(argc);
  UNUSED(argv);
  MW_ev3_init();
  rtmSetErrorStatus(lego_move_optitrack2_M, 0);
  rtExtModeParseArgs(argc, (const char_T **)argv, NULL);

  /* Initialize model */
  lego_move_optitrack2_initialize();

  /* External mode */
  rtSetTFinalForExtMode(&rtmGetTFinal(lego_move_optitrack2_M));
  rtExtModeCheckInit(1);

  {
    boolean_T rtmStopReq = false;
    rtExtModeWaitForStartPkt(lego_move_optitrack2_M->extModeInfo, 1, &rtmStopReq);
    if (rtmStopReq) {
      rtmSetStopRequested(lego_move_optitrack2_M, true);
    }
  }

  rtERTExtModeStartMsg();

  /* Call RTOS Initialization function */
  legoev3RTOSInit(0.2, 0);

  /* Wait for stop semaphore */
  sem_wait(&stopSem);
  return 0;
}

/*
 * File trailer for generated code.
 *
 * [EOF]
 */
