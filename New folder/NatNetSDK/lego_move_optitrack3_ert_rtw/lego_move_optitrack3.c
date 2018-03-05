/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * File: lego_move_optitrack3.c
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

#include "lego_move_optitrack3.h"
#include "lego_move_optitrack3_private.h"
#include "lego_move_optitrack3_dt.h"

/* Block signals (auto storage) */
B_lego_move_optitrack3_T lego_move_optitrack3_B;

/* Real-time model */
RT_MODEL_lego_move_optitrack3_T lego_move_optitrack3_M_;
RT_MODEL_lego_move_optitrack3_T *const lego_move_optitrack3_M =
  &lego_move_optitrack3_M_;

/* Model step function */
void lego_move_optitrack3_step(void)
{
  /* S-Function (ev3_ultrasonic_sensor): '<Root>/Ultrasonic Sensor' */
  lego_move_optitrack3_B.UltrasonicSensor = getUltrasonicSensorValue(1U);

  /* S-Function (ev3_ultrasonic_sensor): '<Root>/Ultrasonic Sensor1' */
  lego_move_optitrack3_B.UltrasonicSensor1 = getUltrasonicSensorValue(4U);

  /* Product: '<Root>/Divide' */
  lego_move_optitrack3_B.Divide = (uint16_T)((uint32_T)
    lego_move_optitrack3_B.UltrasonicSensor *
    lego_move_optitrack3_B.UltrasonicSensor1);

  /* External mode */
  rtExtModeUploadCheckTrigger(1);

  {                                    /* Sample time: [0.2s, 0.0s] */
    rtExtModeUpload(0, lego_move_optitrack3_M->Timing.taskTime0);
  }

  /* signal main to stop simulation */
  {                                    /* Sample time: [0.2s, 0.0s] */
    if ((rtmGetTFinal(lego_move_optitrack3_M)!=-1) &&
        !((rtmGetTFinal(lego_move_optitrack3_M)-
           lego_move_optitrack3_M->Timing.taskTime0) >
          lego_move_optitrack3_M->Timing.taskTime0 * (DBL_EPSILON))) {
      rtmSetErrorStatus(lego_move_optitrack3_M, "Simulation finished");
    }

    if (rtmGetStopRequested(lego_move_optitrack3_M)) {
      rtmSetErrorStatus(lego_move_optitrack3_M, "Simulation finished");
    }
  }

  /* Update absolute time for base rate */
  /* The "clockTick0" counts the number of times the code of this task has
   * been executed. The absolute time is the multiplication of "clockTick0"
   * and "Timing.stepSize0". Size of "clockTick0" ensures timer will not
   * overflow during the application lifespan selected.
   */
  lego_move_optitrack3_M->Timing.taskTime0 =
    (++lego_move_optitrack3_M->Timing.clockTick0) *
    lego_move_optitrack3_M->Timing.stepSize0;
}

/* Model initialize function */
void lego_move_optitrack3_initialize(void)
{
  /* Registration code */

  /* initialize real-time model */
  (void) memset((void *)lego_move_optitrack3_M, 0,
                sizeof(RT_MODEL_lego_move_optitrack3_T));
  rtmSetTFinal(lego_move_optitrack3_M, 25.0);
  lego_move_optitrack3_M->Timing.stepSize0 = 0.2;

  /* External mode info */
  lego_move_optitrack3_M->Sizes.checksums[0] = (34862869U);
  lego_move_optitrack3_M->Sizes.checksums[1] = (2041825732U);
  lego_move_optitrack3_M->Sizes.checksums[2] = (1516920352U);
  lego_move_optitrack3_M->Sizes.checksums[3] = (3211141218U);

  {
    static const sysRanDType rtAlwaysEnabled = SUBSYS_RAN_BC_ENABLE;
    static RTWExtModeInfo rt_ExtModeInfo;
    static const sysRanDType *systemRan[1];
    lego_move_optitrack3_M->extModeInfo = (&rt_ExtModeInfo);
    rteiSetSubSystemActiveVectorAddresses(&rt_ExtModeInfo, systemRan);
    systemRan[0] = &rtAlwaysEnabled;
    rteiSetModelMappingInfoPtr(lego_move_optitrack3_M->extModeInfo,
      &lego_move_optitrack3_M->SpecialInfo.mappingInfo);
    rteiSetChecksumsPtr(lego_move_optitrack3_M->extModeInfo,
                        lego_move_optitrack3_M->Sizes.checksums);
    rteiSetTPtr(lego_move_optitrack3_M->extModeInfo, rtmGetTPtr
                (lego_move_optitrack3_M));
  }

  /* block I/O */
  (void) memset(((void *) &lego_move_optitrack3_B), 0,
                sizeof(B_lego_move_optitrack3_T));

  /* data type transition information */
  {
    static DataTypeTransInfo dtInfo;
    (void) memset((char_T *) &dtInfo, 0,
                  sizeof(dtInfo));
    lego_move_optitrack3_M->SpecialInfo.mappingInfo = (&dtInfo);
    dtInfo.numDataTypes = 14;
    dtInfo.dataTypeSizes = &rtDataTypeSizes[0];
    dtInfo.dataTypeNames = &rtDataTypeNames[0];

    /* Block I/O transition table */
    dtInfo.BTransTable = &rtBTransTable;
  }

  /* Start for S-Function (ev3_ultrasonic_sensor): '<Root>/Ultrasonic Sensor' */
  initUltrasonicSensor(1U);

  /* Start for S-Function (ev3_ultrasonic_sensor): '<Root>/Ultrasonic Sensor1' */
  initUltrasonicSensor(4U);
}

/* Model terminate function */
void lego_move_optitrack3_terminate(void)
{
  /* Terminate for S-Function (ev3_ultrasonic_sensor): '<Root>/Ultrasonic Sensor' */
  terminateUltrasonicSensor(1U);

  /* Terminate for S-Function (ev3_ultrasonic_sensor): '<Root>/Ultrasonic Sensor1' */
  terminateUltrasonicSensor(4U);
}

/*
 * File trailer for generated code.
 *
 * [EOF]
 */
