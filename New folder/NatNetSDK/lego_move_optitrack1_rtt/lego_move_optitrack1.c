/*
 * File: lego_move_optitrack1.c
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

#include "lego_move_optitrack1.h"
#include "lego_move_optitrack1_private.h"

/* Real-time model */
RT_MODEL_lego_move_optitrack1_T lego_move_optitrack1_M_;
RT_MODEL_lego_move_optitrack1_T *const lego_move_optitrack1_M =
  &lego_move_optitrack1_M_;

/* Model output function */
void lego_move_optitrack1_output(void)
{
  int8_T tmp;
  int8_T tmp_0;
  real_T tmp_1;

  /* DataTypeConversion: '<S1>/Data Type Conversion' incorporates:
   *  Constant: '<Root>/Constant'
   */
  tmp_1 = floor(lego_move_optitrack1_P.Constant_Value);
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
  tmp_1 = floor(lego_move_optitrack1_P.Constant1_Value);
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
void lego_move_optitrack1_update(void)
{
  /* (no update code required) */
}

/* Model initialize function */
void lego_move_optitrack1_initialize(void)
{
  /* Registration code */

  /* initialize error status */
  rtmSetErrorStatus(lego_move_optitrack1_M, (NULL));

  /* Start for S-Function (ev3_motor): '<S1>/Motor' */
  initMotor(1U);

  /* Start for S-Function (ev3_motor): '<S2>/Motor' */
  initMotor(2U);
}

/* Model terminate function */
void lego_move_optitrack1_terminate(void)
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
