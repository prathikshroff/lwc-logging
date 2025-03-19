/**
 * @name              : 
 * @author            : pchannab
 * @usage             : 
 * @last modified on  : 03-19-2025
 * @last modified by  : pchannab
 * Modifications Log
 * Ver   Date         Author     Modification
 * 1.0   03-19-2025   pchannab   Initial Version
**/
@isTest
private class LogEntryFactoryTest {


@IsTest
    static void testBuildLogEntryFactory() {
        // Create a test factory
        Test.startTest();
        LogAbstract logObj = LogEntryFactory.create().withEventName('Test Event').withLogLevel(LogLevel.INFO).withLogMessage('Test Message').withUserId('123').withUserName('Test User').build();
        Test.stopTest();        
        // Verify the log entry properties        
        Assert.areEqual('Test Event', logObj.eventName, 'Event Name should be "Test Event"');
        Assert.areEqual('Test Message', logObj.logMessage, 'Message should be "Test Message"');
        Assert.areEqual(LogLevel.INFO, logObj.logLevel, 'Log Level should be INFO');
        Assert.areEqual('123', logObj.userId, 'User Id should be "123"');
        Assert.areEqual('Test User', logObj.user_name, 'User Name should be "Test User"');
    }

    @IsTest
    static void testSaveLog() {
        Test.startTest();
        LogEntryFactory.create().withEventName('Test Event').withLogLevel(LogLevel.INFO).withLogMessage('Test Message').withUserId('123').withUserName('Test User').save();        
        Test.stopTest();

        List<Log__c> logs = [SELECT Id, Event_Name__c, Log_Level__c, Log_Message__c, User_Id__c, User_Name__c FROM Log__c];

        Assert.isTrue(!logs.isEmpty(), 'There should be one log entry');
        Assert.areEqual('Test Event', logs[0].Event_Name__c, 'Event Name should be "Test Event"');
        Assert.areEqual('Test Message', logs[0].Log_Message__c, 'Log Message should be "Test Message"');
        Assert.areEqual('123', logs[0].User_Id__c, 'User Id should be "123"');
        Assert.areEqual('Test User', logs[0].User_Name__c, 'User Name should be "Test User"');
    }

    @IsTest
    static void testEventNameException() {
        Test.startTest();
        try {
            LogEntryFactory.create().withLogLevel(LogLevel.INFO).withLogMessage('Test Message').withUserId('Test User 123').withUserName('Test User').build();
        } catch (LoggingException ex) {
            Assert.areEqual('Event name is required', ex.getMessage(), 'The exception message should be "Event name is required"');
        }
        Test.stopTest();
    }

    @IsTest
    static void testLogLevelException() {
        Test.startTest();
        try {
            LogEntryFactory.create().withEventName('Test Event').withLogMessage('Test Message').withUserId('Test User 123').withUserName('Test User').build();
        } catch (LoggingException ex) {
            Assert.areEqual('Log level is required', ex.getMessage(), 'The exception message should be "Log level is required"');
        }
        Test.stopTest();
    }
}