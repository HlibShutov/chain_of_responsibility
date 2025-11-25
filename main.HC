class Logger {
    Logger *next;
    U0 (*log)(Logger *self, U8 *msg, U8 level);
};

U0 test_log(Logger *self, U8 *msg, U8 level) {
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
    if (self->next != NULL) self->next->log(self->next, msg, 0);
    else return;
}
U0 Main()
{
  Logger logger;
  logger.log = &test_log;
  logger.next = NULL;
  logger.log(&logger, "woah", 0);
}
Main;

