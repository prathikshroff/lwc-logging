@isTest
private class LogEntryImplTest {


@IsTest
    private static void testLogEntryImpl() {
        LogEntryImpl logEntryImpl = new LogEntryImpl('Test', LogLevel.DEBUG);
        
        System.assertEquals('Test', logEntryImpl.eventName, 'The event name is not correct');
        System.assertEquals(LogLevel.DEBUG, logEntryImpl.logLevel, 'The log level is not correct');
    }


@IsTest
    private static void testInvalidLogEntry() {
        LogEntryImpl logEntryImpl = new LogEntryImpl(null, null);

        System.assertEquals(false, logEntryImpl.save(), 'The save method should return false for an invalid log entry');
    }


@IsTest
    private static void testSave() {
        LogEntryImpl logEntry = new LogEntryImpl('Test', LogLevel.DEBUG);
        Boolean isSuccessful = logEntry.save();
        
        System.assertEquals(true, isSuccessful, 'The save method should return true');
    }

}