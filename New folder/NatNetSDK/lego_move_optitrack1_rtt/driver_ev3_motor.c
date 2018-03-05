/* Copyright 2013 The MathWorks, Inc. */

/**************************************
 *     LEGO EV3 Motor Driver          *
 **************************************/

#include "driver_ev3.h"

static int motorFile = -1;
static int motorCount = 0;

void initMotor(uint8_T portNumber)
{
    uint8_T motor_command[2];
    
    if(motorFile == -1) {
        motorFile = open(PWM_DEVICE_NAME, O_WRONLY);
        if(motorFile == -1) {
            _EV3_DEBUG_PRINTF(("Failed to initialize motor on port %d.\n", portNumber));
            exit(1);
        }
        _EV3_DEBUG_PRINTF(("Successfully initialized motor on port %d with ID %d.\n", portNumber, motorFile));
        
    }
    
    // Clear all counters
    motor_command[0] = opOUTPUT_CLR_COUNT;
    motor_command[1] = 1 << (portNumber - 1);
    write(motorFile,motor_command,2);
    
    motorCount++;
}

void setMotor(int8_T* inData, uint8_T portNumber, uint8_T stopAction)
{
    uint8_T MOTOR;
    uint8_T SPEED = *inData;
    uint8_T motor_command[5];
    
    //A = 0x01, B = 0x02, C = 0x04, D = 0x08
    switch (portNumber) {
        case 1:
            MOTOR = 0x01;
            break;
        case 2:
            MOTOR = 0x02;
            break;
        case 3:
            MOTOR = 0x04;
            break;
        case 4:
            MOTOR = 0x08;
            break;
    }
    _EV3_DEBUG_PRINTF(("Set motor on port %d (%d) with speed %d.\n", portNumber, MOTOR, SPEED));
    
    
    // Set the motor power
    motor_command[0] = opOUTPUT_POWER;
    motor_command[1] = MOTOR;
    motor_command[2] = SPEED;
    write(motorFile,motor_command,3);
    
    // Start the motor
    motor_command[0] = opOUTPUT_START;
    write(motorFile,motor_command,2);
    
}

void terminateMotor(uint8_T portNumber, uint8_T stopAction)
{
    uint8_T MOTOR = portNumber;
    uint8_T motor_command[5];
    
    //A = 0x01, B = 0x02, C = 0x04, D = 0x08
    switch (portNumber) {
        case 1:
            MOTOR = 0x01;
            break;
        case 2:
            MOTOR = 0x02;
            break;
        case 3:
            MOTOR = 0x04;
            break;
        case 4:
            MOTOR = 0x08;
            break;
    }
    
    // Stop motor
    motor_command[0] = opOUTPUT_STOP;
    motor_command[1] = MOTOR;
    motor_command[2] = 0;
    write(motorFile,motor_command,3);
    
    _EV3_DEBUG_PRINTF(("try to close motor file %d.\n", motorCount));
    motorCount--;
    
    if(motorCount == 0) {
        _EV3_DEBUG_PRINTF(("close motor file !!!!\n"));
        close(motorFile);
        motorFile = -1;
    }
    
}
