/**
 * @name              : 
 * @author            : pchannab
 * @usage             : 
 * @last modified on  : 03-14-2025
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
        try {
            logEntryImpl = new LogEntryImpl(null, null);   
            System.assertEquals(false, logEntryImpl.save(), 'The save method should return false for an invalid log entry');
        } catch (Exception ex) {
            System.assert(true);
        }               
    }


@IsTest
    private static void testSave() {
        LogEntryImpl logEntry = new LogEntryImpl('Test', LogLevel.DEBUG);
        logEntry.setLogMessage('test message');
        logEntry.setUserContext('test user ID', 'test user name');
        Boolean isSuccessful = logEntry.save();
        
        System.assertEquals(true, isSuccessful, 'The save method should return true');
    }

}