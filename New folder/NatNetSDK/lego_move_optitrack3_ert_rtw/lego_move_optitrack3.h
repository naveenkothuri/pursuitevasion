/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * File: lego_move_optitrack3.h
 *
 * Code generated for Simulink model 'lego_move_optitrack3'.
 *
 * Model version                  : 1.14
 * Simulink Coder version         : 8.12 (R2017a) 16-Feb-2017
 * C/C++ source code generated on : Tue Aug 08 12:12:01 2017
 *
 * Target selection: ert.tlc
 * Embedded hardware selection: ARM Compatible->ARM 9
 * Code generation objectives: Unspecified
 * Validation result: Not run
 */

#ifndef RTW_HEADER_lego_move_optitrack3_h_
#define RTW_HEADER_lego_move_optitrack3_h_
#include <float.h>
#include <string.h>
#include <stddef.h>
#ifndef lego_move_optitrack3_COMMON_INCLUDES_
# define lego_move_optitrack3_COMMON_INCLUDES_
#include "rtwtypes.h"
#include "rtw_extmode.h"
#include "sysran_types.h"
#include "rtw_continuous.h"
#include "rtw_solver.h"
#include "dt_info.h"
#include "ext_work.h"
#include "driver_ev3.h"
#endif                                 /* lego_move_optitrack3_COMMON_INCLUDES_ */

#include "lego_move_optitrack3_types.h"

/* Shared type includes */
#include "multiword_types.h"

/* Macros for accessing real-time model data structure */
#ifndef rtmGetFinalTime
# define rtmGetFinalTime(rtm)          ((rtm)->Timing.tFinal)
#endif

#ifndef rtmGetRTWExtModeInfo
# define rtmGetRTWExtModeInfo(rtm)     ((rtm)->extModeInfo)
#endif

#ifndef rtmGetErrorStatus
# define rtmGetErrorStatus(rtm)        ((rtm)->errorStatus)
#endif

#ifndef rtmSetErrorStatus
# define rtmSetErrorStatus(rtm, val)   ((rtm)->errorStatus = (val))
#endif

#ifndef rtmGetStopRequested
# define rtmGetStopRequested(rtm)      ((rtm)->Timing.stopRequestedFlag)
#endif

#ifndef rtmSetStopRequested
# define rtmSetStopRequested(rtm, val) ((rtm)->Timing.stopRequestedFlag = (val))
#endif

#ifndef rtmGetStopRequestedPtr
# define rtmGetStopRequestedPtr(rtm)   (&((rtm)->Timing.stopRequestedFlag))
#endif

#ifndef rtmGetT
# define rtmGetT(rtm)                  ((rtm)->Timing.taskTime0)
#endif

#ifndef rtmGetTFinal
# define rtmGetTFinal(rtm)             ((rtm)->Timing.tFinal)
#endif

/* Block signals (auto storage) */
typedef struct {
  uint16_T Divide;                     /* '<Root>/Divide' */
  uint8_T UltrasonicSensor;            /* '<Root>/Ultrasonic Sensor' */
  uint8_T UltrasonicSensor1;           /* '<Root>/Ultrasonic Sensor1' */
} B_lego_move_optitrack3_T;

/* Real-time Model Data Structure */
struct tag_RTM_lego_move_optitrack3_T {
  const char_T *errorStatus;
  RTWExtModeInfo *extModeInfo;

  /*
   * Sizes:
   * The following substructure contains sizes information
   * for many of the model attributes such as inputs, outputs,
   * dwork, sample times, etc.
   */
  struct {
    uint32_T checksums[4];
  } Sizes;

  /*
   * SpecialInfo:
   * The following substructure contains special information
   * related to other components that are dependent on RTW.
   */
  struct {
    const void *mappingInfo;
  } SpecialInfo;

  /*
   * Timing:
   * The following substructure contains information regarding
   * the timing information for the model.
   */
  struct {
    time_T taskTime0;
    uint32_T clockTick0;
    time_T stepSize0;
    time_T tFinal;
    boolean_T stopRequestedFlag;
  } Timing;
};

/* Block signals (auto storage) */
extern B_lego_move_optitrack3_T lego_move_optitrack3_B;

/* Model entry point functions */
extern void lego_move_optitrack3_initialize(void);
extern void lego_move_optitrack3_step(void);
extern void lego_move_optitrack3_terminate(void);

/* Real-time Model object */
extern RT_MODEL_lego_move_optitrack3_T *const lego_move_optitrack3_M;

/*-
 * The generated code includes comments that allow you to trace directly
 * back to the appropriate location in the model.  The basic format
 * is <system>/block_name, where system is the system number (uniquely
 * assigned by Simulink) and block_name is the name of the block.
 *
 * Use the MATLAB hilite_system command to trace the generated code back
 * to the model.  For example,
 *
 * hilite_system('<S3>')    - opens system 3
 * hilite_system('<S3>/Kp') - opens and selects block Kp which resides in S3
 *
 * Here is the system hierarchy for this model
 *
 * '<Root>' : 'lego_move_optitrack3'
 */
#endif                                 /* RTW_HEADER_lego_move_optitrack3_h_ */

/*
 * File trailer for generated code.
 *
 * [EOF]
 */
