/**
 * @name              : 
 * @author            : pchannab
 * @usage             : 
 * @last modified on  : 03-19-2025
 * @last modified by  : pchannab
 * Modifications Log
 * Ver   Date         Author     Modification
 * 1.0   03-14-2025   pchannab   Initial Version
**/
@isTest
private class LogEntryImplTest {

@IsTest
    private static void testInvalidLogEntry() {
        LogEntryImpl logEntryImpl;
        Test.startTest();
            try {
                logEntryImpl = new LogEntryImpl(null, null);   
                Assert.areEqual(false, logEntryImpl.save(), 'The save method should return false for an invalid log entry');
            } catch (LoggingException ex) {
                Assert.areEqual('Invalid log entry', ex.getMessage(), 'The exception message should be "Invalid log entry"');
            }
        Test.stopTest();               
    }

@IsTest
    private static void testSave() {
        Test.startTest();
            LogEntryImpl logEntry = new LogEntryImpl('Test', LogLevel.DEBUG);
            logEntry.setLogMessage('test message');
            logEntry.setUserContext('test user ID', 'test user name');
            Boolean isSuccessful = logEntry.save();
        Test.stopTest();
        
        Assert.areEqual(true, isSuccessful, 'The save method should return true');
    }

}