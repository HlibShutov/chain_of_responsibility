class Logger {
    Logger *next;
    U0 (*log)(Logger *self, U8 *msg, U8 level);
}

class LoggerA : Logger {
};
class LoggerB : Logger {
};
class LoggerC : Logger {
};

U0 logger_a_log(Logger *self, U8 *msg, U8 level) {
    U8 *level_msg;
    switch (level) {
        case 0:
	    level_msg = "INFO";
	    break;
        case 1:
	    level_msg = "DEBUG";
	    break;
        case 2:
	    level_msg = "ERROR";
	    break;
    }
    "%s %s\n", msg, level_msg;
    if (self->next != NULL) self->next->log(self->next, msg, level);
    else return;
}

U0 logger_b_log(Logger *self, U8 *msg, U8 level) {
    if (level == 1) "im debugging %s\n", msg;
    if (self->next != NULL) self->next->log(self->next, msg, level);
    else return;
}

U0 logger_c_log(Logger *self, U8 *msg, U8 level) {
    if (level == 2) "error %s\n", msg;
    if (self->next != NULL) self->next->log(self->next, msg, level);
    else return;
}

U0 Main()
{
  LoggerA loggerA;
  loggerA.log = &logger_a_log;
  loggerA.next = NULL;

  LoggerB loggerB;
  loggerB.log = &logger_b_log;
  loggerB.next = &loggerA;

  LoggerC loggerC;
  loggerC.log = &logger_c_log;
  loggerC.next = &loggerB;

  loggerC.log(&loggerC, "(((they))) glow in the dark", 0);
}
Main;

