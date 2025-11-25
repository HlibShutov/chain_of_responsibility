#define INFO 0
#define DEBUG 1
#define ERROR 2

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
        case INFO:
	    level_msg = "INFO";
	    break;
        case DEBUG:
	    level_msg = "DEBUG";
	    break;
        case ERROR:
	    level_msg = "ERROR";
	    break;
    }
    "%s %s\n", msg, level_msg;
    if (self->next != NULL) self->next->log(self->next, msg, level);
    else return;
}

U0 logger_b_log(Logger *self, U8 *msg, U8 level) {
    if (level == DEBUG) "im debugging %s\n", msg;
    if (self->next != NULL) self->next->log(self->next, msg, level);
    else return;
}

U0 logger_c_log(Logger *self, U8 *msg, U8 level) {
    if (level == ERROR) "error %s\n", msg;
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

  loggerC.log(&loggerC, "(((they))) glow in the dark", INFO);
}
Main;

