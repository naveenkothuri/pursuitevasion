/*
 * File: lego_move_optitrack2.c
 *
 * Code generated for Simulink model 'lego_move_optitrack2'.
 *
 * Model version                  : 1.9
 * Simulink Coder version         : 8.8 (R2015a) 09-Feb-2015
 * TLC version                    : 8.8 (Jan 20 2015)
 * C/C++ source code generated on : Mon Feb 13 11:44:54 2017
 *
 * Target selection: realtime.tlc
 * Embedded hardware selection: ARM Compatible->ARM 9
 * Code generation objectives: Unspecified
 * Validation result: Not run
 */

#include "lego_move_optitrack2.h"
#include "lego_move_optitrack2_private.h"
#include "lego_move_optitrack2_dt.h"

/* Real-time model */
RT_MODEL_lego_move_optitrack2_T lego_move_optitrack2_M_;
RT_MODEL_lego_move_optitrack2_T *const lego_move_optitrack2_M =
  &lego_move_optitrack2_M_;

/* Model output function */
void lego_move_optitrack2_output(void)
{
  int8_T tmp;
  int8_T tmp_0;
  real_T tmp_1;

  /* DataTypeConversion: '<S1>/Data Type Conversion' incorporates:
   *  Constant: '<Root>/Constant'
   */
  tmp_1 = floor(lego_move_optitrack2_P.Constant_Value);
  if (tmp_1 < 128.0) {
    if (tmp_1 >= -128.0) {
      /* S-Function (ev3_motor): '<S1>/Motor' */
      tmp = (int8_T)tmp_1;
    } else {
      /* S-Function (ev3_motor): '<S1>/Motor' */
      tmp = MIN_int8_T;
    }
  } else {
    /* S-Function (ev3_motor): '<S1>/Motor' */
    tmp = MAX_int8_T;
  }

  /* End of DataTypeConversion: '<S1>/Data Type Conversion' */

  /* S-Function (ev3_motor): '<S1>/Motor' */
  setMotor(&tmp, 1U, 2U);

  /* DataTypeConversion: '<S2>/Data Type Conversion' incorporates:
   *  Constant: '<Root>/Constant1'
   */
  tmp_1 = floor(lego_move_optitrack2_P.Constant1_Value);
  if (tmp_1 < 128.0) {
    if (tmp_1 >= -128.0) {
      /* S-Function (ev3_motor): '<S2>/Motor' */
      tmp_0 = (int8_T)tmp_1;
    } else {
      /* S-Function (ev3_motor): '<S2>/Motor' */
      tmp_0 = MIN_int8_T;
    }
  } else {
    /* S-Function (ev3_motor): '<S2>/Motor' */
    tmp_0 = MAX_int8_T;
  }

  /* End of DataTypeConversion: '<S2>/Data Type Conversion' */

  /* S-Function (ev3_motor): '<S2>/Motor' */
  setMotor(&tmp_0, 2U, 2U);
}

/* Model update function */
void lego_move_optitrack2_update(void)
{
  /* signal main to stop simulation */
  {                                    /* Sample time: [0.2s, 0.0s] */
    if ((rtmGetTFinal(lego_move_optitrack2_M)!=-1) &&
        !((rtmGetTFinal(lego_move_optitrack2_M)-
           lego_move_optitrack2_M->Timing.taskTime0) >
          lego_move_optitrack2_M->Timing.taskTime0 * (DBL_EPSILON))) {
      rtmSetErrorStatus(lego_move_optitrack2_M, "Simulation finished");
    }

    if (rtmGetStopRequested(lego_move_optitrack2_M)) {
      rtmSetErrorStatus(lego_move_optitrack2_M, "Simulation finished");
    }
  }

  /* Update absolute time for base rate */
  /* The "clockTick0" counts the number of times the code of this task has
   * been executed. The absolute time is the multiplication of "clockTick0"
   * and "Timing.stepSize0". Size of "clockTick0" ensures timer will not
   * overflow during the application lifespan selected.
   */
  lego_move_optitrack2_M->Timing.taskTime0 =
    (++lego_move_optitrack2_M->Timing.clockTick0) *
    lego_move_optitrack2_M->Timing.stepSize0;
}

/* Model initialize function */
void lego_move_optitrack2_initialize(void)
{
  /* Registration code */

  /* initialize real-time model */
  (void) memset((void *)lego_move_optitrack2_M, 0,
                sizeof(RT_MODEL_lego_move_optitrack2_T));
  rtmSetTFinal(lego_move_optitrack2_M, 25.0);
  lego_move_optitrack2_M->Timing.stepSize0 = 0.2;

  /* External mode info */
  lego_move_optitrack2_M->Sizes.checksums[0] = (1545536871U);
  lego_move_optitrack2_M->Sizes.checksums[1] = (349425631U);
  lego_move_optitrack2_M->Sizes.checksums[2] = (1900972477U);
  lego_move_optitrack2_M->Sizes.checksums[3] = (2075380972U);

  {
    static const sysRanDType rtAlwaysEnabled = SUBSYS_RAN_BC_ENABLE;
    static RTWExtModeInfo rt_ExtModeInfo;
    static const sysRanDType *systemRan[1];
    lego_move_optitrack2_M->extModeInfo = (&rt_ExtModeInfo);
    rteiSetSubSystemActiveVectorAddresses(&rt_ExtModeInfo, systemRan);
    systemRan[0] = &rtAlwaysEnabled;
    rteiSetModelMappingInfoPtr(lego_move_optitrack2_M->extModeInfo,
      &lego_move_optitrack2_M->SpecialInfo.mappingInfo);
    rteiSetChecksumsPtr(lego_move_optitrack2_M->extModeInfo,
                        lego_move_optitrack2_M->Sizes.checksums);
    rteiSetTPtr(lego_move_optitrack2_M->extModeInfo, rtmGetTPtr
                (lego_move_optitrack2_M));
  }

  /* data type transition information */
  {
    static DataTypeTransInfo dtInfo;
    (void) memset((char_T *) &dtInfo, 0,
                  sizeof(dtInfo));
    lego_move_optitrack2_M->SpecialInfo.mappingInfo = (&dtInfo);
    dtInfo.numDataTypes = 14;
    dtInfo.dataTypeSizes = &rtDataTypeSizes[0];
    dtInfo.dataTypeNames = &rtDataTypeNames[0];

    /* Parameters transition table */
    dtInfo.P = &rtPTransTable;
  }

  /* Start for S-Function (ev3_motor): '<S1>/Motor' */
  initMotor(1U);

  /* Start for S-Function (ev3_motor): '<S2>/Motor' */
  initMotor(2U);
}

/* Model terminate function */
void lego_move_optitrack2_terminate(void)
{
  /* Terminate for S-Function (ev3_motor): '<S1>/Motor' */
  terminateMotor(1U, 2U);

  /* Terminate for S-Function (ev3_motor): '<S2>/Motor' */
  terminateMotor(2U, 2U);
}

/*
 * File trailer for generated code.
 *
 * [EOF]
 */
