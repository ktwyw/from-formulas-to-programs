PROGRAM TankControl
VAR_INPUT
    LevelLow    : BOOL;     (* TRUE when the level is below the low switch *)
    LevelHigh   : BOOL;     (* TRUE when the level is above the high switch *)
    EmergencyStop : BOOL;
END_VAR
VAR_OUTPUT
    Pump        : BOOL;
    Alarm       : BOOL;
END_VAR
VAR
    RunTimer    : TON;      (* on-delay timer: alarm if pumping too long *)
END_VAR

IF EmergencyStop OR LevelHigh THEN   (* the conditions that stop the pump come first *)
    Pump := FALSE;
ELSIF LevelLow THEN
    Pump := TRUE;
END_IF;

RunTimer(IN := Pump, PT := T#10m);   (* 10 minutes *)
Alarm := RunTimer.Q;                  (* pump ran > 10 min: possible leak *)
END_PROGRAM
